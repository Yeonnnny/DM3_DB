/*PK�� FK�� ���踦 ���� ���̺� �����ϱ�*/
-- 1) ������ �θ� ���̺� -> �ڽ�
-- 2) ������ ����-> �ڽ� ���̺� ����, �θ� ���̺��� ���߿�


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
    , '�տ���'
    , '00/01/23'
    , 'M'
);

insert into members
values
(
    members_seq.nextval
    , 'JEON'
    , '����ġ'
    , '93/12/05'
    , 'M'
);


insert into members
values
(
    members_seq.nextval
    , 'KIM'
    , '�赵��'
    , '01/08/28'
    , 'F'
);

insert into members
values
(
    members_seq.nextval
    , 'JO'
    , '������'
    , '01/08/02'
    , 'F'
);


select * 
from members;

commit;

select * from user_constraints;


/* ���� ���̺�(purchase) : members�� �ڽ� ���̺� */
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
-- foreign key�� �θ��� pk�� �����ϴ� ���� �����̳�, unique�� ������

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

-- �տ����� '�ڹ��� ����'�� 1�� ����
insert into purchase
(seqid, item, price, seqno)
values
(purchase_seq.nextval, '�ڹ��� ����', 24000, 1);

-- ����ġ�� 'ȥ�����̽�'�� 2�� ����
insert into purchase
(seqid, item, price, quantity,seqno)
values
(purchase_seq.nextval, 'ȥ�����̽�', 16000*2, 2,2);



-- �赵���� 'V3' 1ī�� ����
insert into purchase
(seqid, item, price, seqno)
values
(purchase_seq.nextval, 'v3 ���', 20000, 3);

-- �տ����� '���� û�� Ű����'�� 1�� ����
insert into purchase
(seqid, item, price, seqno)
values
(purchase_seq.nextval, '���� û�� Ű����', 3200000, 1);



--[����] ���� ��ȣ, ������ �̸�, �����۸�, ���Ű����� ��ȸ

select * from purchase;

select p.seqid, m.user_name, p.item, p.price
from members m join purchase p using(seqno);





-----------------------------------------------------------------------------
/*��������*/



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


--5)�� ������
insert into lunchbox values ('menu01', '������ȭ����', 6500);
insert into lunchbox values ('menu02', 'ġŲ����', 4400);
insert into lunchbox values ('menu03', '������ô�', 7000);
insert into lunchbox values ('menu04', '��ȭ(ġŲ, �����)', 10000);
insert into lunchbox values ('menu05', '���� ���� ���屸��', 12000);

select * from lunchbox;

--6)�� ������
insert into customer values ('hong','ȫ�浿','����� ������ ���ﵿ','010-1111-2222');
insert into customer values ('lim','�Ӳ���', '�λ�� �����1��','010-2222-1212');
insert into customer values ('son','����ġ', '��õ�� ������','010-3333-3434');
insert into customer values ('park','�ڰ���','���ֽ� ������ 1234','010-1234-5656');
insert into customer values ('kim','�質��', '����� ���۱� ��絿','010-5678-8989');

select * from customer;

--7)�� ������
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
where menu_title like '%ġŲ%';

-- 9)
select *
from lunchbox
where price <=10000;

--10)
select c.cust_name as ���̸�, l.menu_title as "���ö� �̸�", l.price as ����, o.order_count as �ֹ�����, l.price*o.order_count as �ֹ��ݾ�, o.order_date as �ֹ���¥
from customer c join orders o using(cust_id) join lunchbox l using(lunchbox_id)
order by 5 desc;
