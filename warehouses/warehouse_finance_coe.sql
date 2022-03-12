USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE "FINANCE_COE" WITH
WAREHOUSE_SIZE = 'XSMALL' 
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE 
MIN_CLUSTER_COUNT = 1 
MAX_CLUSTER_COUNT = 1 
SCALING_POLICY = 'STANDARD' 
COMMENT = 'virtual warehouse for finance data REPORTING';

GRANT USAGE ON WAREHOUSE FINANCE_COE TO ROLE FINANCE_RO;