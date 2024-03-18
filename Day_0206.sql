/*PK와 FK의 관계를 가진 테이블 생성하기*/
-- 1) 생성은 부모 테이블 -> 자식
-- 2) 삭제나 수정-> 자식 테이블 먼저, 부모 테이블을 나중에


drop table members;
create table members
(
    seqno number constraints members_seq_pk primary key,
    user_id varchar2(10) constraints members_id_nq unique,
    user_name varchar2(20) constraints members_name_nn not null,
    birthday date constraints members_birth_nn not null,
    gender char constraints members_gender_ck check(gender in ('F','M')) --,member_use char(1)
);

create sequence members_seq;

insert into members
values
(
    members_seq.nextval
    , 'SON'
    , '손오공'
    , '00/01/23'
    , 'M'
);

insert into members
values
(
    members_seq.nextval
    , 'JEON'
    , '전우치'
    , '93/12/05'
    , 'M'
);


insert into members
values
(
    members_seq.nextval
    , 'KIM'
    , '김도연'
    , '01/08/28'
    , 'F'
);

insert into members
values
(
    members_seq.nextval
    , 'JO'
    , '조나윤'
    , '01/08/02'
    , 'F'
);


select * 
from members;

commit;

select * from user_constraints;


/* 구매 테이블(purchase) : members의 자식 테이블 */
drop table purchase;
create table purchase
(
    seqid number constraints purchase_seq_pk primary key,
    item varchar2(50) constraints purchase_item_nn not null,
    price number(10) default 10000,
    pday date default sysdate,
    quantity number(3) default 1,
    seqno number references members(seqno) on delete cascade
);
create sequence purchase_seq;
drop sequence purchase_seq;
-- foreign key는 부모의 pk로 생성하는 것이 보통이나, unique도 가능함

drop table purchase2;
create table purchase2
(
    seqid number constraints purchase_seq_pk primary key,
    item varchar2(50) constraints purchase_item_nn not null,
    price number(10) default 10000,
    pday date default sysdate,
    quantity number(3) default 1,
    userid varchar2(10) references members(user_id) on delete cascade
);

rollback;

-- 손오공이 '자바의 정석'을 1권 구매
insert into purchase
(seqid, item, price, seqno)
values
(purchase_seq.nextval, '자바의 정석', 24000, 1);

-- 전우치가 '혼공파이썬'을 2권 구매
insert into purchase
(seqid, item, price, quantity,seqno)
values
(purchase_seq.nextval, '혼공파이썬', 16000*2, 2,2);



-- 김도연이 'V3' 1카피 구매
insert into purchase
(seqid, item, price, seqno)
values
(purchase_seq.nextval, 'v3 백신', 20000, 3);

-- 손오공이 '기계식 청축 키보드'를 1개 구매
insert into purchase
(seqid, item, price, seqno)
values
(purchase_seq.nextval, '기계식 청축 키보드', 3200000, 1);



--[문제] 구매 번호, 구매인 이름, 아이템명, 구매가격을 조회

select * from purchase;

select p.seqid, m.user_name, p.item, p.price
from members m join purchase p using(seqno);





-----------------------------------------------------------------------------
/*연습문제*/



drop table lunchbox;
create table lunchbox
(
    lunchbox_id varchar2(10) constraints lunchbox_id_pk primary key,
    menu_title varchar2(50) constraints lunchbox_menu_nn not null,
    price number(7) constraints lunchbox_price_nn not null
);


drop table customer;
create table customer
(
    cust_id varchar2(10) constraints customer_id_pk primary key,
    cust_name varchar2(30) constraints customer_name_nn not null,
    address varchar2(100) constraints customer_addr_nn not null,
    phone varchar2(20) constraints customer_phone_nn not null
);

drop table orders;
create table orders
(
    order_id number constraints orders_id_pk primary key,
    cust_id varchar2(10) references customer(cust_id) on delete cascade,
    lunchbox_id varchar2(10) references lunchbox(lunchbox_id) on delete cascade,
    order_count varchar2(20) default '1' constraints orders_counts_nn not null ,
    order_date date default sysdate
);

drop sequence order_seq;
create sequence order_seq;

ALTER TABLE orders
MODIFY order_count NUMBER;


--5)번 데이터
insert into lunchbox values ('menu01', '숯불직화구이', 6500);
insert into lunchbox values ('menu02', '치킨제육', 4400);
insert into lunchbox values ('menu03', '돈까스도련님', 7000);
insert into lunchbox values ('menu04', '매화(치킨, 연어구이)', 10000);
insert into lunchbox values ('menu05', '순살 고등어 간장구이', 12000);

select * from lunchbox;

--6)번 데이터
insert into customer values ('hong','홍길동','서울시 강남구 역삼동','010-1111-2222');
insert into customer values ('lim','임꺽정', '부산시 충장로1가','010-2222-1212');
insert into customer values ('son','전우치', '인천시 연수구','010-3333-3434');
insert into customer values ('park','박가가','광주시 무산대로 1234','010-1234-5656');
insert into customer values ('kim','김나나', '서울시 동작구 사당동','010-5678-8989');

select * from customer;

--7)번 데이터
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'hong', 'menu01', 2);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'lim', 'menu02', 3);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'son', 'menu05', 1);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'kim', 'menu03', 1);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'hong', 'menu04', 5);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'hong', 'menu01', 1);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'son', 'menu02', 3);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'park', 'menu05', 1);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'kim', 'menu02', 1);
insert into orders (order_id, cust_id, lunchbox_id, order_count) values(order_seq.nextval, 'son', 'menu05', 1);

select * from orders;


-- 8)
select *
from lunchbox
where menu_title like '%치킨%';

-- 9)
select *
from lunchbox
where price <=10000;

--10)
select c.cust_name as 고객이름, l.menu_title as "도시락 이름", l.price as 가격, o.order_count as 주문수량, l.price*o.order_count as 주문금액, o.order_date as 주문날짜
from customer c join orders o using(cust_id) join lunchbox l using(lunchbox_id)
order by 5 desc;
