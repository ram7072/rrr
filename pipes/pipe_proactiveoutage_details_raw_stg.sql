create or replace pipe landingtemp.pipe_proactiveoutage_details_raw_stg 
auto_ingest=true 
as copy into 
LANDINGTEMP.PROACTIVEOUTAGE_DETAILS_RAW_STG 
from
@public.DMS_S3_Source_data_enc/Datalake_Raw/proactive_notification/proactiveoutage_details/stream/
file_format =
(type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"' ESCAPE_UNENCLOSED_FIELD =NONE encoding= 'iso-8859-1' skip_header=1);