/* ************************
조인 (join)
- 둘 이상의 테이블들을 결합하여 데이터를 조회
- 인반적으로 pk와 fk의 관계를 갖고 있는 테이블을 통해 검색
- 관계형 데이터베이스의 가장 큰 장점이면서 가장 중요한 핵심
- 조인을 하는 이유는 데이터의 무결성을 유지하기 위해 테이블을 정규화하는 작업으로 인해 
둘 이상으로 나뉘어진 정보를 조회하기 위한 목적을 가짐
***************************/

-- Cross Join(=카르테시아 조인) : A x B 
-- 직원이름, 급여, 부서명
select e.first_name, e.salary, d.department_name
from departments d, employees e;

select department_name
from departments;

-- EQUI Join : PK와 FK가 같아야 조인처리됨 
-- 직원이름, 급여, 부서명
select e.first_name, e.salary, d.department_name
from departments d, employees e
where d.department_id=e.department_id;


--
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM countries;


-- 부서명과 나라명, 도시명을 조회
select d.department_name, c.country_name,l.city
from departments d, locations l, countries c
where l.location_id = d.location_id and l.country_id = c.country_id; 


/*inner join (join on 조인이라고도 불림)
- 결과는 EQUI join과 동일
- 문법이 다름 
- inner라는 키워드가 들어감 (inner 생략 가능)
- where --> on으로 pk,fk 연결
- fk가 null인 데이터는 조회 안됨
*/
--inner join, on키워드
select e.first_name, e.salary, d.department_name
from departments d inner join employees e
on d.department_id=e.department_id;

--inner 생략, on 키워드
select e.first_name, e.salary, d.department_name
from departments d join employees e
on d.department_id=e.department_id;


-- on 대신 using() 키워드 : using은 PK와 FK의 name이 같을 때만 사용가능함. sefe-join의 경우 사용 불가능함. 
select e.first_name, e.salary, d.department_name
from departments d join employees e
using (department_id);



-- 이름, 급여, 부서명 조회
--1) 오라클 문법
SELECT first_name, salary, d.department_name
from employees e, departments d
where e.department_id=d.department_id;

--2) inner join
SELECT first_name, salary, d.department_name
from employees e inner join departments d
on e.department_id=d.department_id;

--3) ANSI 표준 : join~on (inner 생략가능)
SELECT first_name, salary, d.department_name
from employees e join departments d
on e.department_id=d.department_id;

--4) ANSI 표준 : join~using (inner 생략가능)
SELECT first_name, salary, d.department_name
from employees e join departments d
using (department_id);



--[연습] 부서명, 나라명, 도시명 조회
--1)오라클 문법
select d.department_name, c.country_name, l.city
from departments d, locations l, countries c
where l.location_id = d.location_id and l.country_id = c.country_id; 

--2)ANSI 표준 : inner join
select d.department_name, c.country_name, l.city
from departments d inner join locations l on l.location_id = d.location_id 
    inner join countries c on l.country_id = c.country_id ;

--3)ANSI 표준 : join~on
select d.department_name, c.country_name, l.city
from departments d join locations l on l.location_id = d.location_id 
    join countries c on l.country_id = c.country_id ;

--4)ANSI 표준 : join~using
select d.department_name, c.country_name, l.city
from departments d join locations l using(location_id) 
    join countries c  using(country_id) ;




--[연습] 이름, 입사일, 근속 연수, 부서명, 직급이름
select e.first_name as 이름, e.hire_date as 입사일, floor(months_between(sysdate,e.hire_date)/12) as 근속연수, d.department_name as 부서명, j.job_title as 직급이름
from employees e join departments d 
        using(department_id) 
            join jobs j 
                using(job_id)
order by 3 desc;

-- join~on으로 변경
select e.first_name as 이름, e.hire_date as 입사일, floor(months_between(sysdate,e.hire_date)/12) as 근속연수, d.department_name as 부서명, j.job_title as 직급이름
from employees e join departments d 
        on d.department_id = e.department_id 
            join jobs j 
                on e.job_id = j.job_id
