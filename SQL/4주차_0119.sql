<<조합 데이터 유형>>
<<컬렉션>>
<연관배열>

select * from employees;
-- 스칼라 --
declare
    type lname_table_type is table of employees.last_name%TYPE
        index by PLS_INTEGER;
    t_lname lname_table_type;
begin
    t_lname(1) := '홍길동';
    if t_lname.exists(1) then
        dbms_output.put_line(t_lname(1));
    end if;
    
    t_lname(3) := '김유신';
    t_lname(4) := '이순신';
    t_lname(7) := '대조영';
    
    for i in 1..t_lname.last() loop
        if t_lname.exists(i) then
            dbms_output.put_line(i || ' : ' || t_lname(i));
        else
            dbms_output.put_line(i || ' : 비어있음');
        end if;
    end loop;

--    for i in 100..206 loop
--        select last_name into t_lname(i) from employees wherer employee_id = 1
end;
/

select * from employees;
-- 레코드 --
declare
    type employee_table_type is table of employees%ROWTYPE
        index by PLS_INTEGER;
    v_employee employee_table_type;
    v_max number;
    v_min number;
begin
    select min(employee_id) into v_min from employees;
    select max(employee_id) into v_max from employees;
    for i in v_min..v_max loop
        select * into v_employee(i) from employees where employee_id = i;
    end loop;
    for i in v_min..v_max loop
        if v_employee.exists(i) then
            dbms_output.put_line(v_employee(i).employee_id || ' ' || v_employee(i).last_name || ' ' || v_employee(i).salary);
        else
            dbms_output.put_line('비어있음');
        end if;
    end loop;
end;
/

declare
    type r_employee is record(v_eid employees.employee_id%TYPE, v_fname employees.first_name%type, v_lname employees.last_name%type);
    type employee_table_type is table of r_employee
        index by PLS_INTEGER;
    v_employee employee_table_type;
    v_max number;
    v_min number;
begin
    select min(employee_id) into v_min from employees;
    select max(employee_id) into v_max from employees;
    for i in v_min..v_max loop
        select employee_id, first_name, last_name into v_employee(i) from employees where employee_id = i;
    end loop;
    for i in v_employee.first..v_employee.last loop
        if v_employee.exists(i) then
            dbms_output.put_line(v_employee(i).v_eid || ' ' || v_employee(i).v_fname || ' ' || v_employee(i).v_lname);
        else
            dbms_output.put_line('비어있음');
        end if;
    end loop;
end;
/

<중첩 테이블>
-- 연관 배열         프로그램에 맞게 생성
-- 중첩테이블        테이블 스키마에 맞게 생성. 데이터베이스에 저장이 가능하다. index가 없다.
declare
    type t_employee is table of employees.last_name%type;
    v_emp t_employee;
begin
    v_emp := t_employee('홍길동', '이순신', '김유신', '대조영');
    for i in 1..v_emp.count loop
        dbms_output.put_line(v_emp(i));
    end loop;
end;
/

<VARRAY>
-- 연관배열 인덱스를 지정해야 한다.
-- VARRAY 길이를 제한한다. 다른 언어의 배열과 비슷하다.

declare
    type t_employee is varray(100) of employees.last_name%type;
    v_emp t_employee;
    v_eid number := 100;
begin
    v_emp := t_employee('hong', 'lee', 'kim', 'dae');
    for i in 1..v_emp.count loop
        dbms_output.put_line(v_emp(i));
    end loop;
end;
/

<<< 명시적 커서 >>>
< 커서 >
declare
    cursor c_emp_cursor is
        select employee_id, last_name, salary from employees where department_id = 30;
    v_eid employees.employee_id%type;
    v_lname employees.last_name%type;
    v_salary employees.salary%type;
begin
    open c_emp_cursor;
    loop
        fetch c_emp_cursor into v_eid, v_lname, v_salary;
        exit when c_emp_cursor%NOTFOUND;
        dbms_output.put_line(v_eid || ' ' || v_lname || ' ' || v_salary);       
    end loop;
    close c_emp_cursor;
    
    open c_emp;
    loop
        fetch c_emp into v_emp;
        exit when c_emp%NOTFOUND;
        dbms_output.put_line(v_emp.employee_id || ' ' || v_emp.last_name || ' ' || v_emp.salary);
    end loop;
    close c_emp;
end;
/    
        
begin
    for c in (select employee_id, last_name, salary from employees where department_id = 30);
        loop
        dbms_output.put_line(c.employee_id || ' ' || c.last_name || ' ' || c.salary);
        end loop;
    end for;
end;
/
        
<< 파라미터 커서 >>
declare
    cursor c_emp_cursor is
    
        
        
        
        