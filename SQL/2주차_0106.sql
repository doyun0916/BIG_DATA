*** ���� 1 ***
select e.first_name || ' ' || e.last_name �̸�, e.department_id �μ�, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;

*** ���� 2 ***
select e.last_name �̸�, e.commission_pct �μ�Ƽ��, d.department_name �μ���
from employees e, departments d
where e.department_id = d.department_id and e.commission_pct is not null
order by e.commission_pct desc, e.employee_id desc;

*** ���� 3 ***
select e.last_name �̸�, d.department_name �μ���, l.city ����
from employees e
left outer join departments d
on e.department_id = d.department_id
left outer join locations l
on d.location_id = l.location_id
order by e.employee_id;

*** ���� 4 ***
select e.last_name �̸�, j.job_title ����, e.salary �޿�, s.grade ���
from employees e, jobs j, salgrade s
where e.job_id = j.job_id and e.salary >= s.losal(+) and e.salary < s.hisal(+)
order by e.employee_id, ��� desc;

*** ���� 5 ***
select e.last_name �ڽ�, e.department_id �μ���ȣ, r.last_name ����
from employees e, employees r
where e.last_name = 'Abel' and e.department_id = r.department_id and not r.last_name = 'Abel'
order by ����;

<<< subquery >>>   �ȿ� �ִ°� ���� ���� ��.
�������� - �ܺ�����
�������� - ��������
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<single-row subquery>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select department_name 
from departments 
where department_id = ( select department_id 
                        from employees 
                        where employee_id=110);

<multi-column subquery>
select department_name from departments where department_id =
(select department_id from employees where employee_id = 100)     --------> ��� ���� 1���� ���;���!!! '=' �񱳸� ����

select last_name �̸�, salary ����, avg(salary) over() ��տ��� from employees;
select last_name �̸�, salary ����, (select avg(salary) from employees ) ��տ��� from employees;

�̸� ���� ��տ��� ��� ������ 2500 ������ ����� ��� (11��)
select last_name �̸�, salary ����, (select avg(salary) from employees) ��տ���
from employees
where employees.salary <= 2500;

100�� �μ� �������� �̸� ���� �ְ� ���� �������� ����-��տ��� ��� (6��)
select * from departments;
select last_name �̸�, salary ����, (select max(salary) from employees where employees.department_id=100) �ְ���, 
(select min(salary) from employees where employees.department_id=100) ��������,
trunc(salary-(select avg(salary) from employees where employees.department_id=100)) ������
from employees
where employees.department_id=100;

> < >= <= = !=
select last_name �̸�, salary ����
from employees
where salary >= ( select avg(salary) from employees);

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Multi-row subquery>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

select department_name from departments where department_id =
( select department_id from employees where last_name = 'Seo')   // ���� ��

select department_name from departments where department_id =
( select department_id from employees where last_name = 'King')   // multi row    (error)

select department_name from departments where department_id in
(select department_id from employees where last_name = 'King');   // multi row     (correct)

in ����� �ϳ��� ��ġ�ϸ� ��
any, some ����� �ϳ� �̻� ��ġ�ϸ� ��
all ����� ��� ���� ��ġ�ϸ� ��
exists ��� �߿��� ���� ������ �� �������� ����
        ������ �������� �������� ���� ����
        
select last_name �̸�, salary ���� 
from employees
where salary < any(select min_salary from jobs where job_id = 'IT_PROG')        // ���ⰰ�� ��� �������̶� �ε�ȣ ����! <= (selec...)

select last_name �̸�, salary ���� 
from employees
where salary < any (select salary from employees where job_id = 'IT_PROG')      // ���� ����, �ϳ��� ������ ��������!

select last_name �̸�, salary ���� 
from employees
where salary < all (select salary from employees where job_id = 'IT_PROG')      // ���� �࿡ �ִ� ����, ��ü �� �����ϰ� ������ ��������

////// all �� ��ȣ x ///////////////
select last_name �̸�, salary ����
from employees
where salary = any (select salary from employees where job_id = 'IT_PROG')      // ����

select last_name �̸�, salary ����
from employees
where salary = all (select salary from employees where job_id = 'IT_PROG')      // �Ұ��� �����ϴ� ���̰� ���� �� ����!

select last_name �̸�, salary ���� from employees
where salaey < any (select salary, department_id from employees where job_id = 'IT_PROG')  // multi-column�̶� ����!

select last_name �̸�, salary ����, job_id ����
from employees where exists (select job_id from jobs where job_title = 'Programmer')                    ********exists����, SubQuery�� �����ִ� �� true, false ��!!!!!!!!
 ****** exists �� �ܺ� ���� ���� ���� �Ǻ��ϱ� ���� ���!

last_name�� russell�� ����� �޿����� ���� �޿��� �޴� ����� �̸��� ���� ���
select last_name, salary
from employees
where employees.salary > all (select salary from employees where employees.last_name='Russell')
order by salary desc;

last_name�� russell�� ����� �޿����� ���� �޿��� �޴� ����� �̸��� ���� ���
select last_name, salary
from employees
where employees.salary > any (select salary from employees where employees.last_name='King')
order by salary desc;

********** ���� 4 ************************
select e.employee_id, e.last_name, e.hire_date
from employees e
where e.department_id = (select d.department_id from employees d where d.employee_id = 201)
and e.hire_date < (select j.end_date from job_history j where j.employee_id = 201)
and not e.employee_id = 201;

�� �μ����� ���� ���� �ٹ��� ��� �� ������ ���� ���� ����� ���޽��ѷ��� �Ѵ�.
�ش� ������ �̸��� ����, �Ի���, �μ��� ����Ѵ�.

select o.last_name �̸�, o.salary ����, o.hire_date �Ի���, o.department_id �μ�
from employees o,
(select b.last_name, b.department_id
 from (select last_name, department_id, months_between(sysdate, hire_date) m 
       from employees) b,
      (select min(a.m) t 
       from (select e.department_id, max(months_between(sysdate, e.hire_date)) m 
             from employees e  
             where e.department_id is not null 
             group by e.department_id
             order by m) a) c
 where b.m = c.t) j
where o.last_name = j.last_name and o.department_id = j.department_id;






select o.last_name �̸�, o.salary ����, o.hire_date �Ի���, o.department_id �μ�
from employees o
where o.employee_id = 
(select q.employee_id
from (select b.employee_id, b.salary
      from (select employee_id, salary, department_id, months_between(sysdate, hire_date) m from employees) b, 
           (select e.department_id, max(months_between(sysdate, e.hire_date)) m from employees e  
            where e.department_id is not null 
            group by e.department_id
            order by m) a
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


