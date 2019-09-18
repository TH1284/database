create table node(
    ip      varchar2(1000),
    port    varchar2(1000)
);

select * from node



create table blockchain
(
    no             varchar2(1000),
    previousHash    varchar2(1000),
    timestamp       number,
    data            varchar2(1000),
    currentHash     varchar2(1000),
    proof           varchar2(1000),
    fee             varchar2(1000),
    signature       varchar2(1000)
);
    

select * from blockchain

INSERT INTO blockchain( no, previousHash, timestamp, data, currentHash, proof, fee, signature)
VALUES ( '1', '1', '35', '1', '1', '1', '1', '1' )

DROP TABLE blockchain

create table txdata
(
    commitYN             varchar2(1000),
    sender              varchar2(1000),
    amount               number,
    dreceiver            varchar2(1000),
    uuid     varchar2(1000),
    fee           varchar2(1000),
    message             varchar2(1000),
    txTime       varchar2(1000)
)


select * from txdata

truncate table blockchain