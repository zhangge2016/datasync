import argparse
import sys
import os
import re
import pathlib
import shutil
import traceback
from structure import create_structure
from schedule import Schedule
from autocreatetable import QuerypkOperation
from readjson import load_json
from mail import send_mail

def parse():

    parser = argparse.ArgumentParser(description='datasync, a tool to make offline-synchronization services.')
    parser.add_argument('--web_conf_path',help='the path of a configuration file from YDataBin web')
    parser.add_argument('--task_dir',help='the dir of a task submitted from YDataBin web')
    args = parser.parse_args()
 
    if not args.web_conf_path:
        print('You must supply a web_conf_path\n')
        parser.print_help()
        exit(0)

    if not args.task_dir:
        print('You must supply a task_dir\n')
        parser.print_help()
        exit(0)

    return args.web_conf_path,args.task_dir


def mkdir_needfile(task_dir):
    if not os.path.exists(task_dir):
        os.makedirs(task_dir+'/log')
        pathlib.Path(task_dir+'/log/errorMessage.txt').touch()
        pathlib.Path(task_dir+'/log/errorTable.txt').touch()
    else:
        shutil.rmtree(task_dir)
        os.makedirs(task_dir+'/log')
        pathlib.Path(task_dir+'/log/errorMessage.txt').touch()
        pathlib.Path(task_dir+'/log/errorTable.txt').touch()


def atuocreatetable_config(web_conf_dict):
    '''
    pg_uri: postgresql+psycopg2://my_user:password123@172.20.200.20:30432
    snappydata_host: 172.19.101.82
    snappydata_port: 1528
    '''
    config = {}
    config["pg_uri"]="postgresql+psycopg2://"+web_conf_dict['pg_username']+":"+web_conf_dict["pg_password"]+"@"+web_conf_dict["pg_connection"]
    config["snappydata_host"],config["snappydata_port"]=web_conf_dict["snappydata_connection"].split(':')
    config["snappydata_url"]="jdbc:snappydata://"+web_conf_dict["snappydata_connection"]
    config["snappydata_password"]=web_conf_dict["snappydata_password"]
    return config


def main():

    try:

        web_conf_path,task_dir=parse()

        #set task dir 
        mkdir_needfile(task_dir)
        shutil.copy(web_conf_path, task_dir)

        #snappydata create table
        web_conf_dict=load_json(task_dir+'/web_config.json')
        config=atuocreatetable_config(web_conf_dict)
        for schema_db_tb in web_conf_dict['sync_tables']:
            schema, database, table=re.split('\.',schema_db_tb)
            print (schema, database, table, config)
            t=QuerypkOperation(schema, database, table, config)
            t.operate()

        #create offline sync service structure
        sdc_url=web_conf_dict["sdc_url"]
        taskID=web_conf_dict["taskID"]
        errorMessage_filepath=task_dir+'/log/errorMessage.txt'
        error_tb_filepath=task_dir+'/log/errorTable.txt'
        sync_newpipelineID_list,sync_df,sdc=create_structure(sdc_url,web_conf_dict,taskID,errorMessage_filepath,error_tb_filepath)
        
        #start schedule to control service
        s=Schedule(sdc,sdc_url)
        s.schedule(taskID,sync_newpipelineID_list,sync_df)

        #send mail to business for reporting sync errors
        receiver=web_conf_dict["email_receiver"]
        if os.path.getsize(errorMessage_filepath): 
            send_mail(receiver,errorMessage_filepath)
        else:
            print ("No error records appeared during sync")
        if os.path.getsize(error_tb_filepath): 
            send_mail(receiver,error_tb_filepath)
        else:
            print ("No table with lack of records during sync")

    except Exception as e:
        msg = traceback.format_exc()
        print(msg)
        print(e)

