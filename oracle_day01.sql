SQL����ǲ����ִ�Сд��,����Ϊ��
���ӿɶ���,���Խ��ؼ���ȫ����д,
�ǹؼ���ȫ��Сд.
SELECT SYSDATE FROM dual

SQL�����ݹ����в�ͬ����
DDL���(���ݶ�������)
���ڲ������ݿ����.���ݿ����
����:��,��ͼ,����,����

1:������
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

�鿴��Ľṹ:
DESC employee

ɾ����:
DROP TABLE employee

DEFAULT�ؼ���:
�����ݿ���,���е���������Ĭ��ֵ����
NULL.���ǿ���ͨ��ʹ��DEFAULT�ؼ���
Ϊָ���ֶε�������Ĭ��ֵ.

�����ݿ���,�ַ�������������ʹ�õ���
����������.��һ����Ҫע��.SQL�����Ȼ
�����ִ�Сд,�����ַ������������ִ�Сд��

NOT NULLԼ��
�ǿ�Լ��Ҫ��ָ���ֶ����κ������ֵ������
Ϊ��.
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20) NOT NULL,
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2) DEFAULT 3000,
  job VARCHAR2(30),
  deptno NUMBER(2)
)


2:�޸ı�
�޸ı�����޸ı�����ֺͱ�Ľṹ

2.1:�޸ı���:
RENAME old_name TO new_name
��employee����Ϊmyemp

RENAME employee TO myemp

DESC myemp


2.2:�޸ı�ṹ
������ֶ�,ɾ�������ֶ�,�޸������ֶ�

2.2.1:������ֶ�
��myemp��������ֶ�hiredate

ALTER TABLE myemp 
ADD(
  hiredate DATE
)

DESC myemp

2.2.2:ɾ���ֶ�
��myemp���е�hiredateɾ��

ALTER TABLE myemp
DROP(hiredate)


2.2.3:�޸������ֶ�
�޸��ֶο����޸��ֶε�����,����
���Ĭ��ֵ����Լ������.
�����޸��ֶξ����ڱ���û�����ݵ����
�½���,��������Ҫ�޸��ֶ�����,��
����Ҳ����ֻ������.��������޸�ʧ��.

ALTER TABLE myemp
MODIFY(
  job VARCHAR2(40)
)

DESC myemp


DML���(���ݲ�������)
DML���ڶԱ������ݽ�����,ɾ,�Ĳ���

1:INSERT,��������

INSERT INTO myemp
(id,name,job,deptno)
VALUES
(1,'JACK','CLERK',10)

COMMIT

SELECT * FROM myemp


INSERT����е��ֶ������Ժ���,����
���Ժ����ȫ�в���.
INSERT INTO myemp
VALUES
(2,'rose','M',SYSDATE,5000,
 'CLERK',20)

SELECT * FROM myemp

����������������
����ֱ�Ӹ����ַ���,���Ǹ�ʽ������:
'DD-MON-RR',�������õ��Ǽ�ƴ,��ͬ
���Ե���������г���,Ӣ���������Ӣ��
��ĸ��д��ʽ,��:'01-SEP-03'
�����Ļ�����Ϊ:'01-9��-03'
���Բ�����ʹ��.
����ʹ��TO_DATE����,�������ݿ��һ��
���ú���,���Խ�һ���ַ�������ָ��������
��ʽת��ΪDATEֵ.

INSERT INTO myemp
(id,name,job,deptno,birth)
VALUES
(3,'mark','CLERK',20,
 TO_DATE('1992-08-03','YYYY-MM-DD')
)
SELECT * FROM myemp



2:UPDATE,��������
��rose���Ա��Ϊ'F'

UPDATE myemp
SET gender='F',salary=6000
WHERE name='rose'

�޸ĵ�ʱ��ͨ��Ҫʹ��WHERE�Ӿ������
��������,�������Ὣ���������ļ�¼����
�޸�,������ӹ�����������ȫ�����,����
�����ʵ�ʱȽ���.


3:DELETE,ɾ�����
ɾ��rose
DELETE FROM myemp
WHERE name='rose'


SELECT * FROM myemp












