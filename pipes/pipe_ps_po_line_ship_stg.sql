create or replace pipe landingtemp.PIPE_PS_PO_LINE_SHIP_STG
auto_ingest = true
as
copy into LANDINGTEMP.PS_PO_LINE_SHIP_STG
from @public.DMS_S3_Source_data_enc/Datalake_Raw/Supply_Chain/ps_po_line_ship/
file_format = (type = 'CSV' FIELD_DELIMITER='~' FIELD_OPTIONALLY_ENCLOSED_BY='"'  ESCAPE_UNENCLOSED_FIELD =NONE);