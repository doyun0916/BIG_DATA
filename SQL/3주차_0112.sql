*************** ���� Ǯ�� **********************
create sequence job_seq
start with 100
increment by 100
maxvalue 9999
nocycle
nocache
order;

create sequence dep_seq
start with 10
increment by 10
maxvalue 999
nocycle
nocache
order;

drop sequence dep_seq;

create table job(
job_id number(5) primary key,
job_name varchar2(21) not null
);

create table depart(
depart_id number(5) primary key,
depart_name varchar2(30) not null
);

insert into job values(job_seq.NEXTVAL, '�λ�');
insert into job values(job_seq.NEXTVAL, '����');
insert into job values(job_seq.NEXTVAL, '����');
insert into job values(job_seq.NEXTVAL, '���');
insert into job values(job_seq.NEXTVAL, '�繫');
insert into job values(job_seq.NEXTVAL, '��');
commit;
select * from job;


insert into depart values(dep_seq.NEXTVAL, '�ѹ���');
insert into depart values(dep_seq.NEXTVAL, '�λ��');
insert into depart values(dep_seq.NEXTVAL, '�繫��');
insert into depart values(dep_seq.NEXTVAL, '�����');
insert into depart values(dep_seq.NEXTVAL, '������');
commit;
select * from depart

create table employee(
id number(4) primary key,
passwd varchar(20) not null,
name varchar2(30) not null,
tel varchar2(20) unique not null,
job_id number(5),
depart_id number(5),
constraints job_fk foreign key(job_id) references job(job_id),
constraints depart_fk foreign key(depart_id) references depart(depart_id)
);

create sequence emp_seq
start with 100
increment by 1
maxvalue 9999
nocycle
nocache
order;

insert into employee values(emp_seq.NEXTVAL, '111', 'ȫ�浿', '1111-2222', 100, 10, '�����');
insert into employee values(emp_seq.NEXTVAL, '111', '������', '1111-3333', 100, 10, '�����');
insert into employee values(emp_seq.NEXTVAL, '111', '�̼���', '1111-5555', 200, 20, '�����');
insert into employee values(emp_seq.NEXTVAL, '111', 'ȫ�浿', '1111-7777', 300, 30, '�Ȼ��');
insert into employee values(emp_seq.NEXTVAL, '111', '������', '1111-8888', 400, 40, '��õ��');
insert into employee values(emp_seq.NEXTVAL, '111', '������', '1111-9999', 500, 50, '��õ��');

<< �ε��� >>
����Ŭ �������� �����͸� ����Ͽ� �� �˻� �ӵ��� ���̴� �� ����� �� �ֽ��ϴ�.
����Ŭ �������� �ڵ����� ���ǰ� ���� �����˴ϴ�.

�ڵ�����: ���̺� �����̿��� PRIMARY KEY �Ǵ� UNIQUE ���������� �����ϸ� ���� �ε����� �ڵ����� �����˴ϴ�.
��������: �࿡ �׼����ϴ� �ӵ��� ���̱� ���� ������ ���� ���� �Ǵ� ����� �ε����� ������ �� �ֽ��ϴ�

CREATE index emp_name_idx on employee(name);
select * from user_indexes;
create index emp_name_idx1 on employee(name, job_id);
drop index emp_name_idx;
drop index emp_name_idx1;

<<< �� >>>
create view emp_id
as
select e.id ���, e.name �̸�, e.tel ��ȭ��ȣ, j.job_name ����, d.depart_name �μ�
from employee e, job j, depart d
where e.job_id = j.job_id and e.depart_id = d.depart_id and e.id in (101, 102, 103);

select * from user_views;
select * from emp_id;
select ���, �̸� from emp_id;
select ���, �̸� from emp_id where ���=101;

create or replace view emp_id
(���̵�, �̸�, ��ȭ��ȣ, ����, �μ�)
as
select e.id, e.name, e.tel, j.job_name, d.depart_name
from employee e, job j, depart d
where e.job_id = j.job_id and e.depart_id = d.depart_id and e.id >= 101 and e.id <= 104;

�ܼ� ��(���̺� �ϳ�)������ �밳 DML �۾��� ������ �� �ֽ��ϴ�.
�信 ���� �׸��� ���ԵǾ� ������ ���� ������ �� �����ϴ�.
-�׷� �Լ� -group by �� -distinct Ű���� -pseudocolumn rownum Ű����

select * from employee;
select * from emp_id;
update emp_id set ��ȭ��ȣ='9999-9999' where ���̵�=101;           // ���� �� �ű��� ��: view�� ���� ������ �ٲܼ� �ִ�!!!
commit;

select * from depart;
update emp_id set �μ�='�ѹ��μ�' where ���̵�=101;       // ���� �߻�! -> ���� ���̺��� �ٲٰ� �ǵ���� �� �ٸ��� ���ľ� �ϱ� ������ �Ұ���! �� ���̺��� ���� ����!
update emp_id set ����='�λ��' where ���̵�=101;            // ���� �߻�

insert into emp_id values(emp_seq.NEXTVAL, '111', 'ȫ�浿', '2222-1111', 300, 30, '�����')      // ����
insert into emp_id(���̵�, �̸�, ��ȭ��ȣ) values(emp_seq.NEXTVAL, '�̸�', '1234-5678') // ����     (not null ���� ���ǿ� �ɸ�!)
delete from emp_id where ���̵�=101;            // ���� �൵ ���� ��.

create or replace view emp_job_dep
as
select e.id ���̵�, e.passwd ��й�ȣ, e.name �̸�, e.tel ��ȭ��ȣ, e.address �ּ�, j.job_name, d.depart_name
from employee e, job j, depart d
where e.job_id = j.job_id and e.depart_id = d.depart_id and e.id >= 101 and e.id <= 104;

