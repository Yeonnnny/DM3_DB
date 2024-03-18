--1. ��� ����� �̸���, ��ȭ��ȣ ù 3�ڸ��� ����Ͻÿ�.
select first_name, substr(phone_number,1,3)as phone
from employees;

--2. ��� ����� �̸��� ��, �׸��� (�̸��� ���� ���� ���ڼ�)�� ����Ͻÿ�.
select first_name, last_name, length(first_name||last_name) as num
from employees;

--3. ��� ����� �̸��� ���� �Ӹ����ڸ� ����Ͻÿ�. (��. A.A)
select concat(substr(first_name,1,1),concat('.',substr(last_name,1,1))) as fisrt_str
from employees;

--4. ��� ����� �̸��� ���� �빮�ڷ� ����Ͻÿ�.
select upper(first_name), upper(last_name)
from employees;

--5. ����� JOB_ID�� ���Ե� '_'������ ��ġ�� ���ϰ�, JOB_ID ���� �� ��ġ ���������� ���ڿ��� �����ȣ�� �Բ� ����Ͻÿ�.
--(INSTR, SUBSTR �Լ� ���)
select employee_id, substr(job_id,1, instr(job_id,'_')-1) as idx
from employees;


--6. ��� �޿��� 30���� ���� ���� �Ҽ��� ��° �ڸ����� �ݿø��Ͽ� ����Ͻÿ�.
select round(salary/30,1)
from employees;


--7. ��� �޿��� 30���� ���� ���� �Ҽ��� �Ʒ��� ���� �� �� ����Ͻÿ�.
select trunc(salary/30)
from employees;

--8. 2�� 10���� ����Ͽ� ����Ͻÿ�.
select power(2,10)
from dual;


-- 9. ��� ����� �Ի��ϰ�, �Ի��� ���� 100��° �Ǵ� ���� ������ ���� �������� ����Ͻÿ�.
select employee_id as �����ȣ,hire_date as �Ի���, to_char(hire_date+100,'YYYYMMDD') as ������
from employees;


--10. �Ի��� ���� ���ñ����� ��¥���� ������ ���� ����Ͻÿ�. �ֱ� �Ի��� ��������� ����.
select employee_id as �����ȣ, hire_date as �Ի���, ceil(sysdate-hire_date) as �ٹ��ϼ�
from employees
order by hire_date;


--11. �Ի��� ���� ���ñ����� �������� ������ ���� ����Ͻÿ�.
select employee_id as �����ȣ, hire_date as �Ի���, ceil((sysdate-hire_date)/30) as �ٹ�������
from employees;
select employee_id as �����ȣ, hire_date as �Ի���, trunc(months_between(sysdate,hire_date)) as �ٹ�������
from employees;

--12. �Ի����� ������ ���� �������� ����Ͻÿ�.
SELECT to_char(hire_date,'YYYY')||'�� '||to_char(hire_date,'Mon')||to_char(hire_date,'DD')||'�� '||to_char(hire_date,'DAY') as hire_date
from employees;

SELECT to_char(hire_date,'YYYY"��" MM"��" DD"��" DAY') as hire_date
from employees;

--13. �Ի����� 3���� ��� ����� ������ ����Ͻÿ�.
select *
from employees
where to_char(hire_date,'MM') like '03';


--14. �Ի��� ���� Ȧ���� ��� ����� ������ ����Ͻÿ�.
select *
from employees
where to_char(hire_date,'MM') in ('01','03','05','07','09','11')
order by to_char(hire_date,'MM');

select *
from employees
where mod(to_number(to_char(hire_date,'MM'),99),2) =1
order by to_char(hire_date,'MM');

--15. ���� �ð��� ������ ���� �������� ����Ͻÿ�.
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS')
from dual;

--16. �޿��� ������ ���� �������� ����Ͻÿ�.
select employee_id, to_char(salary, '$999,999,999') as salary
from employees;

--17. �Ի��� �÷��� ���� NULL�� ��� ���� ��¥�� ġȯ�Ͽ� ����Ͻÿ�.
select employee_id, nvl(hire_date,sysdate)
from employees;


