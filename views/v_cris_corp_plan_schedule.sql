CREATE OR REPLACE VIEW DM_CRIS.V_CRIS_CORP_PLAN_SCHEDULE
AS
SELECT	CON."u8dd8_recordcategoryname" AS DESCRIPTION,
		CON."u3378_recordcategoryidentifier" AS PATTERN_CODE,
		CON."u7b68_officeofrecord" AS OFFICE_OF_RECORD,
		CON."ubfe8_comments" AS COMMENTS,
		CON."ue0c8_description" AS FILING_GUIDELINES,
		CON."u448f_rmentitydescription" AS RMENTITY_DESCRIPTION,
		CON."u3916_rmentitytype" AS RMENTITY_TYPE,
		CON."u0c98_pgeidentifier" AS PGE_IDENTIFIER,
		GEN."u7818_disposalschedulename" AS RETENTION_SCHEDULE,
		GEN."u8e76_rmentitytype" AS GENRM_ENTITY_TYPE
FROM 	CRIS.GENERIC_PGEP8OS03 GEN
FULL OUTER JOIN CRIS.CONTAINER_PGEP8OS03 CON
ON GEN."object_id" = CON."u7437_disposalschedule"
ORDER BY CON."u0c98_pgeidentifier",CON."u3378_recordcategoryidentifier";