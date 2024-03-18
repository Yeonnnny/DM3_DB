--jpa02�� �����ϴ� ���̺� ����

drop table myuser;
create table myuser
(
    email varchar2(50) primary key
    ,username varchar2(50) not null
    ,join_date date default sysdate
);

select * from myuser;


--jpa03�� �����ϴ� ���̺� ����
drop table mem;
create table mem
(
     email varchar2(50) primary key
    ,username varchar2(50) not null
    ,birthday date
    ,age number(3)
);

select * from mem;



-- jpa04���� ����� ��ü DDL

drop table product;
drop SEQUENCE prod_seq;

create table product -- �Ƿ��� ����
(
    prod_id number primary key  -- �Ϸù�ȣ
    ,prod_name varchar2(50)
    ,season varchar2(100) -- ��, ����, ����, �ܿ�
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


-- 1page��û��
--select * 
--from( select rownum as num,  tbl.*
--      from test_user tbl)
--where num between 21 and 30;

