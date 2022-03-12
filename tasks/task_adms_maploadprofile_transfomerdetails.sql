CREATE OR REPLACE TASK DM_DATASCIENCE.task_adms_maploadprofile_transfomerdetails
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 0 14 * * 0 America/Los_Angeles'
AS
COPY INTO @public.dsm_api_adms_lp/maploadprofile/transfomerdetails/transfomerdetails
FROM (	select
            REPLACE(LABELTEXT,'\r\n',' '),
            concat('trans#',XFMR_BANKID) AS BANK_OBJECTID,
            concat('season#',USAGE_SEASON,'#day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) as sortId,
            round(RATEDKVA,2) as CAPACITY,
            USAGE_HOUR_BEGINNING,
            USAGE_SEASON,
            USAGE_WEEKDAY,
            round(AVERAGE_USAGE,2),
            round(MAX_USAGE,2),
            round(MIN_USAGE,2),
            LATITUDE,
            LONGITUDE,
            'dms task',
            current_timestamp,
            date_part(epoch_second, dateadd(days,38, current_timestamp))
        from
            WAREHOUSE.TRANSFORMER_USAGE_SEASON TRANS
        JOIN GEOSPATIAL.TRANSFORMER_EVW TX
        ON TRANS.XFMR_BANKID = TX.OBJECTID
			)
FILE_FORMAT= (
TYPE=CSV
COMPRESSION=NONE
FIELD_DELIMITER = '~'
FIELD_OPTIONALLY_ENCLOSED_BY ='"'
ESCAPE_UNENCLOSED_FIELD =NONE
)
OVERWRITE=TRUE
SINGLE=FALSE
HEADER=FALSE;

ALTER TASK DM_DATASCIENCE.task_adms_maploadprofile_transfomerdetails resume;