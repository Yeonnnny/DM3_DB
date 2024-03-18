/* 2�� 1�� */
-- SELECT�� ���ǵ� ����� �ϳ��� �������� �ν��ؼ� ���տ����� �ϴ� ��
-- �� �̻��� �����͸� ������ ������ �������� ó��
-- ������(UNION, UNION ALL), ������(INTERSECT), ������(MINUS)

-- ** ������(intersection)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)

INTERSECT 

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

-- ** ������(minus)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)

MINUS 

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

-- ** ������(minus) ���� ������ ������ �٤̲���!
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

MINUS

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158);

-- ** ������ (union) : �ߺ��� �����ʹ� 1���� ��µ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158);

-- ** ������ (union) : �ߺ��� �����͵� ������ �� ��ȸ�ǵ���!
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-- ** ���տ��� ������ �� ��� 
-- 1) �÷��� ������ �ٸ��� �ٸ� �������� �����ǹǷ� ������
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-- 2) �÷��� ������ ���Ƶ� ���� ��ġ�� �÷� Ÿ���� �ٸ��� ������
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-- 3) ��������� �ƴ϶� ������ ���� (Ÿ�԰� ������ �������� �÷��� �ٸ� ���)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145,147,158)
ORDER BY FIRST_NAME;

-------------------------------------------------
/* �Լ�(FUNCTION)
- ���ǹ��� �Բ� ����Ͽ� ����� �����ϰ� ó���� �� �ִ� ���
-  �Լ��� ����
    1) ������ �Լ�: ������ ���ڵ忡 ����� �����Ű�� �Լ�
    ���̺�ȿ� �����Ͱ� 10���� ������ ���ڵ� ������ �Լ��� �����ϴ� ������ ��ü���ڵ�� ������ ��ġ�� 
    2) �׷��� �Լ�: Ư�� ���ǿ� �°� ���ڵ带 ��� ����� �����Ű�� �Լ� 
    ��ü �����Ϳ��� Ư�� ���ǿ� ���� �׷�ȭ�� ��Ű�� �ش� �׷쿡 �����ϴ� ������ ��ü���ڵ�� ������ ��ġ���� ����
*/
/*
*** 1) ������ �Լ�
1) ���ڿ��� ó���ϴ� �Լ�
- lower(���ڿ� | ���ڿ��� ����ִ� �÷���): �����ڸ� �ҹ��ڷ� ���� ( ������ ������� ����)
- upper(���ڿ� | ���ڿ��� ����ִ� �÷���): �����ڸ� �빮�ڷ� ���� (������ ������� ����)
- initcat(���ڿ� | ���ڿ��� ����ִ� �÷���): �����ڸ� ù��¥�� �빮��, �������� �ҹ��ڷ� ����
- concat(���ڿ�1, ���ڿ�2): ���ڿ��� ���� (= ������ ||)
- substr(���ڿ�, ��ġ1, ����): ���ڿ����� ������ ��ġ1(����)~ ���� ������ ���ڿ��� ��ȯ, INDEX�� 1���� ����
- length(���ڿ�): ���ڿ��� ���� ��ȯ
- instr(���ڿ�, �ι����ڿ�) : ���ڿ����� �κ� ���ڿ��� ��ġ�� ��ȯ
- replace(���ڿ�, ã�¹��ڿ�, �ٲܹ��ڿ�): ���ڿ� ġȯ
*/

-- �̸��� �ҹ��ڷ� ��ȸ
SELECT LOWER(FIRST_NAME)
FROM EMPLOYEES;

-- �̸��� �ҹ���, �빮�ڷ� ��ȸ
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES;

-- �̸��� �ҹ���, �빮�ڷ� ��ȸ
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES;

-- �������̺�('DUAL')�� �̿��Ͽ� 'ASIAN CUP 2024'�� ��� �ҹ��ڷ� ����
SELECT LOWER('ASIAN CUP 2024')
FROM DUAL;

-- �������̺�('DUAL')�� �̿��Ͽ� 'ASIAN CUP 2024'�� �ҹ��ڷ� �����ϰ� ù���ڸ� �빮�ڷ� ����
SELECT LOWER('ASIAN CUP 2024'), INITCAP('ASIAN CUP 2024')
FROM DUAL;

-- SUBSTR(���ڿ�, ��ġ): INDEX�� 1���� ����
SELECT UPPER(SUBSTR('The Soap', 5));

