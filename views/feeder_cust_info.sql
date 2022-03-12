CREATE OR REPLACE VIEW DM_DATASCIENCE.FEEDER_CUST_INFO AS
SELECT FEEDERNAME,DESCRIPTION,COUNT(*) AS COUNT FROM DM_DATASCIENCE.LOAD_CUST_INFO
GROUP BY FEEDERNAME,DESCRIPTION
ORDER BY COUNT DESC;