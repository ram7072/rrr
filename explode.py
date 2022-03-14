import urllib.request
from pyspark import SparkContext, SparkConf
from pyspark.sql import *
from pyspark.sql.functions import *
from pyspark.sql import functions as sf
import os
os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages com.databricks:spark-avro_2.11:4.0.0  pyspark-shell'

def main():
    sc = SparkContext(master="local", appName="test")
    sc.setLogLevel("Error")
    spark = SparkSession.builder.getOrCreate()
    url = "https://randomuser.me/api/0.8/?results=10"
    response = urllib.request.urlopen(url)
    datadecode = response.read().decode('utf-8')
    rdd = sc.parallelize([datadecode])
    rdd.foreach(print)
    results = spark.read.json(rdd)
    results.printSchema()
    results1 = results.withColumn("results", explode(sf.col("results"))) \
        .select("results.user.gender", "results.user.name.*", "results.user.location.*",
                "results.user.email", "results.user.username", "results.user.password",
                "results.user.salt", "results.user.md5", "results.user.sha1",
                "results.user.sha256", "results.user.registered",
                "results.user.dob", "results.user.phone", "results.user.cell",
                "results.user.picture.*", "nationality", "seed", "version") \
        .withColumn("username", regexp_replace(sf.col("username"), '[0-9]', ''))

    results1.show()
    results1.printSchema()

    # results1.write.format("com.databricks.spark.avro") \
    #     .mode("overwrite") \
    #     .option("header", "true").option("inferSchema", "true") \
    #     .save("C:/Users/Rajaraman/Desktop/softwares -spark/dataspark/results1_avro")
    # results1.write.format("json") \
    #     .mode("overwrite") \
    #     .save(r''

if __name__ == '__main__':
    main()
