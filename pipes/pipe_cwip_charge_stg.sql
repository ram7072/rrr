
create or replace pipe landingtemp.PIPE_CWIP_CHARGE_STG
auto_ingest = true
as
copy into LANDINGTEMP.CWIP_CHARGE_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/cwip_charge/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"' ESCAPE_UNENCLOSED_FIELD=NONE);
