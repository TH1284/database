--STEP1:
-- 실적과 프로모션 정보를 조인한다.
--STEP2:
--프로모션이 맵핑안되는경우 예외처리로 해당 제품(PRODUCT) 평균 할인값을 적용한다
--STEP3:
-- 지역,상품,아이팀별 최대할인 TOP RANK 10개를 추출한다!

SELECT * FROM KOPO_CHANNEL_RESULT_NEW

SELECT * FROM KOPO_PROMOTION

SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, B.MAP_PRICE
FROM KOPO_CHANNEL_RESULT_NEW A
LEFT JOIN KOPO_PROMOTION B
ON A.ITEM = B.ITEM

--프로모션 정보 예외처리(1.TARGETWEEK>PLANWEEK 삭제,2.PRICE NULL값 0으로 바꿈, 3. PROCE값이 0이면 IR,PMAP값도 0값)
SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
        CASE WHEN MAP_PRICE = 0 THEN 0
        ELSE IR END AS IR,
        CASE WHEN MAP_PRICE = 0 THEN 0
        ELSE PMAP END AS PMAP
FROM
(
    SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
            CASE WHEN MAP_PRICE IS NULL THEN 0
            ELSE MAP_PRICE END AS MAP_PRICE,
            IR,PMAP
    FROM KOPO_PROMOTION
    WHERE 1=1
    AND TARGETWEEK < PLANWEEK
)
----------------------------------------------------------



SELECT * FROM KOPO_CHANNEL_RESULT_NEW
WHERE 1=1
AND ITEM = 'ITEM02479'

SELECT * FROM KOPO_PROMOTION
WHERE ITEM = 'ITEM02479'



        SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                CASE WHEN MAP_PRICE IS NULL THEN 0
                ELSE MAP_PRICE END AS MAP_PRICE,
                IR,PMAP
        FROM KOPO_PROMOTION
        WHERE 1=1
        AND TARGETWEEK > PLANWEEK
        --AND PRODUCT IS NULL

--조인1        
SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE
FROM KOPO_CHANNEL_RESULT_NEW A
LEFT JOIN
(
    SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
            CASE WHEN MAP_PRICE = 0 THEN 0
            ELSE IR END AS IR,
            CASE WHEN MAP_PRICE = 0 THEN 0
            ELSE PMAP END AS PMAP
    FROM
    (
        SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                CASE WHEN MAP_PRICE IS NULL THEN 0
                ELSE MAP_PRICE END AS MAP_PRICE,
                IR,PMAP
        FROM KOPO_PROMOTION
        WHERE 1=1   
        AND TARGETWEEK < PLANWEEK
    )
)B
ON A.ITEM = B.ITEM
WHERE 1=1
AND A.PRODUCT IS NOT NULL



--조인2        
SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE, B.IR, B.PMAP
FROM KOPO_CHANNEL_RESULT_NEW A
LEFT JOIN
(
    SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
            CASE WHEN MAP_PRICE = 0 THEN 0
            ELSE IR END AS IR,
            CASE WHEN MAP_PRICE = 0 THEN 0
            ELSE PMAP END AS PMAP
    FROM
    (
        SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                CASE WHEN MAP_PRICE IS NULL THEN 0
                ELSE MAP_PRICE END AS MAP_PRICE,
                IR,PMAP
        FROM KOPO_PROMOTION
        WHERE 1=1
        AND TARGETWEEK < PLANWEEK
    )
)B
ON A.ITEM = B.ITEM 

--프로모션이 맵핑안되는경우 예외처리로 해당 제품(PRODUCT) 평균 할인값을 적용

SELECT
    REGIONID,PRODUCT,
    CASE WHEN PROCE_AVG IS NULL THEN 0
    ELSE PROCE_AVG END AS PROCE_AVG
FROM
(
    SELECT REGIONID,PRODUCT, AVG(MAP_PRICE) AS PROCE_AVG
    FROM
    (
SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE
FROM KOPO_CHANNEL_RESULT_NEW A
LEFT JOIN
(
    SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
            CASE WHEN MAP_PRICE = 0 THEN 0
            ELSE IR END AS IR,
            CASE WHEN MAP_PRICE = 0 THEN 0
            ELSE PMAP END AS PMAP
    FROM
    (
        SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                CASE WHEN MAP_PRICE IS NULL THEN 0
                ELSE MAP_PRICE END AS MAP_PRICE,
                IR,PMAP
        FROM KOPO_PROMOTION
        WHERE 1=1
        AND TARGETWEEK < PLANWEEK
        AND PRODUCT IS NOT NULL
    )
)B
ON A.ITEM = B.ITEM
    )
    GROUP BY REGIONID,PRODUCT
)

--평균 할인값 적용
SELECT REGIONID,PRODUCT,ITEM,YEARWEEK,QTY,
    CASE WHEN MAP_PRICE IS NULL THEN PROCE_AVG
    ELSE MAP_PRICE END AS MAP_PRICE
