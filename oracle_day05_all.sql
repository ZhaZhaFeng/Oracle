视图
视图是数据库对象之一
视图在SQL语句中体现的角色与表一致,
但视图并不是真实的表,只是对应的一个
查询语句的结果集.
CREATE VIEW v_emp_10
AS
SELECT empno, ename, sal, deptno 
FROM emp 
WHERE deptno = 10

查看视图的结构:
DESC v_emp_10

查询视图:
SELECT * FROM v_emp_10

视图对应的子查询可以为字段指定别名
那么该视图对应的字段就为这个别名.
需要注意,若视图对应的子查询中的字段
是函数或者表达式,那么该字段必须要
指定别名.

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10

SELECT * FROM v_emp_10


视图分为:简单视图和复杂视图
简单视图:视图对应的子查询中的SELECT
子句里不含有函数,表达式,去重.且查询
不含有分组,关联查询操作.
复杂视图:不是简单视图就是复杂视图.
一般视图对应的子查询有关联查询操作的,
又称为"连接视图",连接视图是复杂视图的一种

对视图进行DML操作
对视图进行DML就是对视图数据来源的"基础表"
进行的.只能对简单视图进行DML操作.

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


对视图进行DML不能违背基表约束,否则
操作失败.
对视图进行DML操作不当会对基表数据
产生"数据污染",即:通过视图进行DML
操作影响基表后,视图对该记录不可见.

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,20)

UPDATE v_emp_10
SET deptno=20

SELECT * FROM emp
SELECT * FROM v_emp_10

只有DELETE语句不会产生污染.
DELETE FROM v_emp_10
WHERE deptno=20

为视图添加检查选项,这样可以避免以为
不当操作视图而对基表数据污染.
检查选项会要求对视图进行DML操作后视图
可以看到该记录,否则该操作不被允许.
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


对视图添加只读选项后,该视图不允许
进行DML操作
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


数据字典
数据字典是数据库自行维护的一组表
这些表中记录了一些清单,便于我们后期
查看
USER_OBJECTS:用户创建过的所有数据库对象
USER_VIEWS:用户创建过的所有视图
USER_TABLES:用户创建过的所有表

SELECT object_name,object_type
FROM user_objects
WHERE object_type='VIEW'
AND object_name LIKE '%FANCQ'

SELECT view_name,text
FROM user_views

SELECT table_name
FROM user_tables


复杂视图
创建一个部门工资情况的视图
包含:部门id,部门名字,最高,最低,平均和工资
总和.

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

查看谁是高于自己所在部门平均工资的?
SELECT e.ename,e.deptno,e.sal
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

查看每个部门最高工资的员工是谁?
SELECT e.ename,e.sal,v.dname
FROM emp e JOIN v_dept_sal v
ON e.deptno=v.deptno
WHERE e.sal=v.max_sal

删除视图:
DROP VIEW v_emp_10


序列
序列也是数据库对象之一
序列用来根据指定的规则生成一系列数字使用
通常使用序列是为某表主键字段提供值

CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

序列支持两个伪列用来获取序列生成的数字
NEXTVAL:获取下一个数字,如果是新建序列
那么会返回START WITH指定数字,以后则是
返回最后生成的数字加上步长得到的新数字.
需要注意,NEXTVAL会导致序列步进,并且序列
是不能回退的.

CURRVAL:获取序列当前数字(最后一次通过
NEXTVAL获取的数字)
如果是新创建的序列必须要至少调用一次NEXTVAL
后才可以使用CURRVAL

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

删除序列
DROP SEQUENCE seq_emp_id



索引
索引是数据库对象之一
索引的目的是加快查询效率.
经常做为过滤条件,去重,排序或连接条件的
字段可以为其添加索引.
索引的建立和使用是数据库自行完成的.





约束

唯一性约束:
唯一性约束要求该字段的值在整张表中每条
记录的值是不允许重复的,NULL除外
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


主键约束
主键约束一张表只能有一个.要求非空且唯一
主键字段:通常表的第一个字段就是主键字段,
该字段的作用是用这个字段的值可以唯一确定
表中的一条记录.

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




