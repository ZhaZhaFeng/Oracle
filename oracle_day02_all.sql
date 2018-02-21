DQL语句
SELECT语句用于查询表中数据.
SELECT语句至少包含两个子句:

SELECT子句:用于指定查询的内容,在
SELECT子句中可以出现表中的字段,函数
或表达式

FROM子句:用于指定数据来源的表

查看emp表中数据
SELECT ename,job,sal,deptno 
FROM emp
WHERE sal>2000

添加了WHERE子句后,可以指定过滤条件,这样
只会将满足条件的记录查询出来.

查看每个员工的年薪?
SELECT ename,sal,sal*12
FROM emp



字符串函数
1:CONCAT(char1,char2)
连接字符串

SELECT CONCAT(ename,sal)
FROM emp

SELECT 
  CONCAT(CONCAT(ename,'的工资是'),sal)
FROM emp

在数据库中可以使用"||"作为连接字符串的操作
SELECT ename||'的工资是'||sal
FROM emp


2:LENGTH(char)
返回字符串的长度

查看每个员工名字的字符个数?
SELECT ename,LENGTH(ename)
FROM emp

3:LOWER,UPPER,INITCAP
将字符串转换为全大写,全小写,首字母大写

dual:伪表
当查询的数据与任何表无关时,可以使用伪表.
伪表并不是一张真实存在的表,仅用来"凑数"
SELECT LOWER('HELLOWORLD'),
       UPPER('helloworld'),
       INITCAP('HELLO WORLD')
FROM dual

SELECT ename,sal,job,deptno
FROM emp
WHERE UPPER(ename)=UPPER('smith')


4:TRIM,LTRIM,RTRIM
去除字符串两边的重复字符,或单独
去除左面,单独去除右面的字符

SELECT TRIM('e' FROM 'eeeeliteeee')
FROM dual

SELECT LTRIM('eeeeliteeee','e')
FROM dual


5:LPAD(char1,n,char2),RPAD
补位函数,可以将char1字符串达到n个字符
长度,若char1不足是,左面(右面)补充若干
个char2字符来达到.若超过,则从左开始截取
到n个字符返回.
SELECT ename,sal,LPAD(sal,5,' ')
FROM emp


6:SUBSTR(char,m[,n])
截取字符串从m开始截取n个字符
n若不指定或者超过了实际可以截取
的字符数量时则是截取到末尾.
m可以是负数,若是负数则是从倒数位置
开始截取.
需要注意,数据库中下标从1开始!

SELECT 
  SUBSTR('thinking in java',-7,2)
FROM dual



7:INSTR(char1,char2[,m[,n]])
查找char2在char1中的位置
m表示从第几个字符开始检索,不写默认为1
n表示第几次出现,不写默认为1
SELECT 
 INSTR('thinking in java','in',4,2)
FROM
 dual


数字函数
1:ROUND(m[,n])
对m进行四舍五入,保留到小数点
后n位,若n不指定则默认为0.
n若为负数则是保留10位以上的数字

SELECT ROUND(45.678, 2) 
FROM DUAL
SELECT ROUND(45.678, 0) 
FROM DUAL
SELECT ROUND(55.678, -2) 
FROM DUAL


2:TRUNC(m[,n])
截取数字,参数意义与ROUND一致
SELECT TRUNC(45.678, 2) 
FROM DUAL
SELECT TRUNC(45.678, 0) 
FROM DUAL
SELECT TRUNC(55.678, -1) 
FROM DUAL


3:MOD(m,n)
求余数,计算是使用m除以n得到
若n为0则直接返回m
SELECT MOD(12,5)
FROM dual


4:CEIL,FLOOR
向上取整与向下取整
SELECT CEIL(45.678) FROM dual
SELECT FLOOR(45.678) FROM dual



日期函数
与日期相关的关键字:
SYSDATE,SYSTIMESTAMP
分别返回DATE类型与时间戳类型的
当前系统时间.

SELECT SYSDATE FROM dual
SELECT SYSTIMESTAMP FROM dual


1:TO_DATE函数
可以将一个字符串按照指定的日期格式
转换为一个DATE值
SELECT 
 TO_DATE('2008-08-08 20:08:08',
         'YYYY-MM-DD HH24:MI:SS')
