--2024�� 1�� 31�� (��)
/*�������ּ�
��
��
��
*/

/* 
- �����ͺ��̽�(Database)
  ������ : ���Ǽ��迡�� �ܼ��� ���� �Ǵ� ������ ���ؼ� ������ ����̳� ��
  ����(Information) : ��Ȳ�� ���� ������ �ǻ� ������ �� �� �ְ� �ϴ� ����
         �������� ��ȿ�� �ؼ��̳� ������ ��ȣ ���� ���踦 ���ϴ� ��
         �����͸� ó���ؼ� ����� ���

- �����ͺ��̽� ���� �ý���(RDBMS) - NoSQL(Not Only SQL) : JSON ���Ϸ� �����
  ����� ���� �����͸� ���ϰ� �����ϰ�, ȿ�������� �����ϰ� �˻��� �� �ִ�
  ȯ���� �������ִ� ����Ʈ����
  

*** SQL (Structured Query Language)
- DB�� �����ؼ� ó���ϴ� ��ɾ��
- ���� ǥ��
- ��ɾ��� ����

 1) DDL (Database Definition Language): ��ü�� �ٷ�� ���
	create(����), alter(����), drop(����)

 2) DML (Database Manipulation Language): ���̺��� ���ڵ带 �ٷ�� ���
	insert(����), update(����), delete(����), select(��ȸ) (select�� Ŀ���� �ʿ� ����)

 3) DCL (Database Control Language): ������ ������ �ٷ�� ���
	grant(�ο�), revoke(���� ȸ��)

 4) TCL (Transaction Control Language): Ʈ������� �ٷ�� ���
 	commit(����), rollback(�ǵ���), savepoint(�ǵ��� ��ġ)

- SQL ��� ==> ;���� ������ ��


*** ��������(constraint)
1) Primary key (��Ű) - ���̺� ���� �� ���ڵ带 �����ϱ� ���� ������ ��
2) Foreign Key (�ܷ�Ű) - ���� ������ ���� �ʿ� (���� ���Ἲ)
   delete cascade // �θ� �����ϸ� �ڽ��� ��� ���� ���ڵ尡 ��������� ��
3) Unique   - ������ ���� ������ (�ֹι�ȣ, ����ȣ)
4) Not Null - �� ���̸� �ȵǴ� ��(�̸�)
5) Check    - �������� ���� ������Ű�� �뵵 (�ε���, ����, �г�)

	default  - �����Ͱ� ���� �� ���ԵǴ� �⺻��

*** ����Ŭ���� �ٷ�� ��ü�� ����
1) ���̺� (Table)
2) ���� (User)
3) ��(View) 
4) �ε���(Index)
5) ������(Sequence)
6) �ó��(Synonym)


*** select
- SELECT ����

  SELECT [ALL | DISTINCT] �÷���,... 
  FROM ���̺��
  WHERE ������
  ORDER BY �÷��� [ASC | DESC] ;   			-- (����) ������ ������ ���� �־�� ��
  
*/

select * from countries;
select * from regions;
select * from departments;
select * from employees;

-- �̸��� �޿� ���� ��ȸ
select first_name, salary from employees;

-- �μ���ȣ ��ȸ
select distinct department_id, count(*) as count
from employees 
group by department_id
order by department_id desc; --��������


-- �̸�, �޿�, �μ� ��ȣ, �̸� �� �������� ��ȸ
select first_name, salary, department_id
from employees
order by 1;

-- �̸�, �޿�, �μ� ��ȣ, �̸� �� �������� ��ȸ (��Ī : as Ű����)
select first_name as �̸�, salary as �޿�, department_id as "�μ� ��ȣ"
from employees
order by first_name;


-- ������ ������ 5%�� ���ʽ��� �����ϰ��� ��
-- ������ �����ȣ, �̸�, �޿�, ���ʽ�, �հ�
-- ��ȸ�� �Ǿ� ��µǴ� �͵� �ٸ� ������ ���̺���
-- ���ڿ��� ���� ����ǥ
select employee_id , first_name||'��' as name, salary, salary*0.05 as bonus, salary+(salary*0.05) as total
from employees;

--�̸��� �� �ٿ� ���
select first_name||'��' as name
from employees;


--�̸��� ���� �ٿ� �̸������� ��ȸ
select first_name||' '||last_name||'��' as name
from employees
order by 1; -- select���� �÷��� ������ �������� �����϶�� ��


-- �޿��� 10000�̻��� �������� �����ȣ, �̸� �޿�, ���� ��ȸ

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


-- commssion ���� null�� �ƴ� ��� ��ȸ
select first_name, salary, commission_pct
from employees
where commission_pct is not null; -- �÷��� is null/ is not null



-- manager x
select first_name, job_id
from employees
where manager_id is null;


-- Ŀ�̼� �ݾ� �ִ� ����� �̸�, �޿�, Ŀ�̼Ǳݾ�, �Ѽ��ɾ� ��ȸ 
select first_name as �̸�, salary as �޿�, commission_pct*salary as Ŀ�̼Ǳݾ�, salary+(commission_pct*salary) as �Ѽ��ɾ�
from employees
where commission_pct is not null
order by 4 desc;


-- between a and b ������
-- �޿��� 5000�̻� 10000������
select employee_id,first_name,salary,department_id
from employees
where salary BETWEEN 5000 and 10000
order by salary desc;

-- in (a,b) ������
-- �μ���ȣ�� 10�̰ų� 50�� �ƴ� 
select first_name,department_id
from employees
where department_id not in(10,50)
order by department_id;

select first_name,department_id
from employees
where not(department_id = 10 or department_id =50)
order by department_id;


-- in, btween ��� �Ұ����� ���
select first_name, phone_number, email
from employees
where salary>7000 and email='SKING';



-- ��¥ ������ : ���� �Է��� ���� ���� ����ǥ, ���� �� �� ���굵 ����
select first_name, hire_date 
from employees
order by 2; 

-- �Ի�⵵�� 07�⵵�� ���� ��ȸ
select first_name, hire_date 
from employees
where hire_date between '070101' and '071231'
order by 2; 

select first_name, hire_date 
from employees
where hire_date like '07%'
order by 2; 

-- �Ի�⵵�� 07�⵵ ������ �Ի��� ��� ��ȸ
select first_name, hire_date 
from employees
where hire_date < '070101'
order by 2; 


-- ��¥ �������� �������
-- ���� ��¥ �����ʹ� ����������� ����. ��¥ ������ �Լ��� ������
select first_name, hire_date, hire_date+1
from employees
order by 2; 


-- like ������
-- �̸��� J�� �����ϴ� ���� ��ȸ
select first_name
from employees
where first_name like 'J%';

-- �̸��� n�� ������ �̸��� �� 5������ ���� ��ȸ
select first_name
from employees
where first_name like '____n';



-- ���ϵ�ī�� ��¥ ����
-- *** like�� ��¥
-- 07�⵵�� �Ի��� ������ �̸��� �Ի��� ��ȸ
select first_name, hire_date
from employees
where hire_date like '07%'
order by hire_date;

-- 01���� �Ի��� ������ �̸��� �Ի��� ��ȸ
select first_name, hire_date
from employees
where hire_date like '%/01/%'
order by hire_date;










