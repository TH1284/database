create table kopo_product_volume_1(
regionid varchar2(20),
productgroup varchar2(20),
yearweek varchar2(8),
volume number not null,
constraint pk_kopo_product_volume_1 primary key(regionid,productgroup, yearweek))



INSERT INTO KOPO_PRODUCT_VOLUME_1
VALUES('REGIONID','PRODUCTGROUP','201702',NULL)


SELECT * FROM kopo_product_volume_1

DELETE FROM KOPO_PRODUCT_VOLUME_1

--�θ����̺� ����
create table kopo_event_info_foreign_1(
 eventid varchar2(20),
 eventperiod varchar2(20),
 PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign_1 primary key(eventid))
 
 SELECT * FROM kopo_event_info_foreign_1
 

 --�ڽ����̺� ����
 CREATE TABLE KOPO_VOLUME_FOREIGN(
REGIONID        VARCHAR2(20),
PRODUCTGROUP    VARCHAR2(20),
YEARWEEK        VARCHAR2(8),
VOLUME          NUMBER NOT NULL,
EVENTID         VARCHAR2(20),
CONSTRAINT PK_KOPO_VOLUME_FOREIGN PRIMARY KEY(REGIONID, PRODUCTGROUP, YEARWEEK),
CONSTRAINT FK_KOPO_PRODUCT_VOLUME_FOREIGN FOREIGN KEY(EVENTID) REFERENCES kopo_event_info_foreign_1(EVENTID)
ON DELETE CASCADE
)

drop table KOPO_VOLUME_FOREIGN

SELECT * FROM KOPO_VOLUME_FOREIGN
--�ڽ�Ű���� ENNTID ����

INSERT INTO
    KOPO_VOLUME_FOREIGN
    VALUES('A02','ST0001','201502',300,'EV0001')
    
    COMMIT;

INSERT INTO kopo_event_info_foreign_1
    VALUES('EV0002','5',0.4)

--�ڽ�Ű���� ������ ����
TRUNCATE TABLE KOPO_VOLUME_FOREIGN


--�θ����̺���  ������ ������ �ȵ�(����)
DELETE FROM kopo_event_info_foreign_1

--���������� ����(�θ�Ű���� ���� �����ϱ�����)


-- �ڽ� ���̺� �÷� ����
select * from KOPO_PRODUCT_VOLUME_TH2 

select * from REGION_MASTER_TH2

ALTER TABLE KOPO_PRODUCT_VOLUME_TH2 RENAME COLUMN QTY TO VOLUME;

select * from KOPO_PRODUCT_VOLUME_TH2

--�⺻Ű ���� �ٽ��ϱ�

alter table REGION_MASTER_TH2
drop constraints REGION_MASTER_TH2_pk

alter table REGION_MASTER_TH2
ADD constraint REGION_MASTER_TH2_pk primary key(regionid)

alter table KOPO_PRODUCT_VOLUME_TH2
DROP constraints KOPO_PRODUCT_VOLUME_TH2_FK

alter table KOPO_PRODUCT_VOLUME_TH2
ADD constraint KOPO_PRODUCT_VOLUME_TH2_FK
    reference REGION_MASTER_TH2(regionid)
    on delete cascade
    
-- �⺻Ű �����
ALTER TABLE KOPO_PRODUCT_VOLUME_TH2
        ADD CONSTRAINTS KOPO_PRODUCT_VOLUME_TH2_PK
        PRIMARY KEY (REGIOMID, PRODUCTGROUP, YEARWEEK)
        
alter table KOPO_PRODUCT_VOLUME_TH2
    ADD constraints KOPO_PRODUCT_VOLUME_TH2_PK
    primary key (REGIONID, PRODUCTGROUP, YEARWEEK)

EDIT KOPO_PRODUCT_VOLUME_TH2

update KOPO_PRODUCT_VOLUME_TH2
    set volume = 200
    where regionid = 'A01'
    
DELETE FROM KOPO_PRODUCT_VOLUME_TH2
WHERE REGIONID IS NULL
    
SELECT * FROM KOPO_PRODUCT_VOLUME_TH2
WHERE PRODUCTGROUP IS NULL
...

    SELECT  * FROM KOPO_PRODUCT_VOLUME_TH2
    
    
    (REGIONID, PRODUCTGROUP, YEARWEEK,VOLUME) = not NULL