*************** 과제 풀이 **********************
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

insert into job values(job_seq.NEXTVAL, '인사');
insert into job values(job_seq.NEXTVAL, '생산');
insert into job values(job_seq.NEXTVAL, '관리');
insert into job values(job_seq.NEXTVAL, '배송');
insert into job values(job_seq.NEXTVAL, '재무');
insert into job values(job_seq.NEXTVAL, '비서');
commit;
select * from job;


insert into depart values(dep_seq.NEXTVAL, '총무부');
insert into depart values(dep_seq.NEXTVAL, '인사부');
insert into depart values(dep_seq.NEXTVAL, '재무부');
insert into depart values(dep_seq.NEXTVAL, '생산부');
insert into depart values(dep_seq.NEXTVAL, '관리부');
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

insert into employee values(emp_seq.NEXTVAL, '111', '홍길동', '1111-2222', 100, 10, '서울시');
insert into employee values(emp_seq.NEXTVAL, '111', '김유신', '1111-3333', 100, 10, '서울시');
insert into employee values(emp_seq.NEXTVAL, '111', '이순신', '1111-5555', 200, 20, '수언시');
insert into employee values(emp_seq.NEXTVAL, '111', '홍길동', '1111-7777', 300, 30, '안산시');
insert into employee values(emp_seq.NEXTVAL, '111', '대조영', '1111-8888', 400, 40, '인천시');
insert into employee values(emp_seq.NEXTVAL, '111', '강감찬', '1111-9999', 500, 50, '인천시');

<< 인덱스 >>
오라클 서버에서 포인터를 사용하여 행 검색 속도를 높이는 데 사용할 수 있습니다.
오라클 서버에서 자동으로 사용되고 유지 관리됩니다.

자동으로: 테이블 저으이에서 PRIMARY KEY 또는 UNIQUE 제약조건을 정의하면 고유 인덱스가 자동으로 생성됩니다.
수동으로: 행에 액세스하는 속도를 높이기 위해 유저가 열의 고유 또는 비고유 인덱스를 생성할 수 있습니다

CREATE index emp_name_idx on employee(name);
select * from user_indexes;
create index emp_name_idx1 on employee(name, job_id);
drop index emp_name_idx;
drop index emp_name_idx1;

<<< 뷰 >>>
create view emp_id
as
select e.id 사번, e.name 이름, e.tel 전화번호, j.job_name 업무, d.depart_name 부서
from employee e, job j, depart d
where e.job_id = j.job_id and e.depart_id = d.depart_id and e.id in (101, 102, 103);

select * from user_views;
select * from emp_id;
select 사번, 이름 from emp_id;
select 사번, 이름 from emp_id where 사번=101;

create or replace view emp_id
(아이디, 이름, 전화번호, 업무, 부서)
as
select e.id, e.name, e.tel, j.job_name, d.depart_name
from employee e, job j, depart d
where e.job_id = j.job_id and e.depart_id = d.depart_id and e.id >= 101 and e.id <= 104;

단순 뷰(테이블 하나)에서는 대개 DML 작업을 수행할 수 있습니다.
뷰에 다음 항목이 포함되어 있으면 행을 제거할 수 없습니다.
-그룹 함수 -group by 절 -distinct 키워드 -pseudocolumn rownum 키워드

select * from employee;
select * from emp_id;
update emp_id set 전화번호='9999-9999' where 아이디=101;           // 주의 및 신기한 점: view를 통해 원본을 바꿀수 있다!!!
commit;

select * from depart;
update emp_id set 부서='총무부서' where 아이디=101;       // 에러 발생! -> 원본 테이블값을 바꾸고 건들려면 한 다리를 거쳐야 하기 때문에 불가능! 주 테이블은 변경 가능!
update emp_id set 업무='인사부' where 아이디=101;            // 에러 발생