FROM
 dual

当日期格式中出现了非时期格式字符或
符号之外的其他字符时,通常需要使用双引号
括起来.
SELECT 
 TO_DATE('2008年08月08日',
         'YYYY"年"MM"月"DD"日"')
FROM
 dual

日期类型可以进行计算:
1:对日期加减一个数字,等同于加减天数
2:两个日期向减,差为相差的天数

日期也可以比较大小,越晚的越大

明天的日期?
SELECT SYSDATE+1 FROM dual

查看每个员工入职到今天共多少天了?
SELECT ename,SYSDATE-hiredate
FROM emp


SELECT 
  TRUNC(SYSDATE-TO_DATE('1992-05-03','YYYY-MM-DD'))
FROM
  dual


2:TO_CHAR函数
TO_CHAR函数常用来将DATE按照指定的
格式转换为字符串使用
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


日期常用函数
1:LAST_DAY(date)
返回给定日期所在月的月底日期

查看当月月底日期?
SELECT LAST_DAY(SYSDATE)
FROM dual




2:ADD_MONTHS(date,i)
对给定的日期加上指定的月,若
i为负数,则是减去指定的月

查看每个员工入职20周年纪念日?
SELECT 
 ename,hiredate,
 ADD_MONTHS(hiredate,12*20)
FROM
 emp


3:MONTHS_BETWEEN(date1,date2)
计算两个日期之间相差的月
计算方式是用date1-date2得出的

查看每个员工入职至今多少个月了?
SELECT ename,MONTHS_BETWEEN(SYSDATE,hiredate)
FROM emp


4:NEXT_DAY(date,i)
返回给定日期第二天开始一周之内周几
对应的日期
i是数字:1-7,分别表示周日-周六

SELECT NEXT_DAY(SYSDATE,6)
FROM dual



5:LEAST,GREATEST
求最小值与最大值
凡是能比较大小的数据类型都可以使用
这两个函数,对于日期而言,最小值求的
就是最早的日期,最大值求的就是最晚的
日期.
SELECT 
 LEAST(SYSDATE,TO_DATE('2008-10-10',
                       'YYYY-MM-DD')) 
FROM dual


6:EXTRACT()
提取指定日期指定时间分量的值
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM dual

查看1982年入职的员工?
SELECT ename,hiredate
FROM emp
WHERE EXTRACT(YEAR FROM hiredate)=1982



空值操作
CREATE TABLE student(
  id NUMBER(4), 
  name CHAR(20), 
  gender CHAR(1)
);

INSERT INTO student VALUES(1000, '李莫愁', 'F');

INSERT INTO student VALUES(1001, '林平之', NULL);

INSERT INTO student(id, name) VALUES(1002, '张无忌');


更新成NULL
UPDATE student
SET gender=NULL
WHERE id=1000

将性别为NULL的删除
在过滤条件中判断时,要使用:
IS NULL,IS NOT NULL

DELETE FROM student
WHERE gender IS NULL

SELECT * FROM student


空值操作:
字符串与NULL连接等于什么也没干
数字与NULL运算结果还是NULL

SELECT ename||NULL
FROM emp

查看每个员工的总收入(工资+绩效)
SELECT ename,sal,comm,sal+comm
FROM emp

空值函数
1:NVL(arg1,arg2)
当arg1为NULL时,函数返回arg2的值
若不为NULL,函数返回arg1.
所以NVL函数的意义是将NULL替换为一个非NULL值

查看每个员工的总收入(工资+绩效)
SELECT ename,sal,comm,
       sal+NVL(comm,0)
FROM emp

查看每个员工的绩效情况,即:
绩效不为NULL的,则显示为"有绩效"
为NULL的则显示为"没有绩效"

2:NVL2(arg1,arg2,arg3)
当arg1不为NULL时,函数返回arg2
arg1为NULL时,函数返回arg3

SELECT 
 ename,comm,
 NVL2(comm,'有绩效','没有绩效')
FROM
 emp

SELECT 
 ename,sal,comm,
 NVL2(comm,comm+sal,sal)
FROM
 emp



