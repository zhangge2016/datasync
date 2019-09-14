import os
import json
from exceptions import FileNotFoundError

def load_json(jsonpath):
    if not os.path.exists(jsonpath):
         raise FileNotFoundError(jsonpath)
    with open(jsonpath,'rb') as json_file:
        json_dict=json.load(json_file)
    return json_dict
