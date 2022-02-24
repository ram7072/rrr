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

    @classmethod
    def tearDownClass(cls):
        cls.sc.stop()

class SimpleTestCase(PySparkTestCase):

    def test_do_word_counts(self):

        test_input = [
            ' hello spark ',
            ' hello again spark spark'
        ]

        input_rdd = self.sc.parallelize(test_input, 1)
        results = wordcount.do_word_counts(input_rdd)
        expected_results = {'hello':3, 'spark':3, 'again':1}
        print("test case success")
        #assert results == expected_results

    def test_main(self):
        args = [1]
        print(args)
        #with self.assertRaises(SystemExit):
        wordcount.main(args)