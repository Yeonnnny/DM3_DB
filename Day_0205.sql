/**************************************
서브쿼리 (Sub Query)
- 쿼리 문장 안에 다른 쿼리가 포함된 것
- 서브쿼리, 메인쿼리

1) 메인쿼리 
- 실핼 결과가 조회되는 쿼리
- 서브쿼리에 의해 실행된 쿼리문의 결과에 의해 메인 쿼리가 실행됨

2) 서브쿼리
- 메인쿼리의 안쪽에 위치한 쿼리
- 서브쿼리의 실행결과가 메인쿼리의 조건이나 결과로 사용됨
- 서브쿼리에는 order by 사용할 수 없음
- 서브쿼리의 사용 위치
    * where절 : 값의 결과가 1개로 나오는 결과일 경우 
    * having절 : 메인쿼리에서 그룹행 함수를 사용하고 그룹에 대한 조건을 서브쿼리로 사용가능함
    * from절
    * select절 
    * insert 명령의 into절
    * update 명령의 set절
    
- 서브쿼리의 종류
    * 단일행 서브쿼리 : 서브쿼리의 결과가 하나만 나오는 경우
    * 복수행 서브쿼리 : 서브쿼리의 결과가 하나 이상 나오는 경우
                     where 절의 in 연산자와 사용 가능 
                     in, any, all, exists 등


**************************************/

--[문제1]사원번호가 109번인 사원의 급여보다 급여가 많은 직원의 이름과 담당업무 조회
-- 일반 쿼리로 두번 나눠서 한 방법
select salary
from employees
where  employee_id =109; --9000

select first_name, job_id, salary
from employees
where salary > 9000
order by 3;


-- 서브쿼리 사용 (단일행 서브쿼리)
select first_name, job_id, salary
from employees
where salary > (select salary
                from employees
                where  employee_id =109)
order by 3;


--[문제2]사원번호가 162인 급여와 동일한 사원의의 명단 조회
select first_name, salary, department_id 
from employees
where salary = (select salary
                from employees
                where employee_id=162);



--[문제3] from 절에서 사용 - 
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



-- 일련번호 rownum : 동적으로 붙여주는 순서번호, paging하는 경우 예를 들어 게시판 글 등 각 레코드별 번호가 필요할 때 사용함
select rownum, first_name
from employees
where department_id=80;



--[문제4] 사원 번호가 101인 사원의 job_id가 같은 사원들의 목록
select employee_id, first_name, job_id
from employees
where job_id = (select job_id
                from employees
                where employee_id = 101);

--[문제5] 03년도 이전에 입사한 직원들의 일련번호와 이름, 급여, 입사일, 부서명
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

-- 이 중 3번째로 급여가 많은 직원의 명단 제조
select *
from(select rownum as rno,temp.*
     from (select first_name, salary, hire_date, department_name
           from employees join departments using(department_id)
           where hire_date <'03/01/01'
           order by salary desc )temp)
where rno=3;


-- 9. SELF JOIN을 사용하여 'Oliver' 사원의 부서명, 그 사원과 동일한 부서에서 근무하는 동료 사원의 이름을 조회. 
--     단, 각 열의 별칭은 부서명, 동료로 할 것.

select department_name, first_name
from (select first_name, department_id
      from employees
      where department_id = (select department_id
                             from employees
                             where first_name = 'Oliver')) join departments using (department_id);


--[문제6] 이름이 'Bruce' , 'Daniel'의 성을 알고 싶음
select first_name, last_name
from employees
where first_name in ('Bruce','Daniel'); 

select (select last_name from employees where first_name like 'Bruce')as "Bruce의 성", 
       (select last_name from employees where first_name like 'Daniel') as "Daniel의 성"
from dual;

/*복수행 서브쿼리*/
-- 1) in 연산자와 함께 사용한 복수행 서브쿼리

--[문제7] in연산자와 사용해서, 30번 부서의 직급과 동일한 직급이 다른 부서에도 있는지 조회

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

-- 최소값인 5800 이상인 모든 salary
select first_name, salary
from employees 
where salary > any (select salary
                    from employees
                    where job_id = 'ST_MAN');


-- 서브쿼리로 추출된 모든 값들보다 큰값인 8200이 메인쿼리에서 사용되므로 가장 큰 값보다 더 큰 값
select first_name, salary
from employees 
where salary > all (select salary
                    from employees
                    where job_id = 'ST_MAN');
                    
                    
                    
-- 문제 : ST_MAN 직군의 급여 중 가장 적게 받는 급여보다 더 적게 받는 사람의 이름, 급여

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




-- 문제 : REP 직군의 직원들이 받는 급여와 동일한 급여를 받는 직원이 사원번호, 이름, 직급, 급여
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

