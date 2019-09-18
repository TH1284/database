--지역 상품 아이템별 TOP10 추출-------------------------------------
SELECT
    *
    FROM
(
    SELECT
            A.*,
            ROW_NUMBER() OVER(ORDER BY MAP_PRICE DESC) AS REGION_PRODUCT_ITEMROW
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


SELECT * FROM PRO_PROMOTION
WHERE 1=1
AND TARGETWEEK < PLANWEEK
