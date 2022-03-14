import json
import logging
import re
import sys
import numpy as np
import pandas as pd
import unicodedata
import unidecode
from dateutil import parser
import datetime
from calendar import monthrange

def get_object_columns(df):
    cols = df.iloc[:, 1:].select_dtypes(include=[np.object]).columns
    print('Object Columns:' + str(cols))
    return cols

def ltrim(df):
    print('In ltrim')
    df = df.applymap(lambda x: x.lstrip() if isinstance(x, str) else x)
    print('Leading Spaces Removed :'+str(df))
    return df

def rtrim(df):
    print('In rtrim')
    df = df.applymap(lambda x: x.rstrip() if isinstance(x, str) else x)
    print('Trailing Spaces Removed :' + str(df))
    return df

def remove_accents(record):
    print('In remove_accents')
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        print(cols)
        print('Object Columns :'+str(cols))
        # Remove Accents
        record[cols] = record[cols].apply(
            lambda x: x.str.normalize("NFKD").str.encode("ascii", errors="ignore").str.decode("utf-8"))
        print("Normalized df :\n" + str(record))
        return record
    elif isinstance(record, str):
        record = unidecode.unidecode(record)
        print(record,'raja')
        return record
    elif isinstance(record, list):
        for i in range(len(record)):
            record[i] = unidecode.unidecode(record[i])
        print('Accents Removed list:' + str(record))
        return record
    elif isinstance(record, dict):
        for k, v in record.items():
            if v == 'nan' or v is None or v is np.nan:
                v = ""
            else:
                v = unidecode.unidecode(v)
        print('Accents Removed dict:' + str(record))
        return record


def remove_characters_other_than_alphabets(record):
    print('In remove_characters_other_than_alphabets')
    pat = r"[^a-zA-Z\s]+"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove some special characters
        record[cols] = record[cols].replace(pat, "", regex=True)
        print('Special characters other than alphabets removed :' + str(record))
        return record
    elif isinstance(record, str):
        record = re.sub(pat, "", record)
        print('Special characters other than alphabets removed :' + str(record))
        return record
    elif isinstance(record, list):
        for i in range(len(record)):
            record[i] = re.sub(pat, "", record[i])
        print('Special characters other than alphabets removed :' + str(record))
        return record
    elif isinstance(record, dict):
        for k, v in record.items():
            if v == 'nan' or v is None or v is np.nan:
                v = ""
            else:
                v = re.sub(pat, "", v)
        print('Special characters other than alphabets removed dict:' + str(record))
        return record

def remove_characters_other_than_alphabets_numbers(record):
    print('In remove_characters_other_than_alphabets_numbers')
    pat = r"[^A-Za-z0-9\s]+"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove some special characters
        record[cols] = record[cols].replace(pat, "", regex=True)
        print('Special characters other than alphabets & numbers removed :' + str(record))
        return record
    elif isinstance(record, str):
        record = re.sub(pat, "", record)
        print('Special characters other than alphabets & numbers removed :' + str(record))
        return record
    elif isinstance(record, list):
        for i in range(len(record)):
            record[i] = re.sub(pat, "", record[i])
        print('Special characters other than alphabets & numbers removed list :' + str(record))
        return record
    elif isinstance(record, dict):
        for k, v in record.items():
            if v == 'nan' or v is None or v is np.nan:
                v = ""
            else:
                v = re.sub(pat, "", v)
        print('Special characters other than alphabets & numbers removed dict:' + str(record))
        return record

def remove_email_special_chars(df):
    cols = get_object_columns(df)
    # Remove some special characters
    df[cols] = df[cols].replace(r"[^a-zA-Z0-9@.\-_]+", "", regex=True)
    print('Special Characters Removed :' + str(df))
    return df

def multiple_spaces(df):
    cols = get_object_columns(df)
    # Convert 2 or more spaces between names to 1 space
    df[cols] = df[cols].replace(r"\s{2,}", " ", regex=True)
    print('Multiple Spaces Removed :' + str(df))
    return df

