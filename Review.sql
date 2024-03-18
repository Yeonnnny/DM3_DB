/*
Review
*/

-- 1) 이름이 ‘William’인 사람의 성, 이메일, 전화번호를 조회하라
select last_name, email, phone_number
from employees
where first_name like 'William';

-- 2) 매니저가 103인 직원의 정보(아이디, 이름, 부서, 매니저번호)를 조회하시오.
select employee_id, first_name, department_id, manager_id
from employees
where manager_id=103;

-- 3) 어느 부서에도 속하지 않은 직원의 정보 (이름, 전화번호, 부서)를 조회하시오
select first_name, phone_number, department_id
from  employees 
where department_id is null;

-- 4) 급여가 10000을 초과하면서 JOB_ID가 'SA_REP'인 사람의 이메일, 이름, 전화번호, JOB_ID 정보를 조회하시오
select email, first_name, phone_number, job_id
from employees
where salary>10000 and job_id like 'SA_REP';

-- 5) 부서가 60이거나 이름이 A로 시작하는 시작하는 직원의 정보(이름, 급여, 부서)를  조회하시오.
select first_name, salary, department_id
from employees
where department_id = 60 or first_name like 'A%';

-- 6) 부서가 10이거나 50이거나 60번 부서의 직원의 정보(이름, 급여, 부서)를 조회하시오
select first_name, salary, department_id
from employees
where department_id in (10,50,60);

-- 7) 이름이 3글자인 모든 사람의 정보를 조회하시오.
select *
from employees
where first_name like '___';

-- 8) 전체 직원들중 직급이 'CLERK' 들을 조회 (종류가 많음)
select * 
from employees
where job_id like '%CLERK%';

-- 9) 커미션(COMMISSION_PCT)을 받는 사람들의 이름과 이메일을 조회
select first_name, email
from employees
where commission_pct is not null;

-- 10) 이메일이 'KGEE'인 사람의 풀네임은?
select first_name || ' '|| last_name as full_name
from employees
where email like 'KGEE';

-- 11) SALARY(급여)가 10000달러 초과하면서, JOB_ID(직업번호)가 'SA_REP' 인 사람의 
--     EMAIL, LAST_NAME, PHONE_NUMBER를 EMPLOYEES 테이블에서 조회
select email, last_name, phone_number 
from employees
where salary>10000 and job_id like 'SA_REP';



-- 12) SALARY(급여)가 3000달러 미만이거나, 14000달러를 초과하는 직원의 EMPLOYEE_ID를 조회
select employee_id
from employees
where salary <3000 or salary > 14000;



-- 13) 모든 직원의 업무와 부서번호를 중복되는 값이 없도록 조회하시오.
select distinct job_id, department_id
from employees;

-- 14) 80번 부서에 속한 직원의 사원번호, 이름, 급여, 입사일을 조회하시오. 이때 입사일이 빠른순으로 정렬
select employee_id, first_name, salary, hire_date
from employees
where department_id = 80
order by hire_date;

-- 15) 전체 직원의 사원번호, 이름, 급여, 부서번호, 를 조회하시오.
--     이때 부서번호 오름차순, 같은 부서의 경우 급여의 내림차순으로 정렬하시오
select employee_id, first_name, salary, department_id
from employees
order by department_id asc, salary desc; 

-------------------------------------------------------------------------

--1. 모든 사원의 이름과, 전화번호 첫 3자리를 출력하시오.
select first_name, substr(phone_number,1,3) phone_number
from employees;

--2. 모든 사원의 이름과 성, 그리고 (이름과 성을 합한 글자수)를 출력하시오.
select first_name, last_name, length(first_name||last_name) as len
from employees;



--3. 모든 사원의 이름과 성의 머리글자만 출력하시오. (예. A.A)
select substr(first_name,1,1)||'.'||substr(last_name,1,1) as head
from employees;

--4. 모든 사원의 이름과 성을 대문자로 출력하시오.
select upper(first_name), upper(last_name)
from employees;


