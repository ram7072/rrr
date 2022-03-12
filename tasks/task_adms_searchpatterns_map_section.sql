CREATE OR REPLACE TASK DM_DATASCIENCE.task_adms_searchpatterns_map_section
WAREHOUSE = DATA_INGESTION_OLT,
SCHEDULE ='USING CRON 0 0 * * * America/Los_Angeles'
AS
COPY INTO @public.dsm_api_adms_lp/searchpatterns/mapsection/mapsection
FROM (	Select
            distinct concat('feedertransformer#',feederName),
            BANK_OBJECTID,
            REPLACE(LABELTEXT,'\r\n',' '),
            'dms task',
            current_timestamp
        from
            WAREHOUSE.HUB_GIS_ASSET_MAP
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

ALTER TASK DM_DATASCIENCE.task_adms_searchpatterns_map_section resume;