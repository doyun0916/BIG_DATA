select 5 + 2 from dual;

select last_name, salary, salary + 100 
from employees;

select last_name, commission_pct from employees;
select last_name, salary * commission_pct from employees;
select last_name, salary + nvl(commission_pct, 0) from employees;
select last_name as �̸�, salary ����, salary + 1000 �λ� from employees;
select last_name "�̸�" from employees;
select first_name, last_name �̸�, salary ���� from employees;
select first_name || last_name �̸�, salary ���� from employees;
select first_name || ' ' || last_name �̸�, salary ���� from employees;
select department_name || q'[ Departmnet's Manager Id: ]' || manager_id as Department
from departments;

select first_name || ' ' || last_name ��ü�̸�, salary ����, salary * 1.1 "10% �λ�� ����"
from employees;

# last_name �� 107ĭ, distinct�� ����, 12��. ...> error
# ������ ���Ƶ� row�� �ٸ��� ������ ��� �Ұ�.
select last_name �̸�, distinct department_id �μ� from employees;    // error!

select last_name �̸�, salary ����, department_id �μ�
from employees
where department_id != 90;

select last_name �̸�, salary ����, department_id �μ�
from employees
where salary >= 10000;

select last_name �̸�, salary ����, department_id �μ�
from employees
where last_name = 'King';

select last_name �̸�, salary ����
from employees
where salary >= 100

select last_name �̸�, salary ����
from employees
where salary between 10000 and 15000;

select last_name �̸�, department_id �μ�
from employees
where department_id = 90 or department_id =100 or department_id = 80

select last_name �̸�, department_id �μ�
from employees
where department_id in (80, 90, 100);

select last_name �̸�, job_id ����
from employees
where last_name like 'King'

select last_name �̸�, job_id ����
from employees
where last_name like '__k%'

select last_name �̸�, job_id ����
from employees
where last_name like '%k%'

select last_name �̸�, job_id ����
from employees
where last_name like '___'

# _A�� ���°� ã�� ������,
select last_name �̸�, job_id ����
from employees
where job_id like '%\_A%' escape '\';

select last_name �̸�, commission_pct �μ�Ƽ��
from employees
where commission_pct is null;

select last_name �̸�, commission_pct �μ�Ƽ��
from employees
where commission_pct is not null;

select last_name �̸�, salary ����
from employees
where not (salary >= 10000 and salary <= 15000);

select last_name �̸�, salary ����
from employees
where not salary >= 10000 and salary <= 15000;

select last_name �̸�, department_id �μ�
from employees
where not department_id = 90 or department_id = 100;

select last_name �̸�, department_id �μ�
from employees
where department_id not in (90, 100);

select last_name �̸�, salary ����
from employees
order by salary desc;

#��¥�� ���� ����.
select last_name �̸�, department_id �μ�, salary ����
from employees
where department_id = 50
order by salary desc;

#���� ������?
select last_name �̸�, salary ����, hire_date �Ի���
from employees
order by salary desc, hire_date;

#order by���� alias ��� ����!
select last_name �̸�, salary ����, hire_date �Ի���
from employees
order by ���� desc, �Ի���;

define num = 100
select employee_id ���, last_name �̸�, salary ����
from employees
where employee_id = &num;
// undefine�� ���� ���� ���������.
undefine num;

define str = 'Hello World!!!'
select lower('&str')
select upper('&str')
from dual;
select initcap('&str') from dual;      // �� �տ��� �빮��
select concat ('&str', '!!') from dual;
select substr('&str', 1, 2) from dual;   // ù��°���� 2�� �����Ͷ�.
select substr('&str', -4, 2) from dual;   // �ں��� 2�� �����Ͷ�
                                         // index�� ������, but �������°� ������
select instr('&str', 'o') ��ġ from dual; 
select instr('&str', 'o', 1, 2) ��ġ from dual; //�ι�° ���� �޶�.
select length('&str') from dual;
select lpad('&str', 20) from dual;
select rpad('&str', 20) from dual;

define s = '       A B   C   D  E  F          '
select '&s' from dual;
select ltrim('&s') from dual;
select rtrim('&s') from dual;
select trim( ' ' from '&s') from dual;
undefine str;
undefine s;
////////////// ���� ���� //////////////
2-1)
    1. ����
    2. ����
    3. �޸�, "annual salary", salary, ������ x�ƴϰ� *
    4. a) desc departments;
       b) select * from departments;
    5. a) desc employees;
       b) select employee_id, last_name, job_id, hire_date "STARTDATE"
          from employees;
    6. select job_id from employees;
select distinct job_id from employees;
    7. select employee_id "Emp #", last_name "Employee", job_id "Job", hire_date "HireDate"
       from employees;
    8. select last_name || ', ' || job_id as "Employee and Title"
       from employees;
    9. select employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' || phone_number || ',' || job_id as "THE_OUTPUT"
       from employees;
3-1)
1.
select last_name, salary
from employees
where salary > 12000;
2.
select last_name, department_id
from employees
where employee_id = 176;
3.
select last_name, salary
from employees
where salary not between 5000 and 12000;
4.
select last_name, job_id, hire_date
from employees
where last_name in ('Matos', 'Taylor')
order by hire_date;
5.
select last_name, department_id
from employees
where department_id in (20, 50)
order by last_name;
6.
select last_name "employee", salary "Monthly Salary"
from employees
where salary between 5000 and 12000 and department_id in (20, 50);
7.
select last_name, hire_date
from employees
where hire_date like '06%';
8.
select last_name, job_id
from employees
where manager_id is null;
9.
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by 2 desc, 3 desc;

10.
select last_name, salary
from employees
where salary > &num;
11.
select employee_id, last_name, salary, department_id
from employees
where manager_id = &a
order by &b;
12.
select last_name
from employees
where last_name like '__a%';
13.
select last_name
from employees
where last_name like '%e%a%' or last_name like '%a%e%';
14.
select last_name, job_id, salary
from employees
where job_id in ('SA_REP', 'ST_CLERK') and salary not in (2500, 3500, 7000);
15.
select last_name "employee", salary "Monthly Salary", commission_pct
from employees
where commission_pct = 0.2;

4-1)
1.
select hire_date "Date"
from employees
2,3.
select employee_id, last_name, salary, salary * 1.155 "New Salary"
from employees;
4.
select employee_id, last_name, salary, salary * 1.155 "New Salary", salary * 1.155-salary Increase
from employees;
5.
a)
select last_name Name, length(last_name) Length
from employees
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%';
b)
select last_name Name, length(last_name) Length
from employees
where last_name like '&s%';
c)
select last_name Name, length(last_name) Length
from employees
where last_name like 'upper(&s)%';
