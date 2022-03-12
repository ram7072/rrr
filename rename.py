import sys
import logging
import pyspark
from pyspark.sql import SparkSession
import json
spark = SparkSession.builder.getOrCreate()

def rename_columns(df,columns):
    for old_name,new_name in columns.items():
        df= df.withColumnRenamed(old_name,new_name)
    return df
def load_and_rename_test(source_path,target_column_headers: list[str],target_path):
    df = spark.read.options(sep=",", header="true").csv(source_path)
    df.show()
    #df = rename_columns(df, target_column_headers)
    df1=rename_columns(df, conf['columns'])
    df1.show()
  # Test Condition to check whether the column is renamed successfully
    #target_column_headers=list(columns.values)
    l_headers=list(target_column_headers.values())
    for i in df1.columns:
        if i in l_headers:
            print('Renamed columns are {}'.format(i))
            print('Test condition Passed')
            df1.write.option('header','true').csv(target_path)
        else:
            pass
def load_run_configs() -> list[dict]:
    return [
        {
            "source_path": "C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt",
            "target_path": "C:/Users/10638056/Desktop/RRR Training/data/renamedforage2",
            "columns": {"age": "age_test"},
        },
        {
            "source_path": "C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt",
            "target_path": "C:/Users/10638056/Desktop/RRR Training/data/renamedforx2",
            "columns": {"x": "x_test"},
        },
        {
            "source_path": "C:/Users/10638056/Desktop/RRR Training/data/sparkdata.txt",
            "target_path": "C:/Users/10638056/Desktop/RRR Training/data/renamedforworkclass2",
            "columns": {"workclass": "workclass_test"}
        }

    ]
run_configs = load_run_configs()
total_iterations = len(run_configs)
count = 1
for conf in run_configs:
    print("Executing configuration ({} of {}) \r".format(count, total_iterations))
    load_and_rename_test(conf["source_path"],conf['columns'],conf["target_path"])
    count=count+1