--5. 사원의 JOB_ID에 포함된 '_'문자의 위치를 구하고, JOB_ID 에서 그 위치 이전까지의 문자열을 사원번호와 함께 출력하시오.
--(INSTR, SUBSTR 함수 사용)
select employee_id, substr(job_id,1,instr(job_id,'_')-1) as job_id  
from employees;


--6. 사원 급여를 30으로 나눈 값을 소수점 둘째 자리에서 반올림하여 출력하시오.
select round(salary/30,2)
from employees;


--7. 사원 급여를 30으로 나눈 값을 소수점 아래를 버림 한 후 출력하시오.
select trunc(salary/30)
from employees;


--8. 2의 10승을 계산하여 출력하시오.
select power(2,10)
from dual;


--9. 모든 사원의 입사일과, 입사일 이후 100일째 되는 날을 다음과 같은 형식으로 출력하시오.
select employee_id as "사원번호", hire_date as 입사일, hire_date +100 as 백일후
from employees;

select employee_id as "사원번호", hire_date as 입사일, to_char(hire_date +100, 'YYYYMMDD')as 백일후
from employees;

--10. 입사일 이후 오늘까지의 날짜수를 다음과 같이 출력하시오. 최근 입사한 사원순으로 정렬.
select employee_id as 사원번호, hire_date as 입사일, trunc(sysdate-hire_date) as 근무일수 
from employees
order by hire_date desc;

--11. 입사일 이후 오늘까지의 개월수를 다음과 같이 출력하시오.
select employee_id as 사원번호, hire_date as 입사일, trunc(months_between(sysdate,hire_date)) as 근무개월수 
from employees;


--12. 입사일을 다음과 같은 형식으로 출력하시오.
select to_char(hire_date,'YYYY"년" MM"월" DD"일" DAY') as hire_date
from employees;

--13. 입사일이 3월인 모든 사원의 정보를 출력하시오.
select *
from employees
where to_char(hire_date,'MM') like '03';


--14. 입사한 달이 홀수인 모든 사원의 정보를 출력하시오.
select *
from employees
where mod(to_number(to_char(hire_date,'MM'),99),2) = 1
order by hire_date;


--15. 현재 시간을 다음과 같은 형식으로 출력하시오.
select to_char(sysdate,'YYYY-MM-DD HH:MI:SS') from dual;

--16. 급여를 다음과 같은 형식으로 출력하시오.
select employee_id, to_char(salary,'$999,999') from employees;


--17. 입사일 컬럼의 값이 NULL인 경우 오늘 날짜로 치환하여 출력
select nvl(hire_date, sysdate) as hire_date
from employees;



--------------------------------------------------------------------------------

-- 1. JOIN을 이용하여 사원ID가 100번인 사원의 부서번호와 부서이름을 출력하시오
select employee_id,department_id ,department_name
from employees e join departments d using(department_id)
where e.employee_id=100;

-- 2. INNER JOIN을 이용하여 사원이름과 함께 그 사원이 소속된 도시이름과 지역명을 출력하시오
select first_name, city, region_name
from employees inner join departments using(department_id) 
                inner join locations using (location_id) 
                inner join countries using(country_id) 
                inner join regions using(region_id);

-- 3. INNER JOIN과 USING 연산자를 사용하여 100번 부서에 속하는 
--    직원명과 직원의 담당 업무명, 속한 부서의 도시명을 출력하시오.
--    (100번 부서에는 직원 6명있음)
select first_name, job_title, city
from employees e join departments using(department_id)
                 join jobs using(job_id)
                 join locations using (location_id)
where department_id = 100;
    
-- 4. JOIN을 사용하여 커미션을 받는 모든 사원의 이름, 부서ID, 도시명을 출력하시오
select first_name, department_id, city
from employees inner join departments using(department_id) 
                inner join locations using (location_id) 
where commission_pct is  not null;

select e.first_name, d.department_id, l.city
from employees e, departments d, locations l
where commission_pct is not null 
      and e.department_id = d.department_id(+)
      and d.location_id = l.location_id(+); -- department_id가 null값인 사람도 나옴

