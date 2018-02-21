SQL语句是不区分大小写的,但是为了
增加可读性,可以将关键字全部大写,
非关键字全部小写.
SELECT SYSDATE FROM dual

SQL语句根据功能有不同分类
DDL语句(数据定义语言)
用于操作数据库对象.数据库对象
包括:表,视图,索引,序列

1:创建表
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

查看表的结构:
DESC employee

删除表:
DROP TABLE employee

DEFAULT关键字:
在数据库中,所有的数据类型默认值都是
NULL.但是可以通过使用DEFAULT关键字
为指定字段单独设置默认值.

在数据库中,字符串的字面量是使用单引
号括起来的.这一点需要注意.SQL语句虽然
不区分大小写,但是字符串内容是区分大小写的

NOT NULL约束
非空约束要求指定字段在任何情况下值不允许
为空.
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20) NOT NULL,
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2) DEFAULT 3000,
  job VARCHAR2(30),
  deptno NUMBER(2)
)


2:修改表
修改表可以修改表的名字和表的结构

2.1:修改表名:
RENAME old_name TO new_name
将employee改名为myemp

RENAME employee TO myemp

DESC myemp


2.2:修改表结构
添加新字段,删除现有字段,修改现有字段

2.2.1:添加新字段
向myemp表中添加字段hiredate

ALTER TABLE myemp 
ADD(
  hiredate DATE
)

DESC myemp

2.2.2:删除字段
将myemp表中的hiredate删除

ALTER TABLE myemp
DROP(hiredate)


2.2.3:修改现有字段
修改字段可以修改字段的类型,长度
添加默认值或者约束条件.
但是修改字段尽量在表中没有数据的情况
下进行,否则尽量不要修改字段类型,改
长度也尽量只增不减.否则可能修改失败.

ALTER TABLE myemp
MODIFY(
  job VARCHAR2(40)
)

DESC myemp


DML语句(数据操作语言)
DML用于对表中数据进行增,删,改操作

1:INSERT,插入数据

INSERT INTO myemp
(id,name,job,deptno)
VALUES
(1,'JACK','CLERK',10)

COMMIT

SELECT * FROM myemp


INSERT语句中的字段名可以忽略,但是
忽略后就是全列插入.
INSERT INTO myemp
VALUES
(2,'rose','M',SYSDATE,5000,
 'CLERK',20)

SELECT * FROM myemp

插入日期类型数据
可以直接给定字符串,但是格式必须是:
'DD-MON-RR',由于月用的是简拼,不同
语言地区这里会有出入,英语地区是以英文
字母缩写形式,如:'01-SEP-03'
而中文环境下为:'01-9月-03'
所以不建议使用.
可以使用TO_DATE函数,这是数据库的一个
内置函数,可以将一个字符串按照指定的日期
格式转换为DATE值.

INSERT INTO myemp
(id,name,job,deptno,birth)
VALUES
(3,'mark','CLERK',20,
 TO_DATE('1992-08-03','YYYY-MM-DD')
)
SELECT * FROM myemp



2:UPDATE,更新数据
将rose的性别改为'F'

UPDATE myemp
SET gender='F',salary=6000
WHERE name='rose'

修改的时候通常要使用WHERE子句来添加
过滤条件,这样仅会将满足条件的记录进行
修改,若不添加过滤条件则是全表更新,这样
的情况实际比较少.


3:DELETE,删除语句
删除rose
DELETE FROM myemp
WHERE name='rose'


SELECT * FROM myemp












