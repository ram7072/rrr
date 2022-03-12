# appl =['Jay','Sam','Vi','Li','My','Xi','On','Mo','An','Bo']
# test_ok=['xi','my','sam','an','mo','on']
# int_ok=['my','li','an','mo','bo','jay']
# legacy=['sue','bo','xi']
# out=['Accepted Students:An,Bo,Mo,My,Xi']
#
# def cond(a):
#     c1,c2,c3=a in test_ok, a in int_ok, a in legacy
#     print(c1,'-1',c2,'--2',c3,'3')
#     return (c3 and(c1 or c2)) or (not c3 and (c1 and c2))
# output= [ap for ap in  appl if cond(ap.lower())]
# output.sort()
# out1= "Accepted Students:"+",".join(output)
# print(out1)
# print(out[0])
# # if:
# #     assert out1==out[0]
# #     print(true)
# # else:
# #     pass
from datetime import datetime
import pandas as pd
from tabulate import tabulate
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql import Row
spark = SparkSession.builder.getOrCreate()
txt='2021-11-07T18:59:35-05:00 {cluster_id="1107-022605-pnhp36i7", cluster_ip="10.75.92.26", cluster_name="job-2004-run-67", env="prod"}  2021-11-07T23:59:35.330: tableRecordCount for mrc_vbup is 112'
print(txt.split()[4].split('=')[1].split('"')[1]) # wrong
print(datetime.fromisoformat(txt.split()[0])) #  wrong -
print(txt.split()[3].split('-')[1])
print(txt.split()[3].split('-')[3][:-2])
print(datetime.fromisoformat(txt.split()[5][:-1]))
print(txt.split()[8])
print(txt.split()[8].rsplit('_', 1)[0])
print(txt.split()[8].rsplit('_', 1)[1])
print(txt.split()[10])




d=dict()
time=[]
job_id=[]
time1=[]
delta_table=[]
erp=[]
table_name=[]
record_count=[]
run_no=[]
if txt.split()[4].split('=')[1].split('"')[1] == 'prod':
    time.append(datetime.fromisoformat(txt.split()[0]))
    job_id.append(txt.split()[3].split('-')[1])
    run_no.append(txt.split()[3].split('-')[3][:-2])
    time1.append(datetime.fromisoformat(txt.split()[5][:-1]))
    delta_table.append(txt.split()[8])
    erp.append(txt.split()[8].rsplit('_', 1)[0])
    table_name.append(txt.split()[8].rsplit('_', 1)[1])
    record_count.append(txt.split()[10])

d['time']=time
d['job_id'] = job_id
d['run_no'] = run_no
d['time1'] = time1
d['delta_table'] = delta_table
d['erp'] = erp
d['table_name'] = table_name
d['record_count'] = record_count

print(d)
df = pd.DataFrame(data=d)
l=['time','job_id']
#display(df)
#fields = [StructField(field_name, StringType(), True) for field_name in txt.split()]
rdd=spark.sparkContext.parallelize(df)
parts =d.map(lambda l: l.split(","))
orders_struct = parts.map(lambda p: Row(order_id=int(p[0]), order_date=p[1], customer_id=p[2], order_status=p[3]))
df1=spark.createDataFrame(orders_struct)
df1.show()
# # txt = "gmd_f421"
# #
# # # setting the maxsplit parameter to 1, will return a list with 2 elements!
# # x = txt.rsplit("_ ", 1)
# # print(x)
# df.set_index('time1',inplace=True)
# print(tabulate(df,headers='keys',tablefmt='pretty'))


