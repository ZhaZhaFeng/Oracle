�Ӳ�ѯ
�Ӳ�ѯ��һ����ѯ���,����Ƕ����
����SQL���֮�е�,Ŀ����Ϊ���
SQL�ṩ����.


�鿴��CLARK���ʸߵ�Ա��?
SELECT ename,sal,job
FROM emp
WHERE sal>(SELECT sal FROM emp
           WHERE ename='CLARK')

�鿴��CLARKͬ���ŵ�Ա��?
SELECT ename,job,deptno
FROM emp
WHERE deptno=(SELECT deptno
              FROM emp
              WHERE ename='CLARK')

�鿴���ʸ��ڹ�˾ƽ�����ʵ�Ա��?
SELECT ename,sal,deptno
FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp)


��DDL��ʹ���Ӳ�ѯ
���Ը����Ӳ�ѯ�Ľ������һ�ű����
��������

����һ�ű�,�ñ�����ֶ�:
empno,ename,sal,job,deptno,dname,loc
��������emp,dept��
CREATE TABLE employee
AS
SELECT 
 e.empno,e.ename,e.sal,e.job,
 d.deptno,d.dname,d.loc
FROM
 emp e FULL OUTER JOIN dept d
ON
 e.deptno = d.deptno

DML��ʹ���Ӳ�ѯ

��CLARK���ڲ���Ա�������ϸ�10%
UPDATE emp
SET sal=sal*1.1
WHERE deptno=(SELECT deptno FROM emp
WHERE ename='CLARK')

SELECT ename,sal
FROM emp
WHERE deptno=10


�Ӳ�ѯ���ݲ�ѯ�����ͬ���˷���:
���е����Ӳ�ѯ,���е����Ӳ�ѯ,��
���ж����Ӳ�ѯ
���е����Ӳ�ѯͨ����Ϊ��������ʹ��
�������Ӳ�ѯͨ��������ʹ��

��ʹ�ö��е����Ӳ�ѯ��Ϊ��������ʱ
Ҫ���IN,ANY,ALLʹ��:

�鿴��ְλ��MANAGERͬ���ŵ�Ա��?
SELECT ename,job,deptno
FROM emp
WHERE deptno IN(SELECT deptno 
                FROM emp
                WHERE job='MANAGER')

�鿴���ʸ���ְλ��SALESMAN��CLERK��Ա��?
SELECT ename,sal,job
FROM emp
WHERE sal >ALL(SELECT sal FROM emp
               WHERE job IN ('SALESMAN','CLERK'))


EXISTS�ؼ���
EXISTS�ڹ���������ʹ��,���Ҫ��һ��
�Ӳ�ѯ,������ע�Ӳ�ѯ���������ݵ�ֵ
�Ƕ���,ֻ��ע�Ƿ��ܲ鵽����,ֻҪ�ܲ�
������EXISTS����Ϊ��������.

�鿴��Ա���Ĳ�������Щ?
SELECT deptno,dname,loc
FROM dept d
WHERE 
 NOT EXISTS(SELECT * FROM emp e
            WHERE e.deptno=d.deptno)

�鿴˭�Ǳ��˵��쵼(��������Ա��)?
SELECT m.empno,m.ename,m.job
FROM emp m
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.mgr = m.empno
)



�鿴���нˮ����30�Ų������нˮ�Ĳ���
���нˮ���Ƕ���?
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal)>(SELECT MIN(sal) 
                 FROM emp
                 WHERE deptno=30)


�鿴˭���Լ����ڲ���ƽ�����ʸ�?
SELECT e.ename,e.sal,e.deptno
FROM emp e,(SELECT AVG(sal) avg_sal,
                   deptno
            FROM emp
            GROUP BY deptno) t
WHERE e.deptno=t.deptno
AND e.sal>t.avg_sal


�Ӳ�ѯҲ������SELECT�Ӿ���ʹ��,
���Խ��ò�ѯ�Ľ������һ���ֶε�
ֵ�г���.
SELECT 
  e.ename,e.sal,e.job,
  (SELECT d.dname FROM dept d
   WHERE e.deptno = d.deptno) dname
FROM
  emp e


��ҳ��ѯ
��һ�β�ѯ�Ľ�������������ǳ����ʱ��
�ᵼ��:���紫���ٶ���,ϵͳ��Դռ�ô��
���⵼�µ��������.����ʵ���û�Ҳ����
��һ������Ҫ��ô������������.�Դ�,����
���õİ취����"�����ֶ�"�����ݲ�ѯ����,
����Ƿ�ҳ��ѯ.�������ڷ�ҳ��ѯ��û��
���﷨������SQL��׼��,���Բ�ͬ���ݿ��
��ҳ��䲻ͬ.


