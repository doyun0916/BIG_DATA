<<<<<<<<<<<<< mc 계정 >>>>>>>>>>>>>>>>>>>>>
set serveroutput on;
copy from HR/hr@localhost:1521:xe create employees using select * from employees;

<<중첩블럭>>
declare
begin
    declare
    begin
    end;
exception                                    -- 예외블록에는 중첩 불가!
end;
/

declare
    v_name varchar2(20) := '홍길동';
    v_age number(3) := 20;
begin
    dbms_output.put_line('외부 블럭');
    dbms_output.put_line('outer v_name: ' || v_name);
    dbms_output.put_line('outer v_age: ' || v_age);
    begin
     dbms_output.put_line('내부 블럭');
    end;
end;
/

declare
    v_name varchar2(20) := '홍길동';
    v_age number(3) := 20;
begin
    dbms_output.put_line('외부 블럭');
    dbms_output.put_line('outer v_name: ' || v_name);
    dbms_output.put_line('outer v_age: ' || v_age);
    declare
        v_name varchar2(20) := '이순신';
        v_tel varchar(30) := '1111-2222';
    begin
        dbms_output.put_line('내부 블럭');
        dbms_output.put_line('inner v_name: ' || v_name);
        dbms_output.put_line('inner v_age: ' || v_age);
        dbms_output.put_line('inner v_tel: ' || v_tel);
    end;
    
    dbms_output.put_line('외부 블럭');
 --   dbms_output.put_line('outer v_tel: ' || v_tel);        // 내부 블럭 변수 외부에서 사용 불가!
        
end;
/

<블럭 레이블>
begin <<first>>
declare
    v_name varchar2(30) := '홍길동';
begin
    begin <<second>>
    declare
        v_name varchar2(30) := '김유신';
    begin
        begin <<third>>
        declare v_name varchar2(30) := '이순신';
        begin
            dbms_output.put_line('inner v_name: ' || v_name);
            dbms_output.put_line('inner second.v_name: ' || second.v_name);
            dbms_output.put_line('inner first.v_name: ' || first.v_name);
            dbms_output.put_line('inner third.v_name: ' || third.v_name);
        end;
        end third;
    end;                                         -- begin으로 크게 declare, begin, end 를 통채로 묶어줘야함 레이블링은!
    end second;
end;
end first;
/

< PLSQL SELECT>
select * from employees;
alter table employees drop column email;
alter table employees drop column phone_number;
alter table employees drop column commission_pct;
alter table employees drop column manager_id;

copy from HR/hr@localhost:1521:xe create departments using select * from departments;
copy from HR/hr@localhost:1521:xe create jobs using select * from jobs;

declare
    v_lname employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
    v_sum employees.salary%TYPE;
begin
    select last_name, salary
    into v_lname, v_salary
    from employees where employee_id = 200;
    dbms_output.put_line('last name: ' || v_lname);
    dbms_output.put_line('salary: ' || v_salary);
    
    select sum(salary) into v_sum from employees;
    dbms_output.put_line('sum: ' || v_sum);
    -- v_sum := sum(v_salary);                   -- PLSQL 안에서 그룹함수 쓰는건 노노!
end;
/

declare
    v_lname employees.last_name%TYPE;
    v_dename departments.department_name%TYPE;
    v_jtitle jobs.job_title%TYPE;
begin
    select e.last_name, d.department_name, j.job_title
    into v_lname, v_dename, v_jtitle
    from employees e, departments d, jobs j
    where e.department_id = d.department_id
    and e.job_id = j.job_id
    and e.employee_id = 200;
end;
/

< PLSQL DML>
SELECT COUNT(*) from employees;

begin
    insert into employees values(300, '길동', '홍', sysdate, 'IT_PROG', 5000, 60);
    insert into employees values(301, '순신', '이', sysdate, 'IT_PROG', 4000, 60);
    insert into employees values(302, '유신', '김', sysdate, 'IT_PROG', 3000, 60);
    -- dbms_output.put_line('작업성공 : ' || SQL%FOUND);         -- 조건문 반복문에서 사용
    dbms_output.put_line('행수 : ' || SQL%ROWCOUNT);        -- 가장 최근에 작업한 것에서 변경된 것! 그러므로 1 나옴! 누적 아님!
end;
/

select * from employees;

declare
    v_up number(4, 2) := 1.1;
begin
    update employees set salary = salary * v_up where department_id = 60;
end;
/

<<<<<< 제어문 >>>>>>>>>>
<< 조건 >>
<IF>
if 조건 then 실행문;       -- 참 실행문
end if;                   -- 거짓 다음 실행문 실행

declare
    v_salary employees.salary%TYPE;
    v_avg employees.salary%TYPE;
begin
    select salary into v_salary from employees where employee_id = 200;
    select avg(salary) into v_avg from employees;
    if v_salary > v_avg
        then dbms_output.put_line('상위권');
    else
        dbms_output.put_line('하위권');
    end if;
    dbms_output.put_line('프로그램 끝');
end;
/

if 조건 then 실행문1;
else 실행문2
end if;

declare
    v_dname departments.department_name%TYPE;
begin
    select department_name into v_dname from employees e, departments d 
    where e.department_id = d.department_id and employee_id=200;
    if v_dname = 'IT_Support'
        then dbms_output.put_line('IT부서');
    else
        dbms_output.put_line('타부서');
    end if;
end;
/

IF 조건1 then 실행문1;     -- 참 실행문 1
elsif 조건2 then 실행문2;   -- 참 실행문 2 생략가능
else 실행문3;              -- 거짓 실행문 3 나머지의 의미. 생략가능
end if;

declare v_hdate date default sysdate;
begin
    select hire_date into v_hdate from employees where employee_id = 200;
    if v_hdate < '2000/01/01'
        then dbms_output.put_line('이사');
    elsif v_hdate < '2003/01/01'
        then dbms_output.put_line('부장');
    elsif v_hdate < '2007/01/01'
        then dbms_output.put_line('과장');
    else
        dbms_output.put_line('사원');
    end if;
end;
/

declare
    v_sal employees.salary%TYPE;
begin
    select employees.salary into v_sal from employees where employees.employee_id = 200;
    if v_sal > 20000
        then dbms_output.put_line('이사');
    elsif v_sal > 15000
        then dbms_output.put_line('부장');
    elsif v_sal > 10000
        then dbms_output.put_line('과장');
    elsif v_sal > 5000
        then dbms_output.put_line('대리');
    else
        dbms_output.put_line('사원');
    end if;
end;
/

<< PLSQL CASE>>   -- 실행문 실행
declare
    v_sal employees.salary%TYPE;
begin
    select employees.salary into v_sal from employees where employees.employee_id = 200;
    case
        when v_sal >= 20000 then dbms_output.put_line('이사');
        when v_sal >= 15000 then dbms_output.put_line('부장');
        when v_sal >= 10000 then dbms_output.put_line('과장');
        when v_sal >= 5000 then dbms_output.put_line('대리');
        else dbms_output.put_line('사원');
    end case;
end;
/

<< SQL CASE>>    -- 값 반환! 안에 PL/SQL 함수 삽입 불가.
declare
    v_sal employees.salary%TYPE;
begin
    select employees.salary into v_sal from employees where employees.employee_id = 200;
    v_rank := case
        when v_sal >= 20000 and v_salary <= 30000 then '이사'
        when v_sal >= 15000 then '부장'
        when v_sal >= 10000 then '과장'
        when v_sal >= 5000 then '대리'
        else '사원'
    end;
    dbms_output.put_line('직급: ' || v_rank);
end;
/