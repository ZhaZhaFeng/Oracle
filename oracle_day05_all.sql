��ͼ
��ͼ�����ݿ����֮һ
��ͼ��SQL��������ֵĽ�ɫ���һ��,
����ͼ��������ʵ�ı�,ֻ�Ƕ�Ӧ��һ��
��ѯ���Ľ����.
CREATE VIEW v_emp_10
AS
SELECT empno, ename, sal, deptno 
FROM emp 
WHERE deptno = 10

�鿴��ͼ�Ľṹ:
DESC v_emp_10

��ѯ��ͼ:
SELECT * FROM v_emp_10

��ͼ��Ӧ���Ӳ�ѯ����Ϊ�ֶ�ָ������
��ô����ͼ��Ӧ���ֶξ�Ϊ�������.
��Ҫע��,����ͼ��Ӧ���Ӳ�ѯ�е��ֶ�
�Ǻ������߱��ʽ,��ô���ֶα���Ҫ
ָ������.

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10

SELECT * FROM v_emp_10


��ͼ��Ϊ:����ͼ�͸�����ͼ
����ͼ:��ͼ��Ӧ���Ӳ�ѯ�е�SELECT
�Ӿ��ﲻ���к���,���ʽ,ȥ��.�Ҳ�ѯ
�����з���,������ѯ����.
������ͼ:���Ǽ���ͼ���Ǹ�����ͼ.
һ����ͼ��Ӧ���Ӳ�ѯ�й�����ѯ������,
�ֳ�Ϊ"������ͼ",������ͼ�Ǹ�����ͼ��һ��

����ͼ����DML����
����ͼ����DML���Ƕ���ͼ������Դ��"������"
���е�.ֻ�ܶԼ���ͼ����DML����.

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,10)

SELECT * FROM v_emp_10
SELECT * FROM emp

UPDATE v_emp_10
SET salary=6000
WHERE id=7839

DELETE FROM v_emp_10
WHERE id=7839


����ͼ����DML����Υ������Լ��,����
����ʧ��.
����ͼ����DML����������Ի�������
����"������Ⱦ",��:ͨ����ͼ����DML
����Ӱ������,��ͼ�Ըü�¼���ɼ�.

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,20)

UPDATE v_emp_10
SET deptno=20

SELECT * FROM emp
SELECT * FROM v_emp_10

ֻ��DELETE��䲻�������Ⱦ.
DELETE FROM v_emp_10
WHERE deptno=20

Ϊ��ͼ��Ӽ��ѡ��,�������Ա�����Ϊ
����������ͼ���Ի���������Ⱦ.
���ѡ���Ҫ�����ͼ����DML��������ͼ
���Կ����ü�¼,����ò�����������.
WITH CHECK OPTION


CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,20)

UPDATE v_emp_10
SET deptno=20

SELECT * FROM v_emp_10
SELECT * FROM emp


����ͼ���ֻ��ѡ���,����ͼ������
����DML����
WITH READ ONLY

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,10)

UPDATE v_emp_10
SET salary=2000


�����ֵ�
�����ֵ������ݿ�����ά����һ���
��Щ���м�¼��һЩ�嵥,�������Ǻ���
�鿴
USER_OBJECTS:�û����������������ݿ����
USER_VIEWS:�û���������������ͼ
USER_TABLES:�û������������б�

SELECT object_name,object_type
FROM user_objects
WHERE object_type='VIEW'
AND object_name LIKE '%FANCQ'

SELECT view_name,text
FROM user_views

SELECT table_name
FROM user_tables


������ͼ
����һ�����Ź����������ͼ
����:����id,��������,���,���,ƽ���͹���
�ܺ�.

CREATE VIEW v_dept_sal
AS
SELECT d.deptno,d.dname,
       MAX(e.sal) max_sal,
       MIN(e.sal) min_sal,
       SUM(e.sal) sum_sal,
       AVG(e.sal) avg_sal
FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY d.deptno,d.dname


SELECT * FROM v_dept_sal

�鿴˭�Ǹ����Լ����ڲ���ƽ�����ʵ�?
SELECT e.ename,e.deptno,e.sal
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

�鿴ÿ��������߹��ʵ�Ա����˭?
SELECT e.ename,e.sal,v.dname
FROM emp e JOIN v_dept_sal v
ON e.deptno=v.deptno
WHERE e.sal=v.max_sal

ɾ����ͼ:
DROP VIEW v_emp_10


����
����Ҳ�����ݿ����֮һ
������������ָ���Ĺ�������һϵ������ʹ��
ͨ��ʹ��������Ϊĳ�������ֶ��ṩֵ

CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

����֧������α��������ȡ�������ɵ�����
NEXTVAL:��ȡ��һ������,������½�����
��ô�᷵��START WITHָ������,�Ժ�����
����������ɵ����ּ��ϲ����õ���������.
��Ҫע��,NEXTVAL�ᵼ�����в���,��������
�ǲ��ܻ��˵�.

CURRVAL:��ȡ���е�ǰ����(���һ��ͨ��
NEXTVAL��ȡ������)
������´��������б���Ҫ���ٵ���һ��NEXTVAL
��ſ���ʹ��CURRVAL

SELECT seq_emp_id.NEXTVAL
FROM dual

SELECT seq_emp_id.CURRVAL
FROM dual

INSERT INTO emp
(empno,ename,sal,job,deptno)
VALUES
(seq_emp_id.NEXTVAL,'JACK',
 2000,'CLERK',10)
 
SELECT * FROM emp

ɾ������
DROP SEQUENCE seq_emp_id



����
���������ݿ����֮һ
������Ŀ���Ǽӿ��ѯЧ��.
������Ϊ��������,ȥ��,���������������
�ֶο���Ϊ���������.
�����Ľ�����ʹ�������ݿ�������ɵ�.





Լ��

Ψһ��Լ��:
Ψһ��Լ��Ҫ����ֶε�ֵ�����ű���ÿ��
��¼��ֵ�ǲ������ظ���,NULL����
CREATE TABLE employees2(
  eid NUMBER(6) UNIQUE,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE,
  CONSTRAINT employees_email_uk UNIQUE(email)
)
INSERT INTO employees2
(eid,name,email)
VALUES
(NULL,'JACK',NULL)

SELECT * FROM employees2


����Լ��
����Լ��һ�ű�ֻ����һ��.Ҫ��ǿ���Ψһ
�����ֶ�:ͨ����ĵ�һ���ֶξ��������ֶ�,
���ֶε�������������ֶε�ֵ����Ψһȷ��
���е�һ����¼.

CREATE TABLE employees3 (
  eid NUMBER(6) PRIMARY KEY,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE
)

INSERT INTO employees3
(eid,name)
VALUES
(NULL,'JACK')