-- exist : 서브쿼리에서 질의한 결과에 만족하는 행이 존재하면 메인 쿼리 실행
select department_name
from departments
where exists (select department_id
              from employees 
              where department_id = 80);

-- 성이 'Chen'이 존재하면 그 직원의 부서명, 이름, 성,급여 조회
select department_name, first_name, last_name, salary
from employees join departments using(department_id)
where exists (select first_name
             from employees
             where last_name like 'Chen') and last_name like 'Chen';


/******************************************************
DDL
- 관계형 데이터 베이스의 객체를 조작하는 명령문
- 테이블, 시퀀스, 뷰, 시노님, 인덱스 등이 있음
- create, alter, drop
- 테이블에는 (Pk, fk, nn, uq, ck) - default

*******************************************************/
/*
Data Type

name : '홍길동' --> vachar2(15) --> 6바이트는 save됨 (한글은 한 글자 당 3바이트)
       'KOREA' --> char(15)   --> 10바이트는 낭비됨

42.195 --> number(10, 3) -- 전체 길이가 10이고, 그 중 소수점 이하 길이는 3
           number(3) -- 전체 길이가 3 즉, 정수는 999까지 넣을 수 있음
*/

create table t1
(   
    userid varchar2 not null
    uername varchar2
    birthday date
)

create table 테이블명
(
    컬럼명  데이터 타입  제약 조건
    ...
);

drop table members;

create table members
(
    userid number constraints members_id_pk primary key ,  -- default인 22바이트까지 사용가능함, constraints : 제약조건 이름 지정 (테이블명_컬럼명_타입): 옵션임
    username varchar2(50) constraints members_name_nn not null,
    birth date,
    age number(3), -- 최대 3자리수
    join_date date default sysdate
);


select * 
from members;

-- 어느 테이블에 어떤 제약 조건이 걸려있는지 확인하기
-- 일반 테이블 외에 제약 조건을 관리하는 메타 테이블로 확인 가능

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

-- keyword를 관리하는 메타 테이블 조회(DBA가능)
select *
from v$reserved_words;

--
drop table my_table;
create table my_table(
    user_id varchar2(10),
    user_name varchar2(50)
);
-- 테이블에 데이터 삽입
-- 테이블 순서대로 데이터를 삽입하지 않거나 모든 컬럼에 값을 넣지 않는다면 컬럼명을 지정해줘야 함
insert into my_table
values ('Hong', '홍길동');

insert into my_table (user_name)
values ('저팔계');

insert into my_table (user_id)
values ('Son');

insert into my_table (user_name,user_id)
values ('전우치','Jeon');

insert into my_table
values ('a','김길동');

insert into my_table
values ('b','이길동');

insert into my_table
values ('c','최길동');



select * 
from my_table;


-- 테이블 저장, 트랜잭션 마무리 명령어
commit;

-- 트랜잭션이 마무리되기 전 상태로 돌아감. 즉 가장 마지막 커밋 이후 실행된 내용은 취소됨
rollback;



--테이블 생성하시오
/*
아이디 숫자 3자리 pk
상품명 가변길이 50자리 nn
단가 숫자 7자리 nn
이익률 : 숫자(5,1)

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
values(1,'TV리모컨', 15000, 0.1);

insert into product
values(2,'스마트폰', 250000, 0.2);


insert into product
values(PRODUCT_SEQ.nextval,'냉장고', 1000000, 0.2);

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
시퀀스 (Sequence)
- 자동 일련번호 생성기
- 시퀀스를 사용하게 되면 다음의 번호를 요청해서 값을 받을 수 있음
- 기본값은 1부터 시작, 1씩 증가
- 시퀀스의 컬럼 참조 변수
    1) 시퀀스명.nextval
    2) 시퀀스명.currval
    
create sequence product_seq
increment by 1
star with 1
maxvalue 10
cycle -- 1~10 계속 반복

**********************************/

create sequence 시퀀스명; -- 연결해서 사용할 테이블의 이름과 유사하게

drop sequence PRODUCT_SEQ;
create sequence product_seq; -- default : 1부터 시작해서 1씩 증가

select PRODUCT_SEQ.nextval
from dual;

select PRODUCT_SEQ.currval
from dual;





/*연습문제*/
-- 테이블 생성 연습문제
drop table com_book;
create table com_book
(
    isbn varchar2(10) constraints com_book_no_pk primary key,
    bname varchar2(30) constraints com_book_name_nn not null,
    bcount number constraints com_book_count_nn not null
);


insert into com_book
values ('b1', '콩쥐팥쥐',2);

insert into com_book
values ('b2', '신데렐라',3);


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





































