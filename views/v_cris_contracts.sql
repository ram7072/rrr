CREATE OR REPLACE VIEW DM_CRIS.V_CRIS_CONTRACTS
AS
SELECT	DOC."u1708_documenttitle" AS RECORD_TITLE,
		DOC."uef58_pgepatterncode" AS PATTERN_CODE,
		DOC."uf568_contractnumber" AS CONTRACT_NUMBER,
		DOC."u46f8_supplementnumber" AS SUPPLEMENT_NUMBER,
		DOC."u3a13_startdate" AS START_DATE,
		DOC."u03d3_enddate" AS END_DATE,
		TO_CHAR(DOC."u3a13_startdate",'YYYY/MM/DD') || ' - ' || TO_CHAR(DOC."u03d3_enddate",'YYYY/MM/DD') AS RECORD_DATE,
		DOC."u3628_rcnumber" AS RC_NUMBER,
		DOC."u9168_project" AS PROJECT,
		DOC."u46f8_comments" AS COMMENTS,
		DOC."uab78_keywords" AS KEYWORDS,
		DOC."uf918_mediatype" AS MEDIA_TYPE, 
		DOC."u8dc7_homelocation" AS SHELF_LOCATION,
		DOC."udb38_barcodeid" AS BOX_NAME,		
		DOC."uc6b8_crisrecordtype" AS TYPE,
		DOC."ud878_requester" AS REQUESTER,
		DOC."u4b72_pending" AS PENDING,
		CON."u8488_fprcnumber" AS FPRC_NUMBER,
		CON."u3038_fppatterncode" AS FPPATTERN_CODE,
		CON."u448f_rmentitydescription" AS ENTITY_DESCRIPTION,
		CON."u7688_filingguidelines" AS FILING_GUIDELINES
FROM   ((CRIS.GENERIC_PGEP8FPOSPHY GEN 
FULL OUTER JOIN CRIS.CONTAINER_PGEP8FPOSPHY CON 
ON GEN."object_id" = CON."u7437_disposalschedule") 
FULL OUTER JOIN CRIS.RELATIONSHIP REL 
ON CON."object_id" = REL."tail_id") 
FULL OUTER JOIN CRIS.DOCVERSION DOC 
ON REL."head_id" = DOC."object_id"
ORDER BY DOC."ud878_requester", DOC."u1708_documenttitle";