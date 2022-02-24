import json
import time
import pytz
from pytz import timezone
from pandas import json_normalize
import requests
import datetime
from datetime import timedelta
from dateutil.tz import tzutc, UTC
import pandas as pd
from pandas import DataFrame
import numpy as np
from io import BytesIO
from json import dumps
from pandas.io.json import json_normalize
from datetime import datetime as dt
url = "https://results.us.securityeducation.com/api/reporting/v0.1.0/phishing"
my_headers = {'x-apikey-token': 'YV5iYWWji13z25LX/ZAQOwmHKmHqdpQk8pQzIcSQ5hGl3cpog'}
file = [line.strip() for line in url]
def reshape(r):
    dt = r["data"]
    at = r["data"]["attributes"]
    res = {
        "Type": dt['type'],
        "id": dt["id"]
        #"UserFirstname": [at]['userfirstname']
        # "userLastname": at['userlastname'],
        # "useremailaddress": at['useremailaddress'],
        # "useractiveflag": at['useractiveflag'],
        # "userdeleteddate": at['userdeleteddate'],
        # "senttimestamp": at['senttimestamp'],
        # "eventtimestamp": at['eventtimestamp'],
        # "eventtype": at['eventtype'],
        # "campaignname": at['campaignname'],
        # "autoenrollment": at['autoenrollment'],
        # "campaignstartdate": at['campaignstartdate'],
        # "campaignenddate": at['campaignenddate'],
        # "campaigntype": at['campaigntype'],
        # "campaignstatus": at['campaignstatus'],
        # "templatename": at['templatename'],
        # "templatesubject": at['templatesubject'],
        # "assessmentisarchived": at['assessmentisarchived'],
        # "usertags": at['usertags'],
        # "sso_id": at['sso_id']
    }
    return res


# data = json.load(json_file)
# for url in file:
responses=[]
r = requests.get(url, headers=my_headers)
a=r.json()
df=pd.json_normalize(a['data'])
print(df.columns)
df.columns = df.columns.map(lambda x: x.split(".")[-1])
df.rename(columns = {'type':'D_TYPE','id':'D_ID','sso_id':'D_SSO_ID'} ,inplace = True)
df['index']=list(range(len(df.index))) + 100
print(df.columns)
# fields=''
# dt=df[a]
# dt=dt.explode('a')
# df1=pd.DataFrame(dt['r']).apply(pd.series)
# #print(df1)
# df=pd.json_normalize(a['data'])
# df.rename(columns = {'type':'TYPE'},{'attributes.sso_id':'SSO_ID'} inplace = True)
print(df)
#rankings_pd.rename(columns = {'test':'TEST'}, inplace = True)
# df=pd.json_normalize(json['r'])
# print(df)
# responses.append(reshape(r.json()))
# print(responses)
# # serialized = []
# # for r in responses:
# #     serialized.append(json.dumps(r))
# #     jsonlines_doc = "\n".join(serialized)
# #     df = pd.read_json(jsonlines_doc, lines=True)
# #     print(df)
