--1. 모든 사원의 이름과, 전화번호 첫 3자리를 출력하시오.
select first_name, substr(phone_number,1,3)as phone
from employees;

--2. 모든 사원의 이름과 성, 그리고 (이름과 성을 합한 글자수)를 출력하시오.
select first_name, last_name, length(first_name||last_name) as num
from employees;

--3. 모든 사원의 이름과 성의 머리글자만 출력하시오. (예. A.A)
select concat(substr(first_name,1,1),concat('.',substr(last_name,1,1))) as fisrt_str
from employees;

--4. 모든 사원의 이름과 성을 대문자로 출력하시오.
select upper(first_name), upper(last_name)
from employees;

--5. 사원의 JOB_ID에 포함된 '_'문자의 위치를 구하고, JOB_ID 에서 그 위치 이전까지의 문자열을 사원번호와 함께 출력하시오.
--(INSTR, SUBSTR 함수 사용)
select employee_id, substr(job_id,1, instr(job_id,'_')-1) as idx
from employees;


--6. 사원 급여를 30으로 나눈 값을 소수점 둘째 자리에서 반올림하여 출력하시오.
select round(salary/30,1)
from employees;


--7. 사원 급여를 30으로 나눈 값을 소수점 아래를 버림 한 후 출력하시오.
select trunc(salary/30)
from employees;

--8. 2의 10승을 계산하여 출력하시오.
select power(2,10)
from dual;


-- 9. 모든 사원의 입사일과, 입사일 이후 100일째 되는 날을 다음과 같은 형식으로 출력하시오.
select employee_id as 사원번호,hire_date as 입사일, to_char(hire_date+100,'YYYYMMDD') as 백일후
from employees;


--10. 입사일 이후 오늘까지의 날짜수를 다음과 같이 출력하시오. 최근 입사한 사원순으로 정렬.
select employee_id as 사원번호, hire_date as 입사일, ceil(sysdate-hire_date) as 근무일수
from employees
order by hire_date;


--11. 입사일 이후 오늘까지의 개월수를 다음과 같이 출력하시오.
select employee_id as 사원번호, hire_date as 입사일, ceil((sysdate-hire_date)/30) as 근무개월수
from employees;
select employee_id as 사원번호, hire_date as 입사일, trunc(months_between(sysdate,hire_date)) as 근무개월수
from employees;

--12. 입사일을 다음과 같은 형식으로 출력하시오.
SELECT to_char(hire_date,'YYYY')||'년 '||to_char(hire_date,'Mon')||to_char(hire_date,'DD')||'일 '||to_char(hire_date,'DAY') as hire_date
from employees;

SELECT to_char(hire_date,'YYYY"년" MM"월" DD"일" DAY') as hire_date
from employees;

--13. 입사일이 3월인 모든 사원의 정보를 출력하시오.
select *
from employees
where to_char(hire_date,'MM') like '03';


--14. 입사한 달이 홀수인 모든 사원의 정보를 출력하시오.
select *
from employees
where to_char(hire_date,'MM') in ('01','03','05','07','09','11')
order by to_char(hire_date,'MM');

select *
from employees
where mod(to_number(to_char(hire_date,'MM'),99),2) =1
order by to_char(hire_date,'MM');

--15. 현재 시간을 다음과 같은 형식으로 출력하시오.
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS')
from dual;

--16. 급여를 다음과 같은 형식으로 출력하시오.
select employee_id, to_char(salary, '$999,999,999') as salary
from employees;

--17. 입사일 컬럼의 값이 NULL인 경우 오늘 날짜로 치환하여 출력하시오.
select employee_id, nvl(hire_date,sysdate)
from employees;


