/* 
[��������]  Select���� ����
*/

-- 1) �̸��� ��William���� ����� ��, �̸���, ��ȭ��ȣ�� ��ȸ�϶�
select last_name, email, phone_number
from employees
where first_name = 'William';

-- 2) �Ŵ����� 103�� ������ ����(���̵�, �̸�, �μ�, �Ŵ�����ȣ)�� ��ȸ�Ͻÿ�.
select employee_id, first_name, department_id, manager_id
from employees
where manager_id=103;

-- 3) ��� �μ����� ������ ���� ������ ���� (�̸�, ��ȭ��ȣ, �μ�)�� ��ȸ�Ͻÿ�
select first_name, phone_number, department_id
from employees
where department_id is null;

-- 4) �޿��� 10000�� �ʰ��ϸ鼭 JOB_ID�� 'SA_REP'�� ����� �̸���, �̸�, ��ȭ��ȣ, JOB_ID ������ ��ȸ�Ͻÿ�
select email, first_name, phone_number, job_id
from employees 
where salary >10000 and job_id like 'SA_REP';

-- 5) �μ��� 60�̰ų� �̸��� A�� �����ϴ� �����ϴ� ������ ����(�̸�, �޿�, �μ�)��  ��ȸ�Ͻÿ�.
select first_name, salary, department_id
from employees
where department_id=60 or first_name like 'A%';

-- 6) �μ��� 10�̰ų� 50�̰ų� 60�� �μ��� ������ ����(�̸�, �޿�, �μ�)�� ��ȸ�Ͻÿ�
select first_name, salary, department_id
from employees
where department_id in (10,50,60);

-- 7) �̸��� 3������ ��� ����� ������ ��ȸ�Ͻÿ�.
select * 
from employees
where first_name like '___';

-- 8) ��ü �������� ������ 'CLERK' ���� ��ȸ (������ ����)
select first_name, job_id
from employees
where job_id like '%CLERK';

-- 9) Ŀ�̼�(COMMISSION_PCT)�� �޴� ������� �̸��� �̸����� ��ȸ
select first_name, email
from employees
where commission_pct is not null;

-- 10) �̸����� 'KGEE'�� ����� Ǯ������?
select first_name||' '||last_name as fullname
from employees
where email like 'KGEE';

-- 11) SALARY(�޿�)�� 10000�޷� �ʰ��ϸ鼭, JOB_ID(������ȣ)�� 'SA_REP' �� ����� 
--     EMAIL, LAST_NAME, PHONE_NUMBER�� EMPLOYEES ���̺��� ��ȸ
select EMAIL, LAST_NAME, PHONE_NUMBER
from employees
where salary >10000 and job_id like 'SA_REP';

-- 12) SALARY(�޿�)�� 3000�޷� �̸��̰ų�, 14000�޷��� �ʰ��ϴ� ������ EMPLOYEE_ID�� ��ȸ
select employee_id
from employees
where salary<3000 or salary>14000;

-- 13) ��� ������ ������ �μ���ȣ�� �ߺ��Ǵ� ���� ������ ��ȸ�Ͻÿ�.
select distinct job_id, department_id
from employees;

-- 14) 80�� �μ��� ���� ������ �����ȣ, �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�. �̶� �Ի����� ���������� ����
select employee_id, first_name, salary, hire_date
from employees
where department_id in 80
order by hire_date;

-- 15) ��ü ������ �����ȣ, �̸�, �޿�, �μ���ȣ, �� ��ȸ�Ͻÿ�.
--     �̶� �μ���ȣ ��������, ���� �μ��� ��� �޿��� ������������ �����Ͻÿ�
select employee_id, first_name, salary, department_id
from employees
order by department_id, salary desc;
