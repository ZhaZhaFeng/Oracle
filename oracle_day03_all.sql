DQL 数据查询语言

在SELECT子句中可以为字段添加别名
这样在结果集中对应的该字段的名字就是
这个别名.
当SELECT子句中的字段是函数或者表达式
的时候,通常应当为其指定别名.

别名不区分大小写,也不能含有空格,
若希望区分或含有空格,那么可以使用
双引号括起别名,这样就可以了.
SELECT ename,sal*12 "sal"
FROM emp


AND,OR用来连接多个条件
SELECT ename,sal,job
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

AND的优先级是高于OR的,可以通过
使用括号来提高OR的优先级.


LIKE关键字
LIKE用来模糊匹配字符串
支持两个通配符:
_:单一的一个字符
%:任意个字符(0-多个)

查看名字中第二个字母是A的员工?
SELECT ename,sal,job
FROM emp
WHERE ename LIKE '_A%'

SELECT ename,sal,job
FROM emp
WHERE ename LIKE '%A%K%'



IN(list),NOT IN(list)
判断是列表中的内容或不是列表中的内容
IN,NOT IN经常用在子查询中.
查看职位是CLERK或SALESMAN的员工?
SELECT ename,job,sal
FROM emp
WHERE job IN ('CLERK','SALESMAN')


BETWEEN...AND...
判断在一个范围内

查看工资在1500到3000的员工?
SELECT ename,sal,job
FROM emp
WHERE sal BETWEEN 1500 AND 3000


ANY(list),ALL(list)
当判断大于,小于,大于等于,小于等于
多个值的时候,要配合ANY,ALL使用
>ANY(list):大于其中之一(大于最小)
>ALL(list):大于所有(大于最大)
<ANY(list):小于其中之一(小于最大)
<ALL(list):小于所有(小于最小)
ANY,ALL用在判断子查询中,所以通常列表
中不会出现固定值(没意义).


DISTINCT关键字
去除结果集中指定字段有重复值的记录

查看公司有哪些职位?
SELECT DISTINCT job FROM emp

多字段去重时,不再保证每个字段一定
没有重复记录,但是可以保证这些字段
值的组合没有重复记录.
SELECT DISTINCT job,deptno
FROM emp


排序操作
ORDER BY子句可以将结果集按照指定的
字段进行升序或降序排序
ORDER BY子句必须定义在DQL语句的最后
一个子句上.
其中:ASC表示升序(不写默认就是升序),
DESC为降序.

查看公司工资排名?
SELECT ename,sal
FROM emp
ORDER BY sal DESC

排序可以按照多字段排序,但是排序具有
优先级,即:先按照第一个字段排序结果集
当第一个字段有重复值时,这些记录按照
第二个字段排序,以此类推.

SELECT ename,deptno,sal
FROM emp
ORDER BY deptno DESC,sal DESC


排序的字段含有NULL值时,NULL被认定为
最大值
SELECT ename,comm
FROM emp
ORDER BY comm


聚合函数
聚合函数又称为多行函数,分组函数
聚合函数是用来统计结果集数据的.

其中有四个是对值的统计:
MAX,MIN,SUM,AVG

还有一个是对记录数统计的:
COUNT

查看公司的最高与最低工资是多少?
SELECT MAX(sal),MIN(sal) FROM emp

查看工资总和与平均工资?
SELECT SUM(sal),AVG(sal) FROM emp

查看公司共多少人?
SELECT COUNT(ename) FROM emp

聚合函数忽略NULL值.
SELECT SUM(comm) FROM emp
SELECT AVG(comm) FROM emp
SELECT AVG(NVL(comm,0)) FROM emp

求记录数的常见写法
SELECT COUNT(*) FROM emp
SELECT COUNT(1) FROM emp



分组
GROUP BY子句
GROUP BY允许我们按照指定字段对
表中记录进行分组,原则是该字段值
一样的记录被看做一组.
分组是为了配合聚合函数进行细分统计

查看每个部门的平均工资?
SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

当SELECT子句中有聚合函数时,那么凡
不在聚合函数中的单独字段都必须出现在
GROUP BY子句中.

查看每个职位的最高工资?
SELECT MAX(sal),job
FROM emp
GROUP BY job

查看每个部门各多少人?
SELECT COUNT(*),deptno
FROM emp
GROUP BY deptno

查看部门的平均工资,前提是该部门
平均工资要高于2000

SELECT AVG(sal),deptno
FROM emp
WHERE AVG(sal)>2000
GROUP BY deptno

WHERE中不能使用聚合函数作为过滤
条件,原因在于:过滤时机不对
WHERE是在检索表中数据的时候进行
过滤使用的.而聚合函数是作为统计
使用的,那么统计的前提是有数据.
而是否有数据是WHERE决定的.
所以上面的需求应当是将表中数据都
查询出来(WHERE已经过滤完毕)后才
能进行分组,之后才能统计结果,然后
才可以按照聚合函数的结果进行过滤.

HAVING子句
HAVING子句必须跟在GROUP BY子句之后
即:不定义GROUP BY子句就不能单独定义
HAVING子句

HAVING子句添加过滤条件是用来过滤
GOURP BY子句执行的分组的.即:只将满
足HAVING子句条件的分组保留

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000


查看平均工资高于2000那些部门的
最高工资与最低工资分别是多少?
SELECT MAX(sal),MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000
 
 
 
关联查询 
查询多张表,根据表与表间数据的对应
关系进行关联查询,并生成一个结果集
该结果集每条记录中的字段就来自这
些表.
 
查看每个员工以及其所在部门的名称?
SELECT ename,dname 
FROM emp,dept
WHERE emp.deptno=dept.deptno
 
可以为表起别名,这样所有字段在标注的时候
可以只用表别名来指定字段所属.
当遇到两张表中有同名字段时,该字段必须
标注来自那张表.
SELECT e.ename,e.deptno,d.dname 
FROM emp e,dept d
WHERE e.deptno=d.deptno
 
关联查询中要指定连接条件,并且不满足
连接条件的记录会被忽略.
N张表连接,至少要有N-1个连接条件.
所有连接条件通常要同时成立.
如果有过滤条件时,过滤条件也要与连接
条件同时满足.
当不指定连接条件或连接条件无效时,会
出现笛卡尔积(这通常是一个无意义的结果集)
 
查看在NEW YORK工作的员工?
SELECT e.ename,e.job,
       d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.loc='NEW YORK'


SELECT e.ename,d.dname
FROM emp e,dept d


内连接
内连接的查询作用与普通的关联查询
作用一致,写法不同.

查询员工名字以及其所在部门名称?
SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno

查看在NEW YORK工作的员工? 
SELECT e.ename,d.dname 
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.loc='NEW YORK'
 
 
外链接
外链接可以将不满足连接条件的记录
也查询出来.外链接分为:
左外链接,右外链接,全外链接
左外链接:以JOIN左侧表作为驱动表,
该表中所有记录都要查询出来,那么凡
不满足连接条件的记录,那么来自右侧
表的字段的值全部为NULL.

查看每个员工以及其所在的部门名?
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
 
自连接
当前表的一条数据对应当前表自己的
多条数据,这样的表设计就是自连接.
自连接可以保存数据属性相同,但是
又存在上下级关系的树状结构数据使用.

查看每个员工的名字以及其上司的名字?
例如:SMITH的上司是FORD
SELECT e.ename||'的上司是'
       ||NVL(m.ename,'没有') 
FROM emp e,emp m 
WHERE e.mgr=m.empno(+) 
 
 
 
 
 
 
 
 


 