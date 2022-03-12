CREATE OR REPLACE TASK DM_DATASCIENCE.task_adms_transformerdetails_seasontype
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 0 14 * * 0 America/Los_Angeles'
AS
COPY INTO @public.dsm_api_adms_lp/loadprofile/transformerdetails-seasontype/seasontype
FROM (	select
			REPLACE(labeltext,'\r\n',' '),
			concat('season#',USAGE_SEASON,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			concat('trans#',XFMR_BANKID) AS BANK_OBJECTID,
			USAGE_HOUR_BEGINNING,
			USAGE_SEASON,
			AVG(AVERAGE_USAGE)  as  AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.TRANSFORMER_USAGE_SEASON TRANS
		JOIN (select distinct BANK_OBJECTID,LABELTEXT from WAREHOUSE.HUB_GIS_ASSET_MAP) AM
		ON TRANS.XFMR_BANKID = AM.BANK_OBJECTID
		group by LABELTEXT, XFMR_BANKID,USAGE_HOUR_BEGINNING, USAGE_SEASON, ETL_UPDATE_TIMESTAMP
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

ALTER TASK DM_DATASCIENCE.task_adms_transformerdetails_seasontype resume;