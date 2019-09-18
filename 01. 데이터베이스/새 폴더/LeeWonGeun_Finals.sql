SELECT PRD_SEG1,
    SUM(FCST_AVG) AS FCST_AVG,
    SUM(ACC_AVG) AS ACC_AVG,
    SUM(ACC_AVG) / SUM(FCST_AVG) AS AVERAGE  
FROM
(
    SELECT 
        PRD_SEG1,
        PRD_SEG2,
        LPAD(PRD_SEG3, 5, 11),
        MEASUREID,
        TARGETWEEK,
        YEAR,
        WEEK,
        ACTUAL,
        W6,
        W5,
        W4,
        W3,
        W2,
        W1,
        NVL(ABS(ACTUAL - W6), ACTUAL) AS ABS_W6,
        NVL(ABS(ACTUAL - W5), ACTUAL) AS ABS_W5,
        NVL(ABS(ACTUAL - W4), ACTUAL) AS ABS_W4,
        NVL(ABS(ACTUAL - W3), ACTUAL) AS ABS_W3,
        NVL(ABS(ACTUAL - W2), ACTUAL) AS ABS_W2,
        NVL(ABS(ACTUAL - W1), ACTUAL) AS ABS_W1,
        CASE WHEN W6 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W6 > 2 THEN 0 
        ELSE NVL(1-ABS(W6 - ACTUAL)/W6, 0) END AS ACC_W6,
        CASE WHEN W5 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W5 > 2 THEN 0 
        ELSE NVL(1-ABS(W5 - ACTUAL)/W5, 0) END AS ACC_W5,
        CASE WHEN W4 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W4 > 2 THEN 0 
        ELSE NVL(1-ABS(W4 - ACTUAL)/W4, 0) END AS ACC_W4,
        CASE WHEN W3 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W3 > 2 THEN 0 
        ELSE NVL(1-ABS(W3 - ACTUAL)/W3, 0) END AS ACC_W3,
        CASE WHEN W2 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W2 > 2 THEN 0 
        ELSE NVL(1-ABS(W2 - ACTUAL)/W2, 0) END AS ACC_W2,
        CASE WHEN W1 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W1 > 2 THEN 0 
        ELSE NVL(1-ABS(W1 - ACTUAL)/W1, 0) END AS ACC_W1,
        CASE WHEN W6 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W6 > 2 THEN 0 
        ELSE NVL(W6*(1-ABS(W6 - ACTUAL)/W6), 0) END AS ACC_6WQTY,
        CASE WHEN W5 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W5 > 2 THEN 0 
        ELSE NVL(W5*(1-ABS(W5 - ACTUAL)/W5), 0) END AS ACC_5WQTY,
        CASE WHEN W4 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W4 > 2 THEN 0 
        ELSE NVL(W4*(1-ABS(W4 - ACTUAL)/W4), 0) END AS ACC_4WQTY,
        CASE WHEN W3 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W3 > 2 THEN 0 
        ELSE NVL(W3*(1-ABS(W3 - ACTUAL)/W3), 0) END AS ACC_3WQTY,
        CASE WHEN W2 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W2 > 2 THEN 0 
        ELSE NVL(W2*(1-ABS(W2 - ACTUAL)/W2), 0) END AS ACC_2WQTY,
        CASE WHEN W1 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W1 > 2 THEN 0 
        ELSE NVL(W1*(1-ABS(W1 - ACTUAL)/W1), 0) END AS ACC_1WQTY,
        (NVL(W6, 0) + NVL(W5, 0) + NVL(W4, 0) + NVL(W3, 0) + NVL(W2, 0) + NVL(W1, 0)) /
        (NVL2(W6, 1, 0) + NVL2(W5, 1, 0) + NVL2(W4, 1, 0) + NVL2(W3, 1, 0) + NVL2(W2, 1, 0) + NVL2(W1, 1, 0)) AS FCST_AVG,
        ((CASE WHEN W6 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W6 > 2 THEN 0 
        ELSE NVL(W6*(1-ABS(W6 - ACTUAL)/W6), 0) END)+
        (CASE WHEN W5 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W5 > 2 THEN 0 
        ELSE NVL(W5*(1-ABS(W5 - ACTUAL)/W5), 0) END)+
        (CASE WHEN W4 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W4 > 2 THEN 0 
        ELSE NVL(W4*(1-ABS(W4 - ACTUAL)/W4), 0) END)+
        (CASE WHEN W3 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W3 > 2 THEN 0 
        ELSE NVL(W3*(1-ABS(W3 - ACTUAL)/W3), 0) END)+
        (CASE WHEN W2 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W2 > 2 THEN 0 
        ELSE NVL(W2*(1-ABS(W2 - ACTUAL)/W2), 0) END)+
        (CASE WHEN W1 = 0 OR ACTUAL = 0 THEN 0 
        WHEN ACTUAL/W1 > 2 THEN 0 
        ELSE NVL(W1*(1-ABS(W1 - ACTUAL)/W1), 0) END)) / 6 AS ACC_AVG
    FROM (
        SELECT * FROM
        (
            SELECT PRD_SEG1,
                   PRD_SEG2,
                   PRD_SEG3,
                   'D603_ACT_FCST' AS MEASUREID,
                   '201913' AS PLANWEEK,
                   YEAR,
                   WEEK,
                   YEAR||WEEK AS TARGETWEEK,
                   QTY AS ACTUAL,
                   OUTFCST
            FROM PRO_FCST_RESULT_6WEEK
            WHERE 1=1
            AND YEAR||WEEK = '201918'
        UNION
            SELECT PRD_SEG1,
                   PRD_SEG2,
                   PRD_SEG3,
                   'D603_ACT_FCST' AS MEASUREID,
                   '201914' AS PLANWEEK,
                   YEAR,
                   WEEK,
                   YEAR||WEEK AS TARGETWEEK,
                   QTY AS ACTUAL,
                   OUTFCST
            FROM PRO_FCST_RESULT_5WEEK
            WHERE 1=1
            AND YEAR||WEEK = '201918'
        UNION
            SELECT PRD_SEG1,
                   PRD_SEG2,
                   PRD_SEG3,
                   'D603_ACT_FCST' AS MEASUREID,
                   '201915' AS PLANWEEK,
                   YEAR,
                   WEEK,
                   YEAR||WEEK AS TARGETWEEK,
                   QTY AS ACTUAL,
                   OUTFCST
            FROM PRO_FCST_RESULT_4WEEK
            WHERE 1=1
            AND YEAR||WEEK = '201918'
        UNION
            SELECT PRD_SEG1,
                   PRD_SEG2,
                   PRD_SEG3,
                   'D603_ACT_FCST' AS MEASUREID,
                   '201916' AS PLANWEEK,
                   YEAR,
                   WEEK,
                   YEAR||WEEK AS TARGETWEEK,
                   QTY AS ACTUAL,
                   OUTFCST
            FROM PRO_FCST_RESULT_3WEEK
            WHERE 1=1
            AND YEAR||WEEK = '201918'
        UNION
            SELECT PRD_SEG1,
                   PRD_SEG2,
                   PRD_SEG3,
                   'D603_ACT_FCST' AS MEASUREID,
                   '201917' AS PLANWEEK,
                   YEAR,
                   WEEK,
                   YEAR||WEEK AS TARGETWEEK,
                   QTY AS ACTUAL,
                   OUTFCST
            FROM PRO_FCST_RESULT_2WEEK
            WHERE 1=1
            AND YEAR||WEEK = '201918'
        UNION
            SELECT PRD_SEG1,
                   PRD_SEG2,
                   PRD_SEG3,
                   'D603_ACT_FCST' AS MEASUREID,
                   '201918' AS PLANWEEK,
                   YEAR,
                   WEEK,
                   YEAR||WEEK AS TARGETWEEK,
                   QTY AS ACTUAL,
                   OUTFCST
            FROM PRO_FCST_RESULT_1WEEK
        )PIVOT(
            SUM(OUTFCST) FOR PLANWEEK IN ('201918' AS W1, '201917' AS W2, '201916' AS W3, '201915' AS W4, '201914' AS W5, '201913' AS W6)
        )
    )
)
GROUP BY ROLLUP(PRD_SEG1)
ORDER BY PRD_SEG1;