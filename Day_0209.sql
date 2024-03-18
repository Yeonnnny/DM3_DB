select * from my_table;

drop TABLE friend;
drop sequence friend_seq;
create table friend(
    seq number primary key,
    fname varchar2(30) not null,
    age number(3) default 10,
    is_married char(1) default '0' check(is_married in ('0','1')), --∞·»• ø©∫Œ (0(false):πÃ»•,1(true):±‚»•)
    birthday date,
    height number(6,2)
);

create sequence friend_seq;



insert into friend
values
(
    friend_seq.nextval,
    'º’ø¿∞¯',
    26,
    '0',
    '95/01/05',
    181.4    
);

select * from friend;
select * from friend order by seq;

drop table myuser;
create table myuser
(
    USERNAME      VARCHAR2(20)
    ,EMAIL        VARCHAR2(50)
    ,JOIN_DATE    DATE
);
