import pyspark
from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark import SparkFiles
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.functions import when
from pyspark.sql.types import *
import pyspark.sql.functions as F


sc = SparkContext()
# spark = SparkSession.builder.getOrCreate()
# nums = sc.parallelize([1, 2, 3, 4])
# squared = nums.map(lambda x: x * x).collect()
# print(squared)
# for num in squared:
#     print('%i ' % (num))
#url = "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/adult_data.csv"
#sc.addFile(url)
sqlContext = SQLContext(sc)
#df = sqlContext.read.csv(SparkFiles.get("adult_data.csv"), header=True, inferSchema= True)
#print(df.columns)
filename= 'C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt'
filename1= 'C:/Users/10638056/Desktop/RRR Training/data/ouputdata.txt'
df1 = sqlContext.read.csv(filename, header=True, inferSchema= True)
df2=df1.select('x', 'age', 'workclass', 'fnlwgt', 'education')

print(df2.columns)
df3=df1.select('x', 'age', 'workclass', 'fnlwgt','educational-num')
a=['x', 'age', 'workclass', 'fnlwgt', 'education', 'educational-num','wwww']
#b=df.columns
mismatched_columns=[]

if len(df2.columns)==len(df3.columns):
    print('number of cols {}'.format(len(df2.columns)) )
    for i in df2.columns:
        if i in df3.columns:
            print('Columns matching Successfully ')
        else:
            print('failed in matching ')
            mismatched_columns.append(str(i))
            print('mismatched columns are:', mismatched_columns)
else:
    print('No equal number of columns')

#df.withColumn("Curr_date", F.current_date())

df3=df1.select('x', 'age', 'workclass', 'fnlwgt','educational-num').withColumn("Curr_date", F.current_date())
df3.write.csv(filename1)

#df1.withColumn('Exists', df1.age.isin(a)).filter(F.col('Exists')=='true').show()



