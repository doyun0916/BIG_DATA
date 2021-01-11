** ���� 1 **
select e.last_name �̸�, d.department_name �μ���, l.city ����
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id
and e.job_id = (select job_id from employees where last_name='Russell')
and e.last_name != 'Russell'
order by employee_id;

** ���� 2 **
select e.employee_id ���, e.last_name �̸�
from employees e
where e.department_id =
(select d.department_id
from departments d, locations l
where d.location_id = l.location_id and l.city = 'Toronto')

** ���� 3 **
select a.last_name �̸�, a.salary �޿�
from (select last_name, salary from employees) a, salgrade s
where a.salary >= s.losal and a.salary < hisal and s.grade = 4;

** ���� 4 **
select last_name �̸�, department_id �μ�
from employees 
where department_id in
(select department_id
 from departments
 where location_id in (select location_id
                       from locations
                       where country_id in (select c.country_id
                                            from countries c, regions r
                                            where r.region_id = c.region_id and r.region_name = 'Europe')))
order by employee_id, department_id desc

** ���� 5 **
select o.last_name �̸�, o.salary ����, o.hire_date �Ի���, o.department_id �μ�
from employees o
where o.employee_id = 
(select q.employee_id
from (select b.employee_id, b.salary
      from (select employee_id, salary, department_id, months_between(sysdate, hire_date) m from employees) b, 
           (select e.department_id, max(months_between(sysdate, e.hire_date)) m from employees e  
            where e.department_id is not null 
            group by e.department_id) a
      where b.m in a.m and b.department_id in a.department_id
      order by b.salary) q
where q.salary = (select min(j.salary) 
                  from (select b.employee_id, b.salary
                        from (select employee_id, salary, department_id, months_between(sysdate, hire_date) m from employees) b, 
                             (select e.department_id, max(months_between(sysdate, e.hire_date)) m from employees e  
                              where e.department_id is not null 
                              group by e.department_id
                              order by m) a
                  where b.m in a.m and b.department_id in a.department_id 
                  order by b.salary) j))

** ���� 6 **
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, e.salary ����, sum(m.salary) ��������
from (select employee_id, last_name, department_id, salary from employees where department_id=50) e, 
(select employee_id, last_name, department_id, salary from employees where department_id=50) m
where e.employee_id >= m.employee_id
group by e.employee_id, e.last_name, e.department_id, e.salary
order by e.employee_id;

OR

select employee_id ���, last_name �̸�, department_id �μ�, salary ����, sum(salary) over(order by employee_id) ��������
from employees
where department_id = 50

///// �ؼ� /////
select e.employee_id ���, e.last_name �̸�, e.department_id �μ�, e.salary ����, e.salary+m.salary ��������
from employees e, employees m
where e.department_id = 50
group by e.employee_id, e.last_name, e.department_id, e.salary        // �ļ��� ����! �׳� sum ���� ����! �׷����°� �ƴ�, ó���� imployee_id�� �ؼ�, ��ü �����ŭ ����� �ϰ� �ȴ�.
order by e.employee_id;


*** UNION... ��� ������, ORDER BY�� �������� �ѹ��� ��! **********************


<<<<<<<<< system �������� �۾��Ͽ� ���� ���� �����ϱ� >>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from all_users;
select * from tabs;

DQL Query           select
DML                 insert update delete
DDL                 create alter drop
TCL Transaction     commit rollback savepoint
DCL          grant revoke

// session : �α����� ����, table �����, tablespace�� �־���. �������� �������ذ�! (alter�� 1), �뷮 ���������� ����(alter�� 2)
create user mc identified by mc;
grant create session to mc;
grant create table, create view, create sequence, create trigger to mc;
alter user mc default tablespace users;
alter user mc quota unlimited on users;


<<<<<<<<<< MC �������� >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from all_users;
select * from tabs;

<<<<<<<<<< HR �������� >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UNION / UNION first ������. �߸��� �ϳ���
UNION all           ������. �ߺ��� �ΰ���
MINUS               ������.
INTERSECT           ������.

select last_name �̸�, salary ����, hire_date �Ի��� from employees
where salary <= 7000
UNION
select last_name �̸�, salary ����, hire_date �Ի��� from employees
where hire_date >= '07/01/01';

A 63  B 30      A UNION B 69

select last_name �̸�, salary ����, hire_date �Ի��� from employees
where salary <= 7000
UNION all
select last_name �̸�, salary ����, hire_date �Ի��� from employees
where hire_date >= '07/01/01';

A 63  B 30      A UNION all B 93

select last_name �̸�, salary ����, hire_date �Ի��� from employees
where salary <= 7000
INTERSECT
select last_name �̸�, salary ����, hire_date �Ի��� from employees
where hire_date >= '07/01/01';

A 63  B 30      A intersect B 24

select last_name �̸�, salary ����, hire_date �Ի��� from employees
where salary <= 7000
MINUS
select last_name �̸�, salary ����, hire_date �Ի��� from employees
where hire_date >= '07/01/01';

A 63  B 30      A - B 24


select last_name �̸�, salary ����, hire_date �Ի��� from employees
where hire_date >= '07/01/01'
MINUS
select last_name �̸�, salary ����, hire_date �Ի��� from employees
where ;
A 63  B 30      B - A 6

select last_name �̸�, salary ����, hire_date �Ի��� from employees
where salary <= 7000
union
select last_name �̸�, salary ����, hire_date �Ի��� from employees
where hire_date >= '07/01/01'
order by ���� desc