def remove_honorifics(df):
    pat = "^(consul general|Consul General|marchioness|Marchioness|ambassador|Ambassador|brigadier|Brigadier|commander|\
                Commander|professor|Professor|baroness|Baroness|countess|Countess|minister|Minister|princess|Princess|admiral|\
                Admiral|brother|Brother|duchess|Duchess|general|General|justice|Justice|marquis|Marquis|senator|Senator|\
                sheriff|Sheriff|consul|Consul|deputy|Deputy|father|Father|gräfin|Gräfin|madame|Madame|prince|Prince|sister|\
                Sister|madam|Madam|ma'am|Ma'am|baron|Baron|canon|Canon|chief|Chief|count|Count|judge|Judge|madam|Madam|\
                major|Major|rabbi|Rabbi|miss|Miss|lady|Lady|lord|Lord|miss|Miss|capt|Capt|cllr|Cllr|dame|Dame|duke|Duke|earl|\
                Earl|lady|Lady|lord|Lord|prof|Prof|mrs|Mrs|sir|Sir|dr.|Dr.|mrs|Mrs|col|Col|cpl|Cpl|drs|Drs|eng|ENG|hma|HMA|ing|\
                Ing|lic|Lic|llc|Llc|mme|Mme|pvt|Pvt|sgt|Sgt|sir|Sir|mr|Mr|ms|Ms|mx|Mx|mr|Mr|ms|Ms|dr|Dr|he|HE|lt|Lt)\.?"
    # Remove above Honorifics from First Name
    df.iloc[:, 1:] = df.iloc[:, 1:].replace(pat, "", regex=True)
    print('Honorifics Removed :' + str(df))
    return df

def lowercase(record):
    print('In lowercase')
    if isinstance(record, pd.DataFrame):
        record = record.applymap(lambda s: s.lower() if type(s) == str else s)
        print('Lowercased :' + str(record))
        return record
    elif isinstance(record, str):
        record = record.lower()
        print('Lowercased :' + str(record))
        return record
    elif isinstance(record, list):
        for i in range(len(record)):
            record[i] = record[i].lower()
        print('Lowercased list:' + str(record))
        return record
    elif isinstance(record, dict):
        for k, v in record.items():
            if v == 'nan' or v is None or v is np.nan:
                v = ""
            else:
                v = v.lower()
        print('Lowercased dict:' + str(record))
        return record


def remove_nan(df):
    # Replace missing values with empty string
    df = df.replace(np.nan, "", regex=True)
    df = df.replace('nan', "", regex=True)
    print('NAN Removed :' + str(df))
    return df

def remove_email_patterns(df):
    cols = get_object_columns(df)
    # Remove Email patterns
    df[cols] = df[cols].replace(r"^[^@\s]+@[^@\s]+\.[^@\s]+$", "", regex=True)
    print('Email Patterns Removed :' + str(df))
    return df

# Valid Email Attributes
def get_valid_emails(df):
    try:
        # Get input dataframe columns
        cols = df.columns
        print("{0} validation starts".format(cols[1]))
        if len(df) == df[cols[1]].isna().sum():
            return df
        # Store in numpy array
        email_records = df.values
        # Standard Email Pattern
        # pat = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
        pat = r"([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)"
        for row in email_records:
            matched_list = []
            # Pass null if email value is null
            if row[1] == 'nan' or row[1] is None or row[1] is np.nan:
                row[1] = ""
            else:
                for each in row[1]:
                    res = []
                    x = {}
                    # Condition to check if email is single valued attribute
                    if type(each) == str:
                        # Decode the string to maintain ascii format
                        accent = remove_accents(each)
                        # Check for email pattern matching
                        matches = re.findall(pat, accent)
                        # print("matches of str: ", matches)
                        if matches:
                            if len(matches) >= 1:
                                # Append list of email or emails ([])
                                matched_list.extend(matches)
                    # Condition to check if email is multi valued attribute
                    if type(each) == dict:
                        for key, val in each.items():
                            if key.lower() == "email_type":
                                x[key] = val
                            if key.lower() == "email":
                                # Decode the string to maintain ascii format
                                accent = remove_accents(str(val))
                                # Check for email pattern matching
                                matches = re.findall(pat, accent)
                                # print("matches of list: ", matches)
                                if matches:
                                    emails = ",".join(matches)
                                    res.append(emails)
                                    if len(matches) >= 1:
                                        x[key] = res
                                else:
                                    x[key] = None
                        # Append emails in dict format({email_type : Primary/Secondary ,email:[list of emails]})
                        matched_list.append(x)
                row[1] = matched_list
            # Replace null if no valid emails
            if len(matched_list) == 0:
                # Eliminate email record if not matching all checks
                row[1] = None
    except Exception as e:
        print("Standardization: Email failed")
        logging.debug("Standardization: Email failed with error :" + str(e))
        print('Error :' + str(e))
    # Return Standardized Emails
    df_modified = pd.DataFrame(email_records, columns=cols)
    return df_modified

