select * from tabs;

drop table job cascade constraint;
drop table employee cascade constraint;
drop table depart cascade constraint;
drop table test cascade constraint;
drop table emp_bk cascade constraint;

<<CMD창에서 바로 로그인 X
추가할 파일이 있는 디렉토리까지 이동
MC계정으로 로그인

select * from tabs;

insert into dh_member values('user6', 7, '111', '홍길동', 990505, '010-1111-2222', '40750', '서울시', NULL, sysdate)
insert into dh_member values('user7', 7, '111', '이순신', 990505, '010-2222-2222', '40750', '서울시', NULL, sysdate)

select * from dh_goods;
select * from dh_goods where goods_number = 5;