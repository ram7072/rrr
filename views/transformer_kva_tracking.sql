CREATE OR REPLACE VIEW DM_DATASCIENCE.TRANSFORMER_KVA_TRACKING AS (
SELECT
    OBJECTID,
    CASE
        WHEN ACTION = 'Decommissioned' THEN NEW_LABELTEXT
        ELSE OLD_LABELTEXT
    END AS OLD_LABELTEXT,
    CASE
        WHEN ACTION = 'Decommissioned' THEN 'NA'
        ELSE NEW_LABELTEXT
    END AS NEW_LABELTEXT,
    CASE
        WHEN ACTION = 'Decommissioned' THEN NEW_KVA
        ELSE OLD_KVA
    END AS OLD_KVA,
    CASE
        WHEN ACTION = 'Decommissioned' THEN 0
        ELSE NEW_KVA
    END AS NEW_KVA,
    ACTION
FROM
    (
        SELECT
            NEW.OBJECTID,
            COALESCE(OLD.LABELTEXT, 'N/A') AS OLD_LABELTEXT,
            NEW.LABELTEXT AS NEW_LABELTEXT,
            COALESCE(OLD.OLD_KVA, 0) AS OLD_KVA,
            NEW.NEW_KVA,
            CASE
                WHEN NEW.EFFECTIVE_END_DT <> '9999-12-31'
                AND NEW.ACTIVE_FLAG = 'Y' THEN 'Decommissioned'
                WHEN OLD.OLD_KVA > NEW.NEW_KVA THEN 'Downgraded'
                WHEN OLD.OLD_KVA = NEW.NEW_KVA THEN 'Replaced'
                WHEN OLD.OLD_KVA < NEW.NEW_KVA THEN 'Upgraded'
                WHEN OLD.OLD_KVA IS NULL THEN 'New'
            END AS ACTION
        FROM
            (
                SELECT
                    OBJECTID,
                    LABELTEXT,
                    RATEDKVA AS NEW_KVA,
                    EFFECTIVE_START_DT,
                    EFFECTIVE_END_DT,
                    ACTIVE_FLAG
                FROM
                    WAREHOUSE.SAT_GIS_TRANSFORMER_PIT QUALIFY ROW_NUMBER() OVER(
                        PARTITION BY OBJECTID
                        ORDER BY
                            ETL_UPDATE_TIMESTAMP DESC
                    ) = 1
            ) NEW
            Left JOIN (
                SELECT
                    OBJECTID,
                    LABELTEXT,
                    RATEDKVA AS OLD_KVA,
                    EFFECTIVE_START_DT
                FROM
                    WAREHOUSE.SAT_GIS_TRANSFORMER_PIT QUALIFY ROW_NUMBER() OVER(
                        PARTITION BY OBJECTID
                        ORDER BY
                            ETL_UPDATE_TIMESTAMP DESC
                    ) = 2
            ) OLD ON NEW.OBJECTID = OLD.OBJECTID
    )
);