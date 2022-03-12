import pyspark
import os
import findspark
findspark.init()
import pyspark
from pyspark import SparkContext
sc = SparkContext(appName="EstimatePi")
from pyspark.sql import SparkSession
from pyspark.sql.window import Window
from pyspark.sql.functions import *
# #export PYSPARK_PYTHON=python 3.7
#spark = SparkSession.builder.appName('SparkByExamples.com').master("local").getOrCreate()

# simpleData = (("James", "Sales", 3000), \
#               ("Michael", "Sales", 4600), \
#               ("Robert", "Sales", 4100), \
#               ("Maria", "Finance", 3000), \
#               ("James", "Sales", 3000), \
#               ("Scott", "Finance", 3300), \
#               ("Jen", "Finance", 3900), \
#               ("Jeff", "Marketing", 3000), \
#               ("Kumar", "Marketing", 2000), \
#               ("Saif", "Sales", 4100) \
#               )
#
# columns = ["employee_name", "department", "salary"]
# df = spark.createDataFrame(data = simpleData, schema = columns)
# df.printSchema()
# ## printing the schema
# df.show(truncate=False)
# windowSpec  = Window.partitionBy("department").orderBy("salary")
# #Printing the row_number
# df.withColumn("row_number",row_number().over(windowSpec)) \
#     .show(truncate=False)
#printing the rank
# df.withColumn("rank",rank().over(windowSpec)) \
#     .show()
#printing the dense rank
# df.withColumn("dense_rank",dense_rank().over(windowSpec)) \
#     .show()
# printing the lag

# df.withColumn("lag",lag("salary",2).over(windowSpec)) \
#       .show()
# printing the lead

# df.withColumn("lead",lead("salary",2).over(windowSpec)) \
#     .show()
##pattern##
# s='python'
# p=[s[:i]for i in range(len(s)+1)]
# print(*p+p[::-1],sep='\n')

# largest of a given element
def largest(arr,n):
    mx=arr[0]
    for i in range(1,n):
        if arr[i]>mx:
            mx=arr[i]
            print(mx)
    return mx

arr=[10,324,45,90,9808]
n=len(arr)
ans=largest(arr,n)
print("lrgest in given arry is",ans)





