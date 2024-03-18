--4
select l.city as 도시명, count(*) as 인원수
from employees e join departments d using(department_id)
                join locations l using (location_id)
group by l.city;


--5
select first_name, last_name, hire_date
from employees
where trunc(months_between(sysdate,hire_date)/12) <16
order by 3;


--6
select first_name as 이름, salary as 급여,department_id as 부서번호 ,to_char(tmp.avg_salary,'999,999,999.99')as"부서 평균 급여"
from employees e join (select department_id, round(avg(salary),2) as avg_salary
                       from employees
                       group by department_id)tmp using (department_id);


select first_name as 이름, salary as 급여,department_id as 부서번호 ,to_char(tmp.avg_salary,'999,999,999.99')as"부서 평균 급여"
from employees e left outer join (select department_id, round(avg(salary),2) as avg_salary
                       from employees
                       group by department_id)tmp using (department_id);


--7
select employee_id as "사원 번호", end_date-start_date as "업무 기간", job_title as "업무 명"
from job_history join jobs using(job_id);


select employee_id as "사원 번호", 
        trunc((end_date-start_date)/365)||'년 '||trunc((((end_date-start_date)/365)-trunc((end_date-start_date)/365))*12)||'개월' as "업무 기간", 
        job_title as "업무 명"
from job_history join jobs using(job_id);


--8
select ceil(to_date('2024/05/08')-sysdate) from dual;


--9
select department_name as 부서명, ceil(avg(sysdate-hire_date)) as "평균 근무일"
from employees e join departments d using(department_id)
group by department_name
order by 2 desc;

--10
select nvl(manager_id,0) as 매니저번호, ceil(avg(salary)) as 평균급여, max(salary)as 최대급여, min(salary) as 최소급여
from employees
group by manager_id
having avg(salary)>4000
order by 1;


drop table Categories ;

create table Categories 
(
    category_id char(7) constraints categories_id_pk_ck primary key check (category_id in ('WR_PROD','PA_PROD','AR_PROD','ME_PROD','ET_PROD')),
    cateory_name varchar2(30) constraints categories_name_uq_ck unique check(cateory_name in ('필기구','종이류','미술용품','측정용품','기타')),
    cateory_desc varchar2(3000) default 'None'
);


create table Products
(
    prod_id number constraints products_id_pk primary key,
    prod_name varchar2(30) constraints products_name_nn not null,
    country varchar2(50) constraints products_country_nn not null,
    manufactures varchar2(50) constraints products_manufacture_nn not null,
    making_date date,
    category_id char(7) references Categories(category_id) on delete cascade
);

create sequence Products_seq
increment by 50
start with 100;

create table Stock
(
    stock_id number constraints stock_id_pk primary key,
    prod_id number references Products(prod_id) on delete cascade,
    receive_date date,
    forward_date date default sysdate,
    unit_price number(10,2) default 0,
    total_stock number(7) default 0
);

create sequence Stock_seq;

