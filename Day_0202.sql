/* ************************
���� (join)
- �� �̻��� ���̺���� �����Ͽ� �����͸� ��ȸ
- �ι������� pk�� fk�� ���踦 ���� �ִ� ���̺��� ���� �˻�
- ������ �����ͺ��̽��� ���� ū �����̸鼭 ���� �߿��� �ٽ�
- ������ �ϴ� ������ �������� ���Ἲ�� �����ϱ� ���� ���̺��� ����ȭ�ϴ� �۾����� ���� 
�� �̻����� �������� ������ ��ȸ�ϱ� ���� ������ ����
***************************/

-- Cross Join(=ī���׽þ� ����) : A x B 
-- �����̸�, �޿�, �μ���
select e.first_name, e.salary, d.department_name
from departments d, employees e;

select department_name
from departments;

-- EQUI Join : PK�� FK�� ���ƾ� ����ó���� 
-- �����̸�, �޿�, �μ���
select e.first_name, e.salary, d.department_name
from departments d, employees e
where d.department_id=e.department_id;


--
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM countries;


-- �μ���� �����, ���ø��� ��ȸ
select d.department_name, c.country_name,l.city
from departments d, locations l, countries c
where l.location_id = d.location_id and l.country_id = c.country_id; 


/*inner join (join on �����̶�� �Ҹ�)
- ����� EQUI join�� ����
- ������ �ٸ� 
- inner��� Ű���尡 �� (inner ���� ����)
- where --> on���� pk,fk ����
- fk�� null�� �����ʹ� ��ȸ �ȵ�
*/
--inner join, onŰ����
select e.first_name, e.salary, d.department_name
from departments d inner join employees e
on d.department_id=e.department_id;

--inner ����, on Ű����
select e.first_name, e.salary, d.department_name
from departments d join employees e
on d.department_id=e.department_id;


-- on ��� using() Ű���� : using�� PK�� FK�� name�� ���� ���� ��밡����. sefe-join�� ��� ��� �Ұ�����. 
select e.first_name, e.salary, d.department_name
from departments d join employees e
using (department_id);



-- �̸�, �޿�, �μ��� ��ȸ
--1) ����Ŭ ����
SELECT first_name, salary, d.department_name
from employees e, departments d
where e.department_id=d.department_id;

--2) inner join
SELECT first_name, salary, d.department_name
from employees e inner join departments d
on e.department_id=d.department_id;

--3) ANSI ǥ�� : join~on (inner ��������)
SELECT first_name, salary, d.department_name
from employees e join departments d
on e.department_id=d.department_id;

--4) ANSI ǥ�� : join~using (inner ��������)
SELECT first_name, salary, d.department_name
from employees e join departments d
using (department_id);



--[����] �μ���, �����, ���ø� ��ȸ
--1)����Ŭ ����
select d.department_name, c.country_name, l.city
from departments d, locations l, countries c
where l.location_id = d.location_id and l.country_id = c.country_id; 

--2)ANSI ǥ�� : inner join
select d.department_name, c.country_name, l.city
from departments d inner join locations l on l.location_id = d.location_id 
    inner join countries c on l.country_id = c.country_id ;

--3)ANSI ǥ�� : join~on
select d.department_name, c.country_name, l.city
from departments d join locations l on l.location_id = d.location_id 
    join countries c on l.country_id = c.country_id ;

--4)ANSI ǥ�� : join~using
select d.department_name, c.country_name, l.city
from departments d join locations l using(location_id) 
    join countries c  using(country_id) ;




--[����] �̸�, �Ի���, �ټ� ����, �μ���, �����̸�
select e.first_name as �̸�, e.hire_date as �Ի���, floor(months_between(sysdate,e.hire_date)/12) as �ټӿ���, d.department_name as �μ���, j.job_title as �����̸�
from employees e join departments d 
        using(department_id) 
            join jobs j 
                using(job_id)
order by 3 desc;

-- join~on���� ����
select e.first_name as �̸�, e.hire_date as �Ի���, floor(months_between(sysdate,e.hire_date)/12) as �ټӿ���, d.department_name as �μ���, j.job_title as �����̸�
from employees e join departments d 
        on d.department_id = e.department_id 
            join jobs j 
                on e.job_id = j.job_id
