alter table "DM_DATASCIENCE"."REMAP" add column ETL_CREATE_TIMESTAMP TIMESTAMP_NTZ(9);
alter table "DM_DATASCIENCE"."REMAP" add column ETL_UPDATE_TIMESTAMP TIMESTAMP_NTZ(9);
alter table "DM_DATASCIENCE"."REMAP" add column LOADED_BY VARCHAR(100);