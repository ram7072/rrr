create or replace pipe landingtemp.PIPE_CR_COST_REPOSITORY_STG
auto_ingest = true
as
copy into LANDINGTEMP.CR_COST_REPOSITORY_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/cr_cost_repository/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);