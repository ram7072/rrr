use role accountadmin;

CREATE or replace WAREHOUSE DATA_INGESTION_OLT WITH 
WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 59
AUTO_RESUME = TRUE 
MIN_CLUSTER_COUNT = 1 
MAX_CLUSTER_COUNT = 2
SCALING_POLICY = 'STANDARD'
COMMENT = 'This is to run all the overloaded transformer jobs';

grant operate, modify, monitor, usage on warehouse data_ingestion_olt to role olap_rw;

use role olap_rw;