ORACLE���ṩ��һ��α��:ROWNUM
���ֶ���Ϊ�������ÿ����¼��һ��
�кŵ�.���ֶβ����������κα���
�������б����Բ�ѯ���ֶ�.
��ŵĹ����ǰ����ѯ�Ĺ��̽��е�,
ֻҪ���Դӱ��в�ѯ��һ����¼,ROWNUM
�ֶε�ֵ���Ǹü�¼�ڽ�����е��к�,
��1��ʼ����.
SELECT ROWNUM,ename,sal,job
FROM emp


��ʹ��ROWNUM�Խ�������кŵĹ���
�в�Ҫʹ��ROWNUM��>1�������ֵĹ���
�ж�,����ò����κν��.��ΪROWNUM
���ڲ�ѯ���������ɵ�,ֻ�в�ѯ������
�Ż���,�Ż�����.
����SQL��ѯ�����κν��.
SELECT ROWNUM,ename,sal,job
FROM emp
WHERE ROWNUM >1 

SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT ename,sal,job
          FROM emp
          ORDER BY sal DESC) t)
WHERE rn BETWEEN 6 AND 10



SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT ename,sal,job
          FROM emp
          ORDER BY sal DESC) t
     WHERE ROWNUM <=10)
WHERE rn >=6

page:�ڼ�ҳ
pageSize:ÿҳ��ʾ����Ŀ��

start:(page-1)*pageSize+1
end:pageSize*page


DECODE����,����ʵ�ּ򵥵ķ�֧Ч��
SELECT ename, job, sal,
     DECODE(job,  
            'MANAGER', sal * 1.2,
            'ANALYST', sal * 1.1,
            'SALESMAN', sal * 1.05,
            sal
     ) bonus
FROM emp


DECODE��GROUP BY�Ӿ���
ͳ������,Ҫ��ְλ��MANAGER,ANALYST
����һ��,����ְλԱ��������һ��,�ֱ�ͳ��
����?

SELECT 
  COUNT(*),
  DECODE(job,'MANAGER','VIP',
             'ANALYST','VIP',
             'OTHER')
FROM emp
GROUP BY
  DECODE(job,
         'MANAGER','VIP',
         'ANALYST','VIP',
         'OTHER')

������
��������ROWNUM����,�����Խ����
�����к�.�����������ǽ����������
ָ�����ֶη���,Ȼ�����ڰ���ָ���ֶ�
����,֮��Ϊÿ��ļ�¼�����к�.

ROW_NUMBER:��������������Ψһ������
�鿴ÿ�����ŵĹ�������
SELECT 
 ename,sal,deptno,
 ROW_NUMBER() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
 ) rank
FROM emp


RANK����:�������ڲ�����Ҳ��Ψһ������
SELECT 
 ename,sal,deptno,
 RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
 ) rank
FROM emp


DENSE_RANK:����������������Ψһ������
SELECT 
 ename,sal,deptno,
 DENSE_RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
 ) rank
FROM emp


�߼����麯��:

�鿴ÿ��Ӫҵ��?
SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id

�鿴ÿ��Ӫҵ��?
SELECT year_id,month_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

�鿴ÿ��Ӫҵ��?
SELECT year_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

�ܹ�Ӫҵ��?
SELECT SUM(sales_value)
FROM sales_tab


�鿴ÿ��,ÿ��,ÿ��,�Լ��ܹ�Ӫҵ��?
SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
UNION ALL
SELECT year_id,month_id,NULL,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
UNION ALL
SELECT year_id,NULL,NULL,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
UNION ALL
SELECT NULL,NULL,NULL,SUM(sales_value)
FROM sales_tab


ROLLUP����
GROUP BY ROLLUP(a,b,c)
��Ч��:
GROUP BY a,b,c
UNION ALL 
GROUP BY a,b
UNION ALL 
GROUP BY a
UNION ALL 
ȫ��

SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY ROLLUP(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id


CUBE()
CUBE�����ķ��鷽ʽ�ǲ�����ÿ�����
����Ϊһ�η��鷽ʽ,���Է������Ϊ
2�Ĳ��������η�

GROUP BY CUBE(a,b,c)
ab
ac
bc
a
b
c
abc
ȫ��

SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY CUBE(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id


GROUPING SET����
GROUPING SET��ÿһ������Ϊһ�ַ��鷽ʽ,
Ȼ����Щ����ͳ�ƵĽ������һ�����������ʾ

�鿴ÿ����ÿ�µ�Ӫҵ��?
SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY 
 GROUPING SETS(
  (year_id,month_id,day_id),
  (year_id,month_id)
 )
ORDER BY year_id,month_id,day_id







