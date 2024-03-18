/*
Review
*/

-- 1) �̸��� ��William���� ����� ��, �̸���, ��ȭ��ȣ�� ��ȸ�϶�
select last_name, email, phone_number
from employees
where first_name like 'William';

-- 2) �Ŵ����� 103�� ������ ����(���̵�, �̸�, �μ�, �Ŵ�����ȣ)�� ��ȸ�Ͻÿ�.
select employee_id, first_name, department_id, manager_id
from employees
where manager_id=103;

-- 3) ��� �μ����� ������ ���� ������ ���� (�̸�, ��ȭ��ȣ, �μ�)�� ��ȸ�Ͻÿ�
select first_name, phone_number, department_id
from  employees 
where department_id is null;

-- 4) �޿��� 10000�� �ʰ��ϸ鼭 JOB_ID�� 'SA_REP'�� ����� �̸���, �̸�, ��ȭ��ȣ, JOB_ID ������ ��ȸ�Ͻÿ�
select email, first_name, phone_number, job_id
from employees
where salary>10000 and job_id like 'SA_REP';

-- 5) �μ��� 60�̰ų� �̸��� A�� �����ϴ� �����ϴ� ������ ����(�̸�, �޿�, �μ�)��  ��ȸ�Ͻÿ�.
select first_name, salary, department_id
from employees
where department_id = 60 or first_name like 'A%';

-- 6) �μ��� 10�̰ų� 50�̰ų� 60�� �μ��� ������ ����(�̸�, �޿�, �μ�)�� ��ȸ�Ͻÿ�
select first_name, salary, department_id
from employees
where department_id in (10,50,60);

-- 7) �̸��� 3������ ��� ����� ������ ��ȸ�Ͻÿ�.
select *
from employees
where first_name like '___';

-- 8) ��ü �������� ������ 'CLERK' ���� ��ȸ (������ ����)
select * 
from employees
where job_id like '%CLERK%';

-- 9) Ŀ�̼�(COMMISSION_PCT)�� �޴� ������� �̸��� �̸����� ��ȸ
select first_name, email
from employees
where commission_pct is not null;

-- 10) �̸����� 'KGEE'�� ����� Ǯ������?
select first_name || ' '|| last_name as full_name
from employees
where email like 'KGEE';

-- 11) SALARY(�޿�)�� 10000�޷� �ʰ��ϸ鼭, JOB_ID(������ȣ)�� 'SA_REP' �� ����� 
--     EMAIL, LAST_NAME, PHONE_NUMBER�� EMPLOYEES ���̺��� ��ȸ
select email, last_name, phone_number 
from employees
where salary>10000 and job_id like 'SA_REP';



-- 12) SALARY(�޿�)�� 3000�޷� �̸��̰ų�, 14000�޷��� �ʰ��ϴ� ������ EMPLOYEE_ID�� ��ȸ
select employee_id
from employees
where salary <3000 or salary > 14000;



-- 13) ��� ������ ������ �μ���ȣ�� �ߺ��Ǵ� ���� ������ ��ȸ�Ͻÿ�.
select distinct job_id, department_id
from employees;

-- 14) 80�� �μ��� ���� ������ �����ȣ, �̸�, �޿�, �Ի����� ��ȸ�Ͻÿ�. �̶� �Ի����� ���������� ����
select employee_id, first_name, salary, hire_date
from employees
where department_id = 80
order by hire_date;

-- 15) ��ü ������ �����ȣ, �̸�, �޿�, �μ���ȣ, �� ��ȸ�Ͻÿ�.
--     �̶� �μ���ȣ ��������, ���� �μ��� ��� �޿��� ������������ �����Ͻÿ�
select employee_id, first_name, salary, department_id
from employees
order by department_id asc, salary desc; 

-------------------------------------------------------------------------

--1. ��� ����� �̸���, ��ȭ��ȣ ù 3�ڸ��� ����Ͻÿ�.
select first_name, substr(phone_number,1,3) phone_number
from employees;

--2. ��� ����� �̸��� ��, �׸��� (�̸��� ���� ���� ���ڼ�)�� ����Ͻÿ�.
select first_name, last_name, length(first_name||last_name) as len
from employees;