select * from emp_job_dep;
insert into emp_job_dep(���̵�, ��й�ȣ, �̸�, ��ȭ��ȣ, �ּ�)
values(emp_seq.NEXTVAL, '111', 'ȫ�浿', '2222-1111', '�����');             // ����! not null column�� view�� �����ϰ� �ֱ⋚���� �־��ָ� ����
select * from employee;

update emp_job_dep set ��й�ȣ=999 where ���̵�=104;
update emp_job_dep set ��ȭ��ȣ='9999-9999' where ���̵�=104;
update emp_job_dep set �ּ�='�ϻ��' where ���̵�=104;
�Ǵ�,
update emp_job_dep set ��й�ȣ=999, ��ȭ��ȣ='9999-9999', �ּ�='�ϻ��' where ���̵�=104;      // view�� �ٲ۰� �ƴ϶� ������ �ٲ۰���! ������ �ٲ㼭, �װ��� �����ϰ� �ִ� view ���� �ٲ��.

<< �� ���� >>
�䰡 �����ϰ� �ִ� ���̺��� ������ �Ǹ� view�� �� �̻� ����� �� ����.
�䰡 �����ȴٰ� �ؼ� ���̺��� ���������� �ʽ��ϴ�.
�並 ���� ���̺��� ���� ������ �� �ִ�.

select * from user_views;
drop view emp_id;
drop view emp_job_dep;


<< ROLE >>
role_sys_privs  ���ҿ� �ο��Ǵ� �ý��� ����
role_tab_privs    ���ҿ� �ο��Ǵ� ���̺� ����
user_role_privs        ������ �׼����� �� �ִ� ����
user_sys_privs       �������� �ο��Ǵ� �ý��� ����
user_tab_privs_made ������ ��ü�� ���� �ο��Ǵ� ��ü ����
user_tab_privs_recd  �������� �ο��Ǵ� ��ü ����
user_col_privs_made ���� ��ü�� ���� ���� �ο��Ǵ� ��ü ����
user_col_privs_recd  Ư�� ���� ���� �������� �ο��Ǵ� ��ü ����

<<<<<<<<<<<<<<<<<<<<<<<<<<<<< system >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
revoke create table, create sequence, create view, create synonym from mc;

<<<<<<<<<<<<<<<<<<<<<<<<<<<<< MC >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from user_sys_privs;
create table test(
no number(30),
name varchar2(50)
);                                // ������.

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< system >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
create role test;
grant create table, create sequence, create view, create synonym to test;
grant test to mc;

<<<<<<<<<<<<<<<<<<<<<<<<<<<<< MC >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from user_sys_privs;
select * from role_sys_privs;
select * from user_role_privs;
select * from session_roles;
set role test;

create table test(
no number(30),
name varchar2(50)
);

select * from tabs;

<<< merge >>>
�����ͺ��̽� ���̺��� ���Ǻη� �����ϰų� �����͸� ���� �Ǵ� �����ϴ� ����� �����մϴ�.
���� �����ϴ� ��� update�� �����ϰ� 
- ������ ������ �����մϴ�.
- ���� �� ��� ���Ǽ��� ���˴ϴ�.
- ������ �����Ͽ�¡ ���� ���α׷����� �����մϴ�.

MERGE INTO ���̺�� ��Ī
    USING ������̺�/�� ��Ī
    ON ��������
    WHEN MATCHED THEN
        UPDATE SET
            �÷�1=��1
                �÷�2=��2
    WHEN NOT MATCHED THEN
        INSERT(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...);

SELECT * FROM EMPLOYEE;
alter table employee add (salary number(8, 2));
update employee set salary = 2000 where id=100;
update employee set salary = 3500 where id=102; 
update employee set salary = 4000 where id=103;
update employee set salary = 5000 where id=104;
update employee set salary = 6000 where id=105;
update employee set salary = 4000 where id=107;

merge into employee
using dual
on ( id in(102, 103))
when matched then
    update set salary = salary * 1.1;
�������� �÷��� ���׷��̵� �� �� ����.

update employee set salary = salary * 1.1 where id in( 102, 103);

select * from employee;

create table emp_bk as select * from employee;
select * from emp_bk;
update employee set passwd='999', address='�����', job_id=100, salary=5000 where id=102;
select * from employee;

merge into emp_bk em
using  (select * from employee) ee
on ( ee.id = em.id )
when matched then
    update set em.passwd = ee.passwd, em.address = ee.address, em.salary = ee.salary;

select * from emp_bk;

insert into employee values(emp_seq.NEXTVAL, '111', '������', '2222-3333', 100, 10, '������', 4000);
select * from employee;
select * from emp_bk;

merge into emp_bk em
using ( select * from employee ) ee
on (em.id = ee.id)
when not matched then
    insert values(ee.id, ee.passwd, ee.name, ee.tel, ee.job_id, ee.depart_id, ee.address, ee.salary);

delete from emp_bk;

merge into emp_bk em
using (select * from employee) ee
on (em.id = ee.id)
when matched then
    update set em.id=ee.id, em.passwd=ee.passwd, em.name=ee.name, em.tel=ee.tel, em.job_id=ee.job_id, em.depart_id=ee.depart_id,  em.address=ee.address, em.salary=ee.salary*1.1
                where em.salary <= 3000
when not matched then
    insert values(ee.id, ee.passwd, ee.name, ee.tel, ee.job_id, ee.depart_id, ee.address, ee.salary);
    
select * from emp_bk;