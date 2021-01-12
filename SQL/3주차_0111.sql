select * from tabs;
desc emp;
insert into emp values(1, 'ȫ�浿', 3000, '2001/01/01');
insert into emp values(2, '������', 4000, '2001/02/01');
insert into emp values(3, '�̼���', 5000, '2001/03/01');
insert into emp values(4, '������', 3000, '2001/12/01');
insert into emp values(5, '������', 3000, '2001/07/01');
insert into emp values(6, '��âȣ', 6000, '2001/08/01');
commit;

alter table emp add ( etel varchar2(15) default '0000-0000');           // column �߰�
select * from emp;
insert into emp values(7, 'ȫ�浿', 4000, sysdate, '1111-2222');

<MODIFY>
�����Ͱ� ������ ��� ������ Ÿ���� ������ �� ����.
�� char�� varchar2�� �����ϴ�.
ũ��� ���� �����ͺ��� ���ų� ũ�� ���游 �����ϴ�.

alter table emp modify(etel varchar2(30));
alter table emp modify(etel varchar2(5));   // �����߻�
alter table emp modify(etel number(10));     // �����߻�

update emp set etel ='';
alter table emp modify(etel varchar(10));
alter table emp add(addredd varchar2(50));
alter table emp modify(addredd number(10));    // �����Ͱ� �ȿ� �� null�̸� ���氡��.but! default�صθ� �ɸ�...!

<DROP>
alter table emp drop column addredd;

��Ȱ��ȭ (�ٽ� Ȱ��ȭ ��ų���� ����! ��������� drop�� ���� ���.)
set unused
select * from user_unused_emp;
alter table emp drop unused columns;

�б� ���� ���̺�
alter table emp read only;
select * from emp;
update emp set ename='�̼���' where eno=1;
alter table emp read write;
update emp set ename='�̼���' where eno=1;

select * from tabs;
drop table emp;
drop table emps;
drop table emp0;
drop table emp1;
drop table emp2;
drop table test;
drop table tran;

<<< �������� Constraint >>>
    not null	    �ش� �÷� ������ NULL�� ������� �ʴ´�.
    unique		    �ش� �÷� ���� �׻� ���Ϲ����� ���� ������.
    primary key	    �ش� �÷� ���� �ݵ�� �����ؾ� �ϰ� �����ؾ� �Ѵ�.
                    not null�� unique�� ������ ����
    foreign key	    �ش� �÷� ���� Ÿ �÷��� ���� �����ؾ� �Ѵ�.
                    �����Ǵ� �÷��� ���� ���� �Է� �Ұ�
    check		    �ش� �÷��� ���� ������ ������ ���� ������ ����� ������ ����

    ���� ���� Ȯ���ϱ�
    select * from user_constraints;
    P 		primary key
    R 		foreign key
    C 		check, not null
    U       Unique

    �������� �̸��� ���̺��_�÷���_���� ���� ���� ������ ���Ѵ�.
    pk		primary key
    fk		foreign key
    nn		not null
    uk    	unique
    ck		check

<<<<<<<<<<<<< HR >>>>>>>>>>>>>>>>
select * from user_constraints;
select * from employees;
select * from user_constraints where table_name= 'EMPLOYEES';

<<<<<<<<<<<<<< MC >>>>>>>>>>>>>
drop table emp;

<< ���̺� ���� >>
// constraint�� �̸��ټ� ����.
create table emp(
eno number(3) constraint emp_eno_pk primary key,
ename varchar2(15) constraint emp_name_nn not null,
age number(3) constraint emp_age_ck check(age between 0 and 150),
tel varchar(20) constraint emp_tel_uk unique);
select * from user_constraints;

insert into emp(eno, age, tel) values(100,20,'1111-2222');     // ����! ������������ �ǵ����.
insert into emp values(100, 'ȫ�浿', 20, '1111-2222');         // check, unique �� null ����!
insert into emp values(101, '�̼���', 100, '2222-1111');
insert into emp(eno, ename, age) values(102, '������', 40);
insert into emp(eno, ename, age) values(103, '������', 30);

select * from emp;
<�÷��߰�>
alter table emp add(address varchar2(50) not null );             // �̸� �������൵��. + Not null��, column �߰���, data�� ������ null�� ���µ�, not null�� �϶�� ����̱⿡ ���� �ȵ�.
alter table emp add (address varchar2(50) unique);
insert into emp values(104, 'ȫ�浿', 30, '2222-2222', '����ñ�õ��');
insert into emp values(105, '����', 40, '3333-2222', '����ñ�õ��'); �����߻�
insert into emp values(105, '��������', 40, '3333-2222', '����õ��۱�');

<�������� ����>
select * from user_constraints;
alter table emp drop constraint SYS_c007034;                                    // constraint name �� ���� ����.
insert into emp values(106, '����', 40, '6666-2222', '����ñ�õ��');                   // ���ʹ� �ٸ��� ����
select * from emp;

alter table emp add constraint emp_address_uk unique(address);       /�����߻�
delete from emp where eno=106;
alter table emp add constraint emp_address_uk unique(address);       // �ٽ� constraint �߰�! but ������ �����ϴ� data�� ������ �Ұ���
alter table emp add constraint emp_address_pk primary key(address);       // ����

alter table emp add (gender number(1));
alter table emp add constraint emp_gender_ck check(gender in(0,1));
select * from user_constraints;
select * from emp;
insert into emp values(106, '���߱�', 10, '3333-1111', '������ ���ȱ�', 3);       // check �������ǿ� ����Ǽ� out!
//  not null�� ���¸� �����ϴ°��̱� ������ add�� �ȵ�. add/drop �ȵ�. modify�� ��.

