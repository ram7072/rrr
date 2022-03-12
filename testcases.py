# wordcount_test.py
import pytest
import wordcount
import unittest
import pyspark
import sys

class PySparkTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        conf = pyspark.SparkConf().setMaster("local[*]").setAppName("testing")
        cls.sc = pyspark.SparkContext(conf=conf)
        cls.spark = pyspark.SQLContext(cls.sc)

    # @classmethod
    # def tearDownClass(cls):
    #     cls.sc.stop()

class SimpleTestCase(PySparkTestCase):

    def test_do_word_counts(cls):

        test_input = [
            ' hello spark ',
            ' hello again spark spark'
        ]
        input_rdd = cls.sc.parallelize(test_input, 1)
        print(input_rdd)
        results = wordcount.do_word_counts(input_rdd)
        print(results)

SimpleTestCase.test_do_word_counts()
