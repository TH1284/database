create table kopo_product_volume_임태현
(
    REGIONID    VARCHAR(20 BYTE),
    PRODUCTGROUP VARCHAR(20 BYTE),
    YEARWEAR    VARCHAR(10 BYTE),
    VOLUME      NUMBER
)

SELECT * FROM kopo_product_volume_임태현

INSERT INTO kopo_product_volume_임태현
--VALUES('REGIONID','PRODUCTGROUP', '201702', 물량)
VALUES('A01','ST0001', '201702', 200)

drop table kopo_product_volume_임태현




create table kopo_product_volume_임태현
(
    REGIONID    VARCHAR(20 BYTE),
    PRODUCTGROUP VARCHAR(20 BYTE),
    YEARWEER    VARCHAR(8 BYTE),
    VOLUME      NUMBER not null,
    CONSTRAINT pk_kopo_product_volume_임태현 PRIMARY KEY(REGIONID,PRODUCTGROUP,YEARWEER))
    
    INSERT INTO kopo_product_volume_임태현
    VALUES('REGIONID','PRODUCTGROUP','201702',200)
    
drop table kopo_product_volume_임태현