def remove_non_numeric(number):
    pat = r"(?<!^)\+|[^\d+]+"
    matches = re.sub(pat, "", number)
    return matches

# Valid Phone attributes
def get_valid_phones(df):
    try:
        # Get input dataframe columns
        cols = df.columns
        print("{0} validation starts".format(cols[1]))
        # Return value as it is if all phone number is null
        if len(df) == df[cols[1]].isna().sum():
            return df
        else:
            # Store in numpy array
            phone_records = df.values
            for row in phone_records:
                phone_list = []
                # Replace null if phone value is NAN
                if row[1] == 'nan' or row[1] is None or row[1] is np.nan:
                    row[1] = None
                else:
                    for each in row[1]:
                        if type(each) == str:
                            # Condition to check if phone number is single valued and remove all non numeric chars
                            matches = remove_non_numeric(each)
                            # Replace phone value with null if number greater than 15 or less than 7
                            if len(matches) >= 15 or len(matches) <= 7:
                                row[1] = None
                            else:
                                # Append Phone number as list
                                phone_list.append(matches)
                        # Condition to check if phone number is multi valued and remove all non numeric chars
                        if type(each) == dict:
                            x = {}
                            for key, val in each.items():
                                if key.lower() == "phone_type":
                                    x[key] = val
                                if key.lower() == "phone":
                                    # Condition to check if phone number is single valued and remove all non numeric chars
                                    matches = remove_non_numeric(str(each))
                                    if len(matches) >= 15 or len(matches) <= 7:
                                        x[key] = ""
                                    else:
                                        x[key] = matches
                            phone_list.append(x)
                    row[1] = phone_list
    except Exception as e:
        print("Standardization of Phone failed")
        logging.error("Standardization of Phone failed with error :" + str(e))
        print('Error :' + str(e))
    # Return Standardized Phone Numbers
    df_modified = pd.DataFrame(phone_records, columns=cols)
    return df_modified

def remove_abbreviations(record):
    print('In remove_abbreviations')
    #print('Abbreviations Input :' + str(input_string))
    words = {
        "Dept": "Department",
        "rd": " road",
        "pl": "place",
        "ext": "extension",
        "ln": "lane",
        "ave": "avenue",
        "hwy": "highway",
        "sta": "station",
        "st": "street",
        "str": "street",
        "ne": "north east",
        "nw": "north west",
        "se": "south east",
        "sw": "south west",
        "ltd": "limited",
    }
    # Check for honorifics without space or other non characters
    pat = re.compile(r"\b(%s)\b" % "|".join(words))
    if isinstance(record, str):
        record = pat.sub(lambda m: words.get(m.group()), record)
    elif isinstance(record, list):
        for i in range(len(record)):
            record[i] = pat.sub(lambda m: words.get(m.group()), record[i])
    elif isinstance(record, dict):
        for k, v in record.items():
            if v == 'nan' or v is None or v is np.nan:
                v = ""
            else:
                v = pat.sub(lambda m: words.get(m.group()), v)
    return record

