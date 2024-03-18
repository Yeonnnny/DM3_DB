--jpa02와 연동하는 테이블 생성

drop table myuser;
create table myuser
(
    email varchar2(50) primary key
    ,username varchar2(50) not null
    ,join_date date default sysdate
);

select * from myuser;


--jpa03와 연동하는 테이블 생성
drop table mem;
create table mem
(
     email varchar2(50) primary key
    ,username varchar2(50) not null
    ,birthday date
    ,age number(3)
);

select * from mem;



-- jpa04에서 사용할 객체 DDL

drop table product;
drop SEQUENCE prod_seq;

create table product -- 의류로 가정
(
    prod_id number primary key  -- 일련번호
    ,prod_name varchar2(50)
    ,season varchar2(100) -- 봄, 여름, 가을, 겨울
    ,unit_price number
);

create SEQUENCE prod_seq;

select * from product;

------- jpql test


drop table test_user;
drop SEQUENCE testuser_seq;
create table test_user(
    userid number primary key
    , username varchar2(250) not null
    , pwd varchar2(200) not null
    , email varchar2(200) not null
);

create SEQUENCE testuser_seq;

select * from test_user;


-- 1page요청함
--select * 
--from( select rownum as num,  tbl.*
--      from test_user tbl)
--where num between 21 and 30;

