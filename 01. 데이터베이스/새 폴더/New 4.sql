create table kopo_product_volume_007(
    regionid varchar2(20),
    productgroup varchar2(20),
    yearweek varchar2(8),
    VOLUME   number NOT NULL,
    CONSTRAINT PK_kopo_product_volume_007 PRIMARY KEY(regionid, productgroup, yearweek))


INSERT INTO kopo_product_volume_007
VALUES('regionid', 'productgroup', '201702', 001)


select * from kopo_product_volume_007

drop table kopo_product_volume_007

