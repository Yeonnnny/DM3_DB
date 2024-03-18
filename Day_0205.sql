/**************************************
�������� (Sub Query)
- ���� ���� �ȿ� �ٸ� ������ ���Ե� ��
- ��������, ��������

1) �������� 
- ���� ����� ��ȸ�Ǵ� ����
- ���������� ���� ����� �������� ����� ���� ���� ������ �����

2) ��������
- ���������� ���ʿ� ��ġ�� ����
- ���������� �������� ���������� �����̳� ����� ����
- ������������ order by ����� �� ����
- ���������� ��� ��ġ
    * where�� : ���� ����� 1���� ������ ����� ��� 
    * having�� : ������������ �׷��� �Լ��� ����ϰ� �׷쿡 ���� ������ ���������� ��밡����
    * from��
    * select�� 
    * insert ����� into��
    * update ����� set��
    
- ���������� ����
    * ������ �������� : ���������� ����� �ϳ��� ������ ���
    * ������ �������� : ���������� ����� �ϳ� �̻� ������ ���
                     where ���� in �����ڿ� ��� ���� 
                     in, any, all, exists ��


**************************************/

--[����1]�����ȣ�� 109���� ����� �޿����� �޿��� ���� ������ �̸��� ������ ��ȸ
-- �Ϲ� ������ �ι� ������ �� ���
select salary
from employees
where  employee_id =109; --9000

select first_name, job_id, salary
from employees
where salary > 9000
order by 3;


-- �������� ��� (������ ��������)
select first_name, job_id, salary
from employees
where salary > (select salary
                from employees
                where  employee_id =109)
order by 3;


--[����2]�����ȣ�� 162�� �޿��� ������ ������� ��� ��ȸ
select first_name, salary, department_id 
from employees
where salary = (select salary
                from employees
                where employee_id=162);



--[����3] from ������ ��� - 
select employee_id , first_name, salary, department_id
from employees 
where department_id = 50;



select *
from (select employee_id , first_name, salary, department_id
      from employees 
      where department_id = 50) tbl;



select *
from (select rownum as rno, employee_id , first_name, salary, department_id
      from employees 
      where department_id = 50) tbl
where salary >3000 and rno between 11 and 20;


select *
from (select rownum as rno, employee_id , first_name, salary, department_id
      from employees 
      where department_id = 50) tbl
where rno between 11 and 20;



-- �Ϸù�ȣ rownum : �������� �ٿ��ִ� ������ȣ, paging�ϴ� ��� ���� ��� �Խ��� �� �� �� ���ڵ庰 ��ȣ�� �ʿ��� �� �����
select rownum, first_name
from employees
where department_id=80;



--[����4] ��� ��ȣ�� 101�� ����� job_id�� ���� ������� ���
select employee_id, first_name, job_id
from employees
where job_id = (select job_id
                from employees
                where employee_id = 101);

--[����5] 03�⵵ ������ �Ի��� �������� �Ϸù�ȣ�� �̸�, �޿�, �Ի���, �μ���
select *
from (select rownum as rno, first_name, salary, hire_date, department_name
      from employees join departments using(department_id)
      where hire_date <'03/01/01')
order by salary desc;


select *
from (select rownum as rno,first_name, salary, hire_date, department_name
      from employees join departments using(department_id) )
where hire_date <'03/01/01';

select rownum as rno,temp.*
from (select first_name, salary, hire_date, department_name
      from employees join departments using(department_id)
      order by salary desc )temp
where hire_date <'03/01/01';

-- �� �� 3��°�� �޿��� ���� ������ ��� ����
select *
from(select rownum as rno,temp.*
     from (select first_name, salary, hire_date, department_name
           from employees join departments using(department_id)
           where hire_date <'03/01/01'
           order by salary desc )temp)
where rno=3;


-- 9. SELF JOIN�� ����Ͽ� 'Oliver' ����� �μ���, �� ����� ������ �μ����� �ٹ��ϴ� ���� ����� �̸��� ��ȸ. 
--     ��, �� ���� ��Ī�� �μ���, ����� �� ��.

select department_name, first_name
from (select first_name, department_id
      from employees
      where department_id = (select department_id
                             from employees
                             where first_name = 'Oliver')) join departments using (department_id);


