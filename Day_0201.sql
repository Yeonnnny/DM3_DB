/* 2월 1일 */
-- SELECT로 질의된 결과를 하나의 집합으로 인식해서 집합연산을 하는 것
-- 둘 이상의 데이터를 가지고 집합의 개념으로 처리
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- ** 교집합(intersection)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)

INTERSECT 

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

-- ** 차집합(minus)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)

MINUS 

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

-- ** 차집합(minus) 위의 집합의 순서를 바ㅜ꺼서!
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

MINUS

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158);

-- ** 합집합 (union) : 중복된 데이터는 1개만 출력됨
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158);

-- ** 합집합 (union) : 중복된 데이터도 무조건 다 조회되도록!
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-- ** 집합에서 오류가 난 경우 
-- 1) 컬럼의 개수가 다르면 다른 집합으로 인지되므로 오류임
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-- 2) 컬럼의 개수가 같아도 같은 위치의 컬럼 타입이 다르면 오류임
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-- 3) 실행오류가 아니라 논리적인 오류 (타입과 개수는 맞췄지만 컬럼이 다른 경우)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-------------------------------------------------
/* 함수(FUNCTION)
- 질의문과 함께 사용하여 결과를 강력하게 처리할 수 있는 기능
-  함수의 종류
    1) 단일행 함수: 각각의 레코드에 기능을 적용시키는 함수
    테이블안에 데이터가 10개가 있으면 레코드 각각에 함수를 적용하는 것으로 전체레코드와 개수가 일치함 
    2) 그룹행 함수: 특정 조건에 맞게 레코드를 묶어서 기능을 적용시키는 함수 
    전체 데이터에서 특정 조건에 맞춰 그룹화를 시키고 해당 그룹에 적용하는 것으로 전체레코드와 개수가 일치하지 않음
*/
/*
*** 1) 단일행 함수
1) 문자열을 처리하는 함수
- lower(문자열 | 문자열이 들어있는 컬럼명): 영문자를 소문자로 변경 ( 원본이 변경되지 않음)
- upper(문자열 | 문자열이 들어있는 컬럼명): 영문자를 대문자로 변경 (원본이 변경되지 않음)
- initcat(문자열 | 문자열이 들어있는 컬럼명): 영문자를 첫글짜만 대문자, 나머지는 소문자로 변경
- concat(문자열1, 문자열2): 문자열을 결합 (= 연산자 ||)
- substr(문자열, 위치1, 개수): 문자열에서 지정된 위치1(포함)~ 개수 사이의 문자열을 반환, INDEX가 1부터 시작
- length(문자열): 문자열의 길이 반환
- instr(문자열, 부문문자열) : 문자열에서 부분 문자열의 위치를 반환
- replace(문자열, 찾는문자열, 바꿀문자열): 문자열 치환
*/

-- 이름을 소문자로 조회
SELECT LOWER(FIRST_NAME)
FROM EMPLOYEES;

-- 이름을 소문자, 대문자로 조회
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES;

-- 이름을 소문자, 대문자로 조회
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES;

-- 더미테이블('DUAL')을 이용하여 'ASIAN CUP 2024'를 모두 소문자로 변경
SELECT LOWER('ASIAN CUP 2024')
FROM DUAL;

-- 더미테이블('DUAL')을 이용하여 'ASIAN CUP 2024'를 소문자로 변경하고 첫글자만 대문자로 변경
SELECT LOWER('ASIAN CUP 2024'), INITCAP('ASIAN CUP 2024')
FROM DUAL;

-- SUBSTR(문자열, 위치): INDEX가 1부터 시작
SELECT UPPER(SUBSTR('The Soap', 5));

--SUBSTR(문자열, 위치, 개수):
SELECT UPPER(SUBSTR('The Soap', 5, 2)) AS RESULT
FROM DUAL;

--LENGTH(문자열):길이 반환
SELECT LENGTH('The Soap')
FROM DUAL;

-- INSTR(문자열, 부분문자열): 위치값 찾기
SELECT INSTR('The Soap','o')
FROM DUAL;

-- INSTR(문자열, 부분문자열): 위치값 찾기
SELECT INSTR('오라클 마스터','터')
FROM DUAL;

-- INSTR(문자열, 부분문자열): 위치값 찾기 (찾지 못할 경우 0 반환)
SELECT INSTR('오라클 마스터','우')
FROM DUAL;

-- ***다른 문장과 함께 사용
-- 참고
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;

-- 함수를 WHERE절에서 사용하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -1,1) = 'n'; 