insert into emp_id values(emp_seq.NEXTVAL, '111', '홍길동', '2222-1111', 300, 30, '서울시')      // 에러
insert into emp_id(아이디, 이름, 전화번호) values(emp_seq.NEXTVAL, '이름', '1234-5678') // 에러     (not null 제약 조건에 걸림!)
delete from emp_id where 아이디=101;            // 원래 행도 삭제 됨.

create or replace view emp_job_dep
as
select e.id 아이디, e.passwd 비밀번호, e.name 이름, e.tel 전화번호, e.address 주소, j.job_name, d.depart_name
from employee e, job j, depart d
where e.job_id = j.job_id and e.depart_id = d.depart_id and e.id >= 101 and e.id <= 104;

select * from emp_job_dep;
insert into emp_job_dep(아이디, 비밀번호, 이름, 전화번호, 주소)
values(emp_seq.NEXTVAL, '111', '홍길동', '2222-1111', '서울시');             // 가능! not null column을 view가 포함하고 있기떄문에 넣어주면 가능
select * from employee;

update emp_job_dep set 비밀번호=999 where 아이디=104;
update emp_job_dep set 전화번호='9999-9999' where 아이디=104;
update emp_job_dep set 주소='일산시' where 아이디=104;
또는,
update emp_job_dep set 비밀번호=999, 전화번호='9999-9999', 주소='일산시' where 아이디=104;      // view를 바꾼게 아니라 원본을 바꾼것임! 원본을 바꿔서, 그것을 참조하고 있는 view 또한 바뀐것.

<< 뷰 삭제 >>
뷰가 참조하고 있는 테이블이 삭제가 되면 view를 더 이상 사용할 수 없다.
뷰가 삭제된다고 해서 테이블이 삭제되지는 않습니다.
뷰를 통해 테이블의 행을 삭제할 수 있다.

select * from user_views;
drop view emp_id;
drop view emp_job_dep;


<< ROLE >>
role_sys_privs  역할에 부여되는 시스템 권한
role_tab_privs    역할에 부여되는 테이블 권한
user_role_privs        유저가 액세스할 수 있는 권한
user_sys_privs       유저에게 부여되는 시스템 권한
user_tab_privs_made 유저의 객체에 대해 부여되는 객체 권한
user_tab_privs_recd  유저에게 부여되는 객체 권한
user_col_privs_made 유저 객체의 열에 대해 부여되는 객체 권한
user_col_privs_recd  특정 열에 대해 유저에게 부여되는 객체 권한

<<<<<<<<<<<<<<<<<<<<<<<<<<<<< system >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
revoke create table, create sequence, create view, create synonym from mc;

<<<<<<<<<<<<<<<<<<<<<<<<<<<<< MC >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select * from user_sys_privs;
create table test(
no number(30),
name varchar2(50)
);                                // 오류남.

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
데이터베이스 테이블을 조건부로 갱신하거나 데이터를 삽입 또는 삭제하는 기능을 제공합니다.
행이 존재하는 경우 update를 수행하고 
- 별도의 갱신을 방지합니다.
- 성능 및 사용 편의성이 향상됩니다.
- 데이터 웨어하우징 응용 프로그램에서 유용합니다.

MERGE INTO 테이블명 별칭
    USING 대상테이블/뷰 별칭
    ON 조인조건
    WHEN MATCHED THEN
        UPDATE SET
            컬럼1=값1
                컬럼2=값2
    WHEN NOT MATCHED THEN
        INSERT(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...);

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
조건절의 컬럼은 업그레이드 할 수 없다.

update employee set salary = salary * 1.1 where id in( 102, 103);

select * from employee;

create table emp_bk as select * from employee;
select * from emp_bk;
update employee set passwd='999', address='서울시', job_id=100, salary=5000 where id=102;
select * from employee;

merge into emp_bk em
using  (select * from employee) ee
on ( ee.id = em.id )
when matched then
    update set em.passwd = ee.passwd, em.address = ee.address, em.salary = ee.salary;

select * from emp_bk;

insert into employee values(emp_seq.NEXTVAL, '111', '김유신', '2222-3333', 100, 10, '수원시', 4000);
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