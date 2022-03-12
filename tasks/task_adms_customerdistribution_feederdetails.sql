CREATE OR REPLACE TASK DM_DATASCIENCE.task_adms_customerdistribution_feederdetails
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 0 14 * * 0 America/Los_Angeles'
AS
COPY INTO @public.dsm_api_adms_lp/customerdistribution/feederdetails/feederdetails
FROM (	select
            FEEDERNAME,
            concat('desc#',DESCRIPTION) DESCRIPTION,
			COUNT,
			'dms task' modifed_by,
			current_timestamp modified_date_time,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			DM_DATASCIENCE.FEEDER_CUST_INFO
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

ALTER TASK DM_DATASCIENCE.task_adms_customerdistribution_feederdetails resume;