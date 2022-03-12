create or replace TABLE DM_CUSTOMER.CITY_TAX
 (
--  LOAD_TIMESTAMP    TIMESTAMP_NTZ(9),
--  SNAPSHOT_DT		DATE,
  FISCAL_YEAR		VARCHAR(20),
  ACCOUNTING_PERIOD	VARCHAR(20),
  CITY_NAME			VARCHAR(250),
  BILLED_DOLLARS	NUMBER(25,2),
  ETL_CREATE_TIMESTAMP TIMESTAMP_NTZ(9),
  ETL_UPDATE_TIMESTAMP TIMESTAMP_NTZ(9),
  LOADED_BY 		VARCHAR(100),
  PRIMARY KEY (FISCAL_YEAR,ACCOUNTING_PERIOD,CITY_NAME)
 );
 
