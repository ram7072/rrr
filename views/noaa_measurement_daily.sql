CREATE OR REPLACE VIEW 
DM_DATASCIENCE.NOAA_MEASUREMENT_DAILY
AS
SELECT 
STATION,
EXTRACT('YEAR',TIMESTAMP_MEASUREMENT_PST) AS YEAR,
EXTRACT('MONTH',TIMESTAMP_MEASUREMENT_PST) AS MONTH,
EXTRACT('DAY',TIMESTAMP_MEASUREMENT_PST) AS DAY,
NVL(ROUND(AVG(DNM.CELSIUS_TEMP),1),9999.9) AS CELSIUS_TEMP,
COUNT(DNM.CELSIUS_TEMP) AS COUNT_TEMP,
NVL(ROUND(AVG(DNM.DEWPOINT),1),9999.9) AS DEWPOINT,
COUNT(DNM.DEWPOINT) AS COUNT_DEWP,
NVL(ROUND(AVG(DNM.SEALEVELPRESSURE)),9999.9) AS SEALEVELPRESSURE,
COUNT(DNM.SEALEVELPRESSURE) AS COUNT_SLP,
NVL(ROUND(AVG(DNM.VISIBILITY)),999.9) AS VISIBILITY,
COUNT(DNM.VISIBILITY) AS COUNT_VISIB,
NVL(ROUND(AVG(DNM.WINDSPEED)),999.9) AS WINDSPEED,
COUNT(DNM.WINDSPEED) AS COUNT_WDSP,
NVL(MAX(DNM.WINDSPEED),999.9) AS MXPSD,
NVL(MAX(DNM.WINDGUST),999.9) AS WINDGUST,
NVL(MAX(DNM.CELSIUS_TEMP),9999.9) AS MAX_TEMP,
NVL(MIN(DNM.CELSIUS_TEMP),9999.9) AS MIN_TEMP,
DECODE(MAX(DNM.SNOW),0,NVL(MAX(DNM.precipitationlasthour),99.99),99.99) as prcp,
DECODE(MAX(DNM.SNOW),1,NVL(MAX(DNM.precipitationlasthour),999.9),999.9) as sndp,
NVL(MAX(DNM.FOG),0) AS FOG,
NVL(MAX(DNM.RAIN_DRIZZLE),0) AS RAIN_DRIZZLE,
NVL(MAX(DNM.SNOW_ICE_PELLETS),0) AS SNOW_ICE_PELLETS,
NVL(MAX(DNM.HAIL),0) AS HAIL,
NVL(MAX(DNM.THUNDER),0) AS THUNDER,
NVL(MAX(DNM.TORNADO_FUNNEL_CLOUD),0) AS TORNADO_FUNNEL_CLOUD
from WEATHER.EXT_NOAA_MEASUREMENT DNM 
GROUP BY
STATION,
EXTRACT('YEAR',TIMESTAMP_MEASUREMENT_PST),
EXTRACT('MONTH',TIMESTAMP_MEASUREMENT_PST),
EXTRACT('DAY',TIMESTAMP_MEASUREMENT_PST);