<�������� ����>
alter table emp modify gender check(gender in (1,2));               // �����߻�
update emp set gender = 1 where eno=106;
alter table emp modify gender check(gender in (1,2));
alter table emp drop constraint emp_gneder_ck;
select * from user_constraints;

alter table emp drop constraint SYS_C007038;
select * from emp;

alter table emp modify age constraint emp_age_nn not null;
insert into emp(eno, ename, tel, address, gender)
values(107, '��', '3333-3333', 'seoul', 2);
alter table emp modify age constraint emp_age_nn null;
insert into emp(eno, ename, tel, address, gender)
values(107, '��', '3333-3333', 'seoul', 0);

// ���� ������ Ȯ�� ���� option���� �ټ� ����.
alter table emp modify gender constraint emp_gender_nn not null enable novalidate; ���� ������ ��Ȯ���ϸ鼭 �������� �߰��Ҽ� �ֵ���.
alter table emp modify gender constraint emp_gender_nn not null enable validate;   Ȯ��
select * from user_constraints;

<�������Ἲ ��������>
create table emp (
...
deno varchar2(10) constraint emp_deno_fk references depart(deno),
...
);


create table temp (
tnum number(5),
tname varchar2(10),
deno number(10),
constraint temp_deno_fk foreign key(deno) references depart(deno) on delete cascade
);


insert into temp values(1, 'asd', 100);
select * from depart;
select * from temp;
delete from depart where deno=100;

create table depart(
deno number(3) primary key,
dname varchar2(20) not null
);

insert into depart values(100, '�񼭽�');
insert into depart values(200, '�渮��');
insert into depart values(300, '�λ��');
insert into depart values(40, '������');
insert into depart values(50, '������');
commit;
select * from depart;
select * from user_constraints;
select * from emp;

alter table emp add(deno number(3) constraint emp_deno_fk references depart(deno));
alter table emp modify gender constraint emp_gender_nn null
insert into emp values(108, 'ȫ�浿', 20, '2222-3333', '����� ���α�', 100);             // ���� ���Ἲ ����
insert into emp values(108, 'ȫ�浿', 20, '2222-3333', '����� ���α�', 10);
insert into emp (eno, ename, age, tel, address)
values(109, '�豸', 45, '2222-5555', '����� ���Ǳ�');

alter table emp drop constraint emp_deno_fk;
insert into emp values(110, '������', 20, '2222-7777', '����� ���ʱ�', 100);

alter table emp add constraint emp_deno_fk foreign key(deno) references depart(deno);  // ����
update emp set deno=50 where eno=110;
alter table emp add constraint emp_deno_fk foreign key(deno) references depart(deno);

drop table depart;                   // ���� ���Ἲ �������� ������ ���� �߻�
drop table depart cascade constraints;

select * from tabs;
select * from emp;
select * from depart;
update emp set deno=100 where eno=104;
select * from user_constraints;
delete from emp where eno=110
delete from emp where eno=104



<<������>>
create table emp(
eno number(3) constraint emp_eno_pk primary key,
ename varchar2(15) constraint emp_name_nn not null,
tel varchar(20) );

select * from emp;

create sequence emp_seq
start with 200
increment by 1
maxvalue 999
nocycle
nocache
order;

select * from user_sequences;
select emp_seq.NEXTVAL from dual;
select emp_seq.CURRVAL from dual;
select * from emp;
insert into emp values( emp_seq.NEXTVAL, 'ȫ�浿', '3333-2222');
insert into emp values( emp_seq.NEXTVAL, 'ȫ�浿', '3333-2222');

���а�, �ִ밪, �ּҰ�, ��ȯ�ɼ� �Ǵ� ĳ�ÿɼ��� �����մϴ�.
alter sequence emp_seq
increment by 2
maxvalue 9999
nocycle
nocache
order;

<<< ���Ǿ� >>
���̺� �Ǵ� ��Ÿ �����ͺ��̽� ��ü�� ��ü �̸��� �����ϱ� ���� ������ �� �ֽ��ϴ�.
�� ��ü �̸��� ª�� ����ϴ�.
�⺻ ��Ű�� ��ü�� ID �� ��ġ�� ����� �� �����մϴ�.


<<<<<<<<<<<<<<<< system >>>>>>>>>>>>>>>
grant create synonym to mc;

<<<<<<<<<<<<< MC ���� >>>>>>>>>>>>>>
create synonym em for emp;
select * from user_synonyms;
select * from em;                     // emp �������� ��� �Ұ�!

<<������>>
select * from tabs;
show recyclebin;
flashback table emp;



********** ���� ********************************************************
drop table depart;
select * from user_constraints;
create table job(
job_id number(5),
job_name varchar2(15) not null
);

create table depart(
depart_id number(5),
depart_name varchar2(15) not null
);

select * from user_constraints;
select * from tabs;
alter table job add constraints job_pri primary key(job_id);
alter table depart add constraints depart_pri primary key(depart_id);

create table employee (
id number(5) primary key,
pw varchar2(15) not null,
ph varchar2(20) not null unique,
addr varchar2(20) not null,
job_id number(5),
depart_id number(5),
constraints emplo_job foreign key(job_id) references job(job_id),
constraints emplo_depart foreign key(depart_id) references depart(depart_id)
);

alter sequence emp_seq
start with 1
increment by 1
maxvalue 9999
nocycle
nocach
order;

create sequence emp_seq
start with 1
increment by 1
maxvalue 9999
nocycle
nocache
order;
