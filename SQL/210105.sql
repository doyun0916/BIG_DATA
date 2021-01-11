select last_name �̸�, salary ����, hire_date �Ի���,
( trunc( months_between( sysdate, hire_date ) / 12 ) * 1000 ) +
case
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) = 0 then 0
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 3 then 250
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 6 then 500
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 9 then 750
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 11 then 1000
end ����
from employees
order by ���� desc;

<<< ���� >>>
Inner Join
Outer Join

select department_id from employees where employee_id = 110;
select department_name from departments where department_id = 100;

< cross join >

< equi join > Inner Join
select employees.last_name �̸�, departments.department_name �μ���
from employees
join departments
on employees.department_id = departments.department_id
where employees.employee_id = 110;

select employees.last_name �̸�, departments.department_name �μ���
from employees, departments
where employees.department_id = departments.department_id
and employees.employee_id = 110;

select e.last_name �̸�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 110;

select e.last_name �̸�, d.department_name �μ���
from employees e
join departments d
on e.department_id = d.department_id
where e.employee_id = 110;

����� 120���� ����� 
���, �̸�, ����(job_id), ������(job_title)�� ���.
join~on, where �� �����ϴ� �� ���� ��� ���.

select e.employee_id ���, e.last_name �̸�, e.job_id ����, j.job_title ������
from employees e
join jobs j
on e.job_id = j.job_id
and e.employee_id = 120;

select e.employee_id ���, e.last_name �̸�, e.job_id ����, j.job_title ������
from employees e, jobs j
where e.job_id = j.job_id
and e.employee_id = 120;

�� ���̺� ����
join~on where
select e.employee_id ���, d.department_name �μ���, j.job_title ������
from employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id

select e.employee_id ���, d.department_name �μ���, j.job_title ������
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

2005�� ��ݱ⿡ �Ի��� ������ 
���, �̸�, �Ի���, 
�μ���(department_name), ������(job_title)�� ���
select e.employee_id ���, e.last_name �̸�, e.hire_date �Ի���, d.department_name �μ���, j.job_title ������
from employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id
where hire_date between '05/01/01' and '05/06/30';

select e.employee_id ���, e.last_name �̸�, e.hire_date �Ի���, d.department_name �μ���, j.job_title ������
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and hire_date >= '05/01/01' and hire_date <= '05/06/30';

< nonequi join > Inner Join

create table salgrade(
    grade varchar(2) not null,
	losal number not null,
	hisal number not null
);
insert into salgrade values( '1', 1000, 5000 );
insert into salgrade values( '2', 5000, 10000 );
insert into salgrade values( '3', 10000, 15000 );
insert into salgrade values( '4', 15000, 20000 );
insert into salgrade values( '5', 20000, 30000 );
commit;

select * from salgrade;
select * from tabs;

select e.last_name �̸�, e.salary ����, s.grade �������
from employees e, salgrade s
where e.salary >= s.losal and e.salary < s.hisal
order by ������� desc;

select e.last_name �̸�, e.salary ����, s.grade �������
from employees e
join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by ������� desc;

select e.last_name �̸�, d.department_name �μ���, s.grade �������
from employees e, departments d, salgrade s
where e.department_id = d.department_id
and e.salary >= s.losal and e.salary < s.hisal
order by ������� desc;

select e.last_name �̸�, d.department_name �μ���, s.grade �������
from employees e
join departments d
on e.department_id = d.department_id
join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by ������� desc;

< self join > Inner Join
select * from employees;

select e.employee_id ���, e.last_name �̸�, e.manager_id �μ���, m.employee_id �μ�����, m.last_name �μ����̸�
from employees e, employees m
where e.manager_id = m.employee_id 
order by e.employee_id;

select e.employee_id ���, e.last_name �̸�, e.manager_id �μ���, m.employee_id �μ�����, m.last_name �μ����̸�
from employees e
join employees m
on e.manager_id = m.employee_id
order by e.employee_id;

< equi join > Outer Join
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id(+)
order by ���;

select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e
left outer join departments d
on e.department_id = d.department_id
order by ���;

select * from employees;
select count(distinct department_id) from employees;
select count(*) from departments;
select * from departments;

< nonequi join > Outer Join
select * from salgrade;
update salgrade set losal = 2500 where grade = 1;
commit;

select e.employee_id ���, e.last_name �̸�, e.salary ����, s.grade
from employees e, salgrade s
where e.salary >= s.losal and e.salary < s.hisal
order by e.employee_id;

select e.employee_id ���, e.last_name �̸�, e.salary ����, s.grade
from employees e, salgrade s
where e.salary >= s.losal(+) and e.salary < s.hisal(+)
order by e.employee_id;

select e.employee_id ���, e.last_name �̸�, e.salary ����, s.grade
from employees e
left outer join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by e.employee_id;

< self join > Outer Join
select e.employee_id ���, e.last_name �̸�, e.manager_id �μ���, m.employee_id �μ�����, m.last_name �μ����̸�
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

select e.employee_id ���, e.last_name �̸�, e.manager_id �μ���, m.employee_id �μ�����, m.last_name �μ����̸�
from employees e
left outer join employees m
on e.manager_id = m.employee_id
order by e.employee_id;

< FULL OUTER JOIN >
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id(+)
UNION
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where e.department_id(+) = d.department_id 

select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e
full outer join departments d
on e.department_id = d.department_id
order by e.employee_id;