order by 3 desc;

-- ����Ŭ �������� ����
select e.first_name as �̸�, e.hire_date as �Ի���, floor(months_between(sysdate,e.hire_date)/12) as �ټӿ���, d.department_name as �μ���, j.job_title as �����̸�
from employees e, departments d , jobs j
where d.department_id = e.department_id and e.job_id = j.job_id
order by 3 desc;



-- view�� �����
create view my_view as(
    select e.first_name as �̸�, e.hire_date as �Ի���, floor(months_between(sysdate,e.hire_date)/12) as �ټӿ���, d.department_name as �μ���, j.job_title as �����̸�
    from employees e join departments d 
            using(department_id) 
                join jobs j 
                    using(job_id)
);
     
     
select * 
from my_view
order by �ټӿ��� desc;

--drop view my_view; -- �� ����


/** outer join 
- fk�� ���� ���̺��� �����Ͱ� null�϶� ��ȸ���� �ʴ� ���ڵ尡 ����Ƿ�, 
��ȸ���� �ʴ� �����ͱ��� ��ȸ�ϱ� ���� ���� ���
- join������ ���� ���� ��쿡�� ����� ��ȯ�ް��� �� ��
- ���� : left outer, right outer, full outer

1) left outer
- ���� ���� ���̺��� �����͸� ��������, ������ ���̺��� �������µ�, 
�̶� ���������� ���� ������ null�� ä��
- ������ �ڽ��� �ִ� ���� ����Ŵ

*/

--left outer
--[����] �̸�, �μ��� ��ȸ
--1. ����Ŭ ���� (�θ�, �ڽ� ����, �θ�PK�� (+)����)
select e.first_name, d.department_name
from  departments d,employees e
where d.department_id(+) = e.department_id;

--2. LEFT OUTER JOIN ~ ON (�ڽ�, �θ� ����)
select e.first_name, d.department_name
from  employees e left outer join departments d on d.department_id = e.department_id;


--3. LEFT OUTER JOIN ~ ON (�ڽ��� ���ʿ� ����)
select e.first_name, d.department_name
from  employees e left outer join departments d using (department_id);



--4. RIGHT OUTER JOIN ~ ON (�ڽ��� �����ʿ� ����)
select e.first_name, d.department_name
from  departments d  right outer join employees e using (department_id);


/*
SELF JOIN
-- PK, FK�� �ϳ��� ���̺� ���� ����
*/


--[����] ������ ���̵�, ������ �̸��� �Ŵ��� ���̵�� �̸� ��ȸ
-- 1) ����Ŭ ����
select e2.employee_id, e2.first_name, e2.manager_id, e1.first_name 
from employees e1, employees e2
where e2.manager_id = e1.employee_id;


--2)join on 
select e2.employee_id, e2.first_name, e2.manager_id, e1.first_name 
from employees e1 join employees e2
on e2.manager_id = e1.employee_id;

--3)right join on 
select e2.employee_id, e2.first_name, e2.manager_id, e1.first_name 
from employees e1 right join employees e2
on e2.manager_id = e1.employee_id;


-- [��������]
--1. join�� �̿��� �����ȣ�� 100�� ����� ��� ��ȣ, �μ���ȣ, �μ��̸� ��ȸ
select e.employee_id, e.department_id, d.department_name
from employees e join departments d on e.department_id=d.department_id;

-- 2. inner������ �̿��� ������ �Բ� �� ����� ���� �μ��� �����̸� �����̸� ��ȸ
select e.first_name, l.city, r.region_name
from employees e, departments d,locations l, countries c, regions r
where e.department_id=d.department_id and d.location_id=l.location_id and l.country_id = c.country_id and c.region_id = r.region_id; 

-- 3. 100�� �μ��� ���ϴ� ������ �̸��� ������ ��� ������, �μ��� �ִ� ���ø� ��ȸ
select e.first_name, j.job_title, l.city
from employees e, jobs j, departments d, locations l
where e.job_id = j.job_id and e.department_id=d.department_id and d.location_id=l.location_id;









































































