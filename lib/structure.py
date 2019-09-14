import re
import os
import json
import pandas as pd
import time
from readjson import load_json
from pipelinecopy import model_copy
from pipelineconfigparse import Manager,Sync,Check


def create_structure(sdc_url,web_conf_dict,taskID,errorMessage_filepath,error_tb_filepath):
    datasync_dir=(os.path.abspath(__file__)).replace(r'/lib/structure.py','')
    print (datasync_dir)
    sync_df = pd.DataFrame(columns=('schema', 'database', 'table'))
    i=0
    for schema_db_tb in web_conf_dict['sync_tables']:
        lists=re.split('\.',schema_db_tb)
        sync_df.loc[i]=lists
        i+=1
    db_list=list(set(sync_df['database']))
    
    #manager pipeline copy and modify, a pipeline execute only once in a task
    sync_newpipelineID_list=[]
    new_pipelineID=taskID+'_'+'manager'
    port=web_conf_dict['rpc_connection'].split(':')[1]
    pipeline_dir,sdc=model_copy(sdc_url,new_pipelineID,datasync_dir+'/data/manager_pipeline.json')
    model_manager_pipeline_conf_file=pipeline_dir+'/pipeline.json'
    t_manager=Manager(taskID, port)
    t_manager.manager_parse(model_manager_pipeline_conf_file,errorMessage_filepath)

    #sync pipeline copy and modify for each db_name, each pipeline execute only once in a task
    for db in db_list:
        new_pipelineID=taskID+'_'+db
        sync_newpipelineID_list.append(new_pipelineID)
        pipeline_dir,_=model_copy(sdc_url,new_pipelineID,datasync_dir+'/data/sync_pipeline.json')
        model_sync_pipeline_conf_file=pipeline_dir+'/pipeline.json'
        t_sync=Sync(web_conf_dict, taskID, db)
        t_sync.sync_parse(model_sync_pipeline_conf_file)

    #check pipeline copy, a pipeline execute repeatly with different rawdata inputs (db_name) in a task
    new_pipelineID=taskID+'_'+'check'
    pipeline_dir,_=model_copy(sdc_url,new_pipelineID,datasync_dir+'/data/check_pipeline.json')
    model_check_pipeline_conf_file=pipeline_dir+'/pipeline.json'
    t_check=Check(web_conf_dict, taskID)
    t_check.check_parse(model_check_pipeline_conf_file,error_tb_filepath)

    return sync_newpipelineID_list,sync_df,sdc
