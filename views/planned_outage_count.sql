CREATE
OR REPLACE VIEW DM_DATASCIENCE.PLANNED_OUTAGE_COUNT AS (
    WITH T1 AS (
        SELECT
            COUNT(*) OMS_TOTAL_PLANNED_OUTAGES,
            TO_DATE(BEGIN_TIME) OUTAGEDATE
        FROM
            OUTAGEMANAGEMENT.JOBS J
        WHERE
            (BEGIN_TIME >= TO_TIMESTAMP_NTZ('2021-02-26'))
            AND DEVCLS_NAME LIKE 'xfm%'
            AND STATUS != 12
            AND CALL_TYPE IN ('SWP', 'PLAN')
        GROUP BY
            OUTAGEDATE
    ),
    T2 AS (
        SELECT
            COUNT(BANK_OBJECTID) OLT_COUNT_OVERLOAD_XFMR,
            TO_DATE(BEGIN_TIME) OUTAGEDATE
        FROM
            (
                WITH T AS (
                    SELECT
                        SUBSTR (ALIAS, 8) LABELTEXT,
                        BEGIN_TIME
                    FROM
                        OUTAGEMANAGEMENT.JOBS J
                    WHERE
                        (BEGIN_TIME >= TO_TIMESTAMP_NTZ('2021-02-26'))
                        AND DEVCLS_NAME LIKE 'xfm%'
                        AND STATUS != 12
                        AND CALL_TYPE IN ('SWP', 'PLAN')
                )
                SELECT
                    T.BEGIN_TIME,
                    A.BANK_OBJECTID,
                    REPLACE(
                        REPLACE (A.LABELTEXT, CHR(13), ''),
                        CHR(10),
                        ' '
                    ) LABELTEXT
                FROM
                    DM_DATASCIENCE.OVERLOADED_TRANSFORMER_YEARLY_SNAPSHOT A
                    INNER JOIN T ON T.LABELTEXT = A.LABELTEXT
                    INNER JOIN (
                        SELECT
                            BANK_OBJECTID,
                            REPLACE(REPLACE (LABELTEXT, CHR(13), ''), CHR(10), ' ') LABELTEXT,
                            MIN(ETL_UPDATE_TIMESTAMP) MIN_ETL_UPDATE_TIMESTAMP
                        FROM
                            DM_DATASCIENCE.OVERLOADED_TRANSFORMER_YEARLY_SNAPSHOT
                        WHERE
                            XFMR_OVERLOAD_COUNT <> 0
                        GROUP BY
                            BANK_OBJECTID,
                            LABELTEXT
                    ) B ON A.BANK_OBJECTID = B.BANK_OBJECTID
                    AND A.LABELTEXT = B.LABELTEXT
                    AND A.ETL_UPDATE_TIMESTAMP = B.MIN_ETL_UPDATE_TIMESTAMP
                ORDER BY
                    A.XFMR_OVERLOAD_COUNT DESC
            )
        GROUP BY
            OUTAGEDATE
    )
    SELECT
        'PLANNED' as OUTAGETYPE,
        T1.OMS_TOTAL_PLANNED_OUTAGES,
        T2.OLT_COUNT_OVERLOAD_XFMR,
        T1.OUTAGEDATE
    FROM
        T1
        LEFT JOIN T2 ON T1.OUTAGEDATE = T2.OUTAGEDATE
    ORDER BY
        T1.OUTAGEDATE
);