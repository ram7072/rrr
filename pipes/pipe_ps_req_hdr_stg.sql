create or replace pipe landingtemp.PIPE_PS_REQ_HDR_STG
auto_ingest = true
as
copy into LANDINGTEMP.PS_REQ_HDR_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Supply_Chain/ps_req_hdr/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);