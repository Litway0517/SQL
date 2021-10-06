/*
    约束 constraint
*/

/*
    1 -> 约束, 针对表中的数据, 在添加, 删除, 更改的过程中, 进行的限制. 
    
    2 -> 约束的分类
	角度一(从声明的位置上): 列级约束 VS 表级约束
	角度二(从作用的列的数量上): 单列约束 VS 多列约束
		如果是单列约束 -> 
			比如, 对last_name加上非空约束. 那么如果last_name是空的, 则不可通过. 
		如果是多列约束 -> 
			比如, 同时约束last_name和password两个字段, 加上unique约束. 那么(Tom,123) 和 (Tom,456)是可以通过的.  
	角度三(从功能上区分):
		not null : 非空约束
		unique : 唯一性约束
		primary key : 主键约束
		foreign key : 外键约束
		check : 检查约束
		default : 默认值约束

    3 -> 设置约束的时机
	情况1 : 在 CREATE TABLE 的同时, 给表的字段添加上约束
	情况2 : 通过 ALTER TABLE 的方式添加, 删除约束. (没有修改约束语句)

*/





-- ----------------------------------------------------------------------------------------------------------
/*01
    NOT NULL -> 非空约束
*/
# 在创建表的同时, 添加约束
CREATE TABLE emp3(
	id INT NOT NULL,
	last_name VARCHAR(15) NOT NULL,
	email VARCHAR(25),
	hire_date DATE
);


DESC emp3;

# 添加成功
INSERT INTO emp3(id,last_name,email,hire_date)
VALUES(1,'Tom','tom@126.com',CURDATE());

SELECT * FROM emp3;

# 添加失败
INSERT INTO emp3(id,last_name,email,hire_date)
VALUES(2,NULL,'jury@163.com',CURDATE());



# 在 ALTER TABLE时, 删除表的非空约束
ALTER TABLE emp3
MODIFY last_name VARCHAR(15) NULL;	# 最后加上一个null, 意思是在插入数据的时候, 允许这个字段的值为null. 


/*
    如果想通过, ALTER TABLE ... MODIFY ... 修改某个字段为 非空约束 时, 但是这张表的该字段已经有了null, 那么是不行的. 
    比如, 如果表中的last_name字段本身有null值出现了, 那么再修改该字段为not null是不行的. 
*/







-- ----------------------------------------------------------------------------------------------------------
/*02
    UNIQUE -> 唯一性约束
	UNIQUE能写在列级约束(就是紧跟在字段后面), 也可以写在表级约束. 
*/
CREATE TABLE emp4(
	id INT UNIQUE,
	last_name VARCHAR(15),
	email VARCHAR(25),
	hire_date DATE,
	# 表级约束
	CONSTRAINT emp4_email_uk UNIQUE(email)
);


DESC emp4;

SELECT * FROM emp4;


# 成功 -> 插入数据
INSERT INTO emp4(id,last_name,email,hire_date)
VALUES(1,'Tom','tom@126.com',CURDATE());


# 插入失败 -> Duplicate entry '1' for key 'id'
INSERT INTO emp4(id,last_name,email,hire_date)
VALUES(1,'Tom','tom@126.com',CURDATE());

# 插入失败 -> Duplicate entry 'tom@126.com' for key 'emp4_email_uk'
INSERT INTO emp4(id,last_name,email,hire_date)
VALUES(2,'Jury','tom@126.com',CURDATE());

# 插入成功
INSERT INTO emp4(id,last_name,email,hire_date)
VALUES(3,'Tom1',NULL,CURDATE());

# 插入成功
INSERT INTO emp4(id,last_name,email,hire_date)
VALUES(4,'Tom1',NULL,CURDATE());

SELECT * FROM emp4;

/*
    结论 -> 
	声明为unique约束的字段, 在添加或修改数据时, 允许多次设置为null
*/



/*
    在修改表的时候, 如果删除约束? 

    1. 在创建唯一约束的时候, 如果不给唯一约束起别名, 那么就默认和列原来的名字相同. 
    
    2. MySQL会给唯一约束的列上默认创建一个唯一索引
    
    
    删除约束
	- 删除唯一约束只能通过删除唯一索引的方式删除。
	- 删除时需要指定唯一索引名，唯一索引名就和唯一约束名一样。
	- 如果创建唯一约束时未指定名称，如果是单列，就默认和列名相同，如果是组合列，那么默认和()中排在
	  第一个的列名相同。也可以自定义唯一性约束名。

*/

DESC emp4;

# 删除email字段的唯一性约束 <- 需要通过删除该字段的索引名称来删除
ALTER TABLE emp4
DROP INDEX emp4_email_uk;

DESC emp4;


# 再删除id的索引
ALTER TABLE emp4
DROP INDEX id;

DESC emp4;


# 重新再加上唯一性约束
ALTER TABLE emp4
ADD CONSTRAINT emp4_id_uk UNIQUE(id);


DESC emp4;



# 查看某张表中已经存在的约束
SELECT * FROM information_schema.`TABLE_CONSTRAINTS`
WHERE table_name = 'employees';




