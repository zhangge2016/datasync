"""
Created on Wed Aug 21 16:01:31 2019
@author: zhangge
Description:
    Schedule offline-synchronization services

Last modified: 2019-08-23
Modified by:
zhangge:

"""
import time
import os
import re
import commands
import threading

#Check pipeline stage
#When the stage of manager pipeline is RUNNING, End recursion
#When the stage of offline-sync pipeline is Finished, End recursion
class Schedule(object):

    def __init__(self, sdc,sdc_url):
        self.sdc= sdc
        self.sdc_url=sdc_url

    def stage_judge(self,pipelineID,sleep_time,control):
        try:
            a=[]

            print ('%s cli -U %s manager status -n %s' % (self.sdc,self.sdc_url,pipelineID))
            pipeline_status=commands.getoutput('%s cli \
              -U %s manager status -n %s' % (self.sdc,self.sdc_url,pipelineID))
            if re.search('STARTING',pipeline_status):
                if control=='manager':
                    a.append('manager')
                    time.sleep(sleep_time)
                    self.stage_judge(pipelineID,30,'manager')
                elif control=='sync':
                    a.append('sync')
                    self.stage_judge(pipelineID,180,'sync')
                elif control=='check':
                    a.append('check')
                    self.stage_judge(pipelineID,10,'check')
            elif re.search('RUNNING',pipeline_status):
                if control=='sync':
                    a.append('sync2')
                    self.stage_judge(pipelineID,180,'sync')
                elif control=='manager':
                    a.append('manager2')
                    return
                elif control=='check':
                    a.append('check2')
                    self.stage_judge(pipelineID,10,'check')
            elif re.search('FINSHED',pipeline_status):
                a.append('f')
                return
            else:
                print ('Stage abnormal')
        except:
            print (a)
            print ('Processing Error')

    def schedule(self,taskID,sync_newpipelineID_list,sync_df):

        #Priority start up the manager pipeline
        manager_pipelineID=taskID+'_'+'manager'
        os.system('%s cli -U %s manager reset-origin -n %s' % (self.sdc,self.sdc_url,manager_pipelineID))
        os.system('%s cli -U %s manager start -n %s' % (self.sdc,self.sdc_url,manager_pipelineID))
        self.stage_judge(manager_pipelineID,30,'manager')

        #Start up total sync pipelines by multiple line
        threads=[]
        for sync_pipelineID in sync_newpipelineID_list:
            os.system('%s cli -U %s manager reset-origin -n %s' % (self.sdc,self.sdc_url,sync_pipelineID))
            os.system('%s cli -U %s manager start -n %s' % (self.sdc,self.sdc_url,sync_pipelineID))
            t= threading.Thread(target=self.stage_judge,args=(sync_pipelineID,180,'sync',))
            threads.append(t)

        for each_t in threads:
            each_t.setDaemon(True)
            each_t.start()
        for each_t in threads:
            each_t.join()
        time.sleep(60)

        #When all sync pipelines end, stopping manager pipeline
        os.system('%s cli -U %s manager stop -n %s' % (self.sdc,self.sdc_url,manager_pipelineID))

        #Start up check pipeline for table check in each database
        check_pipelineID=taskID+'_'+'check'
        for db_name in list(set(sync_df['database'])):
            rawData_dict={}
            for tables in sync_df[sync_df['database']==db_name]['table']:
                rawData_dict='\"{\\\"db_name\\\":\\\"%s\\\",\\\"tb_name\\\":\\\"%s\\\"}\"' % (db_name,tables)
                print (rawData_dict)
            parameters='{"rawData": %s,"database":"%s"}' % (rawData_dict,db_name)
            print (parameters)
            os.system("%s cli -U %s manager reset-origin -n %s" % (self.sdc,self.sdc_url,check_pipelineID))
            os.system("%s cli -U %s manager start -n %s  -R '%s'" % (self.sdc,self.sdc_url,check_pipelineID,parameters))
            print ("%s cli -U %s manager start -n %s  -R '%s'" % (self.sdc,self.sdc_url,check_pipelineID,parameters))
            self.stage_judge(check_pipelineID,30,'check')
