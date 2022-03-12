create or replace pipe landingtemp.pipe_dtn_input_weather_hist 
auto_ingest=true 
as
copy into landingtemp.dtn_input_weather_hist_stg
from(
select 'I',CURRENT_TIMESTAMP(),t.$1,t.$2,TO_TIMESTAMP(cast(t.$3 as VARCHAR(100)),'YYYY/MM/DD HH'),t.$4,t.$5,t.$6,t.$7,t.$8,t.$9,t.$10,t.$11,t.$12,t.$13,t.$14,TO_TIMESTAMP(cast(t.$15 as VARCHAR(100)),'YYYY/MM/DD HH:MI'),t.$16
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Weather/Input/ t
)
file_format = (type = 'CSV'  FIELD_DELIMITER='\t' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1 ESCAPE_UNENCLOSED_FIELD =NONE encoding= 'iso-8859-1');