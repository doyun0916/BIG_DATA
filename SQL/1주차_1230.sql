select 5 + 2 from dual;

select last_name, salary, salary + 100 
from employees;

select last_name, commission_pct from employees;
select last_name, salary * commission_pct from employees;
select last_name, salary + nvl(commission_pct, 0) from employees;
select last_name as 이름, salary 연봉, salary + 1000 인상 from employees;
select last_name "이름" from employees;
select first_name, last_name 이름, salary 연봉 from employees;
select first_name || last_name 이름, salary 연봉 from employees;
select first_name || ' ' || last_name 이름, salary 연봉 from employees;
select department_name || q'[ Departmnet's Manager Id: ]' || manager_id as Department
from departments;

select first_name || ' ' || last_name 전체이름, salary 연봉, salary * 1.1 "10% 인상된 연봉"
from employees;

# last_name 은 107칸, distinct를 쓴건, 12개. ...> error
# 갯수가 같아도 row가 다르기 때문에 출력 불가.
select last_name 이름, distinct department_id 부서 from employees;    // error!

select last_name 이름, salary 연봉, department_id 부서
from employees
where department_id != 90;

select last_name 이름, salary 연봉, department_id 부서
from employees
where salary >= 10000;

select last_name 이름, salary 연봉, department_id 부서
from employees
where last_name = 'King';

select last_name 이름, salary 연봉
from employees
where salary >= 100

select last_name 이름, salary 연봉
from employees
where salary between 10000 and 15000;

select last_name 이름, department_id 부서
from employees
where department_id = 90 or department_id =100 or department_id = 80

select last_name 이름, department_id 부서
from employees
where department_id in (80, 90, 100);

select last_name 이름, job_id 업무
from employees
where last_name like 'King'

select last_name 이름, job_id 업무
from employees
where last_name like '__k%'

select last_name 이름, job_id 업무
from employees
where last_name like '%k%'

select last_name 이름, job_id 업무
from employees
where last_name like '___'

# _A가 들어가는거 찾고 싶을땐,
select last_name 이름, job_id 업무
from employees
where job_id like '%\_A%' escape '\';

select last_name 이름, commission_pct 인센티브
from employees
where commission_pct is null;

select last_name 이름, commission_pct 인센티브
from employees
where commission_pct is not null;

select last_name 이름, salary 연봉
from employees
where not (salary >= 10000 and salary <= 15000);

select last_name 이름, salary 연봉
from employees
where not salary >= 10000 and salary <= 15000;

select last_name 이름, department_id 부서
from employees
where not department_id = 90 or department_id = 100;

select last_name 이름, department_id 부서
from employees
where department_id not in (90, 100);

select last_name 이름, salary 연봉
from employees
order by salary desc;

#날짜도 정렬 가능.
select last_name 이름, department_id 부서, salary 연봉
from employees
where department_id = 50
order by salary desc;

#이중 정렬은?
select last_name 이름, salary 연봉, hire_date 입사일
from employees
order by salary desc, hire_date;

#order by에만 alias 사용 가능!
select last_name 이름, salary 연봉, hire_date 입사일
from employees
order by 연봉 desc, 입사일;

define num = 100
select employee_id 사번, last_name 이름, salary 연봉
from employees
where employee_id = &num;
// undefine은 따로 동작 시켜줘야함.
undefine num;

define str = 'Hello World!!!'
select lower('&str')
select upper('&str')
from dual;
select initcap('&str') from dual;      // 맨 앞에만 대문자
select concat ('&str', '!!') from dual;
select substr('&str', 1, 2) from dual;   // 첫번째부터 2개 가져와라.
select substr('&str', -4, 2) from dual;   // 뒤부터 2개 가져와라
                                         // index는 역방향, but 가져오는건 정방향
select instr('&str', 'o') 위치 from dual; 
select instr('&str', 'o', 1, 2) 위치 from dual; //두번째 값을 달라.
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
////////////// 연습 문제 //////////////
2-1)
    1. 맞음
    2. 맞음
    3. 콤마, "annual salary", salary, 연산자 x아니고 *
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
