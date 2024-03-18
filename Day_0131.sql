--2024년 1월 31일 (수)
/*여러줄주석
주
우
석
*/

/* 
- 데이터베이스(Database)
  데이터 : 현실세계에서 단순히 관찰 또는 측정을 통해서 수집된 사실이나 값
  정보(Information) : 상황에 따른 적절한 의사 결정을 할 수 있게 하는 지식
         데이터의 유효한 해석이나 데이터 상호 간의 관계를 말하는 것
         데이터를 처리해서 얻어진 결과

- 데이터베이스 관리 시스템(RDBMS) - NoSQL(Not Only SQL) : JSON 파일로 저장됨
  방대한 양의 데이터를 편리하게 관리하고, 효율적으로 저장하고 검색할 수 있는
  환경을 제공해주는 소프트웨어
  

*** SQL (Structured Query Language)
- DB에 접근해서 처리하는 명령어들
- 국제 표준
- 명령어의 종류

 1) DDL (Database Definition Language): 객체를 다루는 명령
	create(생성), alter(변경), drop(삭제)

 2) DML (Database Manipulation Language): 테이블의 레코드를 다루는 명령
	insert(삽입), update(수정), delete(삭제), select(조회) (select는 커밋할 필요 업음)

 3) DCL (Database Control Language): 유저의 권한을 다루는 명령
	grant(부여), revoke(권한 회수)

 4) TCL (Transaction Control Language): 트랜잭션을 다루는 명령
 	commit(저장), rollback(되돌림), savepoint(되돌릴 위치)

- SQL 명령 ==> ;으로 끝나야 함


*** 제약조건(constraint)
1) Primary key (주키) - 테이블 내의 각 레코드를 구별하기 우한 유일한 값
2) Foreign Key (외래키) - 관계 설정을 위해 필요 (참조 무결성)
   delete cascade // 부모를 삭제하면 자식의 모든 참조 레코드가 사라지도록 함
3) Unique   - 유일한 값을 갖도록 (주민번호, 폰번호)
4) Not Null - 빈 값이면 안되는 것(이름)
5) Check    - 데이터의 값을 한정시키는 용도 (부동산, 성별, 학년)

	default  - 데이터가 없을 때 삽입되는 기본값

*** 오라클에서 다루는 객체의 종류
1) 테이블 (Table)
2) 유저 (User)
3) 뷰(View) 
4) 인덱스(Index)
5) 시퀀스(Sequence)
6) 시노님(Synonym)


*** select
- SELECT 문법

  SELECT [ALL | DISTINCT] 컬럼명,... 
  FROM 테이블명
  WHERE 조건절
  ORDER BY 컬럼명 [ASC | DESC] ;   			-- (정렬) 무조건 문장의 끝에 있어야 함
  
*/

select * from countries;
select * from regions;
select * from departments;
select * from employees;

-- 이름과 급여 정보 조회
select first_name, salary from employees;

-- 부서번호 조회
select distinct department_id, count(*) as count
from employees 
group by department_id
order by department_id desc; --내림차순


-- 이름, 급여, 부서 번호, 이름 순 오름차순 조회
select first_name, salary, department_id
from employees
order by 1;

-- 이름, 급여, 부서 번호, 이름 순 오름차순 조회 (별칭 : as 키워드)
select first_name as 이름, salary as 급여, department_id as "부서 번호"
from employees
order by first_name;


-- 직원의 월급의 5%를 보너스로 지급하고자 함
-- 직원의 사원번호, 이름, 급여, 보너스, 합계
-- 조회가 되어 출력되는 것도 다른 종류의 테이블임
-- 문자열은 작은 따옴표
select employee_id , first_name||'님' as name, salary, salary*0.05 as bonus, salary+(salary*0.05) as total
from employees;

--이름에 님 붙여 출력
select first_name||'님' as name
from employees;


--이름과 성울 붙여 이름순으로 조회
select first_name||' '||last_name||'님' as name
from employees
order by 1; -- select문의 컬럼의 순서를 기준으로 정렬하라는 뜻


-- 급여가 10000이상인 직원들의 사원번호, 이름 급여, 직급 조회

select employee_id,first_name,salary, job_id
from employees
where salary>=10000
order by salary desc;


-- 
select employee_id,first_name,salary,department_id
from employees
where department_id=80
order by salary desc;


-- 
select employee_id,first_name,salary,department_id
from employees
where salary BETWEEN 5000 and 10000
order by salary desc;


select employee_id,first_name,salary,department_id
from employees
where salary >=5000 and salary<=10000
order by salary desc;



-- 
select employee_id, first_name, salary, department_id
from employees
where department_id=10 or department_id=50
order by salary desc;


-- 
select first_name,department_id
from employees
where not department_id in(10,50)--(department_id=10 or department_id=50)
order by department_id;


-- commssion 값이 null이 아닌 사람 조회
select first_name, salary, commission_pct
from employees
where commission_pct is not null; -- 컬럼명 is null/ is not null



-- manager x
select first_name, job_id
from employees
where manager_id is null;


-- 커미션 금액 있는 사람만 이름, 급여, 커미션금액, 총수령액 조회 
select first_name as 이름, salary as 급여, commission_pct*salary as 커미션금액, salary+(commission_pct*salary) as 총수령액
from employees
where commission_pct is not null
order by 4 desc;


-- between a and b 연산자
-- 급여가 5000이상 10000이하인
select employee_id,first_name,salary,department_id
from employees
where salary BETWEEN 5000 and 10000
order by salary desc;

-- in (a,b) 연산자
-- 부서번호가 10이거나 50이 아닌 
select first_name,department_id
from employees
where department_id not in(10,50)
order by department_id;

select first_name,department_id
from employees
where not(department_id = 10 or department_id =50)
order by department_id;


-- in, btween 사용 불가능한 경우
select first_name, phone_number, email
from employees
where salary>7000 and email='SKING';



-- 날짜 데이터 : 직접 입력할 때는 작은 따옴표, 연산 시 비교 연산도 가능
select first_name, hire_date 
from employees
order by 2; 

-- 입사년도가 07년도인 직원 조회
select first_name, hire_date 
from employees
where hire_date between '070101' and '071231'
order by 2; 

select first_name, hire_date 
from employees
where hire_date like '07%'
order by 2; 

-- 입사년도가 07년도 이전에 입사한 사람 조회
select first_name, hire_date 
from employees
where hire_date < '070101'
order by 2; 


-- 날짜 데이터의 산술연산
-- 보통 날짜 데이터는 산술연산하지 않음. 날짜 데이터 함수가 존재함
select first_name, hire_date, hire_date+1
from employees
order by 2; 


-- like 연산자
-- 이름이 J로 시작하는 직원 조회
select first_name
from employees
where first_name like 'J%';

-- 이름이 n로 끝나고 이름이 총 5글자인 직원 조회
select first_name
from employees
where first_name like '____n';



-- 와일드카드 날짜 적용
-- *** like와 날짜
-- 07년도에 입사한 직원의 이름과 입사일 조회
select first_name, hire_date
from employees
where hire_date like '07%'
order by hire_date;

-- 01월에 입사한 직원의 이름과 입사일 조회
select first_name, hire_date
from employees
where hire_date like '%/01/%'
order by hire_date;










