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



/*
    7. 删除表
*/
DROP TABLE employees_copy;


/*
    8. 清空表
*/



