-- 함수를 WHERE절에서 사용하기
-- 이름의 끝에서 2번째 2개가 'en'으로 끝나는 지구언의 사원번호와 이름
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -2,2) = 'en'; 

-- CONCAT(문자열1, 문자열2): 두 개의 문자열을 합치는 함수 ( ||와 동일)
SELECT CONCAT('I have a','dream')
FROM DUAL;

-- CONCAT()을 테이블에 적용
SELECT 
    CONCAT(EMPLOYEE_ID, FIRST_NAME),
    CONCAT(EMPLOYEE_ID, CONCAT(': ', FIRST_NAME))
FROM EMPLOYEES;

-- REPLACE(문자열, 찾을 문자열, 바꿀 문자열)
-- HIRE_DATE에서 구분기호를 '/' -> '-'로 변경
SELECT FIRST_NAME, REPLACE(HIRE_DATE, '/', '-')
FROM EMPLOYEES;

-- 이름, 전화번호를 조회하되, 전화번호의 '.'을 ' ' 으로 치환하시오
SELECT FIRST_NAME,PHONE_NUMBER, REPLACE(PHONE_NUMBER, '.', ' ')
FROM EMPLOYEES;

/*
2) 숫자와 관련된 함수
- abs(숫자): 특정 숫자의 절대값 구하는 함수
- ceil(숫자): 올림, 가장 가까운 양의 방향의 정수를 반환 (ex -2.5일 경우 -2로 올림) 
- floorceil(숫자): 버림, 가장 가까운 음의 방향의 정수를 반환 (ex -2.5일 경우 -1로 반환)
- round(숫자, 자릿수): 지정한 위치에서 반올림(방향과 무관)
- trunc(숫자, 자릿수): 지정한 위치에서 절삭
- mod(값1, 값2): 첫 번째 숫자를 두 번째 숫자로 나눴을 때 나머지
- power(값1, 값2): 첫 번째 숫자를 두 번째 숫자만큼 곱한 값 (ex (2,4) 일 경우 2의 4승)
- sign(숫자): 숫자가 음수면 -1, 0이면 0, 양수면 1을 반환
*/

-- ABS()
SELECT ABS(15.6), ABS(-15.6) FROM DUAL;

-- CEIL()
SELECT CEIL(15.3),CEIL(-15.3) FROM DUAL;

-- FLOOR()
SELECT FLOOR(15.3),FLOOR(-15.3) FROM DUAL;

-- ROUND(M, N)
SELECT ROUND(15.195, 0),ROUND(15.195, 1), 
       ROUND(15.195, 2), ROUND(15.195, -1) FROM DUAL;
       
SELECT ROUND(-15.195, 0),ROUND(-15.195, 1), 
       ROUND(-15.195, 2), ROUND(-15.195, -1) FROM DUAL;

-- TRUNC(M, N)
SELECT TRUNC(15.195, 0),TRUNC(15.195, 1), 
       TRUNC(15.195, 2), TRUNC(15.195, -1) FROM DUAL;
       
SELECT TRUNC(-15.195, 0),TRUNC(-15.195, 1), 
       TRUNC(-15.195, 2), TRUNC(-15.195, -1) FROM DUAL;
       
-- MOD, POWER, SIGN
SELECT MOD(10, 3),POWER(10, 3), 
       SIGN(10), SIGN(-10) FROM DUAL;

/*날짜 함수
- 날짜 관련 시스템 값: SYSDATE(시스템 현재 날짜, SYSTIMESTAMP(시스템 현재 날짜와 시간)
- 날짜 타입은 기본 사술 연산자를 이용한 연산이 가능(일 단위) : + -

- add_months(날짜, 정수값): 지정날짜에 정수달을 더했을 때 변경되는 날짜를 반환
- months_between(날짜1, 날짜2): 두 날짜 사이에 몇 개월의 차이가 있는지 반환
- last_day(날짜): 지정 날짜의 마지막 날이 몇일인지를 반환
- next_day(날짜, '요일;): 날짜를 기준으로 그 다음 요일이 몇일인지 반환 
*/

-- SYSDATE
SELECT SYSDATE FROM DUAL;

-- SYSTIMESTAMP
SELECT SYSDATE,SYSTIMESTAMP  FROM DUAL;

-- SYSDATE: 일단위 
SELECT SYSDATE + 1 AS "내일", SYSDATE + 1 AS "어제"  FROM DUAL;

-- ADD_MONTHS (날짜, 정수값): 월단위
SELECT ADD_MONTHS(SYSDATE, 10) AS '10개월 후', ADD_MONTHS(SYSDATE, -10) AS '10개월 전' FROM DUAL;

-- TO_DATE
SELECT CEIL(SYSDATE - TO_DATE('23/01/02')) FROM DUAL;


