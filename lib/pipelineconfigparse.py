#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import re
import os
import json
from readjson import load_json
from exceptions import FileNotFoundError
class Sync(object):

    def __init__(self, web_conf_dict, taskID, db_name):
        self.web_conf_dict = web_conf_dict
        self.taskID=taskID
        self.db_name=db_name
	print (self.web_conf_dict)

    #define sync pipeline constants
    def sync_pipeline_constants(self):
	print (self.web_conf_dict)
        constants=[ {
          "key" : "pg_connection",
          "value" :"jdbc:postgresql://"+self.web_conf_dict["pg_connection"]+"/"+self.db_name
          }, {
          "key" : "snappydata_connection",
          "value" : "jdbc:snappydata://"+self.web_conf_dict["snappydata_connection"]
          }, {
          "key" : "snappydata_dbname",
          "value" :(self.db_name).upper()
          }, {
          "key" : "snappydata_username",
          "value" : self.web_conf_dict["snappydata_username"]
          }, {
          "key" : "snappydata_password",
          "value" : self.web_conf_dict["snappydata_password"]
          }, {
          "key" : "pg_username",
          "value" : self.web_conf_dict["pg_username"]
          }, {
          "key" : "pg_password",
          "value" : self.web_conf_dict["pg_password"]
          }, {
          "key" : "email_receiver",
          "value" : self.web_conf_dict["email_receiver"]
          } , {
            "key" : "rpc_id",
            "value" : self.taskID
          }, {
            "key" : "rpc_connection",
            "value" :self.web_conf_dict["rpc_connection"]
          }]
        return constants

    #define sync pipeline tableConfig for each tables
    def tableConfigs_parse(self,schema_db_tb):
        schema,_,table_name=re.split('\.',schema_db_tb)
        tableConfigs={ 
          "tablePattern" : table_name,
          "overrideDefaultOffsetColumns": False,
          "offsetColumns" : [ ],
          "offsetColumnToInitialOffsetValue" : [ ],
          "enableNonIncremental" : True,
          "partitioningMode" : "DISABLED",
          "partitionSize" : "1000000",
          "maxNumActivePartitions" : -1,
          "schema" : schema
        }
        return tableConfigs

    #parse sync pipeline configure for each db_name
    def sync_parse(self,model_sync_pipeline_conf_file):
        '''
        parse parameters: pipelineId;
                          pg_connection;
                          snappydata_connection;
                          snappydata_dbname;
                          snappydata_username;
                          snappydata_password;
                          pg_username;
                          pg_password;
                          email_receiver;
                          tableConfigs;
        '''
        if not os.path.exists(model_sync_pipeline_conf_file):
            raise FileNotFoundError(model_sync_pipeline_conf_file)
        sync_conf_dict=load_json(model_sync_pipeline_conf_file)
	print ('come on')
	print (sync_conf_dict.keys())
        try:
            sync_conf_dict['configuration'][10]['name']=="constants"
	    print ('come two')
	    print (sync_conf_dict['configuration'][10]['value'])
            sync_conf_dict['configuration'][10]['value']=self.sync_pipeline_constants()
        except KeyError,e:
            print (e.message)

        try:
            sync_conf_dict['stages'][0]['configuration'][0]['name']=="tableJdbcConfigBean.tableConfigs"
            map_db='\.%s\.' % self.db_name
            total_sync_tableConfigs=[self.tableConfigs_parse(schema_db_tb) for schema_db_tb in self.web_conf_dict['sync_tables'] if re.search(map_db,schema_db_tb)]
            sync_conf_dict['stages'][0]['configuration'][0]['value']=total_sync_tableConfigs
        except KeyError,e:
	    print ('com three2')
            print e.message

        with open(model_sync_pipeline_conf_file,'w') as create_pipeline_conf:
            json.dump(sync_conf_dict,create_pipeline_conf,sort_keys=True, indent=4, separators=(',', ': '))

