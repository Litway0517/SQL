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






















