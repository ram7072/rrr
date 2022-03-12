create or replace pipe landingtemp.pipe_c1_ntf_pref_hist
auto_ingest = true
as
copy into CUSTOMER.C1_NTF_PREF_HIST from 
@public.DMS_S3_Source_data_enc/Datalake_Raw/Customer/c1_ntf_pref/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);