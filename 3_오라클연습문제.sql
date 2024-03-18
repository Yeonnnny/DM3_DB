/* [연습문제] */
-- 1. JOIN을 이용하여 사원ID가 100번인 사원의 부서번호와 부서이름을 출력하시오
select department_id, department_name
from employees e join departments d using(department_id)
where employee_id = 100;

-- 2. INNER JOIN을 이용하여 사원이름과 함께 그 사원이 소속된 도시이름과 지역명을 출력하시오
select e.first_name, l.city, r.region_name
from employees e 
    join departments d using(department_id) 
    join locations l using (location_id)
    join countries c using(country_id) 
    join regions r using(region_id);

-- 3. INNER JOIN과 USING 연산자를 사용하여 100번 부서에 속하는 
--    직원명과 직원의 담당 업무명, 속한 부서의 도시명을 출력하시오.
--    (100번 부서에는 직원 6명있음)

select e.first_name, d.department_name, l.city
from employees e
    join departments d using(department_id)
    join locations l using(location_id)
where department_id=100;

    
-- 4. JOIN을 사용하여 커미션을 받는 모든 사원의 이름, 부서ID, 도시명을 출력하시오

select first_name, department_id, city
from employees 
    join departments using (department_id)
    join locations using(location_id)
where commission_pct is not null;

    
-- 5. INNER JOIN과 와일드카드를 사용하여 이름에 A가 포함된 모든 사원의 이름과 부서명을 출력하시오(단, 대소문자 구분 없음)
select first_name, department_name
from employees join departments using(department_id)
where upper(first_name) like '%A%' ;

-- 6. JOIN을 사용하여 Seattle에 근무하는 모든 사원의 이름, 업무, 부서번호 및  부서명을 출력하시오
select first_name, job_id, department_id, department_name
from employees 
    join departments using(department_id)
    join locations using(location_id)
where city like 'Seattle';

-- 7. SELF 조인을 사용하여 사원의 이름 및 사원번호와 매니저 이름 및 매니저 번호와  함께 조회하시오. (이미 풀었던 문제임)
select  e1.employee_id,e1.first_name, e1.manager_id, e2.first_name
from employees e1 join employees e2
on e1.manager_id = e2.employee_id
order by 1;

select  e2.employee_id,e2.first_name, e2.manager_id, e1.first_name
from employees e1 join employees e2
on e2.manager_id = e1.employee_id;

-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 조회
select e1.employee_id, e1.first_name, e1.manager_id, e2.first_name
from employees e1, employees e2
where e2.manager_id = e1.employee_id
order by 1 desc;


-- 9. SELF JOIN을 사용하여 'Oliver' 사원의 부서명, 그 사원과 동일한 부서에서 근무하는 동료 사원의 이름을 조회. 
--     단, 각 열의 별칭은 부서명, 동료로 할 것.
select tmp2.first_name, tmp2.department_name, tmp1.first_name
from (select * from employees e join departments d using(department_id))tmp1 join (select * from employees e join departments d using(department_id))tmp2
on tmp2.department_name = tmp1.department_name
where tmp2.first_name like 'Oliver';


-- 10. SELF JOIN을 사용하여 관리자보다 먼저 입사한 모든 사원의 이름 및 입사일을 매니저 이름 및 입사일과 함께 출력하시오
select e2.first_name, e2.hire_date, e1.first_name, e1.hire_date
from employees e1 join employees e2
on e2.manager_id =  e1.employee_id
where e2.hire_date<e1.hire_date; 


-- 11. Last name이 ‘King’을 Manager로 둔 사원의 이름과 급여를 조회하시오.
select e2.first_name, e2.salary
from employees e1, employees e2
where e2.manager_id = e1.employee_id and e1.last_name like 'King';

-- 12. Finance부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시하시오
select department_id, first_name, job_id
from employees join departments using(department_id)
where department_name like 'Finance';
    
-- 13. 평균 급여보다 많은 급여를 받고 이름에 'M'이 포함된 사원과 같은 부서에서 
--     근무하는 사원의 사원번호, 이름, 급여를 조회하시오 
select employee_id, first_name, salary
from employees 
where salary >(select avg(salary) from employees) and department_id in (select distinct department_id
                                                                            from employees
                                                                            where upper(first_name)like '%M%' and department_id is not null);


select distinct e1.employee_id, e1.first_name, e1.salary
from employees e1 join employees e2 using(department_id)
where upper(e2.first_name) like '%M%' and e1.salary >(select avg(salary) from employees) ;



