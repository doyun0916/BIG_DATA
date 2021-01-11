*** 문제 1 ***
select e.first_name || ' ' || e.last_name 이름, e.department_id 부서, d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;

*** 문제 2 ***
select e.last_name 이름, e.commission_pct 인센티브, d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id and e.commission_pct is not null
order by e.commission_pct desc, e.employee_id desc;

*** 문제 3 ***
select e.last_name 이름, d.department_name 부서명, l.city 도시
from employees e
left outer join departments d
on e.department_id = d.department_id
left outer join locations l
on d.location_id = l.location_id
order by e.employee_id;

*** 문제 4 ***
select e.last_name 이름, j.job_title 업무, e.salary 급여, s.grade 등급
from employees e, jobs j, salgrade s
where e.job_id = j.job_id and e.salary >= s.losal(+) and e.salary < s.hisal(+)
order by e.employee_id, 등급 desc;

*** 문제 5 ***
select e.last_name 자신, e.department_id 부서번호, r.last_name 동료
from employees e, employees r
where e.last_name = 'Abel' and e.department_id = r.department_id and not r.last_name = 'Abel'
order by 동료;

<<< subquery >>>   안에 있는게 먼저 실행 됨.
내부쿼리 - 외부쿼리
서브쿼리 - 메인쿼리
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<single-row subquery>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select department_name 
from departments 
where department_id = ( select department_id 
                        from employees 
                        where employee_id=110);

<multi-column subquery>
select department_name from departments where department_id =
(select department_id from employees where employee_id = 100)     --------> 결과 값은 1개로 나와야함!!! '=' 비교를 위해

select last_name 이름, salary 연봉, avg(salary) over() 평균연봉 from employees;
select last_name 이름, salary 연봉, (select avg(salary) from employees ) 평균연봉 from employees;

이름 연봉 평균연봉 출력 연봉이 2500 이하인 사람들 출력 (11명)
select last_name 이름, salary 연봉, (select avg(salary) from employees) 평균연봉
from employees
where employees.salary <= 2500;

100번 부서 직원들의 이름 연봉 최고 연봉 최저연봉 연봉-평균연봉 출력 (6명)
select * from departments;
select last_name 이름, salary 연봉, (select max(salary) from employees where employees.department_id=100) 최고연봉, 
(select min(salary) from employees where employees.department_id=100) 최저연봉,
trunc(salary-(select avg(salary) from employees where employees.department_id=100)) 연봉차
from employees
where employees.department_id=100;

> < >= <= = !=
select last_name 이름, salary 연봉
from employees
where salary >= ( select avg(salary) from employees);

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Multi-row subquery>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

select department_name from departments where department_id =
( select department_id from employees where last_name = 'Seo')   // 단일 행

select department_name from departments where department_id =
( select department_id from employees where last_name = 'King')   // multi row    (error)

select department_name from departments where department_id in
(select department_id from employees where last_name = 'King');   // multi row     (correct)

in 결과중 하나라도 일치하면 참
any, some 결과와 하나 이상 일치하면 참
all 결과와 모든 값이 일치하면 참
exists 결과 중에서 값이 있으면 참 메인쿼리 수행
        없으면 거짓으로 메인쿼리 수행 안함
        
select last_name 이름, salary 연봉 
from employees
where salary < any(select min_salary from jobs where job_id = 'IT_PROG')        // 여기같은 경우 단일행이라서 부등호 가능! <= (selec...)

select last_name 이름, salary 연봉 
from employees
where salary < any (select salary from employees where job_id = 'IT_PROG')      // 다중 행중, 하나라도 작은거 나오도록!

select last_name 이름, salary 연봉 
from employees
where salary < all (select salary from employees where job_id = 'IT_PROG')      // 다중 행에 있는 것중, 전체 다 만족하게 작은것 나오도록

////// all 은 등호 x ///////////////
select last_name 이름, salary 연봉
from employees
where salary = any (select salary from employees where job_id = 'IT_PROG')      // 가능

select last_name 이름, salary 연봉
from employees
where salary = all (select salary from employees where job_id = 'IT_PROG')      // 불가능 만족하는 아이가 있을 수 없음!

select last_name 이름, salary 연봉 from employees
where salaey < any (select salary, department_id from employees where job_id = 'IT_PROG')  // multi-column이라 오류!

select last_name 이름, salary 연봉, job_id 업무
from employees where exists (select job_id from jobs where job_title = 'Programmer')                    ********exists에서, SubQuery가 돌려주는 건 true, false 다!!!!!!!!
 ****** exists 는 외부 쿼리 실행 여부 판별하기 위해 사용!

last_name이 russell인 사람의 급여보다 많은 급여를 받는 사람의 이름과 연봉 출력
select last_name, salary
from employees
where employees.salary > all (select salary from employees where employees.last_name='Russell')
order by salary desc;

last_name이 russell인 사람의 급여보다 많은 급여를 받는 사람의 이름과 연봉 출력
select last_name, salary
from employees
where employees.salary > any (select salary from employees where employees.last_name='King')
order by salary desc;

********** 문제 4 ************************
select e.employee_id, e.last_name, e.hire_date
from employees e
where e.department_id = (select d.department_id from employees d where d.employee_id = 201)
and e.hire_date < (select j.end_date from job_history j where j.employee_id = 201)
and not e.employee_id = 201;

각 부서에서 가장 오래 근무한 사람 중 연봉이 제일 적은 사람을 진급시켜려고 한다.
해당 직원의 이름과 연봉, 입사일, 부서를 출력한다.

select o.last_name 이름, o.salary 연봉, o.hire_date 입사일, o.department_id 부서
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






select o.last_name 이름, o.salary 연봉, o.hire_date 입사일, o.department_id 부서
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


