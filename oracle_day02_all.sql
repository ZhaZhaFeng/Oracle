DQL���
SELECT������ڲ�ѯ��������.
SELECT������ٰ��������Ӿ�:

SELECT�Ӿ�:����ָ����ѯ������,��
SELECT�Ӿ��п��Գ��ֱ��е��ֶ�,����
����ʽ

FROM�Ӿ�:����ָ��������Դ�ı�

�鿴emp��������
SELECT ename,job,sal,deptno 
FROM emp
WHERE sal>2000

�����WHERE�Ӿ��,����ָ����������,����
ֻ�Ὣ���������ļ�¼��ѯ����.

�鿴ÿ��Ա������н?
SELECT ename,sal,sal*12
FROM emp



�ַ�������
1:CONCAT(char1,char2)
�����ַ���

SELECT CONCAT(ename,sal)
FROM emp

SELECT 
  CONCAT(CONCAT(ename,'�Ĺ�����'),sal)
FROM emp

�����ݿ��п���ʹ��"||"��Ϊ�����ַ����Ĳ���
SELECT ename||'�Ĺ�����'||sal
FROM emp


2:LENGTH(char)
�����ַ����ĳ���

�鿴ÿ��Ա�����ֵ��ַ�����?
SELECT ename,LENGTH(ename)
FROM emp

3:LOWER,UPPER,INITCAP
���ַ���ת��Ϊȫ��д,ȫСд,����ĸ��д

dual:α��
����ѯ���������κα��޹�ʱ,����ʹ��α��.
α������һ����ʵ���ڵı�,������"����"
SELECT LOWER('HELLOWORLD'),
       UPPER('helloworld'),
       INITCAP('HELLO WORLD')
FROM dual

SELECT ename,sal,job,deptno
FROM emp
WHERE UPPER(ename)=UPPER('smith')


4:TRIM,LTRIM,RTRIM
ȥ���ַ������ߵ��ظ��ַ�,�򵥶�
ȥ������,����ȥ��������ַ�

SELECT TRIM('e' FROM 'eeeeliteeee')
FROM dual

SELECT LTRIM('eeeeliteeee','e')
FROM dual


5:LPAD(char1,n,char2),RPAD
��λ����,���Խ�char1�ַ����ﵽn���ַ�
����,��char1������,����(����)��������
��char2�ַ����ﵽ.������,�����ʼ��ȡ
��n���ַ�����.
SELECT ename,sal,LPAD(sal,5,' ')
FROM emp


6:SUBSTR(char,m[,n])
��ȡ�ַ�����m��ʼ��ȡn���ַ�
n����ָ�����߳�����ʵ�ʿ��Խ�ȡ
���ַ�����ʱ���ǽ�ȡ��ĩβ.
m�����Ǹ���,���Ǹ������Ǵӵ���λ��
��ʼ��ȡ.
��Ҫע��,���ݿ����±��1��ʼ!

SELECT 
  SUBSTR('thinking in java',-7,2)
FROM dual



7:INSTR(char1,char2[,m[,n]])
����char2��char1�е�λ��
m��ʾ�ӵڼ����ַ���ʼ����,��дĬ��Ϊ1
n��ʾ�ڼ��γ���,��дĬ��Ϊ1
SELECT 
 INSTR('thinking in java','in',4,2)
FROM
 dual


���ֺ���
1:ROUND(m[,n])
��m������������,������С����
��nλ,��n��ָ����Ĭ��Ϊ0.
n��Ϊ�������Ǳ���10λ���ϵ�����

SELECT ROUND(45.678, 2) 
FROM DUAL
SELECT ROUND(45.678, 0) 
FROM DUAL
SELECT ROUND(55.678, -2) 
FROM DUAL


2:TRUNC(m[,n])
��ȡ����,����������ROUNDһ��
SELECT TRUNC(45.678, 2) 
FROM DUAL
SELECT TRUNC(45.678, 0) 
FROM DUAL
SELECT TRUNC(55.678, -1) 
FROM DUAL


3:MOD(m,n)
������,������ʹ��m����n�õ�
��nΪ0��ֱ�ӷ���m
SELECT MOD(12,5)
FROM dual


4:CEIL,FLOOR
����ȡ��������ȡ��
SELECT CEIL(45.678) FROM dual
SELECT FLOOR(45.678) FROM dual



���ں���
��������صĹؼ���:
SYSDATE,SYSTIMESTAMP
�ֱ𷵻�DATE������ʱ������͵�
��ǰϵͳʱ��.

SELECT SYSDATE FROM dual
SELECT SYSTIMESTAMP FROM dual


1:TO_DATE����
���Խ�һ���ַ�������ָ�������ڸ�ʽ
ת��Ϊһ��DATEֵ
SELECT 
 TO_DATE('2008-08-08 20:08:08',
         'YYYY-MM-DD HH24:MI:SS')
