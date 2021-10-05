/*
    数据处理之增删改
*/

/*01
    增加数据/添加数据 -> INSERT
*/

/*
    方式1 -> 一条数据一条数据的添加
*/
DESC emp1;


SELECT *
FROM emp1;

INSERT INTO emp1
VALUES(1,'Ton','tom@outlook.com',3000,CURDATE());

INSERT INTO emp1
VALUES(2,'Tom','tom@outlook.com',NULL,CURDATE());


# 指定插入的字段与数据匹配
INSERT INTO emp1(id,last_name,hire_date,salary,email)
VALUES(3,'jury','2007-10-25',9000,'jury@126.com');

# 仅仅声明部分字段, 那么剩余的字段在添加完数据之后, 值为null.
INSERT INTO emp1(id,email,salary)
VALUES(4,'xmw@163.com',5700);


/*
    方式2 -> 基于现有的表, 将数据插入到指定表

	注意. 如果开发过程中有这种需求, 一定要先看看, 待插入数据的表格(insert into后面的那个) 与 查询到数据的表格(select那个)
	这两张表的对应字段的 储值范围 是否是一致的.
*/
INSERT INTO emp1(id,last_name)
SELECT employee_id,last_name
FROM employees
WHERE department_id IN(10,20,30);

SELECT *
FROM emp1;









