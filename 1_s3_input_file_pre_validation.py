import json
import os
import datetime
import re
import shutil
import threading
import pandas as pd
import csv
from mongodb_python_connection import connection


def validate_source_input_files(*args, **kwargs):
    """
    Function to validate the source file. Called from Main
    :param args: list of all sources which are mapped from mongoDB
    :param kwargs: None
    :return: None
    """
    # Getting the Count of thread needs to be created
    no_of_threads = len(args[0])
    print("no_of_threads required-", no_of_threads)

    new_source_thread = threading.Thread(target=thread_function, args=(args[0][0],))
    new_source_thread.start()
    # for _thread in range(0, no_of_threads):
    #     #         print(args[0][_thread])
    # Creating the Thread
    #     new_source_thread = threading.Thread(target=thread_function, args=(args[0][_thread],))
    #     new_source_thread.start()
    exit()

def getcount(file):
    """
    This Function Will return the count of records in the file
    :param file: input file
    :return: count of records present
    """
    count_of_records = 0
    if file.endswith(".csv"):
        with open(file) as file:
            reader = csv.reader(file)
            count_of_records = len(list(reader))
    elif file.endswith(".json"):
        with open(file) as file:
            jsonOBJ = json.load(file)
            print(jsonOBJ)
            count_of_records = len(jsonOBJ)
    return count_of_records

def check_file_extension(file):
    """
    This function will check for the extension of the file.
    :param file: file name
    :return: True or False
    """
    if file.endswith((".csv", ".json")):
        return True
    else:
        return False

def check_delimeter(file, DELIMITER):
    """
    This function will check for the delimiter in the csv file only
    :param file: csv file, sourcename
    :return: True or False
    """
    print(file)
    print(DELIMITER)
    with open(file, newline="") as csvfile:
        try:
            dialect = csv.Sniffer().sniff(csvfile.read(1024), delimiters=DELIMITER)
            print(dialect)
            print("Delimiter is ,")
            return True
        except:
            print("Wrong Delimiter")
            return False

def check_header(file, src):
    """
    This function will check for the header weather is is present in csv file or not
    :param file: csv file
    :param src: name of the source of which the file is getting processed
    :return: True or False
    """
    print("------------------Inside check_header Function------------")
    print("File-", file)
    print("src-", src)
    global VALIDATED_FILE_DESTINATION
    try:
        with open(file) as f:
            header = csv.Sniffer().has_header(f.read(1024))
            print(header)
            if header == True:
                csv_df = pd.read_csv(file, header="infer")
                csv_columns = csv_df.columns
                #  print("csv_columns-", csv_columns)
                #  print("len csv_columns-", len(csv_columns))
                with open(source_column_mapping) as mapping_file:
                    source_column = json.load(mapping_file)
                    required_no_of_column = len(source_column[src])
                    #  print("required_no_of_column-", required_no_of_column)
                    input_column_no = 0
                    for key, value in source_column[src].items():
                        for each_val in value:
                            if each_val in csv_columns:
                                input_column_no += 1
                    print("required_no_of_column-", required_no_of_column)
                    print("input_column_no-", input_column_no)
                    print("---------Outside For Loop---------")
                    if required_no_of_column == input_column_no:
                        print("Header is Validated")
                        return True
                    else:
                        print("Write that file to Respective Error Folder")
                        print("Send Error Mail to DSO")
    except Exception as e:
        print("error-", e)

def copy_src_to_dest(ROOT_PATH, OLD_FILENAME, NEW_FILENAME, SOURCE, DESTINATION):
    """
    This is to copy the file from one source to destination
    :param ROOT_PATH: Root path of the file
    :param OLD_FILENAME: Old filename
    :param NEW_FILENAME: New filename
    :param SOURCE: Source Name
    :param DESTINATION: Destination Folder
    :return: True or False
    """
    print("------------------Inside copy_src_to_dest Fucntion------------")
    #     s3 = boto3.resource('s3')
    NEW_DESTINATION = ROOT_PATH + "/" + DESTINATION
    OLD_SOURCE = ROOT_PATH + "/" + SOURCE + "/" + OLD_FILENAME
    print("NEW_DESTINATION-", NEW_DESTINATION)
    print("OLD_SOURCE-", OLD_SOURCE)

#  s3.Object(NEW_DESTINATION, NEW_FILENAME).copy_from(CopySource = OLD_SOURCE)
#  s3.Object('my_bucket','old_file_key').delete()

def getname(file, count_of_records, source_name):
    """
    This is file to get the New Name for the File
    :param file: Name of the Old File
    :param count_of_records: Total no of Record
    :param source_name: Name of the Souce
    :return: New File Name
    """
    print("------------------Inside getname Function- Create New Name-----------")
    source = file.split('/')[-1]
    name = source.split('.')[0]
    ext = source.split('.')[1]
    print("source-", source)
    print("name-", name)
    fileName = name + '_validated_' + str(datetime.datetime.now().strftime('%d%m%Y%H%M%S')) + "_" + str(
        count_of_records) + "." + ext
    print("filename-", fileName)
    #     copy_src_to_dest(source_name, file, fileName, "input", VALIDATED_INPUT_FILE)
    return fileName

