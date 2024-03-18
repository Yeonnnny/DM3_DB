/* 
[연습문제]  Select문의 기초
*/

-- 1) 이름이 ‘William’인 사람의 성, 이메일, 전화번호를 조회하라
select last_name, email, phone_number
from employees
where first_name = 'William';

-- 2) 매니저가 103인 직원의 정보(아이디, 이름, 부서, 매니저번호)를 조회하시오.
select employee_id, first_name, department_id, manager_id
from employees
where manager_id=103;

-- 3) 어느 부서에도 속하지 않은 직원의 정보 (이름, 전화번호, 부서)를 조회하시오
select first_name, phone_number, department_id
from employees
where department_id is null;

-- 4) 급여가 10000을 초과하면서 JOB_ID가 'SA_REP'인 사람의 이메일, 이름, 전화번호, JOB_ID 정보를 조회하시오
select email, first_name, phone_number, job_id
from employees 
where salary >10000 and job_id like 'SA_REP';

-- 5) 부서가 60이거나 이름이 A로 시작하는 시작하는 직원의 정보(이름, 급여, 부서)를  조회하시오.
select first_name, salary, department_id
from employees
where department_id=60 or first_name like 'A%';

-- 6) 부서가 10이거나 50이거나 60번 부서의 직원의 정보(이름, 급여, 부서)를 조회하시오
select first_name, salary, department_id
from employees
where department_id in (10,50,60);

-- 7) 이름이 3글자인 모든 사람의 정보를 조회하시오.
select * 
from employees
where first_name like '___';

-- 8) 전체 직원들중 직급이 'CLERK' 들을 조회 (종류가 많음)
select first_name, job_id
from employees
where job_id like '%CLERK';

-- 9) 커미션(COMMISSION_PCT)을 받는 사람들의 이름과 이메일을 조회
select first_name, email
from employees
where commission_pct is not null;

-- 10) 이메일이 'KGEE'인 사람의 풀네임은?
select first_name||' '||last_name as fullname
from employees
where email like 'KGEE';

-- 11) SALARY(급여)가 10000달러 초과하면서, JOB_ID(직업번호)가 'SA_REP' 인 사람의 
--     EMAIL, LAST_NAME, PHONE_NUMBER를 EMPLOYEES 테이블에서 조회
select EMAIL, LAST_NAME, PHONE_NUMBER
from employees
where salary >10000 and job_id like 'SA_REP';

-- 12) SALARY(급여)가 3000달러 미만이거나, 14000달러를 초과하는 직원의 EMPLOYEE_ID를 조회
select employee_id
from employees
where salary<3000 or salary>14000;

-- 13) 모든 직원의 업무와 부서번호를 중복되는 값이 없도록 조회하시오.
select distinct job_id, department_id
from employees;

-- 14) 80번 부서에 속한 직원의 사원번호, 이름, 급여, 입사일을 조회하시오. 이때 입사일이 빠른순으로 정렬
select employee_id, first_name, salary, hire_date
from employees
where department_id in 80
order by hire_date;

-- 15) 전체 직원의 사원번호, 이름, 급여, 부서번호, 를 조회하시오.
--     이때 부서번호 오름차순, 같은 부서의 경우 급여의 내림차순으로 정렬하시오
select employee_id, first_name, salary, department_id
from employees
order by department_id, salary desc;
