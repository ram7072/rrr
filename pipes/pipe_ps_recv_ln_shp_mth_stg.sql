create or replace pipe landingtemp.PIPE_PS_RECV_LN_SHP_MTH_STG
auto_ingest = true
as
copy into LANDINGTEMP.PS_RECV_LN_SHP_MTH_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Supply_Chain/ps_recv_ln_shp_mth/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);