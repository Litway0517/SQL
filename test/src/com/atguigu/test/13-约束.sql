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



