-- ----------------------------------------------------------------------------------------------------------
/*03
    PRIMARY KEY -> 主键约束
	- 一个表中只能有一个主键约束. 
	- 主键约束, 既满足唯一性, 也满足非空性. 
	- 通过声明有主键约束的字段, 可以确定表中的唯一的一条记录. 
	- 通常, 在创建表的同时, 需要指明一个主键约束. 
*/
CREATE TABLE emp5(
	id INT PRIMARY KEY,		# 列级约束
	last_name VARCHAR(15),
	email VARCHAR(25),
	hire_date DATE,
	salary DOUBLE(10,2)
);


DESC emp5;

SELECT *
FROM emp5;

# 添加数据 成功
INSERT INTO emp5(id,salary,last_name,email)
VALUES(1,3795,'Tom','tom@126.com');

# 添加数据 失败 -> 主键不能重复		Duplicate entry '1' for key 'PRIMARY'
INSERT INTO emp5(id,salary,last_name,email)
VALUES(1,3795,'Tom','tom@126.com');

# 添加数据 失败 -> 主键不能为空		Column 'id' cannot be null
INSERT INTO emp5(id,salary,last_name,email)
VALUES(NULL,3795,'Tom','tom@126.com');

DROP TABLE emp6;

CREATE TABLE emp6(
	id INT AUTO_INCREMENT,
	last_name VARCHAR(15),
	email VARCHAR(25),
	hire_date DATE,
	salary DOUBLE(10,2),
	CONSTRAINT emp6_id_pk PRIMARY KEY(id)
);



# 插入数据
INSERT INTO emp6(last_name,salary,email,hire_date)
VALUES('Tom',11363,'tom@163.com',CURDATE());

SELECT * FROM emp6;



# 删除表的主键. 如果这个主键值是自增长的, 下面的sql会出错, 所以我们删除emp5表的主键. 
# 但是, 这个sql仅仅是删除主键标识. 而主键标识会带来两个作用, 非空和唯一. 删除的时候 实际上非空约束还是存在的. 
ALTER TABLE emp5
DROP PRIMARY KEY;

DESC emp5;










-- ----------------------------------------------------------------------------------------------------------
/*04
    FOREIGN KEY -> 外键约束
	作用: 在表A的字段a上声明一个外键约束, 与表B的字段b相关联. 则字段a在insert等操作时, 
		其赋的值一定是字段b中出现过的数据. 
	
	要求: 对于B表的b字段也有要求, b字段在B表中的声明, 要是主键约束或者唯一性约束. 
*/


CREATE TABLE dept7(
	dept_id INT,
	dept_name VARCHAR(10)
);


# 错误 -> Cannot add foreign key constraint(因为dept7这个表dept_id字段没有主键约束也没有唯一性约束)
CREATE TABLE emp7(
	id INT,
	last_name VARCHAR(15),
	dept_id INT,
	# 添加表级约束, 外键
	CONSTRAINT emp7_dept_id_fk FOREIGN KEY(dept_id) REFERENCES dept7(dept_id)
);


# 添加dept7表的主键
ALTER TABLE dept7
ADD CONSTRAINT dept7_dept_id_pk PRIMARY KEY(dept_id);

DESC dept7;


# 修改之后成功
CREATE TABLE emp7(
	id INT,
	last_name VARCHAR(15),
	dept_id INT,
	# 添加表级约束, 外键
	CONSTRAINT emp7_dept_id_fk FOREIGN KEY(dept_id) REFERENCES dept7(dept_id)
);


# 当dept7表为空的时候, 向emp7表中添加数据会出错的. 因为dept7表的外键约束
INSERT INTO emp7(id,last_name,dept_id)
VALUES(1,'Tom',10);


# 先对dept7表添加数据
INSERT INTO dept7(dept_id,dept_name)
VALUES(10,'IT');


# 插入成功
INSERT INTO emp7(id,last_name,dept_id)
VALUES(1,'Tom',10);


/*
    结论 ->
	在实际开发中, 不建议在创建表的时候使用外键约束. 
	因为这样在插入数据的时候, 会去检查其他表中是否存在这个值. 呆滞插入速度下降. 
	但是这个需求需要完成, 一般我们会在Java代码中维护一个表格, 日前检查. 下面是例子:
	
	比如 -> 
	    需要对e表插入一条员工信息A, A的部门是50, 那么就必须保证50号部门是真实存在的, 不然会出现错误. 
	    而, 具体有哪些部门, 这些信息我们可以维护在Java代码中. 
*/






-- ----------------------------------------------------------------------------------------------------------
/*05
    CHECK -> 检查约束
	对mysql失效
*/
CREATE TABLE emp8(
	id INT,
	last_name VARCHAR(15),
	salary DOUBLE(10,2) CHECK(salary > 3000)
);

# 添加数据
INSERT INTO emp8(id,last_name,salary)
VALUES(1,'Tom',4555);

INSERT INTO emp8(id,last_name,salary)
VALUES(2,'Jury',2685);

SELECT * FROM emp8;





-- ----------------------------------------------------------------------------------------------------------
/*06
    DEFAULT -> 默认值约束
	对mysql失效
*/
CREATE TABLE emp9(
	id INT,
	last_name VARCHAR(15),
	salary DOUBLE(10,2) DEFAULT 2579
);


# 添加字段
ALTER TABLE emp9
ADD last_name VARCHAR(15);

DESC emp9;

INSERT INTO emp9(id,last_name)
VALUES(1,'Tom');


SELECT * FROM emp9;


INSERT INTO emp9(id,last_name,salary)
VALUES(1,'Tom',5003);