FROM
 dual

�����ڸ�ʽ�г����˷�ʱ�ڸ�ʽ�ַ���
����֮��������ַ�ʱ,ͨ����Ҫʹ��˫����
������.
SELECT 
 TO_DATE('2008��08��08��',
         'YYYY"��"MM"��"DD"��"')
FROM
 dual

�������Ϳ��Խ��м���:
1:�����ڼӼ�һ������,��ͬ�ڼӼ�����
2:�����������,��Ϊ��������

����Ҳ���ԱȽϴ�С,Խ���Խ��

���������?
SELECT SYSDATE+1 FROM dual

�鿴ÿ��Ա����ְ�����칲��������?
SELECT ename,SYSDATE-hiredate
FROM emp


SELECT 
  TRUNC(SYSDATE-TO_DATE('1992-05-03','YYYY-MM-DD'))
FROM
  dual


2:TO_CHAR����
TO_CHAR������������DATE����ָ����
��ʽת��Ϊ�ַ���ʹ��
SELECT
 TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM
 dual

SELECT ename,sal,deptno,
 TO_CHAR(hiredate,'YYYY/MM/DD')
FROM
 emp


SELECT 
 TO_CHAR(
  TO_DATE('50-05-05','RR-MM-DD'),
  'YYYY-MM-DD'
 )
FROM
 dual


���ڳ��ú���
1:LAST_DAY(date)
���ظ������������µ��µ�����

�鿴�����µ�����?
SELECT LAST_DAY(SYSDATE)
FROM dual




2:ADD_MONTHS(date,i)
�Ը��������ڼ���ָ������,��
iΪ����,���Ǽ�ȥָ������

�鿴ÿ��Ա����ְ20���������?
SELECT 
 ename,hiredate,
 ADD_MONTHS(hiredate,12*20)
FROM
 emp


3:MONTHS_BETWEEN(date1,date2)
������������֮��������
���㷽ʽ����date1-date2�ó���

�鿴ÿ��Ա����ְ������ٸ�����?
SELECT ename,MONTHS_BETWEEN(SYSDATE,hiredate)
FROM emp


4:NEXT_DAY(date,i)
���ظ������ڵڶ��쿪ʼһ��֮���ܼ�
��Ӧ������
i������:1-7,�ֱ��ʾ����-����

SELECT NEXT_DAY(SYSDATE,6)
FROM dual



5:LEAST,GREATEST
����Сֵ�����ֵ
�����ܱȽϴ�С���������Ͷ�����ʹ��
����������,�������ڶ���,��Сֵ���
�������������,���ֵ��ľ��������
����.
SELECT 
 LEAST(SYSDATE,TO_DATE('2008-10-10',
                       'YYYY-MM-DD')) 
FROM dual


6:EXTRACT()
��ȡָ������ָ��ʱ�������ֵ
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM dual

�鿴1982����ְ��Ա��?
SELECT ename,hiredate
FROM emp
WHERE EXTRACT(YEAR FROM hiredate)=1982



��ֵ����
CREATE TABLE student(
  id NUMBER(4), 
  name CHAR(20), 
  gender CHAR(1)
);

INSERT INTO student VALUES(1000, '��Ī��', 'F');

INSERT INTO student VALUES(1001, '��ƽ֮', NULL);

INSERT INTO student(id, name) VALUES(1002, '���޼�');


���³�NULL
UPDATE student
SET gender=NULL
WHERE id=1000

���Ա�ΪNULL��ɾ��
�ڹ����������ж�ʱ,Ҫʹ��:
IS NULL,IS NOT NULL

DELETE FROM student
WHERE gender IS NULL

SELECT * FROM student


��ֵ����:
�ַ�����NULL���ӵ���ʲôҲû��
������NULL����������NULL

SELECT ename||NULL
FROM emp

�鿴ÿ��Ա����������(����+��Ч)
SELECT ename,sal,comm,sal+comm
FROM emp

��ֵ����
1:NVL(arg1,arg2)
��arg1ΪNULLʱ,��������arg2��ֵ
����ΪNULL,��������arg1.
����NVL�����������ǽ�NULL�滻Ϊһ����NULLֵ

�鿴ÿ��Ա����������(����+��Ч)
SELECT ename,sal,comm,
       sal+NVL(comm,0)
FROM emp

�鿴ÿ��Ա���ļ�Ч���,��:
��Ч��ΪNULL��,����ʾΪ"�м�Ч"
ΪNULL������ʾΪ"û�м�Ч"

2:NVL2(arg1,arg2,arg3)
��arg1��ΪNULLʱ,��������arg2
arg1ΪNULLʱ,��������arg3

SELECT 
 ename,comm,
 NVL2(comm,'�м�Ч','û�м�Ч')
FROM
 emp

SELECT 
 ename,sal,comm,
 NVL2(comm,comm+sal,sal)
FROM
 emp



