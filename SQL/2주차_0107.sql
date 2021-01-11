** 문제 1 **
select e.last_name 이름, d.department_name 부서명, l.city 도시
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id
and e.job_id = (select job_id from employees where last_name='Russell')
and e.last_name != 'Russell'
order by employee_id;

** 문제 2 **
select e.employee_id 사번, e.last_name 이름
from employees e
where e.department_id =
(select d.department_id
from departments d, locations l
where d.location_id = l.location_id and l.city = 'Toronto')

** 문제 3 **
select a.last_name 이름, a.salary 급여
from (select last_name, salary from employees) a, salgrade s
where a.salary >= s.losal and a.salary < hisal and s.grade = 4;

** 문제 4 **
select last_name 이름, department_id 부서
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

** 문제 5 **
select o.last_name 이름, o.salary 연봉, o.hire_date 입사일, o.department_id 부서
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

** 문제 6 **
select e.employee_id 사번, e.last_name 이름, e.department_id 부서, e.salary 연봉, sum(m.salary) 누적연봉
from (select employee_id, last_name, department_id, salary from employees where department_id=50) e, 
(select employee_id, last_name, department_id, salary from employees where department_id=50) m
where e.employee_id >= m.employee_id
group by e.employee_id, e.last_name, e.department_id, e.salary
order by e.employee_id;

OR

select employee_id 사번, last_name 이름, department_id 부서, salary 연봉, sum(salary) over(order by employee_id) 누적연봉
from employees
where department_id = 50

///// 해설 /////
select e.employee_id 사번, e.last_name 이름, e.department_id 부서, e.salary 연봉, e.salary+m.salary 누적연봉
from employees e, employees m
where e.department_id = 50
group by e.employee_id, e.last_name, e.department_id, e.salary        // 꼼수를 쓴것! 그냥 sum 쓰기 위해! 그룹짓는건 아님, 처음에 imployee_id로 해서, 전체 사람만큼 계산을 하게 된다.
order by e.employee_id;


*** UNION... 등등 쓸때는, ORDER BY는 마지막에 한번만 씀! **********************


<<<<<<<<< system 계정으로 작업하여 계정 새로 생성하기 >>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from all_users;
select * from tabs;

DQL Query           select
DML                 insert update delete
DDL                 create alter drop
TCL Transaction     commit rollback savepoint
DCL          grant revoke

// session : 로그인할 권한, table 만들면, tablespace가 주어짐. 사용공간을 지정해준것! (alter문 1), 용량 무제한으로 수정(alter문 2)
create user mc identified by mc;
grant create session to mc;
grant create table, create view, create sequence, create trigger to mc;
alter user mc default tablespace users;
alter user mc quota unlimited on users;


<<<<<<<<<< MC 계정으로 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from all_users;
select * from tabs;

<<<<<<<<<< HR 계정으로 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UNION / UNION first 합집합. 중목은 하나로
UNION all           합집합. 중복은 두개로
MINUS               차집합.
INTERSECT           교집합.

select last_name 이름, salary 연봉, hire_date 입사일 from employees
where salary <= 7000
UNION
select last_name 이름, salary 연봉, hire_date 입사일 from employees
where hire_date >= '07/01/01';

A 63  B 30      A UNION B 69

select last_name 이름, salary 연봉, hire_date 입사일 from employees
where salary <= 7000
UNION all
select last_name 이름, salary 연봉, hire_date 입사일 from employees
where hire_date >= '07/01/01';

A 63  B 30      A UNION all B 93

select last_name 이름, salary 연봉, hire_date 입사일 from employees
where salary <= 7000
INTERSECT
select last_name 이름, salary 연봉, hire_date 입사일 from employees
where hire_date >= '07/01/01';

A 63  B 30      A intersect B 24

select last_name 이름, salary 연봉, hire_date 입사일 from employees
where salary <= 7000
MINUS
select last_name 이름, salary 연봉, hire_date 입사일 from employees
where hire_date >= '07/01/01';

A 63  B 30      A - B 24


select last_name 이름, salary 연봉, hire_date 입사일 from employees
where hire_date >= '07/01/01'
MINUS
select last_name 이름, salary 연봉, hire_date 입사일 from employees
where ;
A 63  B 30      B - A 6

select last_name 이름, salary 연봉, hire_date 입사일 from employees
where salary <= 7000
union
select last_name 이름, salary 연봉, hire_date 입사일 from employees
where hire_date >= '07/01/01'
order by 연봉 desc