# Valid organization names
def get_valid_orgz(df):
    try:
        print("Org validation starts")
        # Return value as it is if all org records are null
        if len(df) == df['org_name'].isna().sum():
            return df
        # Store in numpy array
        org_records = df.values
        for row in org_records:
            # Condition to check if organization name is single valued and remove accent and special chars
            # Check if org name is None
            if row[1] is None or row[1] is np.nan or row[1] == 'NAN':
                row[1] = ""
            # Convert to list of multivalued separated by '|'
            if '|' in row[1]:
                row[1] = row[1].split('|')
            if type(row[1]) == str:
                # Return null if value contains only numeric
                if row[1].isnumeric():
                    row[1] = ""
                else:
                    # Standardize the Abbreviations
                    std_org = remove_abbreviations(str(row[1]))
                    # Decode to maintain ascii format
                    std_org = remove_accents(std_org)
                    # Lowercase elements in list
                    std_org = lowercase(std_org)
                    row[1] = std_org
            # Condition to check if organization name is multi valued and remove accent and special chars
            if type(row[1]) == list:
                # Decode to maintain ascii format
                row[1] = remove_accents(row[1])
                # Lowercase elements in list
                row[1] = lowercase(row[1])
                # Replace Abbreviations
                row[1] = remove_abbreviations(row[1])
                # Remove Special Characters
                row[1] = remove_characters_other_than_alphabets_numbers(row[1])
                if (len(row[1])) >= 1:
                    orgz = []
                    for org in row[1]:
                        # Return null if value contains only numeric
                        if org.isnumeric():
                            org = ""
                        else:
                            orgz.append(org)
                    row[1] = orgz
                else:
                    row[1] = ""
    except Exception as e:
        print("Standardization of Organization failed")
        logging.error("Standardization of Organization failed with error :" + str(e))
        print('Error :' + str(e))
    # Return Standardized Phone Numbers
    df_modified = pd.DataFrame(org_records, columns=['con_id', 'org_name'])
    return df_modified

# Valid Date attributes
def get_valid_dates(df):
    try:
        # Get input dataframe columns
        cols = df.columns
        print("{0} validation starts".format(cols[1]))
        # Return value as it is if all DOB is null
        if len(df) == df[cols[1]].isna().sum():
            return df
        # Store in numpy array
        date_records = df.values
        for row in date_records:
            # Replace null if DOB value is NAN
            if row[1] == 'NAN' or row[1] == "" or row[1] is None:
                row[1] = ""
            else:
                try:
                    dt_object = datetime.datetime.strptime(row[1], "%Y-%m-%d")
                except ValueError as v:
                    logging.error("Invalid Date Input :" + str(row[1]) + " - Conversion error :" + str(v))
                    row[1] = ""
                    continue
                # Convert to standard format string (dd-mm-yyyy)
                d_std = dt_object.strftime("%d-%m-%Y")
                # print('Standard {0}:{1}'.format(cols[1], d_std))
                logging.debug('Standard {0}:{1}'.format(cols[1], d_std))
                row[1] = d_std
    except Exception as e:
        print("Standardization of {0} failed".format(cols[1]))
        logging.error("Standardization of {0} failed with error :{1}".format(cols[1],str(e)))
        print('Error :' + str(e))
    # Return Standardized DOB
    df_modified = pd.DataFrame(date_records, columns=cols)
    return df_modified

# Valid address attributes
def get_valid_addresses(df):
    try:
        # Get input dataframe columns
        cols = df.columns
        print("{0} validation function starts".format(cols[1]))
        # Return value as it is if all DOB is null
        if len(df) == df[cols[1]].isna().sum():
            return df
        # Store in numpy array
        address_records = df.values
        for row in address_records:
            print('Address Input :'+str(row))
            # Check for None or Nan values
            if row[1] is None or row[1] is np.nan or row[1] == 'NAN':
                row[1] = ""
            # Convert to list if multivalued separated by '|'
            if '|' in row[1]:
                row[1] = row[1].split('|')
            if type(row[1]) == str:
                # Decode to maintain ascii format
                row[1] = remove_accents(row[1])
                # Lowercase elements in list
                row[1] = lowercase(row[1])
                # Replace Abbreviations
                row[1] = remove_abbreviations(row[1])
                # Remove Special Characters
                row[1] = remove_characters_other_than_alphabets_numbers(row[1])
            if type(row[1]) == list:
                res = []
                for each in row[1]:
                    # Decode to maintain ascii format
                    each = remove_accents(each)
                    # Lowercase elements in list
                    each = lowercase(each)
                    # Replace Abbreviations
                    each = remove_abbreviations(each)
                    # Remove Special Characters
                    each = remove_characters_other_than_alphabets_numbers(each)
                    res.append(each)
                row[1] = res
    except Exception as e:
        print("Standardization of {0} failed".format(cols[1]))
        logging.error("Standardization of {0} failed with error :{1}".format(cols[1], str(e)))
        print('Error :' + str(e))
    # Return Standardized Personal Addresses
    df_modified = pd.DataFrame(address_records, columns=cols)
    #print('Valid {0} Addresses :\n'.format((cols[1])))
    return df_modified
