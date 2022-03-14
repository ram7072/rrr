import json
import time
import pandas as pd
import logging
import datetime


def read_json():
    input = 'D:\\Users\\test_file_2.json'
    # Read Input json into dataframe
    print('Reading Input Json')
    with open(input, 'rb') as f:
        data = json.load(f)
    print('Reading Into dataframe')
    df = pd.DataFrame(data)
    #df = pd.read_json(input)
    print('Input Json Read')
    # Sort Values Alphabetically with First Name
    df = df.sort_values(['First_Name'])
    print(df)
    print('Dataframe Length:'+str(len(df)))
    # Drop duplicate con id's and keep first record
    df.drop_duplicates(subset="con_id", keep="first", inplace=True)
    print('Dataframe Length after removing duplicates:' + str(len(df)))
    print(df)
    return df
read_json()
