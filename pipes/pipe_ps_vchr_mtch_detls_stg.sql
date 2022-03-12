create or replace pipe landingtemp.PIPE_PS_VCHR_MTCH_DETLS_STG
auto_ingest = true
as
copy into LANDINGTEMP.PS_VCHR_MTCH_DETLS_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Supply_Chain/ps_vchr_mtch_detls/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);