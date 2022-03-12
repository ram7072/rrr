create or replace pipe landingtemp.PIPE_PS_DISTRIB_LANDING_TEMP_STG
auto_ingest = true
as
copy into LANDINGTEMP.PS_DISTRIB_LANDING_TEMP_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Supply_Chain/ps_distrib_line_landing_temp/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);