select employee_id 사번, last_name 이름, hire_date 입사일,
trunc(months_between(sysdate, hire_date)/12) 근속연수,
trunc(mod(months_between(sysdate, hire_date), 12)) 근속월수,
trunc(sysdate - add_months(hire_date, months_between(sysdate, hire_date))) 근속일수
from employees
order by 근속연수 desc, 근속월수 desc, 근속일수 desc;

// 두개 자료형 맞춰줘야함
select last_name 이름, nvl(to_char(department_id), '신입') 부서
from employees;

CASE (WHEN~ THEN) ELSE ~ END
select last_name 이름, department_id 부서,
case when department_id = 90 then '비서실'
    when department_id = 100 then '인사부'
    when department_id = 50 then '생산부'
    else '영업부'
end 부서명
from employees;

select employee_id 사번, last_name 이름, trunc(months_between(sysdate, hire_date)/12)+1 "근속연수",
case when trunc(months_between(sysdate, hire_date)/12) >= 18+1 then '이사'
    when trunc(months_between(sysdate, hire_date)/12) >= 15+1 then '부장'
    when trunc(months_between(sysdate, hire_date)/12) >= 12+1 then '과장'
    when trunc(months_between(sysdate, hire_date)/12) >= 9+1 then '대리'
else '사원' end "직급"
from employees
order by 근속연수 desc;

select last_name 이름, job_id 업무, 
decode(job_id, 'IT_PROG', '프로그래머', 'SA_MAN', '세일즈매니저', 'ST_MAN', '재고관리', '판매') 업무명
from employees;

select avg(salary) 평균, sum(salary) 합, max(salary) 최고, min(salary) 최저, stddev(salary) 편차 
from employees
where department_id = 50;

select count(last_name) from employees;
select count(department_id) from employees;
select count(*) from employees;

// 아래 두개는 다른 의미.
select count(distinct department_id) from employees;
select distinct department_id from employees;

// 그룹함수는 기본적으로 null값을 무시함.

select department_id 부서, avg(salary) 연봉
from employees
group by department_id;

select department_id 부서, job_id 업무, avg(salary) 평균연봉
from employees
group by department_id, job_id
order by department_id;

// group 짓기 전에 먼저 골라내는것 (where절)!
select department_id 부서, job_id 업무, avg(salary) 평균연봉
from employees
where salary <= 10000
group by department_id, job_id
order by department_id;

// group by에서, 순서가 바뀌면 값이 바뀐다! (출력은 상관 없음.)
select department_id 부서, job_id 업무, avg(salary) 평균연봉
from employees
group by job_id, department_id
order by job_id;
select job_id 업무, department_id 부서, avg(salary) 평균연봉
from employees
group by job_id, department_id
order by job_id;

select department_id 부서, trunc(avg(salary), 2)
from employees
where salary >= 8000
group by department_id;

// group 짓고 후에 적용하는것 (having 절)!
select department_id 부서, trunc(avg(salary), 2)
from employees
group by department_id

select department_id 부서, trunc(avg(salary), 2)
from employees
group by department_id
having avg(salary) <= 8000;

// 부서인원이 2명 이상인 부서의 부서번호와 평균연봉 출력
select department_id 부서번호, trunc(avg(salary), 2) 평균연봉
from employees
group by department_id
having count(department_id)>=2          // having count(*)>=2

// where 절에 group function 불가.

<분석함수>
select last_name 이름, avg(salary) from employees;  // 열 개수 불일치로 실행 x
select last_name 이름, avg(salary) over() from employees; // avg연산을 행마다 계속함.

select last_name 이름, avg(salary) over(order by salary) from employees; // 처음부터 내꺼까지만 계산...

// 첫번째 row 부터 자기까지 첫번째 값을 가지고 최저 연봉을 출력해주는것. last_value 해보면 암.
select last_name 이름, salary 연봉, first_value(salary) over(order by salary) 최저연봉
from employees;

select last_name 이름, salary 연봉, last_value(salary) over(order by salary) 내연봉
from employees;

// windowing = 범위를 지정해주는 것.
select last_name 이름, salary 연봉, first_value(salary) over(order by salary rows 3 preceding) 최저연봉     // 위의 3줄하고 자기까지 해서 계산.
from employees;

// following은, 꼭 preceding이 있어야함.
select last_name 이름, salary 연봉, last_value(salary) over(order by salary rows between 3 preceding and 2 following)  // 위의 3줄하고 자기, 뒤에 2개까지 해서 계산.
from employees;

select last_name 이름, salary 연봉, count(*) over() 인원수
from employees;

// 인원수 예제.
select last_name 이름, salary 연봉, count(*) over() 누적인원수
from employees;
select last_name 이름, salary 연봉, count(*) over(order by salary desc) 누적인원수
from employees;

select last_name 이름, salary 연봉, row_number() over(order by salary desc), rank() over(order by salary desc), dense_rank() over(order by salary desc) from employees;

/////////////////////정리////////////////////////////////////
// 최저, 최고, widowing을 하여 구함.
first_value() over()
last_value() over()

// 계산.
count() over()
sum() over()
avg() over()

// 순서 매김.
row_number over()
rank() over()
dense_rank() over()
/////////////////////////////정리///////////////////////////////////

<group by 확장>
group by (a, b, c)                    // (a, b, c)
group by rollup(a, b, c)           // (a, b, c) (a, b) (a) () -> 차츰 오른쪽꺼 없애면서 추가로 보여줌.
group by cube(a, b, c)           // (a, b, c) (a, b) (a, c) (b, c) (a) (b) (c) ()
group by grouping sets(a, b, c)           // cube에서 필요한 것만 골라서 사용가능.

select department_id 부서, job_id 업무, avg(salary) from employees
group by department_id, job_id
order by department_id;

/// (department_id, job_id)  (department_id) --> 업무가 null인 것들  ()  --> 부서, 업무가 전체 다 null인 것들(전체 평균).
select department_id 부서, job_id 업무, avg(salary)
from employees
group by rollup (department_id, job_id)
order by department_id;

select department_id 부서, job_id 업무, avg(salary)
from employees
group by cube (department_id, job_id)
order by department_id;

select department_id 부서, job_id 업무, avg(salary)
from employees
group by grouping sets( (department_id, job_id), (job_id), ())
order by department_id;

수당은 근속연수당 1000씩 더하고 연수가 갈수록 수당이 높다.
단 1년이 안 된 근무 개월 수를 계산해서, 3개월 당 추가로 250씩 더한다.
예) 2개월 250
6개월 500
8개월 750
10개월 1000

select last_name 이름,
case when trunc(mod(months_between(sysdate, hire_date), 12)) < 3 then 250+trunc(months_between(sysdate, hire_date)/12)*1000
    when trunc(mod(months_between(sysdate, hire_date), 12)) >= 3 and trunc(mod(months_between(sysdate, hire_date), 12)) < 6 then 500+trunc(months_between(sysdate, hire_date)/12)*1000
    when trunc(mod(months_between(sysdate, hire_date), 12)) >= 7 and trunc(mod(months_between(sysdate, hire_date), 12)) < 9 then 750+trunc(months_between(sysdate, hire_date)/12)*1000
else 1000
end 수당
from employees
order by 수당 desc;


// Join 종류: natural join(=equijoin, =equaljoin), self-join, nonequijoin
