#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import os
import re
import sys
import shutil
import commands
#model pipeline copy
def model_copy(sdc_url,new_pipelineID,model_pipelineID):

    for root, dirs, files in os.walk("/"):
        if 'streamsets' in files:
            sdc=root+'/streamsets'
            pipeline_dir=re.sub('/bin','/data/pipelines/'+new_pipelineID,root)
            if os.path.exists(pipeline_dir):
                shutil.rmtree(pipeline_dir)
    #else:
    #    continue
            print ('%s cli -U %s store import -n "%s" -f %s' % (sdc,sdc_url,new_pipelineID,model_pipelineID))
            commands.getoutput('%s cli -U %s store import -n "%s" -f %s' % (sdc,sdc_url,new_pipelineID,model_pipelineID))
            return pipeline_dir,sdc
        else:
            continue
