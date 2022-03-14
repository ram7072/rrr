import json
import time
import pandas as pd
import logging
import datetime
from standardization_functions import *

LOG_FILENAME = datetime.datetime.now().strftime(
    'D:\\Users\\logfile_standardization_%d-%m-%y_%H%M%S.log')
for handler in logging.root.handlers[:]:
    logging.root.removeHandler(handler)
logging.basicConfig(filename=LOG_FILENAME, level=logging.DEBUG)

def get_standardization_rules():
    #myclient = pymongo.MongoClient('mongodb://localhost:27017/')
    #mydb = myclient["guid"]
    #standardization = mydb["standardization"]
    #standardization_rules_dict = {}
    #for ruledict in standardization.find():
        #for i in ruledict['std_rules']:
            #standardization_rules_dict[i] = dict['std_rules'][i]["functions"]
    # Expected output from mongo db
    Rules = {
        'First_Name': [remove_accents, remove_honorifics, remove_email_patterns, remove_characters_other_than_alphabets,
                       multiple_spaces, lowercase, ltrim, rtrim, remove_nan],
        'Middle_Name': [remove_accents, remove_honorifics, remove_email_patterns,
                        remove_characters_other_than_alphabets, multiple_spaces, lowercase, ltrim, rtrim, remove_nan],
        'Last_Name': [remove_accents, remove_honorifics, remove_email_patterns, remove_characters_other_than_alphabets,
                      multiple_spaces, lowercase, ltrim, rtrim, remove_nan],
        'Email': [remove_nan, remove_email_special_chars, lowercase, ltrim, rtrim, get_valid_emails],
        'Phone_Number': [get_valid_phones],
        'org_name': [get_valid_orgz, lowercase, remove_characters_other_than_alphabets_numbers, multiple_spaces, ltrim,
                     rtrim],
        'Date_of_Birth': [get_valid_dates, ltrim, rtrim],
        'Personal_Address': [get_valid_addresses, lowercase, remove_characters_other_than_alphabets_numbers,
                             multiple_spaces, ltrim, rtrim],
        'Professional_Address': [get_valid_addresses, lowercase, remove_characters_other_than_alphabets_numbers,
                                 multiple_spaces, ltrim, rtrim]
        }
    return Rules


def read_json():
    input = 'D:\\Users\\test_file_2.json'
    # Read Input json into dataframe
    print('Reading Input Json')
    with open(input, 'rb') as f:
        data = json.load(f, encoding="utf-8")
    print('Reading Into dataframe')
    df = pd.DataFrame(data)
    #df = pd.read_json(input)
    print('Input Json Read')
    # Sort Values Alphabetically with First Name
    df = df.sort_values(['First_Name'])
    print(df)
    print('Dataframe Length:'+str(len(df)))
    # Drop duplicate con id's and keep first record
    df.drop_duplicates(subset="con_id", keep="first", inplace=True)
    print('Dataframe Length after removing duplicates:' + str(len(df)))
    return df

def apply_rules(rules, df):
    # Start Time
    t1 = time.time()
    json_output = 'D:\\Users\\test_output_2.json'
    exception_records = 'D:\\Users\\test_2_exception.json'
    csv_output = 'D:\\Users\\test_output_2_csv.csv'
    final_df = df['con_id'].to_frame()
    for atr, func in rules.items():
        logging.info("Standardization of: {0} - Begins for Input Json Data".format(atr))
        print("Standardization of: {0} - Begins for Input Json Data".format(atr))
        # Get Attribute Dataframe
        print(atr,'raja')
        inter_df = df[['con_id', atr]]
        print(atr,': is completed')
        # Apply Configured functions to attribute
        for fn in func:
            print(fn,':raja')
            inter_df = fn(inter_df)
        # Merge Individual Attribute Standardized Dataframes
        final_df = final_df.merge(inter_df, how="inner", on=['con_id'])

    t2 = time.time()
    print('Time taken to standardize all attributes :'+str(t2-t1))
    print('Final Dataframe :\n'+str(final_df))

    # Write Final Standardized Dataframe to files
    final_df.to_csv(csv_output, index=False)
    final_df.to_json(json_output, indent=4, orient='records')


if __name__ == '__main__':
    print('Start Execution')
    # Get Standardization functions configured for attributes
    rules = get_standardization_rules()
    # Get Input Dataframe
    df = read_json()
    # Apply rules to input dataframe
    apply_rules(rules, df)