--[����6] �̸��� 'Bruce' , 'Daniel'�� ���� �˰� ����
select first_name, last_name
from employees
where first_name in ('Bruce','Daniel'); 

select (select last_name from employees where first_name like 'Bruce')as "Bruce�� ��", 
       (select last_name from employees where first_name like 'Daniel') as "Daniel�� ��"
from dual;

/*������ ��������*/
-- 1) in �����ڿ� �Բ� ����� ������ ��������

--[����7] in�����ڿ� ����ؼ�, 30�� �μ��� ���ް� ������ ������ �ٸ� �μ����� �ִ��� ��ȸ

select distinct job_id
from employees 
where department_id=30;

select *
from employees
where job_id in (select distinct job_id
                 from employees 
                 where department_id=30);

-- 2) any / all 
-- > any,  < any,  >= any,  <=any,  =any, !=any
-- > all,  < all,  >= all,  <=all,  =all, !=all

-- min : 5800, max : 8200
select salary, job_id
from employees
where job_id = 'ST_MAN';

-- �ּҰ��� 5800 �̻��� ��� salary
select first_name, salary
from employees 
where salary > any (select salary
                    from employees
                    where job_id = 'ST_MAN');


-- ���������� ����� ��� ���麸�� ū���� 8200�� ������������ ���ǹǷ� ���� ū ������ �� ū ��
select first_name, salary
from employees 
where salary > all (select salary
                    from employees
                    where job_id = 'ST_MAN');
                    
                    
                    
-- ���� : ST_MAN ������ �޿� �� ���� ���� �޴� �޿����� �� ���� �޴� ����� �̸�, �޿�

select first_name, salary
from employees 
where salary < all (select salary
                    from employees
                    where job_id = 'ST_MAN');

select first_name, salary
from employees 
where salary < (select min(salary)
                    from employees
                    where job_id = 'ST_MAN');




-- ���� : REP ������ �������� �޴� �޿��� ������ �޿��� �޴� ������ �����ȣ, �̸�, ����, �޿�
select employee_id, first_name, job_id, salary
from employees
where salary = any(select salary 
                 from employees
                 where job_id like '%REP');


select employee_id, first_name, job_id, salary
from employees
where salary in (select salary 
                 from employees
                 where job_id like '%REP');

-- exist : ������������ ������ ����� �����ϴ� ���� �����ϸ� ���� ���� ����
select department_name
from departments
where exists (select department_id
              from employees 
              where department_id = 80);

-- ���� 'Chen'�� �����ϸ� �� ������ �μ���, �̸�, ��,�޿� ��ȸ
select department_name, first_name, last_name, salary
from employees join departments using(department_id)
where exists (select first_name
             from employees
             where last_name like 'Chen') and last_name like 'Chen';


/******************************************************
DDL
- ������ ������ ���̽��� ��ü�� �����ϴ� ��ɹ�
- ���̺�, ������, ��, �ó��, �ε��� ���� ����
- create, alter, drop
- ���̺��� (Pk, fk, nn, uq, ck) - default

*******************************************************/
/*
Data Type

name : 'ȫ�浿' --> vachar2(15) --> 6����Ʈ�� save�� (�ѱ��� �� ���� �� 3����Ʈ)
       'KOREA' --> char(15)   --> 10����Ʈ�� �����

42.195 --> number(10, 3) -- ��ü ���̰� 10�̰�, �� �� �Ҽ��� ���� ���̴� 3
           number(3) -- ��ü ���̰� 3 ��, ������ 999���� ���� �� ����
*/

create table t1
(   
    userid varchar2 not null
    uername varchar2
    birthday date
)

create table ���̺��
(
    �÷���  ������ Ÿ��  ���� ����
    ...
);

drop table members;

create table members
(
    userid number constraints members_id_pk primary key ,  -- default�� 22����Ʈ���� ��밡����, constraints : �������� �̸� ���� (���̺��_�÷���_Ÿ��): �ɼ���
    username varchar2(50) constraints members_name_nn not null,
    birth date,
    age number(3), -- �ִ� 3�ڸ���
    join_date date default sysdate
);


select * 
from members;

