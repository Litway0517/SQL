/*
    创建和管理表
    DDL
    
    数据库对象 -> 表. 视图. 存储过程. 函数. 触发器. 事件. 同义词. 索引等都是数据库对象

*/

/*
    1. 创建库
*/
CREATE DATABASE database0517;

SHOW DATABASES;





/*
    2. 使用指定数据库
*/
USE temp;

SHOW TABLES;




/*
    3. 删除库
*/
DROP DATABASE database0517;



/*
    4. 创建表
*/
# 方式一
CREATE TABLE emp1(
id INT,
last_name VARCHAR(15),
email VARCHAR(25),
salary DOUBLE(10,2),
hire_date DATE
);

DESC emp1;


# 方式二 -> 基于现有的表建表(结构是一致的, 而且这个表内会有数据)
CREATE TABLE emp2
AS
SELECT employee_id,last_name
FROM employees;

DESC emp2;
DESC employees;


# 方式三 -> select 中对列取别名, 会作为新建表的列名
CREATE TABLE emp3
AS 
SELECT employee_id emp_id,last_name,salary sal 
FROM employees;

# 查询失败
SELECT employee_id
FROM emp3;


# 练习1 -> 复制employees表，包含所有数据
CREATE TABLE employees_copy 
AS 
SELECT *
FROM employees;

SELECT *
FROM employees_copy;

# 练习2 -> 复制employees表，不包含所有数据
CREATE TABLE employees_copy_blank 
AS 
SELECT *
FROM employees 
# WHERE department_id = 10000;		# 随便用一个条件, 让select查不到数据即可
WHERE 1 = 2;





/*
    5. 修改表
*/
DESC emp3;


# 5.1 -> 增加一个列
ALTER TABLE emp3
ADD email VARCHAR(25);

SELECT *
FROM emp3;

# 5.2 -> 删除一个列
ALTER TABLE emp3
DROP email;

ALTER TABLE emp3
DROP COLUMN email;


# 5.3 -> 修改字段(类型, 储值范围). 一般来说不会更改字段类型. 但是也可以 -> MODIFY last_name char(50)
DESC emp3;

ALTER TABLE emp3
MODIFY last_name VARCHAR(30);



# 5.4 -> 重命名字段
ALTER TABLE emp3
CHANGE last_name lname VARCHAR(30);



/*
    6. 重命名表
*/
RENAME TABLE emp3 TO myemp3;





/*
    7. 删除表
*/
DROP TABLE employees_copy;


/*
    8. 清空表 -> 清空表中的数据, 但是表的结构会保留
*/
SELECT *
FROM myemp3;


TRUNCATE TABLE myemp3;


DESC myemp3;


/*
    对比 TRUNCATE 和 DELETE FROM...
    结论 -> 
	TRUNCATE TABLE 一旦操作, 就不可以回滚数据. 考虑清楚, 只有一次机会. 
		TRUNCATE操作, 做完了之后就会COMMIT, 不会受到SET autocommit = FALSE;的影响. 
	DELETE FROM 支持表中数据的全部删除, 可以回滚数据. 
	
    测试 -> COMMIT 与 ROLLBACK的使用
	1. COMMIT表示提交数据. 一旦提交数据, 就不能再回滚. 
		有点和Git commit机制差不多. 数据添加到本地库之后就直接生成hash标志码了, 不能在进行更改. 
		
		回滚操作只能回滚到最近的一次commit操作之后. 
	2. ROLLBACK表示回滚数据. 
	
	但是, 默认情况下, DBMS会把 "默认提交" 这个开关打开. 
	默认情况下, 对数据表的操作(DDL, DML), 都是在执行之后, 默认提交数据的. 
	因此, 如果想测试TRUNCATE 与 DELETE FROM 的区别, 需要把这个开关关上.
	set autocommit = false;
*/

CREATE TABLE myemp
AS
SELECT *
FROM employees;



SELECT *
FROM myemp;


COMMIT;


# 首先测试DELETE FROM
SET autocommit = FALSE;

DELETE FROM myemp;	# 删除数据

SELECT *		# 查询数据
FROM myemp;

ROLLBACK;		# 回滚数据, 让刚才删除的数据再退回


# 接着测试TRUNCATE TABLE语句
COMMIT;

SET autocommit = FALSE;

TRUNCATE TABLE myemp;	# 清空表

ROLLBACK;		# 回滚操作

SELECT *
FROM myemp;


/*
    结论 ->
	一TRUNCATE TABLE为代表的DDL操作, 都会在执行了语句之后, 自动执行COMMIT提交数据. 
	而且此行为提交不受SET autocommit = FALSE;语句限制. 所以, ROLLBACK行为对DDL操作都失效.
	DDL -> Database Definition Languages.
	
	实际上, 设计到COMMIT, ROLLBACK是有关数据库的事务, 在JDBC中讲述. 
*/