--3. ��� ����� �̸��� ���� �Ӹ����ڸ� ����Ͻÿ�. (��. A.A)
select substr(first_name,1,1)||'.'||substr(last_name,1,1) as head
from employees;

--4. ��� ����� �̸��� ���� �빮�ڷ� ����Ͻÿ�.
select upper(first_name), upper(last_name)
from employees;


--5. ����� JOB_ID�� ���Ե� '_'������ ��ġ�� ���ϰ�, JOB_ID ���� �� ��ġ ���������� ���ڿ��� �����ȣ�� �Բ� ����Ͻÿ�.
--(INSTR, SUBSTR �Լ� ���)
select employee_id, substr(job_id,1,instr(job_id,'_')-1) as job_id  
from employees;


--6. ��� �޿��� 30���� ���� ���� �Ҽ��� ��° �ڸ����� �ݿø��Ͽ� ����Ͻÿ�.
select round(salary/30,2)
from employees;


--7. ��� �޿��� 30���� ���� ���� �Ҽ��� �Ʒ��� ���� �� �� ����Ͻÿ�.
select trunc(salary/30)
from employees;


--8. 2�� 10���� ����Ͽ� ����Ͻÿ�.
select power(2,10)
from dual;


--9. ��� ����� �Ի��ϰ�, �Ի��� ���� 100��° �Ǵ� ���� ������ ���� �������� ����Ͻÿ�.
select employee_id as "�����ȣ", hire_date as �Ի���, hire_date +100 as ������
from employees;

select employee_id as "�����ȣ", hire_date as �Ի���, to_char(hire_date +100, 'YYYYMMDD')as ������
from employees;

--10. �Ի��� ���� ���ñ����� ��¥���� ������ ���� ����Ͻÿ�. �ֱ� �Ի��� ��������� ����.
select employee_id as �����ȣ, hire_date as �Ի���, trunc(sysdate-hire_date) as �ٹ��ϼ� 
from employees
order by hire_date desc;

--11. �Ի��� ���� ���ñ����� �������� ������ ���� ����Ͻÿ�.
select employee_id as �����ȣ, hire_date as �Ի���, trunc(months_between(sysdate,hire_date)) as �ٹ������� 
from employees;


--12. �Ի����� ������ ���� �������� ����Ͻÿ�.
select to_char(hire_date,'YYYY"��" MM"��" DD"��" DAY') as hire_date
from employees;

--13. �Ի����� 3���� ��� ����� ������ ����Ͻÿ�.
select *
from employees
where to_char(hire_date,'MM') like '03';


--14. �Ի��� ���� Ȧ���� ��� ����� ������ ����Ͻÿ�.
select *
from employees
where mod(to_number(to_char(hire_date,'MM'),99),2) = 1
order by hire_date;


--15. ���� �ð��� ������ ���� �������� ����Ͻÿ�.
select to_char(sysdate,'YYYY-MM-DD HH:MI:SS') from dual;

--16. �޿��� ������ ���� �������� ����Ͻÿ�.
select employee_id, to_char(salary,'$999,999') from employees;


--17. �Ի��� �÷��� ���� NULL�� ��� ���� ��¥�� ġȯ�Ͽ� ���
select nvl(hire_date, sysdate) as hire_date
from employees;



--------------------------------------------------------------------------------

-- 1. JOIN�� �̿��Ͽ� ���ID�� 100���� ����� �μ���ȣ�� �μ��̸��� ����Ͻÿ�
select employee_id,department_id ,department_name
from employees e join departments d using(department_id)
where e.employee_id=100;

-- 2. INNER JOIN�� �̿��Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �����̸��� �������� ����Ͻÿ�
select first_name, city, region_name
from employees inner join departments using(department_id) 
                inner join locations using (location_id) 
                inner join countries using(country_id) 
                inner join regions using(region_id);

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 100�� �μ��� ���ϴ� 
--    ������� ������ ��� ������, ���� �μ��� ���ø��� ����Ͻÿ�.
--    (100�� �μ����� ���� 6������)
select first_name, job_title, city
from employees e join departments using(department_id)
                 join jobs using(job_id)
                 join locations using (location_id)
