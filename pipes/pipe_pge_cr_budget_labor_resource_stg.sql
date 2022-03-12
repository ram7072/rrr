create or replace pipe landingtemp.PIPE_PGE_CR_BUDGET_LABOR_RESOURCE_STG
auto_ingest = true
as
copy into LANDINGTEMP.PGE_CR_BUDGET_LABOR_RESOURCE_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/pge_cr_budget_labor_resource/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD=NONE);
