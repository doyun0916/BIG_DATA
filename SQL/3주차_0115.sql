<<<<<<<<<<<<< mc ���� >>>>>>>>>>>>>>>>>>>>>
set serveroutput on;
copy from HR/hr@localhost:1521:xe create employees using select * from employees;

<<��ø��>>
declare
begin
    declare
    begin
    end;
exception                                    -- ���ܺ�Ͽ��� ��ø �Ұ�!
end;
/

declare
    v_name varchar2(20) := 'ȫ�浿';
    v_age number(3) := 20;
begin
    dbms_output.put_line('�ܺ� ��');
    dbms_output.put_line('outer v_name: ' || v_name);
    dbms_output.put_line('outer v_age: ' || v_age);
    begin
     dbms_output.put_line('���� ��');
    end;
end;
/

declare
    v_name varchar2(20) := 'ȫ�浿';
    v_age number(3) := 20;
begin
    dbms_output.put_line('�ܺ� ��');
    dbms_output.put_line('outer v_name: ' || v_name);
    dbms_output.put_line('outer v_age: ' || v_age);
    declare
        v_name varchar2(20) := '�̼���';
        v_tel varchar(30) := '1111-2222';
    begin
        dbms_output.put_line('���� ��');
        dbms_output.put_line('inner v_name: ' || v_name);
        dbms_output.put_line('inner v_age: ' || v_age);
        dbms_output.put_line('inner v_tel: ' || v_tel);
    end;
    
    dbms_output.put_line('�ܺ� ��');
 --   dbms_output.put_line('outer v_tel: ' || v_tel);        // ���� �� ���� �ܺο��� ��� �Ұ�!
        
end;
/

<�� ���̺�>
begin <<first>>
declare
    v_name varchar2(30) := 'ȫ�浿';
begin
    begin <<second>>
    declare
        v_name varchar2(30) := '������';
    begin
        begin <<third>>
        declare v_name varchar2(30) := '�̼���';
        begin
            dbms_output.put_line('inner v_name: ' || v_name);
            dbms_output.put_line('inner second.v_name: ' || second.v_name);
            dbms_output.put_line('inner first.v_name: ' || first.v_name);
            dbms_output.put_line('inner third.v_name: ' || third.v_name);
        end;
        end third;
    end;                                         -- begin���� ũ�� declare, begin, end �� ��ä�� ��������� ���̺���!
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
    -- v_sum := sum(v_salary);                   -- PLSQL �ȿ��� �׷��Լ� ���°� ���!
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
    insert into employees values(300, '�浿', 'ȫ', sysdate, 'IT_PROG', 5000, 60);
    insert into employees values(301, '����', '��', sysdate, 'IT_PROG', 4000, 60);
    insert into employees values(302, '����', '��', sysdate, 'IT_PROG', 3000, 60);
    -- dbms_output.put_line('�۾����� : ' || SQL%FOUND);         -- ���ǹ� �ݺ������� ���
    dbms_output.put_line('��� : ' || SQL%ROWCOUNT);        -- ���� �ֱٿ� �۾��� �Ϳ��� ����� ��! �׷��Ƿ� 1 ����! ���� �ƴ�!
end;
/

select * from employees;

declare
    v_up number(4, 2) := 1.1;
begin
    update employees set salary = salary * v_up where department_id = 60;
end;
/

<<<<<< ��� >>>>>>>>>>
<< ���� >>
<IF>
if ���� then ���๮;       -- �� ���๮
end if;                   -- ���� ���� ���๮ ����

declare
    v_salary employees.salary%TYPE;
    v_avg employees.salary%TYPE;
begin
    select salary into v_salary from employees where employee_id = 200;
    select avg(salary) into v_avg from employees;
    if v_salary > v_avg
        then dbms_output.put_line('������');
    else
        dbms_output.put_line('������');
    end if;
    dbms_output.put_line('���α׷� ��');
end;
/

if ���� then ���๮1;
else ���๮2
end if;

declare
    v_dname departments.department_name%TYPE;
begin
    select department_name into v_dname from employees e, departments d 
    where e.department_id = d.department_id and employee_id=200;
    if v_dname = 'IT_Support'
        then dbms_output.put_line('IT�μ�');
    else
        dbms_output.put_line('Ÿ�μ�');
    end if;
end;
/

IF ����1 then ���๮1;     -- �� ���๮ 1
elsif ����2 then ���๮2;   -- �� ���๮ 2 ��������
else ���๮3;              -- ���� ���๮ 3 �������� �ǹ�. ��������
end if;

declare v_hdate date default sysdate;
begin
    select hire_date into v_hdate from employees where employee_id = 200;
    if v_hdate < '2000/01/01'
        then dbms_output.put_line('�̻�');
    elsif v_hdate < '2003/01/01'
        then dbms_output.put_line('����');
    elsif v_hdate < '2007/01/01'
        then dbms_output.put_line('����');
    else
        dbms_output.put_line('���');
    end if;
end;
/

declare
    v_sal employees.salary%TYPE;
begin
    select employees.salary into v_sal from employees where employees.employee_id = 200;
    if v_sal > 20000
        then dbms_output.put_line('�̻�');
    elsif v_sal > 15000
        then dbms_output.put_line('����');
    elsif v_sal > 10000
        then dbms_output.put_line('����');
    elsif v_sal > 5000
        then dbms_output.put_line('�븮');
    else
        dbms_output.put_line('���');
    end if;
end;
/

<< PLSQL CASE>>   -- ���๮ ����
declare
    v_sal employees.salary%TYPE;
begin
    select employees.salary into v_sal from employees where employees.employee_id = 200;
    case
        when v_sal >= 20000 then dbms_output.put_line('�̻�');
        when v_sal >= 15000 then dbms_output.put_line('����');
        when v_sal >= 10000 then dbms_output.put_line('����');
        when v_sal >= 5000 then dbms_output.put_line('�븮');
        else dbms_output.put_line('���');
    end case;
end;
/

<< SQL CASE>>    -- �� ��ȯ! �ȿ� PL/SQL �Լ� ���� �Ұ�.
declare
    v_sal employees.salary%TYPE;
begin
    select employees.salary into v_sal from employees where employees.employee_id = 200;
    v_rank := case
        when v_sal >= 20000 and v_salary <= 30000 then '�̻�'
        when v_sal >= 15000 then '����'
        when v_sal >= 10000 then '����'
        when v_sal >= 5000 then '�븮'
        else '���'
    end;
    dbms_output.put_line('����: ' || v_rank);
end;
/