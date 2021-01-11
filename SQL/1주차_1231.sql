define num = 1234.5678
select round('&num') from dual;
select round('&num', 0) from dual;
select round('&num', 2) from dual;
select round('&num', -1) from dual;

select last_name 이름, salary 연봉, round(salary/12, 2) 월급
from employees;

# 버려라!
select trunc('&num') from dual;
select trunc('&num', 0) from dual;
select trunc('&num', 2) from dual;
select trunc('&num', -1) from dual;

select last_name 이름, salary 연봉, trunc((salary+salary*commission_pct)/12, 2) 월급
from employees
where commission_pct is not null;

select ceil(3.12) from dual;
select floor(3.12) from dual;
select mod(5, 2) from dual;

undefine num;

// 내 컴퓨터 시간을 가져옴.
select sysdate from dual;

select last_name 이름, hire_date 입사일, trunc(sysdate - hire_date, 0) 근무일수
from employees;

select sysdate - to_date('95/12/20') from dual;
select months_between(sysdate, '95/12/20') from dual;
select last_name 이름, hire_date 입사일, months_between(sysdate, hire_date) 근무월수
from employees;

select add_months(sysdate, 24) from dual;

select last_name 이름, hire_date 입사일, add_months(hire_date, 24) 진급일
from employees;

// 그해, 그 달의 마지막 날 출력
select last_day(sysdate) from dual;
select last_day('20/02/01') from dual;
select last_day('21/02/01') from dual;
select last_name 이름, hire_date 입사일, last_day(hire_date) 첫월급
from employees;

select last_name 이름, hire_date 입사일, last_day(add_months(hire_date, 6)) 첫상여금
from employees;

// 다음 화요일이 언제냐~
select next_day(sysdate, 'Tuesday') from dual;
// 다음 수요일이 언제냐~
select next_day(sysdate, 4) from dual;

select round(sysdate, 'MONTH') from dual;
select trunc(sysdate, 'MONTH') from dual;
select round(sysdate, 'YEAR') from dual;
select trunc(sysdate, 'YEAR') from dual;

// <width_bucket>
select width_bucket(75, 0, 100, 10) from dual;
// 0부터 100사이를 10개로 쪼개고, 75는 몇 등급인가?
select width_bucket(100, 0, 100, 10) from dual;
select width_bucket(75, 100, 0, 10) from dual;
// 등급이 작으면 작을수록 높은것!
select width_bucket(sysdate, to_date('73/01/18'), add_months('73/01/18', 1200), 20) from dual;  
// 태어난 날부터 100년을 사는데, 오늘 날짜로부터 나는 몇등급째 살았나!

select employee_id 사번, last_name 이름, salary 연봉, hire_date 입사일,
width_bucket(hire_date, sysdate, to_date('00/01/01'), 30)*1000 수당
from employees
order by 수당 desc;
// 등급이 작으면 작을수록, 높은 것. 오늘 날짜랑 hire_date가 가까우면, 등급이 높음. 그러므로 신입임.

// 숫자, 문자간 변환 & 문자, 날짜간 변환만 가능!
// to_char(), to_number(), to_date()

// 날짜형 요소: YYYY, YEAR(영어 철자로 나옴), MM, MONTH, MON, DY, DAY, DD
select sysdate from dual;
select to_char(sysdate, 'YYYY-MM-DD DY') from dual;
select to_char(sysdate, 'YY-MM-DD DAY') from dual;
select to_char(sysdate, 'YEAR MONTH DD HH:MI:SS') from dual;
select to_char(sysdate, 'YEAR MONTH DD HH24:MI:SSSSS') from dual;
select to_char(sysdate, 'DD') from dual;
select to_char(sysdate, 'YY/MM/DDTH HH24:MI:SS AM DY') from dual; // AM이든 PM이든 상관 없이 알아서 줌.

select to_char(12345.678, '999999') from dual;
select to_char(12345.678, '0999999') from dual;   // 원래 앞에 00있는것을 보여준다. 모든것에 다 00있음.
select to_char(12345.678, '0999999.99') from dual;
select to_char(12345.678, '0,999,999.99') from dual;
select to_char(12345.678, 'L0,999,999.99') from dual;
select to_char(12345.678, '9999.99EEEE') from dual;       // 표기시 . 필수!
select to_char(12345.678, '99999V99') from dual;  // 소수점 맨 뒤로 보내버림
select to_char(12345, '99999.99') from dual;    // 소수점 표현 하도록 만듬.
select to_char(12345, 'B99999.99') from dual;   // 위와 동일.

select last_name 이름, hire_Date 입사일
from employees
where hire_date = to_date('05/07/24');


*************************** 과제 1 *********************************************
select employee_id 사번, last_name 이름, hire_date 입사일,
to_number(to_char(sysdate, 'YY'))-to_number(to_char(hire_date, 'YY')) 근속연수, 
to_number(to_char(sysdate, 'MM'))-to_number(to_char(hire_date, 'MM')) 근속월수,
to_number(to_char(sysdate, 'DD'))-to_number(to_char(hire_date, 'DD')) 근속일수
from employees
order by 근속연수 desc, 근속월수 desc, 근속일수 desc;

select employee_id 사번, last_name 이름, hire_date 입사일,
to_number(to_char(sysdate, 'YY'))-to_number(to_char(hire_date, 'YY')) 근속연수, 
to_number(to_char(sysdate, 'MM'))-to_number(to_char(hire_date, 'MM')) 근속월수,
to_number(to_char(sysdate, 'DD'))-to_number(to_char(hire_date, 'DD')) 근속일수,
sysdate-hire_date a,
(to_number(to_char(sysdate, 'YY'))-to_number(to_char(hire_date, 'YY')))*12*30+ 
to_number(to_char(sysdate, 'MM'))-to_number(to_char(hire_date, 'MM'))*12+
to_number(to_char(sysdate, 'DD'))-to_number(to_char(hire_date, 'DD')) b
from employees
order by 근속연수 desc, 근속월수 desc, 근속일수 desc;

select employee_id 사번, last_name 이름, hire_date 입사일,
to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY')) 근속연수, 
(months_between(sysdate, hire_date)/12 - trunc(to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY'))))*12 근속월수,
((months_between(sysdate, hire_date)/12 - trunc(to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY'))))*12)
-trunc((months_between(sysdate, hire_date)/12 - trunc(to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY'))))*12) 근속일수
from employees
order by 근속연수 desc, 근속월수 desc, 근속일수 desc;

select employee_id 사번, last_name 이름, hire_date 입사일,
(((sysdate-hire_date)/360)*12) 근속연수,
(sysdate-hire_date)/12 근속월수,
sysdate-hire_date 근속일수
from employees
order by 근속연수 desc, 근속월수 desc, 근속일수 desc;

select last_day('16/02/01') from dual;

select to_char(sysdate, 'YEAR MONTH DD HH:MI:SS') from dual;
select to_char(sysdate, 'YYYY MM DD HH24:MI:SSSSS') from dual;
