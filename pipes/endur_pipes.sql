create or replace pipe LANDINGTEMP.PIPE_DW_PRICE_INDEX_OUTPUT_VALUES_STG
AUTO_INGEST=TRUE
as
copy into LANDINGTEMP.DW_PRICE_INDEX_OUTPUT_VALUES_STG from @public.DMS_S3_Source_data_enc/Datalake_Raw/Endur/dw_price_index_output_values/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE encoding= 'iso-8859-1');

create or replace pipe LANDINGTEMP.PIPE_DW_EXTRACTION_LOG_STG
AUTO_INGEST=TRUE
as
copy into LANDINGTEMP.DW_EXTRACTION_LOG_STG from @public.DMS_S3_Source_data_enc/Datalake_Raw/Endur/dw_extraction_log/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE encoding= 'iso-8859-1');