class Manager(object):

    def __init__(self, taskID, port):

        self.taskID=taskID
        self.port=port

    def manager_pipeline_constants(self):

        constants=[ {
          "key" : "port",
          "value" : self.port
        }, {
          "key" : "rpc_id",
          "value" : self.taskID
        } ]
        return constants 

    def manager_parse(self,model_manager_pipeline_conf_file,errorMessage_filepath):
        '''
        parse parameters: rpc port;
                          rpc id;
        '''
        if not os.path.exists(model_manager_pipeline_conf_file):
            raise FileNotFoundError(model_manager_pipeline_conf_file)

        if not os.path.exists(errorMessage_filepath):
            raise FileNotFoundError(errorMessage_filepath)


        manager_conf_dict=load_json(model_manager_pipeline_conf_file)

        try:
            manager_conf_dict['configuration'][10]['name']=="constants"
            manager_conf_dict['configuration'][10]['value']=self.manager_pipeline_constants()
        except KeyError,e:
	      print ('com three3')
              print e.message

        try:
            subed_str="/data/bigdata/streamsets-datacollector-3.9.1/user-code/mail/Error_record.out"
            manager_conf_dict["stages"][2]["configuration"][1]["value"].replace(subed_str,errorMessage_filepath)
            manager_conf_dict["stages"][2]["configuration"][2]["value"].replace(subed_str,errorMessage_filepath)
        except KeyError,e:
	    print ('com three4')
            print e.message

        with open(model_manager_pipeline_conf_file,'w') as create_pipeline_conf:
            json.dump(manager_conf_dict,create_pipeline_conf,sort_keys=True, indent=4, separators=(',', ': '))    

class Check(object):

    def __init__(self, web_conf_dict, taskID):
        self.web_conf_dict = web_conf_dict
        self.taskID=taskID

    #define check pipeline constants
    def check_pipeline_constants(self):

        constants=[ {
          "key" : "snappydata_connection",
          "value" : "jdbc:snappydata://"+self.web_conf_dict["snappydata_connection"]
        }, {
          "key" : "snappydata_username",
          "value" : self.web_conf_dict["snappydata_username"]
        }, {
          "key" : "snappydata_password",
          "value" : self.web_conf_dict["snappydata_password"]
        }, {
          "key" : "pg_connection",
          "value" : "jdbc:postgresql://"+self.web_conf_dict["pg_connection"]
        }, {
          "key" : "pg_username",
          "value" : self.web_conf_dict["pg_username"]
        }, {
          "key" : "pg_password",
          "value" : self.web_conf_dict["pg_password"]
        }, {
          "key" : "rawData",
          "value" : ""
        }, {
          "key" : "database",
          "value" : ""
        } ]
        return constants

    #parse check pipeline configure for each db_name
    def check_parse(self,model_check_pipeline_conf_file,error_tb_filepath):
        '''
        parse parameters: pipelineId;
                          rawData
                          pg_connection;
                          snappydata_connection;
                          snappydata_username;
                          snappydata_password;
                          pg_username;
                          pg_password;
                          error_file_savapath in jython
        '''
        if not os.path.exists(model_check_pipeline_conf_file):
            raise FileNotFoundError(model_check_pipeline_conf_file)

        if not os.path.exists(error_tb_filepath):
            raise FileNotFoundError(error_tb_filepath)


        check_conf_dict=load_json(model_check_pipeline_conf_file)
        
        try:
            check_conf_dict['configuration'][10]['name']=="constants"
            check_conf_dict['configuration'][10]['value']=self.check_pipeline_constants()
        except KeyError,e:
	    print ('com three5')
            print e.message
        
        try:
            check_conf_dict['stages'][6]['configuration'][2]['name']=="script"
            check_conf_dict['stages'][6]['configuration'][2]['value'].replace('error_file_savepath',error_tb_filepath)
        except KeyError,e:
	    print ('com three6')
            print e.message

        with open(model_check_pipeline_conf_file,'w') as create_pipeline_conf:
            json.dump(check_conf_dict,create_pipeline_conf,sort_keys=True, indent=4, separators=(',', ': '))