select first_name, department_id, city
from employees left outer join departments using(department_id) 
               left outer join locations using(location_id)
where commission_pct is not null;
    
--null값이 나오게 하려면 outer join!! 자식이 있는 방향으로 left/right 설정, 오라클 문법은  부모의 pk에 (+)붙임 
    
-- 5. INNER JOIN과 와일드카드를 사용하여 이름에 A가 포함된 모든 사원의 이름과 부서명을 출력하시오(단, 대소문자 구분 없음)
select first_name, department_name
from employees e join departments d using (department_id)
where upper(first_name) like '%A%';



-- 6. JOIN을 사용하여 Seattle에 근무하는 모든 사원의 이름, 업무, 부서번호 및  부서명을 출력하시오
select first_name, job_title, department_id, department_name
from employees inner join departments using(department_id) 
                inner join locations using (location_id) 
                inner join jobs using (job_id)
where city like 'Seattle';

-- 7. SELF 조인을 사용하여 사원의 이름 및 사원번호와 매니저 이름 및 매니저 번호와  함께 조회하시오. (이미 풀었던 문제임)
select e2.employee_id,e2.first_name as 직원명,e2.manager_id, e1.first_name as 매니저명 
from employees e1 join employees e2 
on e2.manager_id = e1.employee_id;


-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 조회
SELECT e2.employee_id, e2.first_name as 직원명, e2.job_id, e2.department_id,e2.manager_id, e1.first_name as 매니저명
from employees e1 right outer join employees e2
on e2.manager_id = e1.employee_id
order by e2.employee_id desc;


-- 9. SELF JOIN을 사용하여 'Oliver' 사원의 부서명, 그 사원과 동일한 부서에서 근무하는  동료 사원의 이름을 조회. 
--     단, 각 열의 별칭은 부서명, 동료로 할 것.
select department_name as 부사명, first_name as 동료
from (select *
      from employees
      where department_id = (select department_id
                             from employees
                             where first_name like 'Oliver')) join departments using (department_id);
                    
select d.department_name as 부사명, tmp.first_name as 동료
from (select first_name, department_id
      from employees
      where department_id = (select department_id
                             from employees
                             where first_name like 'Oliver'))tmp join departments d using (department_id);
                    



-- 10. SELF JOIN을 사용하여 관리자보다 먼저 입사한 모든 사원의 이름 및 입사일을 매니저 이름 및 입사일과 함께 출력하시오
select e2.first_name, e2.hire_date, e1.first_name as 매니저이름, e1.hire_date
from employees e1 join employees e2
on e2.manager_id = e1.employee_id
where e2.hire_date < e1.hire_date
order by 2;


select e1.first_name, e1.hire_date, e2.first_name as 매니저이름, e2.hire_date
from employees e1 join employees e2
on e1.manager_id = e2.employee_id
where e1.hire_date < e2.hire_date
order by 2;


-- 11. Last name이 ‘King’을 Manager로 둔 사원의 이름과 급여를 조회하시오.
select e2.first_name, e2.salary
from employees e1 join employees e2
on e2.manager_id = e1.employee_id
where e1.last_name = 'King'
order by 2;

select e1.first_name, e1.salary
from employees e1 join employees e2
on e1.manager_id = e2.employee_id
where e2.last_name = 'King'
order by 2;

-- 12. Finance부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시하시오
select department_id, first_name, job_title
from employees e join departments d using(department_id)
                 join jobs using(job_id)
where department_name like 'Finance';

    
-- 13. 평균 급여보다 많은 급여를 받고 이름에 'M'이 포함된 사원과 같은 부서에서 
--     근무하는 사원의 사원번호, 이름, 급여를 조회하시오
select employee_id, first_name, salary
from (select *
      from employees 
      where salary > (select avg(salary) from employees))
where department_id in (select distinct department_id
                       from employees
                       where first_name like '%M%');
               
select employee_id, first_name, salary
from employees 
where salary >(select avg(salary) from employees) and department_id in (select distinct department_id
                                                                        from employees
                                                                        where first_name like '%M%');
        
                       