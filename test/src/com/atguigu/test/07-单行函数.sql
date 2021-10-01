/*
    单行函数
*/
/*01
    字符串类型
*/
/*
	CONCANT(s1, s2, ...)连接S1,S2,......,Sn为一个字符串
*/
# 例子sql-1
SELECT CONCAT('hello','world.','hello','beijing') "details"	# 四个字符串合在一起. 只有一个列名
FROM DUAL;

# 需求: XXX(员工) worked for XXX(部门管理)
SELECT CONCAT(emp.last_name, ' worked for ',mgr.last_name)
FROM employees emp 
LEFT JOIN employees mgr
ON emp.`manager_id` = mgr.`employee_id`;



/*
	CONCAT_WS(s, S1,S2,......,Sn) 同CONCAT(s1,s2,...)函数，但是每个字符串之间要加上s
*/
SELECT CONCAT_WS('-','hello','world','beijing')
FROM DUAL;



/*
	CHAR_LENGTH(s) 	返回字符串s的字符数
	LENGTH(s) 	返回字符串s的字节数，和字符集有关
*/
SELECT CHAR_LENGTH('hello'),LENGTH('hello'),CHAR_LENGTH('中国'),LENGTH('中国')
FROM DUAL;



/*
	sql中索引是从1开始的, 这个很重要
	INSERT(str, index , len, instr) 将字符串str从第index位置开始，len个字符长的子串替换为字符串instr
*/
SELECT INSERT('helloworld',2,3,'aaaa')		# 从helloworld的第2字符开始, 包含第2个字符的情况下向右数3个长的字符, 替换成aaaa
FROM DUAL;

SELECT INSERT('beijing',4,4,'china');



/*
	LPAD(str, len, pad) 用字符串pad对str最左边进行填充，直到str的长度为len个字符
		在左面补上指定数据, 实现右对齐
	RPAD(str ,len, pad) 用字符串pad对str最右边进行填充，直到str的长度为len个字符
		在右面补上指定数据, 实现左对齐
*/
# 下面的查询中, salary会自动转换为字符串类型, 此自动转换称为隐式转换. 
SELECT employee_id,LPAD(salary,10,' ') details,RPAD(last_name,10,' ')
FROM employees;


# 怎对于数值类型, 字符串类型, 日期类型存在隐式转换
SELECT 1 + '1'
FROM DUAL;



/*
	TRIM(【BOTH 】s1 FROM s) 去掉字符串s开始与结尾的s1
		注意. 中间的是不能去除的. 
	
	TRIM(LEADING s1 FROM s) 去掉字符串s开始处的s1
		和TRIM一样, 去除左侧的. 
	TRIM(TRAILING s1 FROM s) 去掉字符串s结尾处的s1
		和TRIM一样, 去除右侧的. 
	
	REPEAT(str, n) 返回str重复n次的结果
		把字符串str重复n次, 拼接在一块
	
	REPLACE（str, a, b） 用字符串b替换字符串str中所有出现的字符串a
		把str中的a字符都用b替换掉, a变成b
	STRCMP(s1,s2) 比较字符串s1,s2
		
	SUBSTRING(s,index,len) 返回从字符串s的index位置其len个字符
		索引从1开始, 包括index的位置
*/
SELECT TRIM('aa' FROM 'aaahelloa')		# 结果是 -> ahelloa
FROM DUAL;

SELECT TRIM('aa' FROM 'aaahelaaloa')		# 结果是 -> ahelaaloa
FROM DUAL;

# TRIM(LEADING s1 FROM s) -> 去除左侧
SELECT TRIM(LEADING 'aa' FROM 'aahelloaa')	# helloaa
FROM DUAL;

# TRIM(TRAILING s1 from s) -> 去除右侧
SELECT TRIM(TRAILING 'aa' FROM 'aahelloaa')	# aahello
FROM DUAL;

# REPEAT(str,n)
SELECT REPEAT('hello ',2)
FROM DUAL;

# REPLACE（str, a, b） 用字符串b替换字符串str中所有出现的字符串a
SELECT REPLACE('hello','l','s')
FROM DUAL;

# STRCMP(s1,s2) 比较字符串s1,s2
SELECT STRCMP('abc','abd')		# -1, 说明abc小于abd
FROM DUAL;

# SUBSTRING(s,index,len) 返回从字符串s的index位置其len个字符
# 注意索引从1开始
SELECT SUBSTRING('hello',3,3)		# 从hello的第3个字符l处, 取长度为3的字串. 从l向后查询3个字符, llo
FROM DUAL;



/*
	
*/












-- ------------------------------------------------------------------------------------------------------------
/*02
    数值类型
*/





-- ------------------------------------------------------------------------------------------------------------

/*03
    日期类型
*/





-- ------------------------------------------------------------------------------------------------------------

/*04
    流程控制
*/





-- ------------------------------------------------------------------------------------------------------------

/*05
    其他函数
*/