FROM
(    
    SELECT A.*, B.PROCE_AVG
    FROM
    (
        SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE
        FROM KOPO_CHANNEL_RESULT_NEW A
        LEFT JOIN
        (
            SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
                    CASE WHEN MAP_PRICE = 0 THEN 0
                    ELSE IR END AS IR,
                    CASE WHEN MAP_PRICE = 0 THEN 0
                    ELSE PMAP END AS PMAP
            FROM
            (
                SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                        CASE WHEN MAP_PRICE IS NULL THEN 0
                        ELSE MAP_PRICE END AS MAP_PRICE,
                        IR,PMAP
                FROM KOPO_PROMOTION
                WHERE 1=1
                AND TARGETWEEK < PLANWEEK
            )
        )B
        ON A.ITEM = B.ITEM
        WHERE 1=1
        AND A.PRODUCT IS NOT NULL
    )A
    LEFT JOIN
    (
        SELECT
        REGIONID,PRODUCT,
        CASE WHEN PROCE_AVG IS NULL THEN 0
        ELSE PROCE_AVG END AS PROCE_AVG
    FROM
    (
        SELECT REGIONID,PRODUCT, AVG(MAP_PRICE) AS PROCE_AVG
        FROM
        (
            SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE, B.IR, B.PMAP
            FROM KOPO_CHANNEL_RESULT_NEW A
            LEFT JOIN
            (
                SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
                        CASE WHEN MAP_PRICE = 0 THEN 0
                        ELSE IR END AS IR,
                        CASE WHEN MAP_PRICE = 0 THEN 0
                        ELSE PMAP END AS PMAP
                FROM
                (
                    SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                            CASE WHEN MAP_PRICE IS NULL THEN 0
                            ELSE MAP_PRICE END AS MAP_PRICE,
                            IR,PMAP
                    FROM KOPO_PROMOTION
                    WHERE 1=1
                    AND TARGETWEEK < PLANWEEK
                )
            )B
            ON A.ITEM = B.ITEM
        )
        GROUP BY REGIONID,PRODUCT
    )
    )B
    ON A.PRODUCT = B.PRODUCT
)

--지역 상품 아이템별 TOP10 추출-------------------------------------
SELECT
    *
    FROM
(
    SELECT
            A.*,
            DENSE_RANK() OVER(ORDER BY MAP_PRICE DESC) AS REGION_PRODUCT_ITEMROW
    FROM
    (
        SELECT
            REGIONID,PRODUCT,ITEM, AVG(MAP_PRICE) AS MAP_PRICE
        FROM
        (
            SELECT REGIONID,PRODUCT,ITEM,YEARWEEK,QTY,
                CASE WHEN MAP_PRICE IS NULL THEN PROCE_AVG
                ELSE MAP_PRICE END AS MAP_PRICE
            FROM
            (    
                SELECT A.*, B.PROCE_AVG
                FROM
                (
                    SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE
                    FROM KOPO_CHANNEL_RESULT_NEW A
                    LEFT JOIN
                    (
                        SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
                                CASE WHEN MAP_PRICE = 0 THEN 0
                                ELSE IR END AS IR,
                                CASE WHEN MAP_PRICE = 0 THEN 0
                                ELSE PMAP END AS PMAP
                        FROM
                        (
                            SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                                    CASE WHEN MAP_PRICE IS NULL THEN 0
                                    ELSE MAP_PRICE END AS MAP_PRICE,
                                    IR,PMAP
                            FROM KOPO_PROMOTION
                            WHERE 1=1
                            AND TARGETWEEK < PLANWEEK
                        )
                    )B
                    ON A.ITEM = B.ITEM
                )A
                LEFT JOIN
                (
                    SELECT
                    REGIONID,PRODUCT,
                    CASE WHEN PROCE_AVG IS NULL THEN 0
                    ELSE PROCE_AVG END AS PROCE_AVG
                FROM
                (
                    SELECT REGIONID,PRODUCT, AVG(MAP_PRICE) AS PROCE_AVG
                    FROM
                    (
                        SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, A.QTY, B.MAP_PRICE
                        FROM KOPO_CHANNEL_RESULT_NEW A
                        LEFT JOIN
                        (
                            SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK, MAP_PRICE,
                                    CASE WHEN MAP_PRICE = 0 THEN 0
                                    ELSE IR END AS IR,
                                    CASE WHEN MAP_PRICE = 0 THEN 0
                                    ELSE PMAP END AS PMAP
                            FROM
                            (
                                SELECT REGIONID, ITEM, TARGETWEEK, PLANWEEK,
                                        CASE WHEN MAP_PRICE IS NULL THEN 0
                                        ELSE MAP_PRICE END AS MAP_PRICE,
                                        IR,PMAP
                                FROM KOPO_PROMOTION
                                WHERE 1=1
                                AND TARGETWEEK < PLANWEEK
                            )
                        )B
                        ON A.ITEM = B.ITEM
                        WHERE 1=1
                        AND A.PRODUCT IS NOT NULL
                    )
                    GROUP BY REGIONID,PRODUCT
                )
                )B
                ON A.PRODUCT = B.PRODUCT
                WHERE 1=1
                AND A.PRODUCT IS NOT NULL
            )
        )
        GROUP BY REGIONID,PRODUCT,ITEM
        ORDER BY REGIONID,PRODUCT,ITEM
    )A
    ORDER BY MAP_PRICE DESC
)
WHERE 1=1
AND REGION_PRODUCT_ITEMROW <= 10











