CREATE OR replace external TABLE weather.ext_noaa_measurement_hist_2020_temp(
	station	VARCHAR(50)	 AS 	cast(value [	'STATION'	] AS VARCHAR(50)),
	timestamp_measurement_default timestamp  AS 	cast(value [	'TIMESTAMP_MEASUREMENT_DEFAULT'	] AS timestamp),
	timestamp_measurement_pst	timestamp	 AS 	cast(value [	'TIMESTAMP_MEASUREMENT_PST'	] AS timestamp),   
    barometricpressure	NUMBER	 AS 	cast(value [	'BAROMETRICPRESSURE'	] AS NUMBER),
	celsius_temp	FLOAT	 AS 	cast(value [	'CELSIUS_TEMP'	] AS FLOAT),
	dewpoint	FLOAT	 AS 	cast(value [	'DEWPOINT'	] AS FLOAT),
	humidity	FLOAT	 AS 	cast(value [	'HUMIDITY'	] AS FLOAT),
	sealevelpressure	NUMBER	 AS 	cast(value [	'SEALEVELPRESSURE'	] AS NUMBER),
	visibility	NUMBER	 AS 	cast(value [	'VISIBILITY'	] AS NUMBER),
	winddirection	NUMBER	 AS 	cast(value [	'WINDDIRECTION'	] AS NUMBER),
	windgust	NUMBER	 AS 	cast(value [	'WINDGUST'	] AS NUMBER),
	windspeed	NUMBER	 AS 	cast(value [	'WINDSPEED'	] AS NUMBER),
	x_coordinates   FLOAT AS cast(value['X_COORDINATES'] AS FLOAT),
    y_coordinates   FLOAT AS cast(value['Y_COORDINATES'] AS FLOAT),
	fer_temp	FLOAT	 AS 	cast(value [	'FER_TEMP'	] AS FLOAT),
	dewpoint_fer	FLOAT	 AS 	cast(value [	'DEWPOINT_FER'	] AS FLOAT),
    txd 			VARCHAR 	AS 	cast(value['txd'] AS VARCHAR), 
	prcplh        FLOAT AS         cast(value [    'PRCPLH'    ] AS FLOAT),
	current_sndp                    FLOAT     AS     cast(value [    'CURRENT_SNDP'    ] AS FLOAT),
	current_fog                        FLOAT     AS     cast(value [    'CURRENT_FOG'    ] AS FLOAT),
	current_rain_drizzle            FLOAT     AS     cast(value [    'CURRENT_RAIN_DRIZZLE'    ] AS FLOAT),
	current_snow_ice_pellets        FLOAT     AS     cast(value [    'CURRENT_SNOW_ICE_PELLLETS'    ] AS FLOAT),
	current_hail                  FLOAT     AS     cast(value [    'CURRENT_HAIL'    ] AS FLOAT),
	current_thunder                  FLOAT     AS     cast(value [    'CURRENT_THUNDER'    ] AS FLOAT),
	current_torando_funnel_cloud  FLOAT     AS     cast(value [    'CURRENT_TORANDO_FUNNEL_CLOUD'    ] AS FLOAT)
	)    
  	LOCATION=@public.DMS_S3_Source_data_enc/Datalake_Raw/Weather/Noaa/measurement/PARQ_FILES    
 REFRESH_ON_CREATE = true AUTO_REFRESH = true FILE_FORMAT = (TYPE = PARQUET); 