1 ~ 999���� ������ ����!(3�ڸ�)
create table emp(
eno number(3),
ename varchar2(20),
esal number(9, 2),
ehire date
);
desc emp;
drop table emp;

// insert, update, delete ��, �ʼ��� commit����� �����.(create, drop ����� �ʿ� x DDL)
insert into emp values(100, 'ȫ�浿', 5000, '2020/01/01');
insert into emp values(101, '�̼���', NULL, sysdate);
insert into emp(eno, ename, ehire) values(102, '������', sysdate);
insert into emp(eno, esal, ehire, ename) values(103, 4000, '2021/02/01', '������');      // ������ �������� ������ �ٸ���, �츮�� �����ͺ��̽��� ������ �ֵ��� �ϱ����� �����.
insert into emp values(104, '������', '3000', sysdate);     // ����ȯ����.(���ڸ�)
insert into emp values(105, '��âȣ', '3,000', sysdate);       // error
insert into emp values(&num, '��âȣ', 3000, sysdate);       // error
select * from emp;

// where �ڿ��ٰ� �Ϻη� ���� ������ �ָ�, ���̺� ��ü�� �����ϰ� ��.
create table emps as select * from emp where 0=1;
select * from tabs;
select * from emps;
insert into emps values(200, 'AAA', 3000, current_date);
insert into emps values(201, 'BBB', 4000, current_date);
insert into emps values(202, 'CCC', 5000, current_date);
insert into emps values(203, 'DDD', 6000, current_date);
insert into emps values(204, 'EEE', 3000, current_date);

// �ٸ� ���̺� �ִ� �ڷᵵ �����ͼ� ���� ���̺� ���� �� �ִ�. but! �ΰ��� ���̺� ������ column���� ��ġ�ؾ���.
insert into emp
select *
from emps
where esal <= 3000;

insert into emp(eno, ename)
select eno, ename from emps where esal > 4000


INSERT [ALL OR FIRST]       // ALL : ���� ���ǿ� �� ������, �� �� ����.(����1, ����2)   FIRST: ���� �����ϴ� ���� ���̺� ����
WHEN ����1 THEN INTO ���̺��1
WHEN ����2 THEN INTO ���̺��2
...
ELSE INTO ���̺��0
SELECT ����;

���� 3000 ������ EMP1
���� 3000 �ʰ��� EMP2
�̿���          emp0

create table emp0 as select * from emp where 0=1;
create table emp1 as select * from emp where 0=1;
create table emp2 as select * from emp where 0=1;

INSERT ALL                                // �� ���̺� row���� ���� ���̺� �л��ϱ����� ��� but! �����ϸ� ������ ����! �ߺ� ���
WHEN esal >= 4000 then into emp1
when esal >= 3000 then into emp2
else into emp0
select * from emp;

select * from emp1;
select * from emp2;
select * from emp0;

rollback;

INSERT FIRST                        // �� ���̺� row���� ���� ���̺� �л��ϱ����� ��� but! 1������ �����ؼ� �� �����ʹ� 2������ �ȵ�!
WHEN esal >= 4000 then into emp1
when esal >= 3000 then into emp2
else into emp0
select * from emp;

select * from emp1;
select * from emp2;
select * from emp0;

* ���� *
copy from HR/hr@localhost:1521:xe create test using select * from employees;
select * from test;

<< UPDATE >>
update emp set esal=3000 where eno=101;
update emp set esal=4000, ehire='20/12/12' where eno=202;
update emp set esal=esal * 1.1;
update emp set esal=NULL, ehire=NULL where eno=200;
update emp set esal=0, ehire='' where eno=204;                       // '' = NULL
update emp set (esal, ehire) = (select esal, ehire from emps where eno=200)
where eno =200;                                                     // where �Ƚ��ָ� �� �ٲ�.

<< DELETE >>
delete emp where eno=203;
select * from emp

<< TCL Transaction >>
Transaction �� �ϳ�
ALL OR NOTHING

< COMMIT ROLLBACK SAVEPOINT >
create table tran(
num number(2),
name varchar2(5)
);

commit;
insert into tran values(1, 'A');
savepoint a;
insert into tran values(2, 'B');
savepoint b;
insert into tran values(3, 'C');
savepoint c;
insert into tran values(4, 'D');
savepoint d;

rollback;       // ���⼭ rollback �ϸ�, A B C D ��� ����.
commit;          // ���⼭ A B C D ��� �ִ�. & SAVEPOINT�� �� ����.
rollback to b       // �߰���, SAVEPOINT B�� ROLLBACK�ϸ�, C, D�δ� ���� ����.

select * from tran;
rollback to c;
rollback to b;
commit;

insert into tran values(3, 'C');
insert into tran values(4, 'D');
rollback;