def check_valid_name(_file, source):
    # siebel_123456789
    # pattern = source + "_" + str(datetime.datetime.now().strftime('%d-%m-%Y %H:%M:%S'))
    # tt = str(datetime.datetime.now().strftime('%d%m%Y%H%M%S'))
    # print(tt)

    # This list will dynamically Populated from Main Function
    # sources = ['siebel', 'gigya', 'author', 'editor']   # Global Variable source_list
    filename = _file.split(".")[0]
    input_filename_source = filename.split("_")[0]
    timestamp = filename.split("_")[1]
    print(timestamp)
    if input_filename_source not in source_list:
        print(" Invalid File Name Convention")
        return False
    else:
        print("Source Name Matched")

        # Checking if the File is Placed in Respective Source Folder Only
        if input_filename_source.lower() == source.lower():
            print(" File is Properly Placed in Respective Source Folder ")
            matched = re.match(r'\d+', timestamp)
            print("matched-", matched)
            if matched is not None:
                print("Valid Input File Name")
                return True
            else:
                return False

        else:
            print(" File is Wrongly Placed in Wrong Source Folder ")
            return False

    print("------------------Inside null_check Function------------")
    print("File-", file)
    print("src-", src)
    print("sourceId-", sourceId)

    error_file = src + "_null_value_records_"
    # Getting the Columns name on Which Null Check needs to be performed
    null_check_attr = []
    for y in source_registration_schema.find({"sourceId": sourceId}):
        for _attribute in y['mandatory-attributes']:
            if y['mandatory-attributes'][_attribute]['isNull'] == 'False':
                null_check_attr.append(_attribute)
    print(null_check_attr)

    null_record_count = 0
    extension = ''
    # If the File is csv
    if file.endswith(".csv"):
        extension = '.csv'
        input_file_df = pd.read_csv(file)
        columns = list(input_file_df.columns)
        columns.append('comment')
        with open('error.csv', 'a', newline='') as f_object:
            writer_object = csv.writer(f_object)
            writer_object.writerow(columns)
            f_object.close()
        for each in null_check_attr:
            record = input_file_df[input_file_df[each].isnull()]
            input_file_df = input_file_df[input_file_df[each].notna()]
            if len(record) > 0:
                null_record_count += 1
                record['comment'] = each + " is null"
                record.to_csv('error.csv', mode='a', index=False, header=False)

    # If the File is json
    if file.endswith(".json"):
        extension = '.json'
        input_file_df = pd.read_json(file)
        print(input_file_df)
        columns = list(input_file_df.columns)
        columns.append('comment')
        with open('error.csv', 'a', newline='') as f_object:
            writer_object = csv.writer(f_object)
            writer_object.writerow(columns)
            f_object.close()
        for each in null_check_attr:
            record = input_file_df[input_file_df[each] == '']
            input_file_df = input_file_df[input_file_df[each] != '']
            if len(record) > 0:
                null_record_count += 1
                record['comment'] = each + " is null"
                record.to_csv('error.csv', mode='a', index=False, header=False)

    print(input_file_df)

    # Get New Name for the Existing Validated File Name
    count_of_records = len(input_file_df)
    print("count_of_records-", count_of_records)
    validated_file_name = getname(file, count_of_records, src)
    print("validated_file_name-", validated_file_name)

    # Writing the Remaining Not NULL record csv to a Validated file
    if extension == '.csv':
        input_file_df.to_csv(validated_file_name, index=False, header=True)
    else:
        input_file_df.to_json(validated_file_name)

    # Moving the File to Validated - Have to replace this function with S3 copy function
    shutil.move(validated_file_name, VALIDATED_FILE_DESTINATION)
    print("Moved to Validated folder")

    # Moving the Original Input File to Archive
    shutil.move(file, ARCHIVE_FILE_DESTINATION)
    print("Moved to Archive folder")

    # Copy the Error File to Error Folder and Send Mail
    error_file = error_file + str(null_record_count) + str(datetime.datetime.now().strftime('%d%m%Y%H%M%S')) + extension
    print("error_file-", error_file)
    os.rename("error.csv", error_file)
    shutil.move(error_file, ERROR_FILE_DESTINATION)
    print("Moved to Error folder")

    # Send Mail
    exit()
    return 1