-- MONTHS_BETWEEN


-- LAST_DAY
-- 이번달의 마지막 날을 구하는 것 
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- LAST_DAY
-- 태어난 해 그 달의 마지막 날을 구하는 것 
SELECT LAST_DAY(TO_DATE('95/0
2/17')) FROM DUAL;

-- NEXT_DAY

-- [문제1] 입사한 달의 근무일수를 계산하고, 이름, 부서번호, 근무일수를 각각 출력
SELECT FIRST_NAME, DEPARTMENT_ID ,(last_day(HIRE_DATE) - HIRE_DATE)+1 AS WORKING_DAY
FROM EMPLOYEES
order by 3 desc;

SELECT FIRST_NAME, DEPARTMENT_ID ,ceil(last_day(HIRE_DATE) - HIRE_DATE) AS WORKING_DAY
FROM EMPLOYEES
order by 3 desc;


-- [문제2] 80번 부서에서 근무하는 직원들의 시간당 임금을 계산하시오 (시간당 임금 내림차순으로 )
-- SALARY를 월급 ==> 소수점 이하 2자리 절삭
-- 주 5일근무, 하루 8시간, 4주
SELECT FIRST_NAME, SALARY, TRUNC(SALARY/(5*4*8),2) AS 시간당임금
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
order by 3 desc;


-- [문제3] JOB_HISTORY 테이블의 정보를 이용해 102번 직원이 특정 부서에서 몇개월을 근무했는지 계산하시오.
SELECT employee_id, ceil((end_date-start_date)/30) as 근무개월수, department_id
FROM JOB_HISTORY
where employee_id = 102
ORDER BY EMPLOYEE_ID;


-- 도연
select ceil(sysdate-to_date('2001/08/28')) as period
from dual;

-- 지현
select ceil(sysdate-to_date('1997/07/10')) as period
from dual;

--[문제4] 현재부터 수료일(2024-05-08)까지 남은 날
select (to_date('24/05/08')-sysdate)+1 as period
from dual;

-- ** 변환함수
/*
- to_char (날짜, 포맷) : 날짜를 특정 포맷에 맞춰 문자열로 변환
- to_number(문자열) : 숫자형태로 된 문자열을 숫자 타입으로 변환
- to_numbrer(문자열) : 숫자형태로 된 문자열을 숫자타입으로 변환
*/
select '123.5', to_number('123.5')
from dual;

--to_char를 이용한 날짜 포맷
select sysdate, to_char(sysdate,'YYYY-MM-DD'),
to_char(sysdate,'YYYY-MM-DD HH:MI')as 현재시간1,
to_char(sysdate,'YYYY-Mon-DD HH:MI') as 현재시간2,
to_char(sysdate,'YYYY-Mon-DDD HH:MI') as 현재시간3
from dual;


--to_char를 이용한 숫자 포맷
select 
    to_char(1234560.34,'9,999,999.99'), to_char(1234560.34,'$9,999,999.99'),to_char(1234560.34,'l9,999,999.99'), to_char(1234560.34,'9,999,999.99')
from dual;

--[문제] 이름, 급여, 입사일 출력
select first_name, to_char(salary,'$999,999,999.999') as salary, to_char(hire_date,'YYYY-MM-DD(DY)')
from employees;

/* null 관련 함수
- nvl(컬럼, 데이터) : 특정 컬럼의 데이터가 null이면 null대신 데이터 값으로 출력
- nvl2(컬럼, 데이터1, 데이터2) : 특정 컬럼의 데이터가 null이면 데이터2, null이 아니면 데이터1로 출력
*/

select first_name, nvl(commission_pct,0)
from employees;

select first_name,salary,commission_pct,nvl2(commission_pct,commission_pct*salary,0) as 커미션 
from employees;



--[문제] 이름, 부서번호 출력 부서번호 없으면0
select first_name, nvl(department_id,0)
from employees
order by first_name;

--[문제] 이름, 부서번호 출력 부서번호 없으면 '임시'
select first_name, nvl(to_char(department_id),'임시')
from employees;

--[문제] 사원번호, 이름, 팀장 번호, 
select employee_id, first_name, nvl(to_char(manager_id),'회장')
from employees;


------------------------

/*
기타함수
1) decode
 : 다른 언어의 if문과 유사한 개념의 **함수**
decode(exp1, cond1,result1,
            cond2, result2,
            cond3, result3,
            default)


2)case문
case exp1
    when cond1 then result1
    when cond2 then result2
    when cond3 then result3
    else result4
end

*/

select first_name,
        department_id, 
        decode(department_id,
                10,'Administration',
                20, 'Marketing',
                30, 'Purchasing',
                40, 'Human Resources',
                50, 'Shipping',
                'ETC') as department_name
from employees
where department_id in(10,20,30,40,50) -- == where department_id between 10 and 50
order by department_id; 

-- case 변경

select first_name,
        department_id, 
        case department_id
                when 10 then 'Administration'
                when 20 then 'Marketing'
                when 30 then 'Purchasing'
                when 40 then 'Human Resources'
                when 50 then 'Shipping'  
        end as department_name
from employees
where department_id in(10,20,30,40,50) -- == where department_id between 10 and 50
order by department_id; 


select first_name,
        department_id, 
        case    when department_id=10 then 'Administration'
                when department_id=20 then 'Marketing'
                when department_id=30 then 'Purchasing'
                when department_id=40 then 'Human Resources'
                when department_id=50 then 'Shipping'  
                else 'ETC'
        end as department_name
from employees
where department_id in(10,20,30,40,50) -- where department_id between 10 and 50
order by department_id; 

select to_number('1,300',9999)
from dual;


/* ************************
그룹핑 함수
- sum(컬럼명) : null값 제외
- count(컬럼명) : null값 제외
- min/max(컬럼명)
- avg(컬럼명)
***************************/


--sum
select sum(salary) -- null값 제외
from employees;

--count
select count(employee_id)
from employees;

select count(*)
from employees;

select count(commission_pct) -- null값 제외함
from employees; 

select count(commission_pct), sum(commission_pct)
from employees;


--min/max
select min(salary), max(salary)
from employees;

--부서별 최대, 최소 급여 조회
select department_id, min(salary), max(salary)
from employees
group by department_id;


--부서별 최대, 최소 급여와 manager_id 조회
-- 그룹핑과 관련없는 일반컬럼이 select절에 있으면 오류
select department_id, manager_id ,min(salary), max(salary) 
from employees
group by department_id,manager_id  -- 일반컬럼도 같이 쓰고 싶으로 group by에 같이 씀
order by department_id;

-- grouping 정보의 출력에 조건을 걸고 싶으면 having절 사용


--80번 부서의 최대, 최소 급여 조회
select department_id, min(salary), max(salary)
from employees
group by department_id
having department_id like 80;


--avg
--job_id별 급여 평균
select job_id, round(avg(salary),2)
from employees
group by job_id
order by 2 ;


--job_id별 급여 평균 (단, 급여 평균이 5000이상)
select job_id, avg(salary)
from employees
group by job_id
having avg(salary)>=5000
order by 2 ;


select department_id, count(*)
from employees
group by department_id
having department_id is not null
order by 1 ;


--[문제] 부서의 인원수가 없거나 1명인 부서, 부서가 null인 것도 제외
select department_id, count(*)
from employees
group by department_id
having department_id is not null and count(*)>1
order by 1;

--[문제] 입사년도별 그룹핑
select to_char(hire_date,'YYYY')as "입사 년도", count(*) as "인원"
from employees
group by to_char(hire_date,'YYYY')
order by 1;


--[문제] 입사년도 인원이 가장 적은 해의 정보 구하시오
select min(인원) from
(
    select to_char(hire_date,'YYYY')as 입사년도, count(*) as 인원
    from employees
    group by to_char(hire_date,'YYYY')
    order by 1
)temp;


select 입사년도, min(인원) from
(
    select to_char(hire_date,'YYYY')as 입사년도, count(*) as 인원
    from employees
    group by to_char(hire_date,'YYYY')
    order by 1
)temp
group by 입사년도
having min(인원)=1;

/*연습문제*/

--1. 80번부서의 급여 평균, 최고, 최저, 인원 수
select avg(salary), max(salary),min(salary), count(*)
from employees
group by department_id
having department_id=80;


--2. 각 부서의 급여 평균, 최고, 최저, 인원 수
select department_id, round(avg(salary),2), max(salary),min(salary), count(*)
from employees
group by department_id;

--3. 각 부서의 급여 평균, 전체, 최저 월급을 구하여 평균 월급이 많은 순으로 조회, 단 부서번호가 null이면 출력하지 않음
select department_id, round(avg(salary),2), sum(salary),min(salary)
from employees
group by department_id
having department_id is not null
order by 2 desc;

-- 4. 각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서 번호, 업무명, 인원수 출력
select department_id as 부서, job_id as 업무, count(*) as 인원
from employees
group by department_id, job_id
having department_id is not null
order by department_id;


-- 5. 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수 출력
select job_id as 업무, count(*) as 인원
from employees
group by job_id
having count(*)>=4;













