COPY INTO @public.dsm_api_adms_lp/assetdetails/feederdetails/feederdetails
FROM (	select
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
			DM_DATASCIENCE.FEEDER_LOAD_PROFILE_VIEW
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
COPY INTO @public.dsm_api_adms_lp/assetdetails/servicepointdetails/servicepointdetails
FROM (	select
			SPID,
			METERID,
			SPTYPE,
			PREMISETYPE,
			SP_EV_COUNT,
			SP_PVSIZE,
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
			DM_DATASCIENCE.SP_LOAD_PROFILE_VIEW
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
COPY INTO @public.dsm_api_adms_lp/customerdistribution/servicepointdetails/servicepointdetails
FROM (	select
			spid,
			concat('desc#',DESCRIPTION) DESCRIPTION,
			COUNT,
			'dms task' modifed_by,
			current_timestamp modified_date_time,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			DM_DATASCIENCE.SPID_CUST_INFO
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
COPY INTO @public.dsm_api_adms_lp/customerdistribution/transformerdetails/transformerdetails
FROM (	select
            BANK_OBJECTID,
			REPLACE(LABELTEXT,'\r\n',' '),
            concat('desc#',DESCRIPTION) DESCRIPTION,
			COUNT,
			'dms task' modifed_by,
			current_timestamp modified_date_time,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			DM_DATASCIENCE.TRANS_CUST_INFO
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/feederdetails-daytype/daytype
FROM (	select
			concat('feed#',FEEDERNAME),
			concat('day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			USAGE_HOUR_BEGINNING,
			USAGE_WEEKDAY,
			AVG(AVERAGE_USAGE)  AS AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.FEEDER_USAGE_SEASON FUS
		JOIN (Select distinct FEEDERID, FEEDERNAME from WAREHOUSE.HUB_GIS_ASSET_MAP) AM
		ON FUS.FEEDER=AM.FEEDERID
		group by FEEDERNAME, USAGE_HOUR_BEGINNING, USAGE_WEEKDAY,ETL_UPDATE_TIMESTAMP
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/feederdetails-dualselect/dualselect
FROM (	select
			concat('feed#',FEEDERNAME),
			concat('dualselect#season#',USAGE_SEASON,'#day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			USAGE_HOUR_BEGINNING,
			USAGE_SEASON,
			USAGE_WEEKDAY,
			AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.FEEDER_USAGE_SEASON FUS
		JOIN (Select distinct FEEDERID, FEEDERNAME from WAREHOUSE.HUB_GIS_ASSET_MAP) AM
		ON FUS.FEEDER=AM.FEEDERID
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/feederdetails-seasontype/seasontype
FROM (	select
			concat('feed#',FEEDERNAME),
			concat('season#',USAGE_SEASON,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			USAGE_HOUR_BEGINNING,
			USAGE_SEASON,
			AVG(AVERAGE_USAGE) AS AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.FEEDER_USAGE_SEASON FUS
		JOIN (Select distinct FEEDERID, FEEDERNAME from WAREHOUSE.HUB_GIS_ASSET_MAP) AM
		ON FUS.FEEDER=AM.FEEDERID
		group by FEEDERNAME, USAGE_HOUR_BEGINNING, USAGE_SEASON, ETL_UPDATE_TIMESTAMP
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
COPY INTO @public.dsm_api_adms_lp/searchpatterns/feeder/feeder
FROM (	select
			distinct FEEDERNAME,
			'feeder',
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
COPY INTO @public.dsm_api_adms_lp/searchpatterns/servicepoint/servicepoint
FROM (	select
			distinct SPID,
			'servicepoint',
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
COPY INTO @public.dsm_api_adms_lp/searchpatterns/transformer/transformer
FROM (	select
			distinct BANK_OBJECTID,
			REPLACE(LABELTEXT,'\r\n',' '),
			'transformer',
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/servicepointdetails-daytype/daytype
FROM (	select
			concat('sp#',SP_ID),
			concat('day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			USAGE_HOUR_BEGINNING,
			USAGE_WEEKDAY,
			AVG(AVERAGE_USAGE) AS AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.SERVICE_POINT_USAGE_SEASON
		group by SP_ID, USAGE_HOUR_BEGINNING, USAGE_WEEKDAY, ETL_UPDATE_TIMESTAMP
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/servicepointdetails-dualselect/dualselect
FROM (	select
			concat('sp#',SP_ID),
			concat('dualselect#season#',USAGE_SEASON,'#day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			USAGE_HOUR_BEGINNING,
			USAGE_SEASON,
			USAGE_WEEKDAY,
			AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.SERVICE_POINT_USAGE_SEASON
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/transformerdetails-daytype/daytype
FROM (	select
			REPLACE(labeltext,'\r\n',' '),
			concat('day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			concat('trans#',XFMR_BANKID) AS BANK_OBJECTID,
			USAGE_HOUR_BEGINNING,
			USAGE_WEEKDAY,
			AVG(AVERAGE_USAGE)  as  AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.TRANSFORMER_USAGE_SEASON TRANS
		JOIN (select distinct BANK_OBJECTID,LABELTEXT from WAREHOUSE.HUB_GIS_ASSET_MAP) AM
		ON TRANS.XFMR_BANKID = AM.BANK_OBJECTID
		group by LABELTEXT, XFMR_BANKID,USAGE_HOUR_BEGINNING, USAGE_WEEKDAY, ETL_UPDATE_TIMESTAMP
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
COPY INTO @public.dsm_api_adms_lp/loadprofile/transformerdetails-dualselect/dualselect
FROM (	select
			REPLACE(labeltext,'\r\n',' '),
			concat('dualselect#season#',USAGE_SEASON,'#day#',USAGE_WEEKDAY,'#hour#',USAGE_HOUR_BEGINNING) sortId,
			concat('trans#',XFMR_BANKID) AS BANK_OBJECTID,
			USAGE_HOUR_BEGINNING,
			USAGE_SEASON,
			USAGE_WEEKDAY,
			AVERAGE_USAGE,
			'dms task' modifiedBy,
			ETL_UPDATE_TIMESTAMP,
			date_part(epoch_second, dateadd(days,38, current_timestamp))
		from
			WAREHOUSE.TRANSFORMER_USAGE_SEASON TRANS
		JOIN (select distinct BANK_OBJECTID,LABELTEXT from WAREHOUSE.HUB_GIS_ASSET_MAP) AM
		ON TRANS.XFMR_BANKID = AM.BANK_OBJECTID
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