def thread_function(source_name):
    """
    Function Which Will be executed by Each Thread
    :param source_name:
    :return:
    """
    print("------------------Inside Thread Function------------")
    print("source_name-", source_name)

    src = source_name.split("/")[-1]
    print("src-", src)  # siebel

    global VALIDATED_FILE_DESTINATION, ERROR_FILE_DESTINATION, INPUT, ARCHIVE_FILE_DESTINATION, sourceId, DELIMITER

    ###########################Get All requied folders from MongoDB##############
    for x in source_registration_schema.find({"sourceName": src}):
        sourceId = x['sourceId']

    for y in source_registration_schema.find({"sourceId": sourceId}):
        print(y)
        INPUT = source_name + "/" + y['folder-structure']['input']
        VALIDATED_FILE_DESTINATION = source_name + "/" + y['folder-structure']['validated']
        ERROR_FILE_DESTINATION = source_name + "/" + y['folder-structure']['error']
        ARCHIVE_FILE_DESTINATION = source_name + "/" + y['folder-structure']['archive']
        DELIMITER = y['delimeter']
        sourceId = y['sourceId']

    print(INPUT)
    print(VALIDATED_FILE_DESTINATION)
    print(ERROR_FILE_DESTINATION)
    print(ARCHIVE_FILE_DESTINATION)

    source = INPUT
    print("Input source-", source)

    # File Existence Check
    if len(os.listdir(source)) > 0:
        # no_of_files  = len(os.listdir(source))
        all_files = os.listdir(source)
        print("No of Files-", all_files)
        for _file in all_files:
            filename = source + _file
            print("Inside For Loop-", filename)
            # filesize = (os.stat(filename).st_size == 0)
            # print(filesize)
            if os.stat(filename).st_size != 0:
                print(" File is not Empty i.e greater than 0 bytes ")

                if check_file_extension(_file):
                    print(" Valid Extension for ", source, "-", _file)
                    is_name_valid = check_valid_name(_file, src)
                    if is_name_valid:
                        print(" Valid File Format ")
                        if filename.endswith(".json"):
                            # Getting the Count of Records/ Objects
                            count_of_records = getcount(filename)
                            if count_of_records > 0:
                                print(" File Contain Records ")
                                # Check for Null Record Before Sending to Standardization & Also Before Creating
                                # A single JSON File
                                

                            else:
                                print("No record Present - Write that file to ", ERROR_FILE_DESTINATION)
                                # Moving the File to Error - Have to replace this function with S3 copy function
                                shutil.move(filename, ERROR_FILE_DESTINATION)
                                # print("Send Error Mail to DSO for Invalid Header")

                        else:

                            # Validating the Header for csv file
                            valid_header = check_header(filename, src)
                            if valid_header:
                                print(" Valid Header for ", source, "-", _file)

                                # Validating the delimiter of the csv file
                                valid_delimeter = check_delimeter(filename, DELIMITER)

                                if not valid_delimeter:
                                    print("Invalid Delimeter for ", source, "-", _file)
                                    shutil.move(filename, ERROR_FILE_DESTINATION)

                                    print("Invalid Delimeter - Write that file to ", ERROR_FILE_DESTINATION)
                                    # print("Send Error Mail to DSO for Invalid Delimeter")
                                else:
                                    print("Valid Delimeter for ", source, "-", _file)
                                    count_of_records = getcount(filename)
                                    
                            else:
                                print("Invalid Header - Write that file to ", ERROR_FILE_DESTINATION)
                                # Moving the File to Error - Have to replace this function with S3 copy function
                                shutil.move(filename, ERROR_FILE_DESTINATION)
                                # print("Send Error Mail to DSO for Invalid Header")

                    else:
                        print("Invalid FileName Format or File is Wronlgy Placed in worng source Folder"
                              " - Write that file to Respective Error Folder")
                        # Moving the File to Error - Have to replace this function with S3 copy function
                        shutil.move(filename, ERROR_FILE_DESTINATION)
                        # print("Send Error Mail to DSO for Invalid Extension")
                else:
                    print("Invalid Extension - Write that file to Respective Error Folder")
                    # Moving the File to Error - Have to replace this function with S3 copy function
                    shutil.move(filename, ERROR_FILE_DESTINATION)
                    # print("Send Error Mail to DSO for Invalid Extension")
            else:
                print("Empty File - Write that file to Respective Error Folder")
                # Moving the File to Error - Have to replace this function with S3 copy function
                shutil.move(filename, ERROR_FILE_DESTINATION)
                # print("Send Error Mail to DSO for Invalid Extension")
    else:
        print("No File Present - Send Error Mail to Admin")

def main():
    #     ROOT_PATH = "ieee-source-bucket"
    global ROOT_PATH, VALIDATED_INPUT_FILE, source_column_mapping

    ROOT_PATH = "s3://ieee-source-bucket"
    VALIDATED_INPUT_FILE = "validated-input-file"
    source_column_mapping = "source_column_mapping.json"

    ####################################### Below Values are Mapped from  MongoDB ###################
    # siebel = ROOT_PATH + "/siebel"
    # author = ROOT_PATH + "/author"
    # reviewer = ROOT_PATH + "/reviewer"
    # editor = ROOT_PATH + "/editor"

    ########################### Getting Document Connection from Mongo DB############################
    global source_registration_schema, guid_collection, golden_record_collection, sourceId, source_list
    document = connection.person
    guid_collection = document.guid_repository
    golden_record_collection = document.golden_record
    source_registration_schema = document.source_registration
    domain_registration_schema = document.domain_master

    for item in domain_registration_schema.find({"doaminId": "p1111"}):
        ROOT_PATH = item['s3Bucket']

    source_list = []
    for x in source_registration_schema.find({"doaminId": "p1111"}):
        source_list.append(ROOT_PATH + "/" + x['sourceName'])

    print(source_list)
    validate_source_input_files(source_list)


if __name__ == '__main__':
    main()
