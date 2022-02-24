import pyspark
from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark import SparkFiles
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.functions import when
from pyspark.sql.types import *
import pyspark.sql.functions as F
spark = SparkSession\
    .builder\
    .master('local')\
    .config('spark.mongodb.input.uri', 'mongodb://localhost:27017/repo.guid_repo')\
    .config('spark.mongodb.output.uri', 'mongodb://localhost:27017/repo.guid_repo')\
    .config('spark.jars.packages', 'org.mongodb.spark:mongo-spark-connector_2.12:3.0.1')\
    .getOrCreate()
# df=spark.read.format("mongo").option("uri","mongodb://localhost:27017/repo.guid_repo").load()
# df.show()
# connectionString = "mongodb://{0}:{1}@{2}:{3}/{4}.{5}?ssl=true&replicaSet=globaldb".format(userName, primaryKey, host, port, database, collection)
# connectionString='mongodb://localhost:27017'
df = spark.read\
    .format("com.mongodb.spark.sql.DefaultSource")\
    .option("database","repo")\
    .option("collection", "guid_repo")\
    .load()
df.show()