-- ��� ���̺� � ���� ������ �ɷ��ִ��� Ȯ���ϱ�
-- �Ϲ� ���̺� �ܿ� ���� ������ �����ϴ� ��Ÿ ���̺�� Ȯ�� ����

select *
from user_constraints;



drop table fitness;

create table fitness
(
    userid varchar2(50) constraints members_id_pk primary key , 
    username varchar2(50) constraints members_name_nn not null,
    gender char(1) constraints members_gender_ch check(gender in ('M','F')), -- M/F
    birth date,
    height number(6,2),
    weight number(6,2),
    join_date date default sysdate
);

-- keyword�� �����ϴ� ��Ÿ ���̺� ��ȸ(DBA����)
select *
from v$reserved_words;

--
drop table my_table;
create table my_table(
    user_id varchar2(10),
    user_name varchar2(50)
);
-- ���̺� ������ ����
-- ���̺� ������� �����͸� �������� �ʰų� ��� �÷��� ���� ���� �ʴ´ٸ� �÷����� ��������� ��
insert into my_table
values ('Hong', 'ȫ�浿');

insert into my_table (user_name)
values ('���Ȱ�');

insert into my_table (user_id)
values ('Son');

insert into my_table (user_name,user_id)
values ('����ġ','Jeon');

insert into my_table
values ('a','��浿');

insert into my_table
values ('b','�̱浿');

insert into my_table
values ('c','�ֱ浿');



select * 
from my_table;


-- ���̺� ����, Ʈ����� ������ ��ɾ�
commit;

-- Ʈ������� �������Ǳ� �� ���·� ���ư�. �� ���� ������ Ŀ�� ���� ����� ������ ��ҵ�
rollback;



--���̺� �����Ͻÿ�
/*
���̵� ���� 3�ڸ� pk
��ǰ�� �������� 50�ڸ� nn
�ܰ� ���� 7�ڸ� nn
���ͷ� : ����(5,1)

*/
drop table product;
create table product
(
    product_id number(3) constraints product_id_pk primary key,
    product_name varchar2(50) constraints product_name_nn not null,
    unit_price number(7) constraints product_price_nn not null,
    ratio number(5,1) 
);

insert into product
values(1,'TV������', 15000, 0.1);

insert into product
values(2,'����Ʈ��', 250000, 0.2);


insert into product
values(PRODUCT_SEQ.nextval,'�����', 1000000, 0.2);

select PRODUCT_SEQ.nextval
from dual;

delete product
where product_id = 3;


update product 
set  unit_price = 35000
where product_id = 1;


select *
from product;

rollback;
commit;

/*********************************
������ (Sequence)
- �ڵ� �Ϸù�ȣ ������
- �������� ����ϰ� �Ǹ� ������ ��ȣ�� ��û�ؼ� ���� ���� �� ����
- �⺻���� 1���� ����, 1�� ����
- �������� �÷� ���� ����
    1) ��������.nextval
    2) ��������.currval
    
create sequence product_seq
increment by 1
star with 1
maxvalue 10
cycle -- 1~10 ��� �ݺ�

**********************************/

create sequence ��������; -- �����ؼ� ����� ���̺��� �̸��� �����ϰ�

drop sequence PRODUCT_SEQ;
create sequence product_seq; -- default : 1���� �����ؼ� 1�� ����

select PRODUCT_SEQ.nextval
from dual;

select PRODUCT_SEQ.currval
from dual;





/*��������*/
-- ���̺� ���� ��������
drop table com_book;
create table com_book
(
    isbn varchar2(10) constraints com_book_no_pk primary key,
    bname varchar2(30) constraints com_book_name_nn not null,
    bcount number constraints com_book_count_nn not null
);


insert into com_book
values ('b1', '��������',2);

insert into com_book
values ('b2', '�ŵ�����',3);


select * 
from com_book;

commit;

drop table com_loan;
create table com_loan
(
    com_loan_num number constraints com_loan_num_pk primary key,
    inputdate date default sysdate,
    isbn varchar2(10) constraints com_loan_count_nn not null,
    quantity number constraints com_loan_quantuty_nn not null
);


drop sequence com_loan_seq;
create sequence com_loan_seq;

select com_loan_seq.currval;





































