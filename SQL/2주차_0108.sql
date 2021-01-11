1 ~ 999까지 넣을수 있음!(3자리)
create table emp(
eno number(3),
ename varchar2(20),
esal number(9, 2),
ehire date
);
desc emp;
drop table emp;

// insert, update, delete 후, 필수로 commit해줘야 적용됨.(create, drop 등등은 필요 x DDL)
insert into emp values(100, '홍길동', 5000, '2020/01/01');
insert into emp values(101, '이순신', NULL, sysdate);
insert into emp(eno, ename, ehire) values(102, '김유신', sysdate);
insert into emp(eno, esal, ehire, ename) values(103, 4000, '2021/02/01', '대조영');      // 가저온 데이터의 순서가 다를때, 우리의 데이터베이스에 넣을수 있도록 하기위해 사용함.
insert into emp values(104, '강감찬', '3000', sysdate);     // 형변환해줌.(숫자만)
insert into emp values(105, '안창호', '3,000', sysdate);       // error
insert into emp values(&num, '안창호', 3000, sysdate);       // error
select * from emp;

// where 뒤에다가 일부러 거짓 조건을 주면, 테이블 자체만 복사하게 됨.
create table emps as select * from emp where 0=1;
select * from tabs;
select * from emps;
insert into emps values(200, 'AAA', 3000, current_date);
insert into emps values(201, 'BBB', 4000, current_date);
insert into emps values(202, 'CCC', 5000, current_date);
insert into emps values(203, 'DDD', 6000, current_date);
insert into emps values(204, 'EEE', 3000, current_date);

// 다른 테이블에 있는 자료도 가져와서 현재 테이블에 붙일 수 있다. but! 두개의 테이블 데이터 column들이 일치해야함.
insert into emp
select *
from emps
where esal <= 3000;

insert into emp(eno, ename)
select eno, ename from emps where esal > 4000


INSERT [ALL OR FIRST]       // ALL : 양쪽 조건에 다 맞으면, 둘 다 넣음.(조건1, 조건2)   FIRST: 먼저 만족하는 조건 테이블에 저장
WHEN 조건1 THEN INTO 테이블명1
WHEN 조건2 THEN INTO 테이블명2
...
ELSE INTO 테이블명0
SELECT 구문;

연봉 3000 이하인 EMP1
연봉 3000 초과인 EMP2
이외인          emp0

create table emp0 as select * from emp where 0=1;
create table emp1 as select * from emp where 0=1;
create table emp2 as select * from emp where 0=1;

INSERT ALL                                // 한 테이블 row들을 여러 테이블에 분산하기위해 사용 but! 만족하면 무조건 넣음! 중복 허용
WHEN esal >= 4000 then into emp1
when esal >= 3000 then into emp2
else into emp0
select * from emp;

select * from emp1;
select * from emp2;
select * from emp0;

rollback;

INSERT FIRST                        // 한 테이블 row들을 여러 테이블에 분산하기위해 사용 but! 1번에서 만족해서 들어간 데이터는 2번에선 안들어감!
WHEN esal >= 4000 then into emp1
when esal >= 3000 then into emp2
else into emp0
select * from emp;

select * from emp1;
select * from emp2;
select * from emp0;

* 참고 *
copy from HR/hr@localhost:1521:xe create test using select * from employees;
select * from test;

<< UPDATE >>
update emp set esal=3000 where eno=101;
update emp set esal=4000, ehire='20/12/12' where eno=202;
update emp set esal=esal * 1.1;
update emp set esal=NULL, ehire=NULL where eno=200;
update emp set esal=0, ehire='' where eno=204;                       // '' = NULL
update emp set (esal, ehire) = (select esal, ehire from emps where eno=200)
where eno =200;                                                     // where 안써주면 다 바뀜.

<< DELETE >>
delete emp where eno=203;
select * from emp

<< TCL Transaction >>
Transaction 일 하나
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

rollback;       // 여기서 rollback 하면, A B C D 모두 없다.
commit;          // 여기서 A B C D 모두 있다. & SAVEPOINT는 다 날라감.
rollback to b       // 추가로, SAVEPOINT B로 ROLLBACK하면, C, D로는 갈수 없다.

select * from tran;
rollback to c;
rollback to b;
commit;

insert into tran values(3, 'C');
insert into tran values(4, 'D');
rollback;
