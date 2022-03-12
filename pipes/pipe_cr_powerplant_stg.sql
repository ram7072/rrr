
create or replace pipe landingtemp.PIPE_CR_POWERPLANT_STG
auto_ingest = true
as
copy into LANDINGTEMP.CR_POWERPLANT_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/cr_powerplant/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"' ESCAPE_UNENCLOSED_FIELD=NONE);


