DQL ���ݲ�ѯ����

��SELECT�Ӿ��п���Ϊ�ֶ���ӱ���
�����ڽ�����ж�Ӧ�ĸ��ֶε����־���
�������.
��SELECT�Ӿ��е��ֶ��Ǻ������߱��ʽ
��ʱ��,ͨ��Ӧ��Ϊ��ָ������.

���������ִ�Сд,Ҳ���ܺ��пո�,
��ϣ�����ֻ��пո�,��ô����ʹ��
˫�����������,�����Ϳ�����.
SELECT ename,sal*12 "sal"
FROM emp


AND,OR�������Ӷ������
SELECT ename,sal,job
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

AND�����ȼ��Ǹ���OR��,����ͨ��
ʹ�����������OR�����ȼ�.


LIKE�ؼ���
LIKE����ģ��ƥ���ַ���
֧������ͨ���:
_:��һ��һ���ַ�
%:������ַ�(0-���)

�鿴�����еڶ�����ĸ��A��Ա��?
SELECT ename,sal,job
FROM emp
WHERE ename LIKE '_A%'

SELECT ename,sal,job
FROM emp
WHERE ename LIKE '%A%K%'



IN(list),NOT IN(list)
�ж����б��е����ݻ����б��е�����
IN,NOT IN���������Ӳ�ѯ��.
�鿴ְλ��CLERK��SALESMAN��Ա��?
SELECT ename,job,sal
FROM emp
WHERE job IN ('CLERK','SALESMAN')


BETWEEN...AND...
�ж���һ����Χ��

�鿴������1500��3000��Ա��?
SELECT ename,sal,job
FROM emp
WHERE sal BETWEEN 1500 AND 3000


ANY(list),ALL(list)
���жϴ���,С��,���ڵ���,С�ڵ���
���ֵ��ʱ��,Ҫ���ANY,ALLʹ��
>ANY(list):��������֮һ(������С)
>ALL(list):��������(�������)
<ANY(list):С������֮һ(С�����)
<ALL(list):С������(С����С)
ANY,ALL�����ж��Ӳ�ѯ��,����ͨ���б�
�в�����̶ֹ�ֵ(û����).


DISTINCT�ؼ���
ȥ���������ָ���ֶ����ظ�ֵ�ļ�¼

�鿴��˾����Щְλ?
SELECT DISTINCT job FROM emp

���ֶ�ȥ��ʱ,���ٱ�֤ÿ���ֶ�һ��
û���ظ���¼,���ǿ��Ա�֤��Щ�ֶ�
ֵ�����û���ظ���¼.
SELECT DISTINCT job,deptno
FROM emp


�������
ORDER BY�Ӿ���Խ����������ָ����
�ֶν��������������
ORDER BY�Ӿ���붨����DQL�������
һ���Ӿ���.
����:ASC��ʾ����(��дĬ�Ͼ�������),
DESCΪ����.

�鿴��˾��������?
SELECT ename,sal
FROM emp
ORDER BY sal DESC

������԰��ն��ֶ�����,�����������
���ȼ�,��:�Ȱ��յ�һ���ֶ���������
����һ���ֶ����ظ�ֵʱ,��Щ��¼����
�ڶ����ֶ�����,�Դ�����.

SELECT ename,deptno,sal
FROM emp
ORDER BY deptno DESC,sal DESC


������ֶκ���NULLֵʱ,NULL���϶�Ϊ
���ֵ
SELECT ename,comm
FROM emp
ORDER BY comm


�ۺϺ���
�ۺϺ����ֳ�Ϊ���к���,���麯��
�ۺϺ���������ͳ�ƽ�������ݵ�.

�������ĸ��Ƕ�ֵ��ͳ��:
MAX,MIN,SUM,AVG

����һ���ǶԼ�¼��ͳ�Ƶ�:
COUNT

�鿴��˾���������͹����Ƕ���?
SELECT MAX(sal),MIN(sal) FROM emp

�鿴�����ܺ���ƽ������?
SELECT SUM(sal),AVG(sal) FROM emp

�鿴��˾��������?
SELECT COUNT(ename) FROM emp

�ۺϺ�������NULLֵ.
SELECT SUM(comm) FROM emp
SELECT AVG(comm) FROM emp
SELECT AVG(NVL(comm,0)) FROM emp

���¼���ĳ���д��
SELECT COUNT(*) FROM emp
SELECT COUNT(1) FROM emp



����
GROUP BY�Ӿ�
GROUP BY�������ǰ���ָ���ֶζ�
���м�¼���з���,ԭ���Ǹ��ֶ�ֵ
һ���ļ�¼������һ��.
������Ϊ����ϾۺϺ�������ϸ��ͳ��

�鿴ÿ�����ŵ�ƽ������?
SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

��SELECT�Ӿ����оۺϺ���ʱ,��ô��
���ھۺϺ����еĵ����ֶζ����������
GROUP BY�Ӿ���.

�鿴ÿ��ְλ����߹���?
SELECT MAX(sal),job
FROM emp
GROUP BY job

�鿴ÿ�����Ÿ�������?
SELECT COUNT(*),deptno
FROM emp
GROUP BY deptno

�鿴���ŵ�ƽ������,ǰ���Ǹò���
ƽ������Ҫ����2000

SELECT AVG(sal),deptno
FROM emp
WHERE AVG(sal)>2000
GROUP BY deptno

WHERE�в���ʹ�þۺϺ�����Ϊ����
����,ԭ������:����ʱ������
WHERE���ڼ����������ݵ�ʱ�����
����ʹ�õ�.���ۺϺ�������Ϊͳ��
ʹ�õ�,��ôͳ�Ƶ�ǰ����������.
���Ƿ���������WHERE������.
�������������Ӧ���ǽ��������ݶ�
��ѯ����(WHERE�Ѿ��������)���
�ܽ��з���,֮�����ͳ�ƽ��,Ȼ��
�ſ��԰��վۺϺ����Ľ�����й���.

HAVING�Ӿ�
HAVING�Ӿ�������GROUP BY�Ӿ�֮��
��:������GROUP BY�Ӿ�Ͳ��ܵ�������
HAVING�Ӿ�

HAVING�Ӿ���ӹ�����������������
GOURP BY�Ӿ�ִ�еķ����.��:ֻ����
��HAVING�Ӿ������ķ��鱣��

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000


�鿴ƽ�����ʸ���2000��Щ���ŵ�
��߹�������͹��ʷֱ��Ƕ���?
SELECT MAX(sal),MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000
 
 
 
������ѯ 
��ѯ���ű�,���ݱ��������ݵĶ�Ӧ
��ϵ���й�����ѯ,������һ�������
�ý����ÿ����¼�е��ֶξ�������
Щ��.
 
�鿴ÿ��Ա���Լ������ڲ��ŵ�����?
SELECT ename,dname 
FROM emp,dept
WHERE emp.deptno=dept.deptno
 
����Ϊ�������,���������ֶ��ڱ�ע��ʱ��
����ֻ�ñ������ָ���ֶ�����.
���������ű�����ͬ���ֶ�ʱ,���ֶα���
��ע�������ű�.
SELECT e.ename,e.deptno,d.dname 
FROM emp e,dept d
WHERE e.deptno=d.deptno
 
������ѯ��Ҫָ����������,���Ҳ�����
���������ļ�¼�ᱻ����.
N�ű�����,����Ҫ��N-1����������.
������������ͨ��Ҫͬʱ����.
����й�������ʱ,��������ҲҪ������
����ͬʱ����.
����ָ����������������������Чʱ,��
���ֵѿ�����(��ͨ����һ��������Ľ����)
 
�鿴��NEW YORK������Ա��?
SELECT e.ename,e.job,
       d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.loc='NEW YORK'


SELECT e.ename,d.dname
FROM emp e,dept d


������
�����ӵĲ�ѯ��������ͨ�Ĺ�����ѯ
����һ��,д����ͬ.

��ѯԱ�������Լ������ڲ�������?
SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno

�鿴��NEW YORK������Ա��? 
SELECT e.ename,d.dname 
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.loc='NEW YORK'
 
 
������
�����ӿ��Խ����������������ļ�¼
Ҳ��ѯ����.�����ӷ�Ϊ:
��������,��������,ȫ������
��������:��JOIN������Ϊ������,
�ñ������м�¼��Ҫ��ѯ����,��ô��
���������������ļ�¼,��ô�����Ҳ�
����ֶε�ֵȫ��ΪNULL.

�鿴ÿ��Ա���Լ������ڵĲ�����?
SELECT e.ename,e.sal,
       d.dname,d.loc
FROM emp e 
 LEFT|RIGHT|FULL OUTER JOIN 
     dept d
ON e.deptno=d.deptno
 
SELECT e.ename,e.sal,
       d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno
 
������
��ǰ���һ�����ݶ�Ӧ��ǰ���Լ���
��������,�����ı���ƾ���������.
�����ӿ��Ա�������������ͬ,����
�ִ������¼���ϵ����״�ṹ����ʹ��.

�鿴ÿ��Ա���������Լ�����˾������?
����:SMITH����˾��FORD
SELECT e.ename||'����˾��'
       ||NVL(m.ename,'û��') 
FROM emp e,emp m 
WHERE e.mgr=m.empno(+) 
 
 
 
 
 
 
 
 


 