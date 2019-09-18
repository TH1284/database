--STEP1:
-- ������ ���θ�� ������ �����Ѵ�.
--STEP2:
--���θ���� ���ξȵǴ°�� ����ó���� �ش� ��ǰ(PRODUCT) ��� ���ΰ��� �����Ѵ�
--STEP3:
-- ����,��ǰ,�������� �ִ����� TOP RANK 10���� �����Ѵ�!

SELECT * FROM KOPO_CHANNEL_RESULT_NEW

SELECT * FROM KOPO_PROMOTION

SELECT A.REGIONID, A.PRODUCT, A.ITEM, A.YEARWEEK, B.MAP_PRICE
FROM KOPO_CHANNEL_RESULT_NEW A
LEFT JOIN KOPO_PROMOTION B
ON A.ITEM = B.ITEM

--���θ�� ���� ����ó��(1.TARGETWEEK>PLANWEEK ����,2.PRICE NULL�� 0���� �ٲ�, 3. PROCE���� 0�̸� IR,PMAP���� 0��)
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

--����1        
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



--����2        
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

--���θ���� ���ξȵǴ°�� ����ó���� �ش� ��ǰ(PRODUCT) ��� ���ΰ��� ����

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

--��� ���ΰ� ����
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

--���� ��ǰ �����ۺ� TOP10 ����-------------------------------------
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