--SUBSTR(���ڿ�, ��ġ, ����):
SELECT UPPER(SUBSTR('The Soap', 5, 2)) AS RESULT
FROM DUAL;

--LENGTH(���ڿ�):���� ��ȯ
SELECT LENGTH('The Soap')
FROM DUAL;

-- INSTR(���ڿ�, �κй��ڿ�): ��ġ�� ã��
SELECT INSTR('The Soap','o')
FROM DUAL;

-- INSTR(���ڿ�, �κй��ڿ�): ��ġ�� ã��
SELECT INSTR('����Ŭ ������','��')
FROM DUAL;

-- INSTR(���ڿ�, �κй��ڿ�): ��ġ�� ã�� (ã�� ���� ��� 0 ��ȯ)
SELECT INSTR('����Ŭ ������','��')
FROM DUAL;

-- ***�ٸ� ����� �Բ� ���
-- ����
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;

-- �Լ��� WHERE������ ����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -1,1) = 'n'; 

-- �Լ��� WHERE������ ����ϱ�
-- �̸��� ������ 2��° 2���� 'en'���� ������ �������� �����ȣ�� �̸�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -2,2) = 'en'; 

-- CONCAT(���ڿ�1, ���ڿ�2): �� ���� ���ڿ��� ��ġ�� �Լ� ( ||�� ����)
SELECT CONCAT('I have a','dream')
FROM DUAL;

-- CONCAT()�� ���̺� ����
SELECT 
    CONCAT(EMPLOYEE_ID, FIRST_NAME),
    CONCAT(EMPLOYEE_ID, CONCAT(': ', FIRST_NAME))
FROM EMPLOYEES;

-- REPLACE(���ڿ�, ã�� ���ڿ�, �ٲ� ���ڿ�)
-- HIRE_DATE���� ���б�ȣ�� '/' -> '-'�� ����
SELECT FIRST_NAME, REPLACE(HIRE_DATE, '/', '-')
FROM EMPLOYEES;

-- �̸�, ��ȭ��ȣ�� ��ȸ�ϵ�, ��ȭ��ȣ�� '.'�� ' ' ���� ġȯ�Ͻÿ�
SELECT FIRST_NAME,PHONE_NUMBER, REPLACE(PHONE_NUMBER, '.', ' ')
FROM EMPLOYEES;

/*
2) ���ڿ� ���õ� �Լ�
- abs(����): Ư�� ������ ���밪 ���ϴ� �Լ�
- ceil(����): �ø�, ���� ����� ���� ������ ������ ��ȯ (ex -2.5�� ��� -2�� �ø�) 
- floorceil(����): ����, ���� ����� ���� ������ ������ ��ȯ (ex -2.5�� ��� -1�� ��ȯ)
- round(����, �ڸ���): ������ ��ġ���� �ݿø�(����� ����)
- trunc(����, �ڸ���): ������ ��ġ���� ����
- mod(��1, ��2): ù ��° ���ڸ� �� ��° ���ڷ� ������ �� ������
- power(��1, ��2): ù ��° ���ڸ� �� ��° ���ڸ�ŭ ���� �� (ex (2,4) �� ��� 2�� 4��)
- sign(����): ���ڰ� ������ -1, 0�̸� 0, ����� 1�� ��ȯ
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

/*��¥ �Լ�
- ��¥ ���� �ý��� ��: SYSDATE(�ý��� ���� ��¥, SYSTIMESTAMP(�ý��� ���� ��¥�� �ð�)
- ��¥ Ÿ���� �⺻ ��� �����ڸ� �̿��� ������ ����(�� ����) : + -

- add_months(��¥, ������): ������¥�� �������� ������ �� ����Ǵ� ��¥�� ��ȯ
- months_between(��¥1, ��¥2): �� ��¥ ���̿� �� ������ ���̰� �ִ��� ��ȯ
- last_day(��¥): ���� ��¥�� ������ ���� ���������� ��ȯ
- next_day(��¥, '����;): ��¥�� �������� �� ���� ������ �������� ��ȯ 
*/

-- SYSDATE
SELECT SYSDATE FROM DUAL;

-- SYSTIMESTAMP
SELECT SYSDATE,SYSTIMESTAMP  FROM DUAL;

-- SYSDATE: �ϴ��� 
SELECT SYSDATE + 1 AS "����", SYSDATE + 1 AS "����"  FROM DUAL;

