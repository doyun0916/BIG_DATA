define num = 1234.5678
select round('&num') from dual;
select round('&num', 0) from dual;
select round('&num', 2) from dual;
select round('&num', -1) from dual;

select last_name �̸�, salary ����, round(salary/12, 2) ����
from employees;

# ������!
select trunc('&num') from dual;
select trunc('&num', 0) from dual;
select trunc('&num', 2) from dual;
select trunc('&num', -1) from dual;

select last_name �̸�, salary ����, trunc((salary+salary*commission_pct)/12, 2) ����
from employees
where commission_pct is not null;

select ceil(3.12) from dual;
select floor(3.12) from dual;
select mod(5, 2) from dual;

undefine num;

// �� ��ǻ�� �ð��� ������.
select sysdate from dual;

select last_name �̸�, hire_date �Ի���, trunc(sysdate - hire_date, 0) �ٹ��ϼ�
from employees;

select sysdate - to_date('95/12/20') from dual;
select months_between(sysdate, '95/12/20') from dual;
select last_name �̸�, hire_date �Ի���, months_between(sysdate, hire_date) �ٹ�����
from employees;

select add_months(sysdate, 24) from dual;

select last_name �̸�, hire_date �Ի���, add_months(hire_date, 24) ������
from employees;

// ����, �� ���� ������ �� ���
select last_day(sysdate) from dual;
select last_day('20/02/01') from dual;
select last_day('21/02/01') from dual;
select last_name �̸�, hire_date �Ի���, last_day(hire_date) ù����
from employees;

select last_name �̸�, hire_date �Ի���, last_day(add_months(hire_date, 6)) ù�󿩱�
from employees;

// ���� ȭ������ ������~
select next_day(sysdate, 'Tuesday') from dual;
// ���� �������� ������~
select next_day(sysdate, 4) from dual;

select round(sysdate, 'MONTH') from dual;
select trunc(sysdate, 'MONTH') from dual;
select round(sysdate, 'YEAR') from dual;
select trunc(sysdate, 'YEAR') from dual;

// <width_bucket>
select width_bucket(75, 0, 100, 10) from dual;
// 0���� 100���̸� 10���� �ɰ���, 75�� �� ����ΰ�?
select width_bucket(100, 0, 100, 10) from dual;
select width_bucket(75, 100, 0, 10) from dual;
// ����� ������ �������� ������!
select width_bucket(sysdate, to_date('73/01/18'), add_months('73/01/18', 1200), 20) from dual;  
// �¾ ������ 100���� ��µ�, ���� ��¥�κ��� ���� ����° ��ҳ�!

select employee_id ���, last_name �̸�, salary ����, hire_date �Ի���,
width_bucket(hire_date, sysdate, to_date('00/01/01'), 30)*1000 ����
from employees
order by ���� desc;
// ����� ������ ��������, ���� ��. ���� ��¥�� hire_date�� ������, ����� ����. �׷��Ƿ� ������.

// ����, ���ڰ� ��ȯ & ����, ��¥�� ��ȯ�� ����!
// to_char(), to_number(), to_date()

// ��¥�� ���: YYYY, YEAR(���� ö�ڷ� ����), MM, MONTH, MON, DY, DAY, DD
select sysdate from dual;
select to_char(sysdate, 'YYYY-MM-DD DY') from dual;
select to_char(sysdate, 'YY-MM-DD DAY') from dual;
select to_char(sysdate, 'YEAR MONTH DD HH:MI:SS') from dual;
select to_char(sysdate, 'YEAR MONTH DD HH24:MI:SSSSS') from dual;
select to_char(sysdate, 'DD') from dual;
select to_char(sysdate, 'YY/MM/DDTH HH24:MI:SS AM DY') from dual; // AM�̵� PM�̵� ��� ���� �˾Ƽ� ��.

select to_char(12345.678, '999999') from dual;
select to_char(12345.678, '0999999') from dual;   // ���� �տ� 00�ִ°��� �����ش�. ���Ϳ� �� 00����.
select to_char(12345.678, '0999999.99') from dual;
select to_char(12345.678, '0,999,999.99') from dual;
select to_char(12345.678, 'L0,999,999.99') from dual;
select to_char(12345.678, '9999.99EEEE') from dual;       // ǥ��� . �ʼ�!
select to_char(12345.678, '99999V99') from dual;  // �Ҽ��� �� �ڷ� ��������
select to_char(12345, '99999.99') from dual;    // �Ҽ��� ǥ�� �ϵ��� ����.
select to_char(12345, 'B99999.99') from dual;   // ���� ����.

select last_name �̸�, hire_Date �Ի���
from employees
where hire_date = to_date('05/07/24');


*************************** ���� 1 *********************************************
select employee_id ���, last_name �̸�, hire_date �Ի���,
to_number(to_char(sysdate, 'YY'))-to_number(to_char(hire_date, 'YY')) �ټӿ���, 
to_number(to_char(sysdate, 'MM'))-to_number(to_char(hire_date, 'MM')) �ټӿ���,
to_number(to_char(sysdate, 'DD'))-to_number(to_char(hire_date, 'DD')) �ټ��ϼ�
from employees
order by �ټӿ��� desc, �ټӿ��� desc, �ټ��ϼ� desc;

select employee_id ���, last_name �̸�, hire_date �Ի���,
to_number(to_char(sysdate, 'YY'))-to_number(to_char(hire_date, 'YY')) �ټӿ���, 
to_number(to_char(sysdate, 'MM'))-to_number(to_char(hire_date, 'MM')) �ټӿ���,
to_number(to_char(sysdate, 'DD'))-to_number(to_char(hire_date, 'DD')) �ټ��ϼ�,
sysdate-hire_date a,
(to_number(to_char(sysdate, 'YY'))-to_number(to_char(hire_date, 'YY')))*12*30+ 
to_number(to_char(sysdate, 'MM'))-to_number(to_char(hire_date, 'MM'))*12+
to_number(to_char(sysdate, 'DD'))-to_number(to_char(hire_date, 'DD')) b
from employees
order by �ټӿ��� desc, �ټӿ��� desc, �ټ��ϼ� desc;

select employee_id ���, last_name �̸�, hire_date �Ի���,
to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY')) �ټӿ���, 
(months_between(sysdate, hire_date)/12 - trunc(to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY'))))*12 �ټӿ���,
((months_between(sysdate, hire_date)/12 - trunc(to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY'))))*12)
-trunc((months_between(sysdate, hire_date)/12 - trunc(to_number(to_char(sysdate, 'YY')) - to_number(to_char(hire_date, 'YY'))))*12) �ټ��ϼ�
from employees
order by �ټӿ��� desc, �ټӿ��� desc, �ټ��ϼ� desc;

select employee_id ���, last_name �̸�, hire_date �Ի���,
(((sysdate-hire_date)/360)*12) �ټӿ���,
(sysdate-hire_date)/12 �ټӿ���,
sysdate-hire_date �ټ��ϼ�
from employees
order by �ټӿ��� desc, �ټӿ��� desc, �ټ��ϼ� desc;

select last_day('16/02/01') from dual;

select to_char(sysdate, 'YEAR MONTH DD HH:MI:SS') from dual;
select to_char(sysdate, 'YYYY MM DD HH24:MI:SSSSS') from dual;
