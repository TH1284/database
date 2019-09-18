SELECT A.REGIONID, B.REGIONNAME, A.YEARWEEK, A.QTY,
    ROUND((SELECT AVG(QTY)
    FROM KOPO_CHANNEL_SEASONALITY_NEW
    WHERE REGIONID = A.REGIONID
    AND PRODUCT = A.PRODUCT
    GROUP BY A.REGIONID, A.PRODUCT)) AS SUM_QTY,
    CASE WHEN QTY <100 THEN 1000
    ELSE QTY END AS QTY_NEW
FROM KOPO_CHANNEL_SEASONALITY_NEW A
LEFT JOIN KOPO_REGION_MST B
ON A.REGIONID = B.REGIONID


SELECT * FROM KOPO_CHANNEL_SEASONALITY_NEW

SELECT * FROM KOPO_REGION_MST




SELECT
    B.REGIONID, A.REGIONNAME, A00, A01, A02 
    FROM
(    
    SELECT
        REPLACE(REGIONNAME,'AFRICA', 'KOREA') AS REGIONNAME,
        ROUND(CASE WHEN A00 IS NULL THEN 0
        ELSE A00 END) AS A00,
        ROUND(CASE WHEN A01 IS NULL THEN 0
        ELSE A01 END) AS A01,
        ROUND(CASE WHEN A02 IS NULL THEN 0
        ELSE A02 END) AS A02
        FROM
    (
        SELECT
            *
            FROM
        (
            SELECT
                REGIONID,REGIONNAME, AVG(QTY) AS AVG_QTY
                FROM
                (SELECT A.*, B.REGIONNAME,
                    ROUND((SELECT AVG(QTY)
                    FROM KOPO_CHANNEL_SEASONALITY_NEW
                    WHERE REGIONID = A.REGIONID
                    AND PRODUCT = A.PRODUCT
                    GROUP BY A.REGIONID, A.PRODUCT)) AS SUM_QTY,
                    CASE WHEN QTY <100 THEN 1000
                    ELSE QTY END AS QTY_NEW
                FROM KOPO_CHANNEL_SEASONALITY_NEW A
                LEFT JOIN KOPO_REGION_MST B
                ON A.REGIONID = B.REGIONID
            )
            GROUP BY REGIONID,REGIONNAME, QTY_NEW
            ORDER BY REGIONID,REGIONNAME, QTY_NEW
        )
        PIVOT(
            SUM(AVG_QTY)
            FOR REGIONID IN
            ('A00' AS A00, 'A01' AS A01, 'A02' AS A02)
        )
        ORDER BY REGIONNAME
    )
)A
INNER JOIN KOPO_REGION_MST B
ON A. REGIONNAME = B.REGIONNAME

ITEM00533

A01



PRTOMOION

--STEP1:
-- 실적과 프로모션 정보를 조인한다.
--STEP2:
--프로모션이 맵핑안되는경우 예외처리로 해당 제품(PRODUCT) 평균 할인값을 적용한다
--STEP3:
-- 지역,상품,아이팀별 최대할인 TOP RANK 10개를 추출한다!

-- 실적
SELECT * FROM KOPO_CHANNEL_RESULT_NEW
WHERE ITEM = 'ITEM00533'
-- 프로모션
SELECT * FROM KOPO_PROMOTION

select * from tabs
where 1=1
and table_name like '%PROMOTION%'


select * from KOPO_EVENT_INFO_TEST


SELECT * from tabs