order by 3 desc;

-- 오라클 문법으로 변경
select e.first_name as 이름, e.hire_date as 입사일, floor(months_between(sysdate,e.hire_date)/12) as 근속연수, d.department_name as 부서명, j.job_title as 직급이름
from employees e, departments d , jobs j
where d.department_id = e.department_id and e.job_id = j.job_id
order by 3 desc;



-- view로 만들기
create view my_view as(
    select e.first_name as 이름, e.hire_date as 입사일, floor(months_between(sysdate,e.hire_date)/12) as 근속연수, d.department_name as 부서명, j.job_title as 직급이름
    from employees e join departments d 
            using(department_id) 
                join jobs j 
                    using(job_id)
);
     
     
select * 
from my_view
order by 근속연수 desc;

--drop view my_view; -- 뷰 삭제


/** outer join 
- fk를 가진 테이블의 데이터가 null일때 조회되지 않는 레코드가 생기므로, 
조회되지 않는 데이터까지 조회하기 위한 조인 방법
- join조건이 같지 않을 경우에도 결과를 반환받고자 할 때
- 종류 : left outer, right outer, full outer

1) left outer
- 먼저 왼쪽 테이블의 데이터를 가져오고, 오른쪽 테이블을 가져오는데, 
이때 조인조건이 맞지 않으면 null로 채움
- 방향은 자식이 있는 곳을 가리킴

*/

--left outer
--[문제] 이름, 부서명 조회
--1. 오라클 문법 (부모, 자식 순서, 부모PK에 (+)붙임)
select e.first_name, d.department_name
from  departments d,employees e
where d.department_id(+) = e.department_id;

--2. LEFT OUTER JOIN ~ ON (자식, 부모 순서)
select e.first_name, d.department_name
from  employees e left outer join departments d on d.department_id = e.department_id;


--3. LEFT OUTER JOIN ~ ON (자식이 왼쪽에 있음)
select e.first_name, d.department_name
from  employees e left outer join departments d using (department_id);



--4. RIGHT OUTER JOIN ~ ON (자식이 오른쪽에 있음)
select e.first_name, d.department_name
from  departments d  right outer join employees e using (department_id);


/*
SELF JOIN
-- PK, FK가 하나의 테이블 내에 존재
*/


--[문제] 직원의 아이디, 직원의 이름과 매니저 아이디와 이름 조회
-- 1) 오라클 문법
select e2.employee_id, e2.first_name, e2.manager_id, e1.first_name 
from employees e1, employees e2
where e2.manager_id = e1.employee_id;


--2)join on 
select e2.employee_id, e2.first_name, e2.manager_id, e1.first_name 
from employees e1 join employees e2
on e2.manager_id = e1.employee_id;

--3)right join on 
select e2.employee_id, e2.first_name, e2.manager_id, e1.first_name 
from employees e1 right join employees e2
on e2.manager_id = e1.employee_id;


-- [연습문제]
--1. join을 이용해 사원번호가 100인 사원의 사원 번호, 부서번호, 부서이름 조회
select e.employee_id, e.department_id, d.department_name
from employees e join departments d on e.department_id=d.department_id;

-- 2. inner조인을 이용해 사원명과 함께 그 사원이 속한 부서의 도시이름 지역이름 조회
select e.first_name, l.city, r.region_name
from employees e, departments d,locations l, countries c, regions r
where e.department_id=d.department_id and d.location_id=l.location_id and l.country_id = c.country_id and c.region_id = r.region_id; 

-- 3. 100번 부서에 속하는 직원의 이름과 직원의 담당 업무명, 부서가 있는 도시명 조회
select e.first_name, j.job_title, l.city
from employees e, jobs j, departments d, locations l
where e.job_id = j.job_id and e.department_id=d.department_id and d.location_id=l.location_id;









































































