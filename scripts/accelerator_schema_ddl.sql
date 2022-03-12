
create or replace table accelerator.oracle_snowflake_type_conversion(oracle_datatype varchar(100),snowflake_datatype varchar(100));

create or replace TABLE ACCELERATOR.TABLE_LIST (
	SOURCE_DB VARCHAR(100) NOT NULL,
	SOURCE_SCHEMA VARCHAR(100) NOT NULL,
	TARGET_SCHEMA VARCHAR(100) NOT NULL,
	TABLE_NAME VARCHAR(100) NOT NULL,
	FILE_TYPE VARCHAR(20) NOT NULL DEFAULT 'PARQUET',
	RUN_FLAG VARCHAR(1) NOT NULL DEFAULT 'Y',
	EXT_TABLE_FLAG VARCHAR(1) DEFAULT 'Y',
	SEQ_FLAG VARCHAR(1) DEFAULT 'Y',
	VIEW_FLAG VARCHAR(1) DEFAULT 'Y',
	LOAD_COL_FLAG VARCHAR(1) DEFAULT 'Y',
	TRANS_TABLE_FLAG VARCHAR(1) DEFAULT 'N',
	TRANS_SWAP_STAGE_FLAG VARCHAR(1) DEFAULT 'N',
	TRANS_PIPE_FLAG VARCHAR(1) DEFAULT 'N',
	TRANS_TASK_FLAG VARCHAR(1) DEFAULT 'N'
);

create or replace table accelerator.s3_path(schema_name varchar(100),s3_path varchar(500));

insert into accelerator.s3_path values
  ('BUCKET_NAME',concat('dsm-datalake-s3-bucket-',lower(right(current_database(),3)))),
  ('METER',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Meter/')),
  ('OUTAGEMANAGEMENT',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Outagemanagement/')),
  ('CUSTOMER',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Customer/')),
  ('GEOSPATIAL',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Geospatial/')),
  ('WORKSCHEDULE',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Workschedule/')),
  ('WORKMANAGEMENT',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Workmanagement/')),
  ('FINANCE',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Finance/')),
  ('SUPPLY_CHAIN',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/Supply_Chain/')),
  ('HR',concat(current_database(),'.public.DMS_S3_Source_data_enc/Datalake_Raw/HR/'));



insert into accelerator.oracle_snowflake_type_conversion values
  ('NUMBER','NUMERIC'),
  ('FLOAT','FLOAT'),
  ('TIMESTAMP','TIME'),
  ('TIMESTAMP(6)','TIMESTAMP'),
  ('TIMESTAMP(3)','TIMESTAMP'),
  ('TIMESTAMP(4) WITH TIME ZONE','TIMESTAMP_LTZ'),
  ('VARCHAR2','VARCHAR'),
  ('NVARCHAR2','VARCHAR'),
  ('CHAR','VARCHAR'),
  ('DATE','TIMESTAMP'),
  ('BINARY_FLOAT','BINARY'),
  ('BINARY_DOUBLE','BINARY'),
  ('CLOB','VARCHAR'),
  ('BLOB','VARBINARY'),
  ('TIMESTAMP with TIMEZONE','TIMESTAMP_LTZ'),
  ('XMLTYPE','STRING');
  
  --Insert into table_list example
 -- insert into accelerator.table_list values('SCHEMA_NAME','TABLE_NAME','FILE_TYPE(CSV/PARQUET)','RUN_FLAG(Y/N)','TABLE_FLAG(Y/N)','VIEW_FLAG(Y/N)','LOAD_COL_FLAG(Y/N)')
--insert into accelerator.table_list values('CCB','CI_ACCT','CSV','Y','Y','Y','Y')

GRANT SELECT ON ACCELERATOR.TABLE_LIST TO OLAP_RO;
GRANT SELECT ON ACCELERATOR.S3_PATH TO OLAP_RO;
GRANT SELECT ON ACCELERATOR.ORACLE_SNOWFLAKE_TYPE_CONVERSION TO OLAP_RO;
