CREATE OR REPLACE TASK DM_DATASCIENCE.task_adms_assetdetails_transformerdetails
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 0 0 * * * America/Los_Angeles'
AS
COPY INTO @public.dsm_api_adms_lp/assetdetails/transformerdetails/transformerdetails
FROM (	select
			BANK_OBJECTID,
			REPLACE(labeltext,'\r\n',' '),
			CAPACITY,
			HIGHCONFIGURATION,
			LOWCONFIGURATION,
			NOOFCUSTOMERS_TRANS,
			PHASE,
			TX_EV_COUNT,
			TX_PVSIZE,
			FEEDERNAME,
			MINLOAD_FEEDER,
			MAXLOAD_FEEDER,
			AVGLOAD_FEEDER,
			NOOFCUSTOMERSFEEDER,
			FEED_EV_COUNT,
			FEED_PVSIZE,
			'DMS TASK',
			CURRENT_TIMESTAMP
		from
			DM_DATASCIENCE.TRANS_LOAD_PROFILE_VIEW
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

ALTER TASK DM_DATASCIENCE.task_adms_assetdetails_transformerdetails resume;