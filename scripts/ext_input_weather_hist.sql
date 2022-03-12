CREATE OR REPLACE EXTERNAL TABLE weather.ext_input_weather_hist
( code varchar(4) AS cast(value['c1'] AS varchar(4)),
 o_f varchar(1) AS cast(value['c2'] AS varchar(1)),
 forecast_date_old timestamp_ntz(9) AS to_timestamp(cast(value['c3'] AS varchar(100)),'YYYY/MM/DD HH'),
 tmp number(38) AS cast(value['c4'] AS number(38)), 
 dpt number(38) AS cast(value['c5'] AS number(38)),
 hum number(38) AS cast(value['c6'] AS number(38)),
 hid number(38) AS cast(value['c7'] AS number(38)),
 wcl number(38) AS cast(value['c8'] AS number(38)),
 wdr number(38) AS cast(value['c9'] AS number(38)),
 wsp number(38) AS cast(value['c10'] AS number(38)),
 wet number(38) AS cast(value['c11'] AS number(38)),
 cc number(38) AS cast(value['c12'] AS number(38)),
 ssm number(38) AS cast(value['c13'] AS number(38)),
 rad number(38) AS cast(value['c14'] AS number(38)), 
 forecast_date_new timestamp_ntz(9) AS to_timestamp(cast(value['c15'] AS varchar(100)),'YYYY/MM/DD HH:MI'), 
 units varchar(1) AS cast(value['c16'] AS varchar(1)) )
location =@PUBLIC.DMS_S3_SOURCE_DATA_ENC/Datalake_Raw/Weather/Input/
refresh_on_create = true auto_refresh = true file_format = ( type = csv field_delimiter = '\t' skip_header = 1 );