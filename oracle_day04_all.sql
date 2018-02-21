子查询
子查询是一条查询语句,它是嵌套在
其他SQL语句之中的,目的是为外层
SQL提供数据.


查看比CLARK工资高的员工?
SELECT ename,sal,job
FROM emp
WHERE sal>(SELECT sal FROM emp
           WHERE ename='CLARK')

查看与CLARK同部门的员工?
SELECT ename,job,deptno
FROM emp
WHERE deptno=(SELECT deptno
              FROM emp
              WHERE ename='CLARK')

查看工资高于公司平均工资的员工?
SELECT ename,sal,deptno
FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp)


在DDL中使用子查询
可以根据子查询的结果当作一张表快速
创建出来

创建一张表,该表包含字段:
empno,ename,sal,job,deptno,dname,loc
数据来自emp,dept表
CREATE TABLE employee
AS
SELECT 
 e.empno,e.ename,e.sal,e.job,
 d.deptno,d.dname,d.loc
FROM
 emp e FULL OUTER JOIN dept d
ON
 e.deptno = d.deptno

DML中使用子查询

将CLARK所在部门员工工资上浮10%
UPDATE emp
SET sal=sal*1.1
WHERE deptno=(SELECT deptno FROM emp
WHERE ename='CLARK')

SELECT ename,sal
FROM emp
WHERE deptno=10


子查询根据查询结果不同做了分类:
单行单列子查询,多行单列子查询,和
多行多列子查询
其中单列子查询通常作为过滤条件使用
而多列子查询通常当作表使用

当使用多行单列子查询作为过滤条件时
要配合IN,ANY,ALL使用:

查看和职位是MANAGER同部门的员工?
SELECT ename,job,deptno
FROM emp
WHERE deptno IN(SELECT deptno 
                FROM emp
                WHERE job='MANAGER')

查看工资高于职位是SALESMAN和CLERK的员工?
SELECT ename,sal,job
FROM emp
WHERE sal >ALL(SELECT sal FROM emp
               WHERE job IN ('SALESMAN','CLERK'))


EXISTS关键字
EXISTS在过滤条件中使用,其后要跟一个
子查询,它不关注子查询具体查出数据的值
是多少,只关注是否能查到数据,只要能查
到数据EXISTS则认为满足条件.

查看有员工的部门是哪些?
SELECT deptno,dname,loc
FROM dept d
WHERE 
 NOT EXISTS(SELECT * FROM emp e
            WHERE e.deptno=d.deptno)

查看谁是别人的领导(有下属的员工)?
SELECT m.empno,m.ename,m.job
FROM emp m
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.mgr = m.empno
)



查看最低薪水高于30号部门最低薪水的部门
最低薪水各是多少?
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal)>(SELECT MIN(sal) 
                 FROM emp
                 WHERE deptno=30)


查看谁比自己所在部门平均工资高?
SELECT e.ename,e.sal,e.deptno
FROM emp e,(SELECT AVG(sal) avg_sal,
                   deptno
            FROM emp
            GROUP BY deptno) t
WHERE e.deptno=t.deptno
AND e.sal>t.avg_sal


子查询也可以在SELECT子句中使用,
可以将该查询的结果当作一个字段的
值列出来.
SELECT 
  e.ename,e.sal,e.job,
  (SELECT d.dname FROM dept d
   WHERE e.deptno = d.deptno) dname
FROM
  emp e


分页查询
当一次查询的结果集中数据量非常大的时候
会导致:网络传输速度慢,系统资源占用大等
问题导致的拖慢情况.并且实际用户也很少
能一次性需要这么大批量的数据.对此,我们
常用的办法就是"分批分段"将数据查询出来,
这就是分页查询.但是由于分页查询并没有
将语法定义在SQL标准中,所以不同数据库的
分页语句不同.


ORACLE中提供了一个伪列:ROWNUM
该字段是为结果集中每条记录编一个
行号的.该字段并不存在与任何表中
但是所有表都可以查询该字段.
编号的过程是伴随查询的过程进行的,
只要可以从表中查询出一条记录,ROWNUM
字段的值就是该记录在结果集中的行号,
从1开始递增.
SELECT ROWNUM,ename,sal,job
FROM emp


在使用ROWNUM对结果集编行号的过程
中不要使用ROWNUM做>1以上数字的过滤
判断,否则得不到任何结果.因为ROWNUM
是在查询过程中生成的,只有查询到数据
才会编号,才会自增.
下面SQL查询不到任何结果.
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

page:第几页
pageSize:每页显示的条目数

start:(page-1)*pageSize+1
end:pageSize*page


DECODE函数,可以实现简单的分支效果
SELECT ename, job, sal,
     DECODE(job,  
            'MANAGER', sal * 1.2,
            'ANALYST', sal * 1.1,
            'SALESMAN', sal * 1.05,
            sal
     ) bonus
FROM emp


DECODE在GROUP BY子句中
统计人数,要求将职位是MANAGER,ANALYST
看做一组,其他职位员工看做另一组,分别统计
人数?

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

排序函数
排序函数与ROWNUM相似,用来对结果集
生成行号.但是排序函数是将结果集按照
指定的字段分组,然后组内按照指定字段
排序,之后为每组的记录生成行号.

ROW_NUMBER:生成组内连续且唯一的数字
查看每个部门的工资排名
SELECT 
 ename,sal,deptno,
 ROW_NUMBER() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
 ) rank
FROM emp


RANK函数:生成组内不连续也不唯一的数字
SELECT 
 ename,sal,deptno,
 RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
 ) rank
FROM emp


DENSE_RANK:生成组内连续但不唯一的数字
SELECT 
 ename,sal,deptno,
 DENSE_RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
 ) rank
FROM emp


高级分组函数:

查看每天营业额?
SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id

查看每月营业额?
SELECT year_id,month_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

查看每年营业额?
SELECT year_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

总共营业额?
SELECT SUM(sales_value)
FROM sales_tab


查看每天,每月,每年,以及总共营业额?
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


ROLLUP函数
GROUP BY ROLLUP(a,b,c)
等效于:
GROUP BY a,b,c
UNION ALL 
GROUP BY a,b
UNION ALL 
GROUP BY a
UNION ALL 
全表

SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY ROLLUP(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id


CUBE()
CUBE函数的分组方式是参数的每种组合
都作为一次分组方式,所以分组次数为
2的参数个数次方

GROUP BY CUBE(a,b,c)
ab
ac
bc
a
b
c
abc
全表

SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY CUBE(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id


GROUPING SET函数
GROUPING SET的每一个参数为一种分组方式,
然后将这些分组统计的结果并在一个结果集中显示

查看每天与每月的营业额?
SELECT year_id,month_id,day_id,SUM(sales_value)
FROM sales_tab
GROUP BY 
 GROUPING SETS(
  (year_id,month_id,day_id),
  (year_id,month_id)
 )
ORDER BY year_id,month_id,day_id







