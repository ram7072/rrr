
create or replace pipe landingtemp.PIPE_CR_POWERTAX_STG
auto_ingest = true
as
copy into LANDINGTEMP.CR_POWERTAX_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/cr_powertax/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"' ESCAPE_UNENCLOSED_FIELD=NONE);

