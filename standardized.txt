import logging
import re
import numpy as np
import pandas as pd
import unidecode
import datetime


# Get Object Columns to Apply Standardization Rules
def get_object_columns(df):
    cols = df.iloc[:, 3:].select_dtypes(include=[np.object]).columns
    # print('Object Columns:' + str(cols))
    return cols


# Function to remove leading spaces
def ltrim(record, key=None):
    # print('In ltrim')
    if isinstance(record, pd.DataFrame):
        # Get Columns to Standardize
        cols = get_object_columns(record)
        # Standardize Dataframe Record
        record[cols] = record[cols].applymap(lambda x: ltrim(x))
        # print('ltrim output :\n'+str(record))
    elif isinstance(record, str):
        record = record.lstrip()
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = record[i].lstrip()
    elif isinstance(record, dict):
        # print('ltrim Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = record[key].lstrip()
                elif isinstance(record[key], list):
                    std_record = [rec.lstrip() if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('ltrimmed dict : ' + str(record))
    return record


# Function to remove trailing spaces
def rtrim(record, key=None):
    # print('In rtrim')
    if isinstance(record, pd.DataFrame):
        # Get Columns to Standardize
        cols = get_object_columns(record)
        # Standardize Dataframe String Record
        record[cols] = record[cols].applymap(lambda x: rtrim(x))
        # print('rtrim output :\n' + str(record))
    elif isinstance(record, str):
        record = record.rstrip()
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = record[i].rstrip()
    elif isinstance(record, dict):
        # print('rtrim Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = record[key].rstrip()
                elif isinstance(record[key], list):
                    std_record = [rec.rstrip() if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('rtrimmed dict : ' + str(record))
    return record


# Function to remove accents
def remove_accents(record, key=None):
    # print('In remove_accents record :' + str(record))
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove Accents
        # Standardize Dataframe String Record
        record[cols] = record[cols].apply(
            lambda x: x.str.normalize("NFKD").str.encode("ascii", errors="ignore").str.decode("utf-8"))
        # Standardize Dataframe List Record
        record = record.applymap(lambda s: remove_accents(s) if isinstance(s, list) else s)
        # print("Normalized df :\n" + str(record))
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = unidecode.unidecode(record[i])
        # print('Accents Removed list:' + str(record))
    elif isinstance(record, dict):
        # print('Remove Accents Input Key Record : ' + str(record) + 'with key : ' + str(key))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = unidecode.unidecode(record[key])
                elif isinstance(record[key], list):
                    std_record = [unidecode.unidecode(rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Accents Removed dict:' + str(record))
    return record


# Function to remove all chars other than alphabets
def remove_characters_other_than_alphabets(record, key=None):
    # print('In remove_characters_other_than_alphabets')
    pat = r"[^a-zA-Z\s]+"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove some special characters
        # Standardize Dataframe String Record
        record[cols] = record[cols].replace(pat, "", regex=True)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(
            lambda s: remove_characters_other_than_alphabets(s) if isinstance(s, list) else s)
        # print('Special characters other than alphabets removed :' + str(record))
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = re.sub(pat, "", record[i])
        # print('Special characters other than alphabets removed :' + str(record))
    elif isinstance(record, dict):
        # print('Remove Chars other than alphabets Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = re.sub(pat, "", record[key])
                elif isinstance(record[key], list):
                    std_record = [re.sub(pat, "", rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Special characters other than alphabets removed dict:' + str(record))
    return record


# Function to remove all chars other than alphabets and numbers
def remove_characters_other_than_alphabets_numbers(record, key=None):
    # print('In remove_characters_other_than_alphabets_numbers')
    pat = r"[^A-Za-z0-9\s]+"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove some special characters
        # Standardize Dataframe String Record
        record[cols] = record[cols].replace(pat, "", regex=True)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(
            lambda s: remove_characters_other_than_alphabets_numbers(s) if isinstance(s, list) else s)
        # print('Special characters other than alphabets & numbers removed :' + str(record))
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = re.sub(pat, "", record[i])
        # print('Special characters other than alphabets & numbers removed list :' + str(record))
    elif isinstance(record, dict):
        # print('Special characters other than alphabets & numbers Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = re.sub(pat, "", record[key])
                elif isinstance(record[key], list):
                    std_record = [re.sub(pat, "", rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Special characters other than alphabets & numbers removed dict:' + str(record))
    return record


# Function to remove all chars invalid in emails
def remove_non_email_chars(record, key=None):
    pat = r"[^a-zA-Z0-9@.\-_]+"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove email invalid special characters
        # Standardize Dataframe String Record
        record[cols] = record[cols].replace(pat, "", regex=True)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(lambda s: remove_non_email_chars(s) if isinstance(s, list) else s)
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = re.sub(pat, "", record[i])
    elif isinstance(record, dict):
        # print('Non Email Char Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = re.sub(pat, "", record[key])
                elif isinstance(record[key], list):
                    std_record = [re.sub(pat, "", rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Non Email Chars Removed dict:' + str(record))
    return record


# Function to convert multiple spaces to single space
def multiple_spaces_to_single(record, key=None):
    pat = r"\s{2,}"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Convert 2 or more spaces between names to 1 space
        # Standardize Dataframe String Record
        record[cols] = record[cols].replace(pat, " ", regex=True)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(lambda s: multiple_spaces_to_single(s) if isinstance(s, list) else s)
        # print('Multiple to Single Space :\n'+str(record))
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = re.sub(pat, "", record[i])
    elif isinstance(record, dict):
        # print('Multiple Spaces to Single Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = re.sub(pat, "", record[key])
                elif isinstance(record[key], list):
                    std_record = [re.sub(pat, "", rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Multiple Spaces to Single dict:' + str(record))
    return record


# Function to remove honorifics
def remove_honorifics(record, key=None):
    pat = "^(consul general|Consul General|marchioness|Marchioness|ambassador|Ambassador|brigadier|Brigadier|commander|\
                Commander|professor|Professor|baroness|Baroness|countess|Countess|minister|Minister|princess|Princess|admiral|\
                Admiral|brother|Brother|duchess|Duchess|general|General|justice|Justice|marquis|Marquis|senator|Senator|\
                sheriff|Sheriff|consul|Consul|deputy|Deputy|father|Father|gräfin|Gräfin|madame|Madame|prince|Prince|sister|\
                Sister|madam|Madam|ma'am|Ma'am|baron|Baron|canon|Canon|chief|Chief|count|Count|judge|Judge|madam|Madam|\
                major|Major|rabbi|Rabbi|miss|Miss|lady|Lady|lord|Lord|miss|Miss|capt|Capt|cllr|Cllr|dame|Dame|duke|Duke|earl|\
                Earl|lady|Lady|lord|Lord|prof|Prof|mrs|Mrs|sir|Sir|dr.|Dr.|mrs|Mrs|col|Col|cpl|Cpl|drs|Drs|eng|ENG|hma|HMA|ing|\
                Ing|lic|Lic|llc|Llc|mme|Mme|pvt|Pvt|sgt|Sgt|sir|Sir|mr|Mr|ms|Ms|mx|Mx|mr|Mr|ms|Ms|dr|Dr|he|HE|lt|Lt)\.?"
    if isinstance(record, pd.DataFrame):
        # Remove above Honorifics from First Name
        record.iloc[:, 3:] = record.iloc[:, 3:].replace(pat, "", regex=True)
        # print('Honorifics Removed :' + str(record))
    elif isinstance(record, dict):
        # print('Remove Honorifics Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = re.sub(pat, "", record[key])
                elif isinstance(record[key], list):
                    std_record = [re.sub(pat, "", rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Honorifics Removed dict:' + str(record))
    return record


# Function to lowercase input
def lowercase(record, key=None):
    # print('In lowercase')
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Standardize Dataframe String Record
        record[cols] = record[cols].applymap(lambda s: lowercase(s))
        # print('Lowercased :' + str(record))
    elif isinstance(record, str):
        record = record.lower()
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = record[i].lower()
        # print('Lowercased list:' + str(record))
    elif isinstance(record, dict):
        # print('Lowercase Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = record[key].lower()
                elif isinstance(record[key], list):
                    std_record = [rec.lower() if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Lowercased dict:' + str(record))
    return record


# Function to remove nan from input dataframe/list/dictionary
def remove_nan(record, key=None):
    if isinstance(record, pd.DataFrame):
        # Replace missing values with empty string
        # Standardize Dataframe String Record
        record = record.fillna(value="")
        # record = record.dropna()
        record = record.replace('nan', "", regex=True)
        record = record.replace('NAN', "", regex=True)
        record = record.replace([None], "", regex=True)
        # Standardize Dataframe List Record
        record = record.applymap(lambda s: remove_nan(s) if isinstance(s, list) else s)
        # print('NAN Removed :' + str(record))
    elif isinstance(record, list):
        temp = ["" for rec in record if rec == 'nan' or rec == 'NAN' or rec is None or rec is np.nan]
        record = temp
    elif isinstance(record, dict):
        # print('NAN removed Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
    # print('NAN removed output:' + str(record))
    return record


# Function to remove email patterns from input dataframe/list/dictionary
def remove_email_patterns(record, key=None):
    pat = r"^[^@\s]+@[^@\s]+\.[^@\s]+$"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove Email patterns
        # Standardize Dataframe String Record
        record[cols] = record[cols].replace(pat, "", regex=True)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(lambda s: remove_email_patterns(s) if isinstance(s, list) else s)
        # print('Email Patterns Removed Output :\n'+str(record))
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = re.sub(pat, "", record[i])
    elif isinstance(record, dict):
        # print('Remove Email Patterns Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = re.sub(pat, "", record[key])
                elif isinstance(record[key], list):
                    std_record = [re.sub(pat, "", rec) if rec not in (np.nan, None) else "" for rec in record[key]]
                    record[key] = std_record
        # print('Email Patterns Removed Dict : ' + str(record))
    return record


# Function to check valid emails from input dictionary
def check_valid_emails(record, key=None):
    pat = r"([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)"
    res = []
    if isinstance(record, dict):
        if key:
            if isinstance(record[key], list):
                # print('Check Valid Emails Record : ' + str(record[key]))
                for rec in record[key]:
                    if rec.count('@') > 1:
                        rec = ''
                    else:
                        # Check for email pattern matching
                        matches = re.findall(pat, rec)
                        if len(matches):
                            res.append(matches[0])
                if len(res):
                    record[key] = res
                else:
                    record[key] = ''
    return record


# Function to remove non numeric chars from input dataframe/list/dictionary
def remove_non_numeric(record, key=None):
    pat = r"(?<!^)\+|[^\d+]+"
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Remove Non Numeric chars
        # Standardize Dataframe String Record
        record[cols] = record[cols].replace(pat, " ", regex=True)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(lambda s: remove_non_numeric(s) if isinstance(s, list) else s)
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str) and len(record[i]):
                record[i] = re.sub(pat, "", record[i])
    elif isinstance(record, dict):
        if key:
            if isinstance(record[key], list):
                record[key] = remove_non_numeric(record[key])
            elif isinstance(record[key], str):
                record[key] = re.sub(pat, "", record[key])
    return record


# Function to validate length from input string/dictionary
def check_length(record, key=None):
    min = 7
    max = 15
    if isinstance(record, str):
        if len(record) >= max or len(record) <= min:
            record = ""
    elif isinstance(record, dict):
        if key:
            if isinstance(record[key], list):
                std_record = [rec if len(rec) in range(min, max + 1) else "" for rec in record[key]]
                record[key] = std_record
            elif isinstance(record[key], str):
                if len(record[key]) not in range(min, max + 1):
                    record[key] = ""
    return record


# Function to remove abbreviations from input string/dataframe/list/dictionary
def replace_abbreviations(record, key=None):
    # print('In remove_abbreviations')
    # print('Abbreviations Input :' + str(input_string))
    words = {
        "Dept": "Department",
        "dept": "department",
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
    if isinstance(record, pd.DataFrame):
        cols = get_object_columns(record)
        # Standardize Dataframe List Record
        record[cols] = record[cols].applymap(lambda s: replace_abbreviations(s) if isinstance(s, list) else s)
    if isinstance(record, str):
        record = pat.sub(lambda m: words.get(m.group()), record)
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                record[i] = pat.sub(lambda m: words.get(m.group()), record[i])
    elif isinstance(record, dict):
        # print('Remove Abbreviations Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str):
                    record[key] = pat.sub(lambda m: words.get(m.group()), record[key])
                elif isinstance(record[key], list):
                    std_record = [pat.sub(lambda m: words.get(m.group()), rec) if rec not in (np.nan, None) else "" for
                                  rec in record[key]]
                    record[key] = std_record
        # print('Abbreviations Removed Dict : ' + str(record))
    return record


# Function to get non numeric values from input string/dataframe/list/dictionary
def check_non_numeric(record, key=None):
    # print('In check_non_numeric')
    if isinstance(record, pd.DataFrame):
        # print('Non Numeric Input :' + str(record))
        cols = get_object_columns(record)
        # Standardize Dataframe String Record
        record[cols] = record[cols].applymap(lambda s: check_non_numeric(s))
        # print('Non Numeric Output :' + str(record))
    elif isinstance(record, str):
        if record.isnumeric():
            record = None
    elif isinstance(record, list):
        for i in range(len(record)):
            if isinstance(record[i], str):
                if len(record[i]) and record[i].isnumeric():
                    record[i] = None
        return record
        # print('Non Numeric list:' + str(record))
    elif isinstance(record, dict):
        # print('Non Numeric Input Key Record : ' + str(record))
        if key and key in record.keys():
            if record[key] == 'nan' or record[key] is None or record[key] is np.nan:
                record[key] = ""
            else:
                if isinstance(record[key], str) and not record[key].isnumeric():
                    record[key] = record[key].lower()
                elif isinstance(record[key], list):
                    std_record = [rec if not rec.isnumeric() else "" for rec in record[key]]
                    record[key] = std_record
        # print('Non Numeric dict:' + str(record))
    return record


def standardize_dates(record, key=None):
    # print('Input Type : '+str(type(record)))
    std_date_str = lambda d: datetime.datetime.strptime(d, "%Y-%m-%d").strftime("%d-%m-%Y")
    try:
        if isinstance(record, pd.DataFrame):
            # Get input dataframe columns
            col = get_object_columns(record)
            # Return value as it is if all DOB is null
            if len(record) == record[col[0]].isna().sum():
                return record
            # Standardize Dataframe Records
            record[col] = record[col].applymap(lambda s: standardize_dates(s))
            return record
        elif isinstance(record, str):
            if len(record):
                record = std_date_str(record)
            else:
                record = ""
        elif isinstance(record, list):
            for i in range(len(record)):
                if isinstance(record[i], str):
                    if len(record[i]):
                        record[i] = std_date_str(record[i])
                    else:
                        record[i] = ""
            return record
        elif isinstance(record, dict):
            if key and key in record.keys():
                if len(record[key]):
                    record[key] = std_date_str(record[key])
                else:
                    record[key] = ""
            return record
    except Exception as e:
        print("Standardization of {0} failed".format(record))
        logging.error("Standardization of {0} failed with error :{1}".format(record, str(e)))
        print('Error :' + str(e))


# Function to standardize level 2 attributes from corresponding level 1 input dataframe
def standardize_level2_attribute(df, rules):
    try:
        # Get input dataframe columns
        cols = df.columns.values
        # print("{0} validation function starts".format(cols[1]))
        # Return value as it is if all DOB is null
        if len(df) == df[cols[3]].isna().sum():
            return df
        # Store in numpy array
        records = df.values
        for row in records:
            # Check for None or Nan values
            if row[3] is None or row[3] is np.nan or row[3] == 'NAN':
                row[3] = ""
            elif type(row[3]) == list:
                res = []
                for each in row[3]:
                    for key in rules.keys():
                        if isinstance(each, dict) and key in each.keys():
                            for fn in rules[key]:
                                # print('Key:'+str(key))
                                # print('Fn :' + str(fn))
                                func = globals()[fn]
                                each = func(each, key)
                    res.append(each)
                row[3] = res
    except Exception as e:
        print("Standardization of {0} failed".format(cols[3]))
        logging.error("Standardization of {0} failed with error :{1}".format(cols[3], str(e)))
        print('Error :' + str(e))
    # Return Standardized Personal Addresses
    df_modified = pd.DataFrame(records, columns=cols)
    return df_modified
