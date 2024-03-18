/* [��������] */
-- 1. JOIN�� �̿��Ͽ� ���ID�� 100���� ����� �μ���ȣ�� �μ��̸��� ����Ͻÿ�
select department_id, department_name
from employees e join departments d using(department_id)
where employee_id = 100;

-- 2. INNER JOIN�� �̿��Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �����̸��� �������� ����Ͻÿ�
select e.first_name, l.city, r.region_name
from employees e 
    join departments d using(department_id) 
    join locations l using (location_id)
    join countries c using(country_id) 
    join regions r using(region_id);

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 100�� �μ��� ���ϴ� 
--    ������� ������ ��� ������, ���� �μ��� ���ø��� ����Ͻÿ�.
--    (100�� �μ����� ���� 6������)

select e.first_name, d.department_name, l.city
from employees e
    join departments d using(department_id)
    join locations l using(location_id)
where department_id=100;

    
-- 4. JOIN�� ����Ͽ� Ŀ�̼��� �޴� ��� ����� �̸�, �μ�ID, ���ø��� ����Ͻÿ�

select first_name, department_id, city
from employees 
    join departments using (department_id)
    join locations using(location_id)
where commission_pct is not null;

    
-- 5. INNER JOIN�� ���ϵ�ī�带 ����Ͽ� �̸��� A�� ���Ե� ��� ����� �̸��� �μ����� ����Ͻÿ�(��, ��ҹ��� ���� ����)
select first_name, department_name
from employees join departments using(department_id)
where upper(first_name) like '%A%' ;

-- 6. JOIN�� ����Ͽ� Seattle�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ ��  �μ����� ����Ͻÿ�
select first_name, job_id, department_id, department_name
from employees 
    join departments using(department_id)
    join locations using(location_id)
where city like 'Seattle';

-- 7. SELF ������ ����Ͽ� ����� �̸� �� �����ȣ�� �Ŵ��� �̸� �� �Ŵ��� ��ȣ��  �Բ� ��ȸ�Ͻÿ�. (�̹� Ǯ���� ������)
select  e1.employee_id,e1.first_name, e1.manager_id, e2.first_name
from employees e1 join employees e2
on e1.manager_id = e2.employee_id
order by 1;

select  e2.employee_id,e2.first_name, e2.manager_id, e1.first_name
from employees e1 join employees e2
on e2.manager_id = e1.employee_id;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��ȸ
select e1.employee_id, e1.first_name, e1.manager_id, e2.first_name
from employees e1, employees e2
where e2.manager_id = e1.employee_id
order by 1 desc;


-- 9. SELF JOIN�� ����Ͽ� 'Oliver' ����� �μ���, �� ����� ������ �μ����� �ٹ��ϴ� ���� ����� �̸��� ��ȸ. 
--     ��, �� ���� ��Ī�� �μ���, ����� �� ��.
select tmp2.first_name, tmp2.department_name, tmp1.first_name
from (select * from employees e join departments d using(department_id))tmp1 join (select * from employees e join departments d using(department_id))tmp2
on tmp2.department_name = tmp1.department_name
where tmp2.first_name like 'Oliver';


-- 10. SELF JOIN�� ����Ͽ� �����ں��� ���� �Ի��� ��� ����� �̸� �� �Ի����� �Ŵ��� �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�
select e2.first_name, e2.hire_date, e1.first_name, e1.hire_date
from employees e1 join employees e2
on e2.manager_id =  e1.employee_id
where e2.hire_date<e1.hire_date; 


-- 11. Last name�� ��King���� Manager�� �� ����� �̸��� �޿��� ��ȸ�Ͻÿ�.
select e2.first_name, e2.salary
from employees e1, employees e2
where e2.manager_id = e1.employee_id and e1.last_name like 'King';

-- 12. Finance�μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�
select department_id, first_name, job_id
from employees join departments using(department_id)
where department_name like 'Finance';
    
-- 13. ��� �޿����� ���� �޿��� �ް� �̸��� 'M'�� ���Ե� ����� ���� �μ����� 
--     �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ��ȸ�Ͻÿ� 
select employee_id, first_name, salary
from employees 
where salary >(select avg(salary) from employees) and department_id in (select distinct department_id
                                                                            from employees
                                                                            where upper(first_name)like '%M%' and department_id is not null);


select distinct e1.employee_id, e1.first_name, e1.salary
from employees e1 join employees e2 using(department_id)
where upper(e2.first_name) like '%M%' and e1.salary >(select avg(salary) from employees) ;



