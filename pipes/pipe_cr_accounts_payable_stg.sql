create or replace pipe landingtemp.PIPE_CR_ACCOUNTS_PAYABLE_STG
auto_ingest = true
as
copy into LANDINGTEMP.CR_ACCOUNTS_PAYABLE_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/cr_accounts_payable/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);