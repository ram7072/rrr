# import pyspark
# from pyspark import SparkContext
# from pyspark.sql import SQLContext
# from pyspark import SparkFiles
# from pyspark.sql import SparkSession
# from pyspark.sql.functions import *
# from pyspark.sql.functions import when
# from pyspark.sql.types import *
# import pyspark.sql.functions as F
#
# sc =SparkContext()
# spark = SparkSession.builder.getOrCreate()
# # nums= sc.parallelize([1,2,3,4])
# # squared = nums.map(lambda x: x*x).collect()
# # print(squared)
# # for num in squared:
# #     print('%i ' % (num))
#
# ###################
# url = "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/adult_data.csv"
# sc.addFile(url)
# sqlContext = SQLContext(sc)
# #df = sqlContext.read.csv(SparkFiles.get("adult_data.csv"), header=True, inferSchema= True)
# df = spark.read.csv(SparkFiles.get("adult_data.csv"), header=True, inferSchema= True)
# #filename= 'C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt'
# #df = spark.read.csv(filename, header=True, inferSchema= True)
# df_string = sqlContext.read.csv(SparkFiles.get("adult_data.csv"), header=True, inferSchema= False)
# #df.printSchema()
# df.show(5, truncate = False)
# #df_string = spark.read.csv(filename, header=True, inferSchema=  False)
#
# #df_string.printSchema()
# # Write a custom function to convert the data type of DataFrame columns
# def convertColumn(df, names, newType):
#     for name in names:
#         df = df.withColumn(name, df[name].cast(newType))
#     return df
# # List of continuous features
# defined_cols = ['age', 'fnlwgt','capital-gain', 'educational-num', 'capital-loss', 'hours-per-week']
# # Convert the type
# df_string1 = convertColumn(df_string, defined_cols, FloatType())
# # Check the dataset
# #df_string1.printSchema()
# #df.select('age','fnlwgt').show(5)
# df.groupBy("education").count().sort("count",ascending=True).show()
# #df.describe().show()
# df.describe('capital-gain').show()
# #Dropping Columns
# df.drop('educational-num').columns
# a=df.drop('educational-num').columns
# print(a)
#
#
# #count the number of people above 40 year old
# b=df.filter(df.age > 40).count()
# print(b)
# #group data by group and compute statistical operations like the mean.
# #df.groupby('marital-status').agg({'capital-gain': 'mean'}).show()
# #df.groupby('marital-status').orderby('native-country')
# ######
# #c=df.filter(df['native-country'] == 'Holand-Netherlands').count()
#
# #print(c)
#
# #df.groupby('native-country').agg({'native-country': 'count'}).\
#   #  sort(("count(native-country)")).show()
# df_remove = df.filter(df['native-country'] !=	'Holand-Netherlands')
# df_remove.show()
# df.show()
# d=df.replace(0,1)
# #############
# d.show()
# # for x in df.columns:
# #     df3=df.withColumn(x,F.when(F.col(x))== 0, F.lit(None).otherwise(F.col(x)))
# #     df3.show()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.window import Window
from pyspark.sql.functions import *
# #export PYSPARK_PYTHON=python 3.7
spark = SparkSession.builder.appName('SparkByExamples.com').getOrCreate()

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





