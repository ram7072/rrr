from pymongo import MongoClient
from mongoengine import connect
# import config
# from configurator import config
# pprint library is used to make the output look more pretty
from pprint import pprint

def mongo_config():
    global collection
    mongoclient = MongoClient('mongodb://localhost:27017/')
    # for grouping
    db = mongoclient["Grouping_db"]
    collection = db["Grouping_records"]
    return collection

data = mongo_config()


# for Grouping
# data.insert_one(
#     {'bucket_grp' : 'u',
#     'l1_grouping' : 'last_name',
#     'l2_grouping' : 'first_name',
#     'g1_lower_limit' : 2,
#     'g1_upper_limit' : 1000,
#     'g2_lower_limit' : 2,
#     'g2_upper_limit' : 1000,
#     'root_path' : 'D:/grouping/',
#     'g1_bucket_path' : '/G1_2_999/',
#     'g2_bucket1_path' : '/G1_1000+/G2_2_999/',
#     'g2_bucket2_path' : '/G1_1000+/G2_1000+/',
#     'g2_bucket3_path' : '/G1_1000+/G2_Unique/',
#     'g2U_bucket1_path' : '/G1_Unique/G2_2_999/',
#     'g2U_bucket2_path' : '/G1_Unique/G2_1000+/',
#     'g2U_bucket3_path' : '/G1_Unique/G2_Unique/',
#     'l1_file_prefix' : 'L1_',
#     'l2_file_prefix' : 'L2_',
#     'l2U_file_prefix' : 'L2_U_',
#     'src_file_name' : 'last_name_u',
#     'file_ext' : '.csv'
#      }
# )

# abc = collection.find_one({},{"l1_grouping":1})
# l1_grouping = collection.distinct("l1_grouping")[0]
grouping = collection.distinct("grouping")
print(grouping)
for dict in grouping:
    bucket_grp = dict['bucket_grp']
    l1_grouping = dict["level1"]['criteria']
    l2_grouping_1 = dict["level2"]["criteria"]
    l2_grouping = dict["level2"]["criteria1"]
    l2_grouping1 = dict["level2"]["criteria2"]
    g1_lower_limit = dict["level1"]["lower_limit"]
    g1_upper_limit = dict["level1"]["upper_limit"]
    g2_lower_limit = dict["level2"]["lower_limit"]
    g2_upper_limit = dict["level2"]["upper_limit"]
    root_path = dict["path"]["root_path"]
    ########### old logic parameter ###########
    g1_bucket_path = dict["path1"]["g1_bucket_path"]
    g2_bucket1_path = dict["path1"]["g2_bucket1_path"]
    g2_bucket2_path = dict["path1"]["g2_bucket2_path"]
    g2_bucket3_path = dict["path1"]["g2_bucket3_path"]
    g2U_bucket1_path = dict["path1"]["g2U_bucket1_path"]
    g2U_bucket2_path = dict["path1"]["g2U_bucket2_path"]
    g2U_bucket3_path = dict["path1"]["g2U_bucket3_path"]
    l1_file_prefix_old = dict["prefix1"]["l1_file_prefix"]
    l2_file_prefix_old = dict["prefix1"]["l2_file_prefix"]
    l2U_file_prefix = dict["prefix1"]["l2U_file_prefix"]
    ############# New logic ###############
    l2_buckt_path = dict["path"]["l2_buckt_path"]
    l2_buckt_path1 = dict["path"]["l2_buckt_path1"]
    l2_buckt_path2 = dict["path"]["l2_buckt_path2"]
    l1_file_prefix = dict["prefix"]["l1_file_prefix"]
    l2_file_prefix = dict["prefix"]["l2_file_prefix"]
    l2_file_prefix1 = dict["prefix"]["l2_file_prefix1"]
    l2_file_prefix2 = dict["prefix"]["l2_file_prefix2"]
    l2_u_prefix = dict["prefix"]["l2_u_prefix"]
    l2_u_prefix1 = dict["prefix"]["l2_u_prefix1"]
    l2_u_prefix2 = dict["prefix"]["l2_u_prefix2"]
    src_file_name = dict["src_file_name"]
    file_ext = dict["file_ext"]
    print(file_ext,src_file_name, l2U_file_prefix, l2_file_prefix, l1_file_prefix, g2U_bucket3_path, g2U_bucket2_path, g2U_bucket1_path,
          g2_bucket3_path, g2_bucket2_path, g2_bucket1_path, g1_bucket_path, root_path, g2_upper_limit, g2_lower_limit, g1_upper_limit,
          g1_lower_limit,l2_grouping, l2_grouping1, l1_grouping,bucket_grp )
# print(bucket_grp)

# obj = data.distinct()
# obj = data.collection.find( { })
# print(data)
# print("object is :", obj)





# table = db.Contact
# print(db)
# print(table)
# for doc in table.find():
#     pprint(doc)
# with MongoClient() as client:
#     db = client.Person
#     for doc in db.Contact.find():
#         pprint(doc)

# connection = connect(db="Person", host="localhost", port=27017)
# db = connection.Person
# print(connection)
# print(db)
# table = db.Contact
# print(table)
# for doc in table.find():
#     pprint(doc)
# user = config.credentails['user']
# password = config.credentails['pass']
# host = config.credentails['host']
# port = config.credentails['port']
# db = config.credentails['db']
# table = config.credentails['table']
#
# connection = connect(db=db, host=host, port=port)
# db = connection.Person
# # print(connection)
# # print(db)
# table = db.Contact
# # print(table)
# for doc in table.find():
#     pprint(doc)
# print(config)
# user = config.get("db_credentails", "host")
# password = config.get("db_credentails", "pass")
# port = config.get("db_credentails", "port")
# db = config.get("db_credentails", "db")
# host = config.get("db_credentails", "host")
# table = config.get("db_credentails", "table")
#
# try:
#     connection = connect(db=db, host=host, port=int(port))
#     print("Connected successfully!!!")
# except:
#     print("Could not connect to MongoDB")
# document = connection.Person
# print(connection)
# print(db)
# collection = document.Contact
# print(table)
# for doc in table.find():
#     pprint(doc)

