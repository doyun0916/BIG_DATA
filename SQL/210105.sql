select last_name 이름, salary 연봉, hire_date 입사일,
( trunc( months_between( sysdate, hire_date ) / 12 ) * 1000 ) +
case
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) = 0 then 0
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 3 then 250
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 6 then 500
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 9 then 750
    when trunc( mod( months_between( sysdate, hire_date ), 12 ) ) <= 11 then 1000
end 수당
from employees
order by 수당 desc;

<<< 조인 >>>
Inner Join
Outer Join

select department_id from employees where employee_id = 110;
select department_name from departments where department_id = 100;

< cross join >

< equi join > Inner Join
select employees.last_name 이름, departments.department_name 부서명
from employees
join departments
on employees.department_id = departments.department_id
where employees.employee_id = 110;

select employees.last_name 이름, departments.department_name 부서명
from employees, departments
where employees.department_id = departments.department_id
and employees.employee_id = 110;

select e.last_name 이름, d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 110;

select e.last_name 이름, d.department_name 부서명
from employees e
join departments d
on e.department_id = d.department_id
where e.employee_id = 110;

사번이 120번인 사람의 
사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
join~on, where 로 조인하는 두 가지 방법 모두.

select e.employee_id 사번, e.last_name 이름, e.job_id 업무, j.job_title 업무명
from employees e
join jobs j
on e.job_id = j.job_id
and e.employee_id = 120;

select e.employee_id 사번, e.last_name 이름, e.job_id 업무, j.job_title 업무명
from employees e, jobs j
where e.job_id = j.job_id
and e.employee_id = 120;

세 테이블 조인
join~on where
select e.employee_id 사번, d.department_name 부서명, j.job_title 업무명
from employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id

select e.employee_id 사번, d.department_name 부서명, j.job_title 업무명
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

2005년 상반기에 입사한 직원의 
사번, 이름, 입사일, 
부서명(department_name), 업무명(job_title)을 출력
select e.employee_id 사번, e.last_name 이름, e.hire_date 입사일, d.department_name 부서명, j.job_title 업무명
from employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id
where hire_date between '05/01/01' and '05/06/30';

select e.employee_id 사번, e.last_name 이름, e.hire_date 입사일, d.department_name 부서명, j.job_title 업무명
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

select e.last_name 이름, e.salary 연봉, s.grade 연봉등급
from employees e, salgrade s
where e.salary >= s.losal and e.salary < s.hisal
order by 연봉등급 desc;

select e.last_name 이름, e.salary 연봉, s.grade 연봉등급
from employees e
join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by 연봉등급 desc;

select e.last_name 이름, d.department_name 부서명, s.grade 연봉등급
from employees e, departments d, salgrade s
where e.department_id = d.department_id
and e.salary >= s.losal and e.salary < s.hisal
order by 연봉등급 desc;

select e.last_name 이름, d.department_name 부서명, s.grade 연봉등급
from employees e
join departments d
on e.department_id = d.department_id
join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by 연봉등급 desc;

< self join > Inner Join
select * from employees;

select e.employee_id 사번, e.last_name 이름, e.manager_id 부서장, m.employee_id 부서장사번, m.last_name 부서장이름
from employees e, employees m
where e.manager_id = m.employee_id 
order by e.employee_id;

select e.employee_id 사번, e.last_name 이름, e.manager_id 부서장, m.employee_id 부서장사번, m.last_name 부서장이름
from employees e
join employees m
on e.manager_id = m.employee_id
order by e.employee_id;

< equi join > Outer Join
select e.employee_id 사번, e.last_name 이름, e.department_id 부서, d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id(+)
order by 사번;

select e.employee_id 사번, e.last_name 이름, e.department_id 부서, d.department_name 부서명
from employees e
left outer join departments d
on e.department_id = d.department_id
order by 사번;

select * from employees;
select count(distinct department_id) from employees;
select count(*) from departments;
select * from departments;

< nonequi join > Outer Join
select * from salgrade;
update salgrade set losal = 2500 where grade = 1;
commit;

select e.employee_id 사번, e.last_name 이름, e.salary 연봉, s.grade
from employees e, salgrade s
where e.salary >= s.losal and e.salary < s.hisal
order by e.employee_id;

select e.employee_id 사번, e.last_name 이름, e.salary 연봉, s.grade
from employees e, salgrade s
where e.salary >= s.losal(+) and e.salary < s.hisal(+)
order by e.employee_id;

select e.employee_id 사번, e.last_name 이름, e.salary 연봉, s.grade
from employees e
left outer join salgrade s
on e.salary >= s.losal and e.salary < s.hisal
order by e.employee_id;

< self join > Outer Join
select e.employee_id 사번, e.last_name 이름, e.manager_id 부서장, m.employee_id 부서장사번, m.last_name 부서장이름
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

select e.employee_id 사번, e.last_name 이름, e.manager_id 부서장, m.employee_id 부서장사번, m.last_name 부서장이름
from employees e
left outer join employees m
on e.manager_id = m.employee_id
order by e.employee_id;

< FULL OUTER JOIN >
select e.employee_id 사번, e.last_name 이름, e.department_id 부서, d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id(+)
UNION
select e.employee_id 사번, e.last_name 이름, e.department_id 부서, d.department_name 부서명
from employees e, departments d
where e.department_id(+) = d.department_id 

select e.employee_id 사번, e.last_name 이름, e.department_id 부서, d.department_name 부서명
from employees e
full outer join departments d
on e.department_id = d.department_id
order by e.employee_id;







