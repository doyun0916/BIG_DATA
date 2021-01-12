select * from tabs;
desc emp;
insert into emp values(1, '홍길동', 3000, '2001/01/01');
insert into emp values(2, '김유신', 4000, '2001/02/01');
insert into emp values(3, '이순신', 5000, '2001/03/01');
insert into emp values(4, '대조영', 3000, '2001/12/01');
insert into emp values(5, '강감찬', 3000, '2001/07/01');
insert into emp values(6, '안창호', 6000, '2001/08/01');
commit;

alter table emp add ( etel varchar2(15) default '0000-0000');           // column 추가
select * from emp;
insert into emp values(7, '홍길동', 4000, sysdate, '1111-2222');

<MODIFY>
데이터가 존재할 경우 데이터 타입을 변경할 수 없다.
단 char와 varchar2는 가능하다.
크기는 기존 데이터보다 같거나 크게 변경만 가능하다.

alter table emp modify(etel varchar2(30));
alter table emp modify(etel varchar2(5));   // 에러발생
alter table emp modify(etel number(10));     // 에러발생

update emp set etel ='';
alter table emp modify(etel varchar(10));
alter table emp add(addredd varchar2(50));
alter table emp modify(addredd number(10));    // 데이터가 안에 다 null이면 변경가능.but! default해두면 걸림...!

<DROP>
alter table emp drop column addredd;

비활성화 (다시 활성화 시킬수는 없음! 결과적으론 drop과 같은 결과.)
set unused
select * from user_unused_emp;
alter table emp drop unused columns;

읽기 전용 테이블
alter table emp read only;
select * from emp;
update emp set ename='이순신' where eno=1;
alter table emp read write;
update emp set ename='이순신' where eno=1;

select * from tabs;
drop table emp;
drop table emps;
drop table emp0;
drop table emp1;
drop table emp2;
drop table test;
drop table tran;

<<< 제약조건 Constraint >>>
    not null	    해당 컬럼 값으로 NULL을 허용하지 않는다.
    unique		    해당 컬럼 값은 항상 유일무이한 값을 가진다.
    primary key	    해당 컬럼 값은 반드시 존재해야 하고 유일해야 한다.
                    not null과 unique를 결합한 형태
    foreign key	    해당 컬럼 값이 타 컬럼의 값을 참조해야 한다.
                    참조되는 컬럼에 없는 값은 입력 불가
    check		    해당 컬럼에 저장 가능한 데이터 값의 범위나 사용자 조건을 지정

    제약 조건 확인하기
    select * from user_constraints;
    P 		primary key
    R 		foreign key
    C 		check, not null
    U       Unique

    제약조건 이름은 테이블명_컬럼명_제약 조건 유형 순으로 정한다.
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

<< 테이블 생성 >>
// constraint에 이름줄수 있음.
create table emp(
eno number(3) constraint emp_eno_pk primary key,
ename varchar2(15) constraint emp_name_nn not null,
age number(3) constraint emp_age_ck check(age between 0 and 150),
tel varchar(20) constraint emp_tel_uk unique);
select * from user_constraints;

insert into emp(eno, age, tel) values(100,20,'1111-2222');     // 오류! 제약조건으로 건드려서.
insert into emp values(100, '홍길동', 20, '1111-2222');         // check, unique 는 null 가능!
insert into emp values(101, '이순신', 100, '2222-1111');
insert into emp(eno, ename, age) values(102, '김유신', 40);
insert into emp(eno, ename, age) values(103, '대조영', 30);

select * from emp;
<컬럼추가>
alter table emp add(address varchar2(50) not null );             // 이름 안지어줘도됨. + Not null은, column 추가시, data가 있으면 null로 들어가는데, not null로 하라면 모순이기에 성립 안됨.
alter table emp add (address varchar2(50) unique);
insert into emp values(104, '홍길동', 30, '2222-2222', '서울시금천구');
insert into emp values(105, '강동', 40, '3333-2222', '서울시금천구'); 에러발생
insert into emp values(105, '감감감동', 40, '3333-2222', '서울시동작구');

<제약조건 수정>
select * from user_constraints;
alter table emp drop constraint SYS_c007034;                                    // constraint name 쪽 보면 있음.
insert into emp values(106, '강동', 40, '6666-2222', '서울시금천구');                   // 위와는 다르게 가능
select * from emp;

