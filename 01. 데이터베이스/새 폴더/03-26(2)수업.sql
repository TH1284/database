create table kopo_product_volume_������
(
    REGIONID    VARCHAR(20 BYTE),
    PRODUCTGROUP VARCHAR(20 BYTE),
    YEARWEAR    VARCHAR(10 BYTE),
    VOLUME      NUMBER
)

SELECT * FROM kopo_product_volume_������

INSERT INTO kopo_product_volume_������
--VALUES('REGIONID','PRODUCTGROUP', '201702', ����)
VALUES('A01','ST0001', '201702', 200)

drop table kopo_product_volume_������




create table kopo_product_volume_������
(
    REGIONID    VARCHAR(20 BYTE),
    PRODUCTGROUP VARCHAR(20 BYTE),
    YEARWEER    VARCHAR(8 BYTE),
    VOLUME      NUMBER not null,
    CONSTRAINT pk_kopo_product_volume_������ PRIMARY KEY(REGIONID,PRODUCTGROUP,YEARWEER))
    
    INSERT INTO kopo_product_volume_������
    VALUES('REGIONID','PRODUCTGROUP','201702',200)
    
drop table kopo_product_volume_������