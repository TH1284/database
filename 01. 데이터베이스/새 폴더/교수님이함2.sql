CREATE DATABASE LINK ASUS_LINKS8
CONNECT TO kopo
IDENTIFIED BY kopo
Using 'DEV_KOPO'

CREATE TABLE TH.KOPO_PRODUCT_VOLUME2
(
  REGIONID      VARCHAR2(20 BYTE),
  PRODUCTGROUP  VARCHAR2(20 BYTE),
  YEARWEEK      VARCHAR2(6 BYTE),
  VOLUME        NUMBER
)

select * from KOPO_PRODUCT_VOLUME2

exp userid=kopo/kopo


create table kopo_product_volume3
as
select * from kopo_product_volume@ASUS_LINKS8

insert into KOPO_PRODUCT_VOLUME2
select * from kopo_product_volume@ASUS_LINKS8

select * from kopo_product_volume@ASUS_LINKS8