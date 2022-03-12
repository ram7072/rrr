CREATE OR REPLACE TASK DM_DATASCIENCE.task_olt_summary_data
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 30 2 * * * America/Los_Angeles'
AS
COPY INTO @public.dsm_api_olt/incremental/overloaded_transformer_summary/overloaded_transformer_summary
FROM (	select * from (
        Select
        concat(year(ETL_Update_timestamp),'-',lpad(month(ETL_Update_timestamp),2, '0'),'-',lpad(day(ETL_Update_timestamp),2, '0')) "partitionId",
        Y1.BANK_OBJECTID "sortId",
        REPLACE(Y1.LABELTEXT,'\r\n',' ') "Asset Identifier",
        Y1.FEEDERNAME "Feeder Name",
        round(Y1.CAPACITY,2) "Capacity",
        Y1.LOWPHASE_CONFIG "Configuration",
        zeroifnull(Y1.CUSTOMER_COUNT) "No of Customers",
        round(zeroifnull(Y1.xfmr_avg_ratio),2) "Avg Load Ratio",
        round(zeroifnull(Y1.XFMR_MAX_OVERLOAD_PCT),2) "Max load Pct",
        round(zeroifnull(Y1.XFMR_OVERLOAD_COUNT),2) "Overload count",
        y1.ETL_Update_timestamp "Load Date",
        round(zeroifnull(Y1.XFMR_MAX_LOAD),2) "Max load",
        round(zeroifnull(Y1.XFMR_MIN_LOAD),2) "Min load",
        round(zeroifnull(Y1.XFMR_AVG_LOAD),2) "Avg load",
        'dms task' modifiedBy,
        ETL_Update_timestamp modififedDateTime,
        date_part(epoch_second, dateadd(year, 1, ETL_Update_timestamp)),
        row_number() over (order by XFMR_OVERLOAD_COUNT desc) as row_number,
        round(zeroifnull(XFMR_MAX_TEMP),2) "Max Temp",
        round(zeroifnull(XFMR_MIN_TEMP),2) "Min Temp",
        round(zeroifnull(XFMR_AVG_TEMP),2) "Avg Temp",
        XFMR_EV_COUNT "EV Count",
        XFMR_PV_SIZE "PV Size",
        XFMR_TYPE "Type"
        from
        DM_DATASCIENCE.overloaded_transformer_yearly_Snapshot Y1
        where to_date(y1.ETL_Update_timestamp) = to_date(DATEADD(DAY,-1,CURRENT_DATE))
        order by XFMR_OVERLOAD_COUNT desc limit 50)
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


ALTER TASK DM_DATASCIENCE.task_olt_summary_data resume;