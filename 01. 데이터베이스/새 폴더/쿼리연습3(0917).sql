--�Ϲ� ���̺� �����ϱ�
CREATE TABLE CUSTOMERDATA
(
    CUSTID VARCHAR(200),
    AVERAGEPRICE NUMBER,
    EMI NUMBER,
    DEVICECOUNT NUMBER,
    PRODUCTAGE NUMBER,
    CUSTTYPE NUMBER
    );
    
CREATE TABLE KOPO_ST_DDL_TH
(
    PRODUCT VARCHAR2(40),
    YEARWEEK VARCHAR2(6),
    VOLUME NUMBER,
    DATA VARCHAR2(1000) default sysdate
)

SELECT * FROm KOPO_ST_DDL_TH

CREATE TABLE CUSTOMERDATA2
(
    CUSTID VARCHAR(200),
    AVERAGEPRICE NUMBER,
    EMI NUMBER,
    DEVICECOUNT NUMBER,
    PRODUCTAGE NUMBER,
    CUSTTYPE NUMBER default 'normal');
    
CREATE TABLE ����
(
    �÷�1 NUMBER,
    �÷�2 VARCHAR2(10),
    �÷�3 DATE);
    
SELECT * FROM ����

--���̺� ��ü �����ϱ�
CREATE TABLE �O��4 AS SELECT * FROM ����

SELECT * FROM CUSTOMERDATA

drop table ����2

create table customerdata5(
    custid varchar2(200),
    averageprice number,
    emi number,
    devicecount number,
    productage number,
    custtype varchar2(20) default 'normal')

SELECT * FROM customerdata5

INSERT INTO customerdata5(custid,averageprice,emi,devicecount) VALUES(1,2,3,4)

SELECT * FROM TABS

--�ӽ� ���̺� �����ϱ�
CREATE TABLE KOPO_CUSTOMERDATA_YH as SELECT * FROM CUSTOMERDATA

SELECT * FROM KOPO_CUSTOMERDATA_YH

--Ư�� �÷��� ����
ALTER TABLE KOPO_CUSTOMERDATA_YH add(DESCRIPTION VARCHAR2(100));

alter table KOPO_CUSTOMERDATA_YH
   add(description2 varchar2(100) default 'indo')

--���̺� �÷� �̸� �����ϱ�
ALTER TABLE KOPO_CUSTOMERDATA_YH RENAME COLUMN DESCRIPTION TO NATION

--�÷��Ӽ� �����ϱ�
ALTER TABLE KOPO_CUSTOMERDATA_YH MODIFY(DESCRIPTION2 VARCHAR2(1000))

--�÷��Ӽ� Ȯ���ϱ�
DESC KOPO_CUSTOMERDATA_YH

--�÷������ϱ�
ALTER TABLE KOPO_CUSTOMERDATA_YH DROP COLUMN NATION

SELECT * FROM KOPO_CUSTOMERDATA_YH

--���̺� �ڷ� ����
TRUNCATE TABLE KOPO_CUSTOMERDATA_YH

SELECT * FROM KOPO_CUSTOMERDATA_YH

--���ÿ� ���� ���̺� ������ ����