alter table emp add constraint emp_address_uk unique(address);       /에러발생
delete from emp where eno=106;
alter table emp add constraint emp_address_uk unique(address);       // 다시 constraint 추가! but 기존에 위배하는 data가 잇으면 불가능
alter table emp add constraint emp_address_pk primary key(address);       // 에러

alter table emp add (gender number(1));
alter table emp add constraint emp_gender_ck check(gender in(0,1));
select * from user_constraints;
select * from emp;
insert into emp values(106, '안중근', 10, '3333-1111', '수원시 만안구', 3);       // check 제약조건에 위배되서 out!
//  not null은 상태를 변경하는것이기 때문에 add가 안됨. add/drop 안됨. modify로 함.

<제약조건 삭제>
alter table emp modify gender check(gender in (1,2));               // 에러발생
update emp set gender = 1 where eno=106;
alter table emp modify gender check(gender in (1,2));
alter table emp drop constraint emp_gneder_ck;
select * from user_constraints;

alter table emp drop constraint SYS_C007038;
select * from emp;

alter table emp modify age constraint emp_age_nn not null;
insert into emp(eno, ename, tel, address, gender)
values(107, '안', '3333-3333', 'seoul', 2);
alter table emp modify age constraint emp_age_nn null;
insert into emp(eno, ename, tel, address, gender)
values(107, '안', '3333-3333', 'seoul', 0);

// 이전 데이터 확인 여부 option으로 줄수 있음.
alter table emp modify gender constraint emp_gender_nn not null enable novalidate; 기존 데이터 미확인하면서 제약조건 추가할수 있도록.
alter table emp modify gender constraint emp_gender_nn not null enable validate;   확인
select * from user_constraints;

<참조무결성 제약조건>
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

insert into depart values(100, '비서실');
insert into depart values(200, '경리부');
insert into depart values(300, '인사부');
insert into depart values(40, '관리부');
insert into depart values(50, '영업부');
commit;
select * from depart;
select * from user_constraints;
select * from emp;

alter table emp add(deno number(3) constraint emp_deno_fk references depart(deno));
alter table emp modify gender constraint emp_gender_nn null
insert into emp values(108, '홍길동', 20, '2222-3333', '서울시 종로구', 100);             // 참조 무결성 에러
insert into emp values(108, '홍길동', 20, '2222-3333', '서울시 종로구', 10);
insert into emp (eno, ename, age, tel, address)
values(109, '김구', 45, '2222-5555', '서울시 관악구');

alter table emp drop constraint emp_deno_fk;
insert into emp values(110, '김유신', 20, '2222-7777', '서울시 서초구', 100);

alter table emp add constraint emp_deno_fk foreign key(deno) references depart(deno);  // 에러
update emp set deno=50 where eno=110;
alter table emp add constraint emp_deno_fk foreign key(deno) references depart(deno);

drop table depart;                   // 참조 무결성 제약조건 때문에 에러 발생
drop table depart cascade constraints;

select * from tabs;
select * from emp;
select * from depart;
update emp set deno=100 where eno=104;
select * from user_constraints;
delete from emp where eno=110
delete from emp where eno=104



<<시퀸스>>
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
insert into emp values( emp_seq.NEXTVAL, '홍길동', '3333-2222');
insert into emp values( emp_seq.NEXTVAL, '홍길동', '3333-2222');

증분값, 최대값, 최소값, 순환옵션 또는 캐시옵션을 변경합니다.
alter sequence emp_seq
increment by 2
maxvalue 9999
nocycle
nocache
order;

<<< 동의어 >>
테이블 또는 기타 데이터베이스 객체에 대체 이름을 제공하기 위해 생성할 수 있습니다.
긴 객체 이름을 짧게 만듭니다.
기본 스키마 객체의 ID 및 위치를 숨기는 데 유용합니다.


<<<<<<<<<<<<<<<< system >>>>>>>>>>>>>>>
grant create synonym to mc;

<<<<<<<<<<<<< MC 에서 >>>>>>>>>>>>>>
create synonym em for emp;
select * from user_synonyms;
select * from em;                     // emp 지워지면 사용 불가!

<<휴지통>>
select * from tabs;
show recyclebin;
flashback table emp;



********** 과제 ********************************************************
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
