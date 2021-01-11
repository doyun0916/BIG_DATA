<cross join>

*******************************<equi join> Inner Join*************************
select employees.last_name �̸�, departments.department_name �μ���
from employees
join departments
on employees.department_id = departments.department_id
where employees.employee_id = 110;

select employees.last_name �̸�, departments.department_name �μ���
from employees, departments
where employees.department_id = departments.department_id
and employees.employee_id = 100;

select e.last_name �̸�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id and e.employee_id = 110;

select e.employee_id, e.last_name, j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = 120;

select e.employee_id, e.last_name, j.job_id, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where e.employee_id = 120;

// �� ���̺� ����
select e.employee_id, e.last_name, d.department_name, j.job_title
from employees e, jobs j, departments d
where e.job_id = j.job_id and e.department_id = d.department_id;

select e.employee_id, e.last_name, d.department_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
join departments d
on e.department_id = d.department_id

select e.employee_id, e.last_name, e.hire_date, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id 
and hire_date between '05/01/01' and '05/06/30';                                    //  e.hire_date>='05/01/01' and e.hire_date<'05/07/01';

************************<noneqi join -> �������� column���� ������ ��� ���> inner join*****************************
create table salgrade(
    grade varchar(2) not null,
    losal number not null,
    hisal number not null
);
insert into salgrade values('1', 1000, 5000);
insert into salgrade values('2', 5000, 10000);
insert into salgrade values('3', 10000, 15000);
insert into salgrade values('4', 15000, 20000);
insert into salgrade values('5', 20000, 30000);
commit;

select e.last_name �̸�, e.salary ����, s.grade �������
from employees e, salgrade s
where e.salary >= s.losal and e.salary < s.hisal
order by ������� desc;

select e.last_name �̸�, e.salary ����, s.grade �������
from employees e
join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by ������� desc;

***************< �ΰ� ���� ����>***************************
select e.last_name, d.department_name, s.grade
from employees e, departments d, salgrade s
where e.department_id = d.department_id and e.salary >= s.losal and e.salary < s.hisal
order by grade desc;

************************************<self join>  inner join******************

select e.employee_id ���, e.last_name �̸�, e.manager_id �μ���, m.employee_id �μ�����, m.last_name �μ����̸�
from employees e, employees m
where m.employee_id = e.manager_id
order by e.employee_id;

****************< equi join > outer join *************************************
select e.employee_id, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id
order by employee_id;                               // e.department�� null�̸� ������!!! --> == �̰� inner join

// outer join in equi join
select e.employee_id, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id(+)
order by employee_id;

********************< nonequi join>  outer join ******************************

select * from salgrade;
update salgrade set losal = 2500 where grade = 1;
commit;

select e.employee_id ���, e.last_name �̸�, e.salary ����, s.grade 
from employees e, salgrade s
where e.salary >= s.losal(+) and e.salary < s.hisal(+)
order by ��� desc;

******************< self join > outer join **********************************
select e.employee_id ���, e.last_name �̸�, e.manager_id �μ���, m.employee_id �μ�����, m.last_name �μ����̸�
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

********** < FULL OUTER JOIN> *********************************************
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where d.department_id = e.department_id (+)
UNION
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where d.department_id(+) = e.department_id

select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e
full outer join departments d
on e.department_id = d.department_id
order by e.employee_id;


************************���� 3-1********************************************
select e.employee_id ���, e.last_name || ' ' || e.first_name �̸�, j.job_title ����, d.department_name �μ�, h.start_date ����, h.end_date ����
from employees e, jobs j, departments d, job_history h
where e.employee_id = h.employee_id and h.job_id = j.job_id and h.department_id = d.department_id  
order by e.employee_id;

**********************���� 3-2**********************************************
select d.department_name, l.city, c.country_name, r.region_name
from departments d, locations l, countries c, regions r
where d.location_id = l.location_id and l.country_id = c.country_id and c.region_id = r.region_id
