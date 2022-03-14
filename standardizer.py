import json
import time
import pandas as pd
import logging
import datetime
from standardization_functions import *
from mongoengine import connect
import pymongo

# LOG_FILENAME = datetime.datetime.now().strftime(
#     'D:\\Users\\rnabar\\Pycharmprojects\\pythonProject\\log\\logfile_standardization_%d-%m-%y_%H%M%S.log')
# for handler in logging.root.handlers[:]:
#     logging.root.removeHandler(handler)
# logging.basicConfig(filename=LOG_FILENAME, level=logging.DEBUG)

def get_db_connection():
    try:
        myclient = pymongo.MongoClient("mongodb://localhost:27017/")
        print("Connected successfully!!!")
        mydb = myclient["Person"]
        return mydb
    except Exception as e:
        print("Could not connect to MongoDB with error :"+str(e))
        exit(1)

def get_domain_attributes(domain_id):
    try:
        mydb = get_db_connection()
        domain_info = mydb["DomainMaster"].find({'domainId': domain_id})
        domain_attributes = domain_info[0]['attributes']
        return domain_attributes
    except Exception as e:
        print("Could not read DomainMaster Collection with error :" + str(e))
        exit(1)


def get_standardization_rules(domain_id):
    domain_attributes = get_domain_attributes(domain_id)
    standardization_rules_dict = {}
    for ruledict in domain_attributes:
        if 'standardization_rules' not in ruledict.keys() or not len(ruledict['standardization_rules']):
            continue
        else:
            if 'domainAttributeLevel2' in ruledict.keys():
                if ruledict['domainAttributeLevel1'] in standardization_rules_dict.keys():
                    standardization_rules_dict[ruledict['domainAttributeLevel1']].update({ruledict["domainAttributeLevel2"]: ruledict['standardization_rules']})
                else:
                    standardization_rules_dict[ruledict['domainAttributeLevel1']] = {ruledict["domainAttributeLevel2"]: ruledict['standardization_rules']}
            else:
                standardization_rules_dict[ruledict['domainAttributeLevel1']] = ruledict['standardization_rules']
    print('Standardization Rules :' + str(standardization_rules_dict))
    return standardization_rules_dict


def standardize(df, domain_id, session_id, source_id):
    # Create Additional Columns to identify unique records
    df['session_id'] = session_id
    df['sourceId'] = source_id
    try:
        # Get Third Column to identify unique records
        mydb = get_db_connection()
        source_info = mydb["SourceMaster"].find({'sourceId': source_id})
        mappedFields_from_source = source_info[0]['mappedFields']
        print('Source MPrimary Identifier : ' + str(mappedFields_from_source[0]['PrimaryIdentifier']))
        for fld in mappedFields_from_source:
            if fld['PrimaryIdentifier']:
                unique_identifier_column = fld['domainAttributeLevel1']
                break
    except Exception as e:
        print("Error in getting PrimaryIdentifier column :" + str(e))
        exit(1)
    # Columns to identify unique records
    unique_record_identifiers = ['session_id', 'sourceId', unique_identifier_column]
    # Drop duplicate con id's and keep first record
    df.drop_duplicates(subset=unique_record_identifiers, keep="first", inplace=True)
    #print('Dataframe Length after removing duplicates:' + str(len(df)))
    # Get Standardization functions configured for attributes
    rules = get_standardization_rules(domain_id)
    # Start Time
    t1 = time.time()
    final_df = df[unique_record_identifiers]
    attributes_to_standardize = [col for col in df.columns.values if col not in unique_record_identifiers]
    print('Attributes to Standardize : '+str(attributes_to_standardize))
    for attr in attributes_to_standardize:
        if attr in rules.keys():
            logging.info("Standardization of: {0} - Begins for Input Json Data".format(attr))
            print("Standardization of: {0} - Begins for Input Json Data".format(attr))
            # Get Attribute Dataframe
            inter_df = df[["session_id", "sourceId", unique_identifier_column, attr]]
            try:
                # Apply Configured functions to attribute
                if isinstance(rules[attr], list):
                    for fn in rules[attr]:
                        func = globals()[fn]
                        inter_df = func(inter_df)
                else:
                    inter_df = standardize_level2_attribute(inter_df, rules[attr])
            except Exception as e:
                print('Error in Function Execution : '+str(e))
            # Merge Individual Attribute Standardized Dataframes
            #print('Inter DF : '+str(inter_df))
            #print('Final DF before Merging: ' + str(final_df))
            final_df = final_df.merge(inter_df, how="inner", on=["session_id", "sourceId", unique_identifier_column])
            #print('Final DF after Merging: ' + str(final_df))
        else:
            logging.error("Rules for Standardization of {0} Not Configured".format(attr))
            print("Rules for Standardization of {0} Not Configured".format(attr))
            # Get Attribute Dataframe
            inter_df = df[["session_id", "sourceId", unique_identifier_column, attr]]
            # Merge Attribute Dataframe as it is as rules not configured
            #print('Inter DF : ' + str(inter_df))
            #print('Final DF before Merging: ' + str(final_df))
            final_df = final_df.merge(inter_df, how="inner", on=["session_id", "sourceId", unique_identifier_column])
            #print('Final DF after Merging: ' + str(final_df))

    # Drop Additional Columns
    final_df.drop('session_id', axis=1, inplace=True)
    final_df.drop('sourceId', axis=1, inplace=True)
    t2 = time.time()
    print('Time taken to standardize all attributes :' + str(t2 - t1))
    print('Final Dataframe :\n' + str(final_df))
    return final_df


if __name__ == '__main__':
      print('Start Execution')
      input = 'D:\\Users\\rnabar\\PycharmProjects\\pythonProject\\DI_new\\Output_Files\\integrated_csv_to_json.json'
#     csv_input = 'D:\\Users\\rnabar\\PycharmProjects\\pythonProject\\Standardization\\input\\PER019_SBL035_14-06-22-04-43-56.csv'
      json_output = 'D:\\Users\\rnabar\\PycharmProjects\\pythonProject\\Standardization\\test_output\\test_output.json'
#     json_input_new = 'D:\\Users\\rnabar\\PycharmProjects\\pythonProject\\Standardization\\input\\test_file_new.json'
#     #exception_records = 'D:\\Users\\rnabar\\PycharmProjects\\pythonProject\\Standardization\\input\\reviewer_exception.json'
      csv_output = 'D:\\Users\\rnabar\\PycharmProjects\\pythonProject\\Standardization\\test_output\\test_output_csv.csv'
#     # Read Input json into dataframe
#     print('Reading Input Json')
      with open(input, 'rb') as f:
          data = json.load(f, encoding="utf-8")
#     print('Reading Into dataframe')
      df = pd.DataFrame(data)
#     #df = pd.read_csv(csv_input, sep='|')
#     #df.to_json(json_input_new, indent=4, orient='records')
#     print('Input DataFrame :\n'+str(df))
#     print('Input Json Read')
#     # Apply rules to input dataframe
      standardized_df = standardize(df, 'PER019', 1234, 'SBL035')
#     # Write Final Standardized Dataframe to files
      standardized_df.to_csv(csv_output, index=False)
      standardized_df.to_json(json_output, indent=4, orient='records')
