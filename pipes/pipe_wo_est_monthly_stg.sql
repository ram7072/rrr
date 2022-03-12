create or replace pipe landingtemp.PIPE_WO_EST_MONTHLY_STG
auto_ingest = true
as
copy into LANDINGTEMP.WO_EST_MONTHLY_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/wo_est_monthly/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD=NONE);

