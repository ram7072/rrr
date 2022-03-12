CREATE OR REPLACE TASK DM_DATASCIENCE.task_olt_monthly_data
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 30 2 * * * America/Los_Angeles'
AS
COPY INTO @public.dsm_api_olt/incremental/overloaded_transformer_monthly/overloaded_transformer_monthly
FROM (
		select
		bank_objectid "partitionId",
        concat('monthly#year#',usage_year_beginning,'#month#',usage_month_beginning) sortId,
        REPLACE(labeltext,'\r\n',' ') labeltext,
        Feedername,
        round(Capacity,2),
        lowphase_config,
        zeroifnull(CUSTOMER_COUNT) num_of_customers,
        round(zeroifnull(potential_cmi),2),
        round(avg_ratio_mthly,2),
        round(count_loadbased_overload_mthly,2),
        round(avg_temp_f_mthly,2),
        round(max_temp_f_mthly,2),
        round(min_temp_f_mthly,2),
        round(avg_load_mthly,2),
        round(max_load_mthly,2),
        round(min_load_mthly,2),
        round(avg_hotspot_temp_mthly,2),
        round(avg_loss_of_life_mthly,4),
        usage_month_beginning,
        usage_year_beginning,
        'dms task' modifiedBy,
        ETL_Update_timestamp modififedDateTime
        from
        DM_DATASCIENCE.overloaded_transformer_monthly
        where ETL_UPDATE_TIMESTAMP >= to_date(DATEADD(DAY,-1,CURRENT_DATE))
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


ALTER TASK DM_DATASCIENCE.task_olt_monthly_data resume;