where department_id = 100;
    
-- 4. JOIN�� ����Ͽ� Ŀ�̼��� �޴� ��� ����� �̸�, �μ�ID, ���ø��� ����Ͻÿ�
select first_name, department_id, city
from employees inner join departments using(department_id) 
                inner join locations using (location_id) 
where commission_pct is  not null;

select e.first_name, d.department_id, l.city
from employees e, departments d, locations l
where commission_pct is not null 
      and e.department_id = d.department_id(+)
      and d.location_id = l.location_id(+); -- department_id�� null���� ����� ����

select first_name, department_id, city
from employees left outer join departments using(department_id) 
               left outer join locations using(location_id)
where commission_pct is not null;
    
--null���� ������ �Ϸ��� outer join!! �ڽ��� �ִ� �������� left/right ����, ����Ŭ ������  �θ��� pk�� (+)���� 
    
-- 5. INNER JOIN�� ���ϵ�ī�带 ����Ͽ� �̸��� A�� ���Ե� ��� ����� �̸��� �μ����� ����Ͻÿ�(��, ��ҹ��� ���� ����)
select first_name, department_name
from employees e join departments d using (department_id)
where upper(first_name) like '%A%';



-- 6. JOIN�� ����Ͽ� Seattle�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ ��  �μ����� ����Ͻÿ�
select first_name, job_title, department_id, department_name
from employees inner join departments using(department_id) 
                inner join locations using (location_id) 
                inner join jobs using (job_id)
where city like 'Seattle';

-- 7. SELF ������ ����Ͽ� ����� �̸� �� �����ȣ�� �Ŵ��� �̸� �� �Ŵ��� ��ȣ��  �Բ� ��ȸ�Ͻÿ�. (�̹� Ǯ���� ������)
select e2.employee_id,e2.first_name as ������,e2.manager_id, e1.first_name as �Ŵ����� 
from employees e1 join employees e2 
on e2.manager_id = e1.employee_id;


-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��ȸ
SELECT e2.employee_id, e2.first_name as ������, e2.job_id, e2.department_id,e2.manager_id, e1.first_name as �Ŵ�����
from employees e1 right outer join employees e2
on e2.manager_id = e1.employee_id
order by e2.employee_id desc;


-- 9. SELF JOIN�� ����Ͽ� 'Oliver' ����� �μ���, �� ����� ������ �μ����� �ٹ��ϴ�  ���� ����� �̸��� ��ȸ. 
--     ��, �� ���� ��Ī�� �μ���, ����� �� ��.
select department_name as �λ��, first_name as ����
from (select *
      from employees
      where department_id = (select department_id
                             from employees
                             where first_name like 'Oliver')) join departments using (department_id);
                    
select d.department_name as �λ��, tmp.first_name as ����
from (select first_name, department_id
      from employees
      where department_id = (select department_id
                             from employees
                             where first_name like 'Oliver'))tmp join departments d using (department_id);
                    



-- 10. SELF JOIN�� ����Ͽ� �����ں��� ���� �Ի��� ��� ����� �̸� �� �Ի����� �Ŵ��� �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�
select e2.first_name, e2.hire_date, e1.first_name as �Ŵ����̸�, e1.hire_date
from employees e1 join employees e2
on e2.manager_id = e1.employee_id
where e2.hire_date < e1.hire_date
order by 2;


select e1.first_name, e1.hire_date, e2.first_name as �Ŵ����̸�, e2.hire_date
from employees e1 join employees e2
on e1.manager_id = e2.employee_id
where e1.hire_date < e2.hire_date
order by 2;


-- 11. Last name�� ��King���� Manager�� �� ����� �̸��� �޿��� ��ȸ�Ͻÿ�.
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

-- 12. Finance�μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�
select department_id, first_name, job_title
from employees e join departments d using(department_id)
                 join jobs using(job_id)
where department_name like 'Finance';

    
-- 13. ��� �޿����� ���� �޿��� �ް� �̸��� 'M'�� ���Ե� ����� ���� �μ����� 
--     �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ��ȸ�Ͻÿ�
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
        
                       