
create or replace pipe landingtemp.PIPE_PGE_CR_OM_VAR_COMMENT_STG
auto_ingest = true
as
copy into LANDINGTEMP.PGE_CR_OM_VAR_COMMENT_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/pge_cr_om_var_comment/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD=NONE);
