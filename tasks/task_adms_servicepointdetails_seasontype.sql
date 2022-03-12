CREATE OR REPLACE TASK DM_DATASCIENCE.task_adms_servicepointdetails_seasontype
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 0 14 * * 0 America/Los_Angeles'
AS
COPY INTO @public.dsm_api_adms_lp/loadprofile/servicepointdetails-seasontype/seasontype
FROM (	select
			concat('sp#',SP_ID),
			concat('season#',USAGE_SEASON,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			USAGE_HOUR_BEGINNING,
			USAGE_SEASON,
			AVG(AVERAGE_USAGE),
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.SERVICE_POINT_USAGE_SEASON
		group by SP_ID, USAGE_HOUR_BEGINNING, USAGE_SEASON, ETL_UPDATE_TIMESTAMP
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


ALTER TASK DM_DATASCIENCE.task_adms_servicepointdetails_seasontype resume;