-- ADD_MONTHS (��¥, ������): ������
SELECT ADD_MONTHS(SYSDATE, 10) AS '10���� ��', ADD_MONTHS(SYSDATE, -10) AS '10���� ��' FROM DUAL;

-- TO_DATE
SELECT CEIL(SYSDATE - TO_DATE('23/01/02')) FROM DUAL;


-- MONTHS_BETWEEN


-- LAST_DAY
-- �̹����� ������ ���� ���ϴ� �� 
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- LAST_DAY
-- �¾ �� �� ���� ������ ���� ���ϴ� �� 
SELECT LAST_DAY(TO_DATE('95/0
2/17')) FROM DUAL;

-- NEXT_DAY

-- [����1] �Ի��� ���� �ٹ��ϼ��� ����ϰ�, �̸�, �μ���ȣ, �ٹ��ϼ��� ���� ���
SELECT FIRST_NAME, DEPARTMENT_ID ,(last_day(HIRE_DATE) - HIRE_DATE)+1 AS WORKING_DAY
FROM EMPLOYEES
order by 3 desc;

SELECT FIRST_NAME, DEPARTMENT_ID ,ceil(last_day(HIRE_DATE) - HIRE_DATE) AS WORKING_DAY
FROM EMPLOYEES
order by 3 desc;


-- [����2] 80�� �μ����� �ٹ��ϴ� �������� �ð��� �ӱ��� ����Ͻÿ� (�ð��� �ӱ� ������������ )
-- SALARY�� ���� ==> �Ҽ��� ���� 2�ڸ� ����
-- �� 5�ϱٹ�, �Ϸ� 8�ð�, 4��
SELECT FIRST_NAME, SALARY, TRUNC(SALARY/(5*4*8),2) AS �ð����ӱ�
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
order by 3 desc;


-- [����3] JOB_HISTORY ���̺��� ������ �̿��� 102�� ������ Ư�� �μ����� ����� �ٹ��ߴ��� ����Ͻÿ�.
SELECT employee_id, ceil((end_date-start_date)/30) as �ٹ�������, department_id
FROM JOB_HISTORY
where employee_id = 102
ORDER BY EMPLOYEE_ID;


-- ����
select ceil(sysdate-to_date('2001/08/28')) as period
from dual;

-- ����
select ceil(sysdate-to_date('1997/07/10')) as period
from dual;

--[����4] ������� ������(2024-05-08)���� ���� ��
select (to_date('24/05/08')-sysdate)+1 as period
from dual;

-- ** ��ȯ�Լ�
/*
- to_char (��¥, ����) : ��¥�� Ư�� ���˿� ���� ���ڿ��� ��ȯ
- to_number(���ڿ�) : �������·� �� ���ڿ��� ���� Ÿ������ ��ȯ
- to_numbrer(���ڿ�) : �������·� �� ���ڿ��� ����Ÿ������ ��ȯ
*/
select '123.5', to_number('123.5')
from dual;

--to_char�� �̿��� ��¥ ����
select sysdate, to_char(sysdate,'YYYY-MM-DD'),
to_char(sysdate,'YYYY-MM-DD HH:MI')as ����ð�1,
to_char(sysdate,'YYYY-Mon-DD HH:MI') as ����ð�2,
to_char(sysdate,'YYYY-Mon-DDD HH:MI') as ����ð�3
from dual;


--to_char�� �̿��� ���� ����
select 
    to_char(1234560.34,'9,999,999.99'), to_char(1234560.34,'$9,999,999.99'),to_char(1234560.34,'l9,999,999.99'), to_char(1234560.34,'9,999,999.99')
from dual;

--[����] �̸�, �޿�, �Ի��� ���
select first_name, to_char(salary,'$999,999,999.999') as salary, to_char(hire_date,'YYYY-MM-DD(DY)')
from employees;

/* null ���� �Լ�
- nvl(�÷�, ������) : Ư�� �÷��� �����Ͱ� null�̸� null��� ������ ������ ���
- nvl2(�÷�, ������1, ������2) : Ư�� �÷��� �����Ͱ� null�̸� ������2, null�� �ƴϸ� ������1�� ���
*/

select first_name, nvl(commission_pct,0)
from employees;

select first_name,salary,commission_pct,nvl2(commission_pct,commission_pct*salary,0) as Ŀ�̼� 
from employees;



--[����] �̸�, �μ���ȣ ��� �μ���ȣ ������0
select first_name, nvl(department_id,0)
from employees
order by first_name;

--[����] �̸�, �μ���ȣ ��� �μ���ȣ ������ '�ӽ�'
select first_name, nvl(to_char(department_id),'�ӽ�')
from employees;

--[����] �����ȣ, �̸�, ���� ��ȣ, 
select employee_id, first_name, nvl(to_char(manager_id),'ȸ��')
from employees;


------------------------

/*
��Ÿ�Լ�
1) decode
 : �ٸ� ����� if���� ������ ������ **�Լ�**
decode(exp1, cond1,result1,
            cond2, result2,
            cond3, result3,
            default)


2)case��
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

-- case ����

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
�׷��� �Լ�
- sum(�÷���) : null�� ����
- count(�÷���) : null�� ����
- min/max(�÷���)
- avg(�÷���)
***************************/


--sum
select sum(salary) -- null�� ����
from employees;

--count
select count(employee_id)
from employees;

select count(*)
from employees;

select count(commission_pct) -- null�� ������
from employees; 

select count(commission_pct), sum(commission_pct)
from employees;


--min/max
select min(salary), max(salary)
from employees;

--�μ��� �ִ�, �ּ� �޿� ��ȸ
select department_id, min(salary), max(salary)
from employees
group by department_id;


--�μ��� �ִ�, �ּ� �޿��� manager_id ��ȸ
-- �׷��ΰ� ���þ��� �Ϲ��÷��� select���� ������ ����
select department_id, manager_id ,min(salary), max(salary) 
from employees
group by department_id,manager_id  -- �Ϲ��÷��� ���� ���� ������ group by�� ���� ��
order by department_id;

-- grouping ������ ��¿� ������ �ɰ� ������ having�� ���


--80�� �μ��� �ִ�, �ּ� �޿� ��ȸ
select department_id, min(salary), max(salary)
from employees
group by department_id
having department_id like 80;


--avg
--job_id�� �޿� ���
select job_id, round(avg(salary),2)
from employees
group by job_id
order by 2 ;


--job_id�� �޿� ��� (��, �޿� ����� 5000�̻�)
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


--[����] �μ��� �ο����� ���ų� 1���� �μ�, �μ��� null�� �͵� ����
select department_id, count(*)
from employees
group by department_id
having department_id is not null and count(*)>1
order by 1;

--[����] �Ի�⵵�� �׷���
select to_char(hire_date,'YYYY')as "�Ի� �⵵", count(*) as "�ο�"
from employees
group by to_char(hire_date,'YYYY')
order by 1;


--[����] �Ի�⵵ �ο��� ���� ���� ���� ���� ���Ͻÿ�
select min(�ο�) from
(
    select to_char(hire_date,'YYYY')as �Ի�⵵, count(*) as �ο�
    from employees
    group by to_char(hire_date,'YYYY')
    order by 1
)temp;


select �Ի�⵵, min(�ο�) from
(
    select to_char(hire_date,'YYYY')as �Ի�⵵, count(*) as �ο�
    from employees
    group by to_char(hire_date,'YYYY')
    order by 1
)temp
group by �Ի�⵵
having min(�ο�)=1;

/*��������*/

--1. 80���μ��� �޿� ���, �ְ�, ����, �ο� ��
select avg(salary), max(salary),min(salary), count(*)
from employees
group by department_id
having department_id=80;


--2. �� �μ��� �޿� ���, �ְ�, ����, �ο� ��
select department_id, round(avg(salary),2), max(salary),min(salary), count(*)
from employees
group by department_id;

--3. �� �μ��� �޿� ���, ��ü, ���� ������ ���Ͽ� ��� ������ ���� ������ ��ȸ, �� �μ���ȣ�� null�̸� ������� ����
select department_id, round(avg(salary),2), sum(salary),min(salary)
from employees
group by department_id
having department_id is not null
order by 2 desc;

-- 4. �� �μ��� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ� ��ȣ, ������, �ο��� ���
select department_id as �μ�, job_id as ����, count(*) as �ο�
from employees
group by department_id, job_id
having department_id is not null
order by department_id;


-- 5. ���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο��� ���
select job_id as ����, count(*) as �ο�
from employees
group by job_id
having count(*)>=4;













