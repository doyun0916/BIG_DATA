select employee_id ���, last_name �̸�, hire_date �Ի���,
trunc(months_between(sysdate, hire_date)/12) �ټӿ���,
trunc(mod(months_between(sysdate, hire_date), 12)) �ټӿ���,
trunc(sysdate - add_months(hire_date, months_between(sysdate, hire_date))) �ټ��ϼ�
from employees
order by �ټӿ��� desc, �ټӿ��� desc, �ټ��ϼ� desc;

// �ΰ� �ڷ��� ���������
select last_name �̸�, nvl(to_char(department_id), '����') �μ�
from employees;

CASE (WHEN~ THEN) ELSE ~ END
select last_name �̸�, department_id �μ�,
case when department_id = 90 then '�񼭽�'
    when department_id = 100 then '�λ��'
    when department_id = 50 then '�����'
    else '������'
end �μ���
from employees;

select employee_id ���, last_name �̸�, trunc(months_between(sysdate, hire_date)/12)+1 "�ټӿ���",
case when trunc(months_between(sysdate, hire_date)/12) >= 18+1 then '�̻�'
    when trunc(months_between(sysdate, hire_date)/12) >= 15+1 then '����'
    when trunc(months_between(sysdate, hire_date)/12) >= 12+1 then '����'
    when trunc(months_between(sysdate, hire_date)/12) >= 9+1 then '�븮'
else '���' end "����"
from employees
order by �ټӿ��� desc;

select last_name �̸�, job_id ����, 
decode(job_id, 'IT_PROG', '���α׷���', 'SA_MAN', '������Ŵ���', 'ST_MAN', '������', '�Ǹ�') ������
from employees;

select avg(salary) ���, sum(salary) ��, max(salary) �ְ�, min(salary) ����, stddev(salary) ���� 
from employees
where department_id = 50;

select count(last_name) from employees;
select count(department_id) from employees;
select count(*) from employees;

// �Ʒ� �ΰ��� �ٸ� �ǹ�.
select count(distinct department_id) from employees;
select distinct department_id from employees;

// �׷��Լ��� �⺻������ null���� ������.

select department_id �μ�, avg(salary) ����
from employees
group by department_id;

select department_id �μ�, job_id ����, avg(salary) ��տ���
from employees
group by department_id, job_id
order by department_id;

// group ���� ���� ���� ��󳻴°� (where��)!
select department_id �μ�, job_id ����, avg(salary) ��տ���
from employees
where salary <= 10000
group by department_id, job_id
order by department_id;

// group by����, ������ �ٲ�� ���� �ٲ��! (����� ��� ����.)
select department_id �μ�, job_id ����, avg(salary) ��տ���
from employees
group by job_id, department_id
order by job_id;
select job_id ����, department_id �μ�, avg(salary) ��տ���
from employees
group by job_id, department_id
order by job_id;

select department_id �μ�, trunc(avg(salary), 2)
from employees
where salary >= 8000
group by department_id;

// group ���� �Ŀ� �����ϴ°� (having ��)!
select department_id �μ�, trunc(avg(salary), 2)
from employees
group by department_id

select department_id �μ�, trunc(avg(salary), 2)
from employees
group by department_id
having avg(salary) <= 8000;

// �μ��ο��� 2�� �̻��� �μ��� �μ���ȣ�� ��տ��� ���
select department_id �μ���ȣ, trunc(avg(salary), 2) ��տ���
from employees
group by department_id
having count(department_id)>=2          // having count(*)>=2

// where ���� group function �Ұ�.

<�м��Լ�>
select last_name �̸�, avg(salary) from employees;  // �� ���� ����ġ�� ���� x
select last_name �̸�, avg(salary) over() from employees; // avg������ �ึ�� �����.

select last_name �̸�, avg(salary) over(order by salary) from employees; // ó������ ���������� ���...

// ù��° row ���� �ڱ���� ù��° ���� ������ ���� ������ ������ִ°�. last_value �غ��� ��.
select last_name �̸�, salary ����, first_value(salary) over(order by salary) ��������
from employees;

select last_name �̸�, salary ����, last_value(salary) over(order by salary) ������
from employees;

// windowing = ������ �������ִ� ��.
select last_name �̸�, salary ����, first_value(salary) over(order by salary rows 3 preceding) ��������     // ���� 3���ϰ� �ڱ���� �ؼ� ���.
from employees;

// following��, �� preceding�� �־����.
select last_name �̸�, salary ����, last_value(salary) over(order by salary rows between 3 preceding and 2 following)  // ���� 3���ϰ� �ڱ�, �ڿ� 2������ �ؼ� ���.
from employees;

select last_name �̸�, salary ����, count(*) over() �ο���
from employees;

// �ο��� ����.
select last_name �̸�, salary ����, count(*) over() �����ο���
from employees;
select last_name �̸�, salary ����, count(*) over(order by salary desc) �����ο���
from employees;

select last_name �̸�, salary ����, row_number() over(order by salary desc), rank() over(order by salary desc), dense_rank() over(order by salary desc) from employees;

/////////////////////����////////////////////////////////////
// ����, �ְ�, widowing�� �Ͽ� ����.
first_value() over()
last_value() over()

// ���.
count() over()
sum() over()
avg() over()

// ���� �ű�.
row_number over()
rank() over()
dense_rank() over()
/////////////////////////////����///////////////////////////////////

<group by Ȯ��>
group by (a, b, c)                    // (a, b, c)
group by rollup(a, b, c)           // (a, b, c) (a, b) (a) () -> ���� �����ʲ� ���ָ鼭 �߰��� ������.
group by cube(a, b, c)           // (a, b, c) (a, b) (a, c) (b, c) (a) (b) (c) ()
group by grouping sets(a, b, c)           // cube���� �ʿ��� �͸� ��� ��밡��.

select department_id �μ�, job_id ����, avg(salary) from employees
group by department_id, job_id
order by department_id;

/// (department_id, job_id)  (department_id) --> ������ null�� �͵�  ()  --> �μ�, ������ ��ü �� null�� �͵�(��ü ���).
select department_id �μ�, job_id ����, avg(salary)
from employees
group by rollup (department_id, job_id)
order by department_id;

select department_id �μ�, job_id ����, avg(salary)
from employees
group by cube (department_id, job_id)
order by department_id;

select department_id �μ�, job_id ����, avg(salary)
from employees
group by grouping sets( (department_id, job_id), (job_id), ())
order by department_id;

������ �ټӿ����� 1000�� ���ϰ� ������ ������ ������ ����.
�� 1���� �� �� �ٹ� ���� ���� ����ؼ�, 3���� �� �߰��� 250�� ���Ѵ�.
��) 2���� 250
6���� 500
8���� 750
10���� 1000

select last_name �̸�,
case when trunc(mod(months_between(sysdate, hire_date), 12)) < 3 then 250+trunc(months_between(sysdate, hire_date)/12)*1000
    when trunc(mod(months_between(sysdate, hire_date), 12)) >= 3 and trunc(mod(months_between(sysdate, hire_date), 12)) < 6 then 500+trunc(months_between(sysdate, hire_date)/12)*1000
    when trunc(mod(months_between(sysdate, hire_date), 12)) >= 7 and trunc(mod(months_between(sysdate, hire_date), 12)) < 9 then 750+trunc(months_between(sysdate, hire_date)/12)*1000
else 1000
end ����
from employees
order by ���� desc;


// Join ����: natural join(=equijoin, =equaljoin), self-join, nonequijoin
