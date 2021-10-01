/*
    单行函数
*/
-- ------------------------------------------------------------------------------------------------------------
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








-- ------------------------------------------------------------------------------------------------------------
/*02
    数值类型
*/
/*
	ABS(x) 返回x的绝对值
	CEIL(x) 返回大于x的最小整数值
	FLOOR(x) 返回小于x的最大整数值
	MOD(x,y) 返回x/y的模
		MOD函数最终的结果, 和被模数有关, 即与x有关, x正则正,x负则负
	RAND() 返回0~1的随机值
	ROUND(x,y) 返回参数x的四舍五入的有y位的小数的值
	TRUNCATE(x,y) 返回数字x截断为y位小数的结果
	SQRT(x) 返回x的平方根
	POW(x,y) 返回x的y次方
*/
SELECT ABS(-100),CEIL(23.001),FLOOR(123.999),
MOD(12,5),MOD(12,-5),MOD(-12,5),MOD(-12,-5),
RAND() * 100
FROM DUAL;

SELECT ROUND(123.567),ROUND(123.456,0),ROUND(123.567,1),
ROUND(123.56,-1),ROUND(123.567,-2)		# -1是看小数点的左面一位, 仍然按照'四舍五入'规则, 小于等于4则置0, 大于4进10
FROM DUAL;

# 截断函数TRUNCATE(x,y)	不管小数点后面的数字是多少, 均舍掉
SELECT TRUNCATE(123.567,0),TRUNCATE(123.567,1),TRUNCATE(123.998,-1)
FROM DUAL;

# ROUND()和RAND()匹配 -> 生成0-100之间的随机数, 然后保留三位小数
SELECT ROUND(RAND()*100,3)
FROM DUAL;

# SQRT(x)平方根  1/2次方
SELECT SQRT(3)
FROM DUAL;








-- ------------------------------------------------------------------------------------------------------------
/*03
    日期类型
*/
/*
	CURDATE() 或 CURRENT_DATE() 返回当前日期
	CURTIME() 或 CURRENT_TIME() 返回当前时间
	
	NOW() / SYSDATE() / CURRENT_TIMESTAMP() / LOCALTIME() /	LOCALTIMESTAMP() 返回当前系统日期时间
	
	YEAR(date) / MONTH(date) / DAY(date) / HOUR(time) /	MINUTE(time) / SECOND(time) 返回具体的时间值
	
	WEEK(date) / WEEKOFYEAR(date) 返回一年中的第几周
	
	DAYOFWEEK(date) 返回周几，注意：周日是1，周一是2，。。。周六是7
	
	WEEKDAY(date) 返回周几，注意，周1是0，周2是1，。。。周日是6
	
	DAYNAME(date) 返回星期：MONDAY,TUESDAY.....SUNDAY
	
	MONTHNAME(date) 返回月份：January，。。。。。
	
	DATEDIFF(date1,date2) / TIMEDIFF(time1, time2) 返回date1 - date2的日期间隔 / 返回time1 - time2的时间间隔
	
	DATE_ADD(datetime, INTERVAL expr type) 返回与给定日期时间相差INTERVAL时间段的日期时间
	
	DATE_FORMAT(datetime ,fmt) 按照字符串fmt格式化日期datetime值
	
	STR_TO_DATE(str, fmt) 按照字符串fmt对str进行解析，解析为一个日期
*/
SELECT CURDATE(),CURRENT_DATE(),	# 一样的, 记前面那个
CURTIME(),CURRENT_TIME(),		# 一样的, 记前面的
NOW(),SYSDATE()				# 两个一样的, 都记下来. 
FROM DUAL;

# 单独获取当前时间的年 月 日 时 分 秒
SELECT YEAR(CURRENT_DATE()),MONTH(CURDATE()),DAY(CURDATE()),
HOUR(CURTIME()),MINUTE(CURTIME()),SECOND(CURTIME())
FROM DUAL;


SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR)
FROM DUAL;		# 增加一年

SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR)
FROM DUAL;   		# 可以是负数

SELECT DATE_ADD(NOW(), INTERVAL '1_1' YEAR_MONTH)	# 增加一年一个月
FROM DUAL;   		# 需要单引号

# 显示转换	实际上也能够隐式转换, 不过要把格式写正确
# 格式化	日期 -> 字符串
# DATE_FORMAT(datetime ,fmt) 按照字符串fmt格式化日期datetime值	具体的格式见sql-文档
SELECT DATE_FORMAT(NOW(),'%y--%m--%d %h:%i%s')
FROM DUAL;

# 解析		字符串 -> 日期		注意, 后面的格式需要一致. 
SELECT STR_TO_DATE('21--10--01 12:0204','%y--%m--%d %h:%i%s')
FROM DUAL;








-- ------------------------------------------------------------------------------------------------------------

/*04
    流程控制
*/
/*
	IF(value,t ,f) 如果value是真，返回t，否则返回f
	
	IFNULL(value1, value2) 如果value1不为空，返回value1，否则返回value2

	CASE WHEN 条件1 THEN result1 WHEN 条件2 THEN result2 ....[ELSE resultn] END 相当于Java的if...else if...else...

	CASE expr WHEN 常量值1 THEN 值1 WHEN 常量值1 THEN 值1.... [ELSE 值n] END 相当于Java的switch...case...

*/
# IF(value,t,f)
SELECT employee_id,last_name,IF(salary > 1000,'高工资','低工资') "details",
IF(commission_pct IS NOT NULL,commission_pct,0) "details"
FROM employees;

# IFBULL(value1, value2) 如果value1不为空，返回value1，否则返回value2
SELECT employee_id,last_name,IFNULL(commission_pct,0)
FROM employees;

# CASE WHEN...THEN...WHEN...THEN
SELECT employee_id,last_name,CASE WHEN salary >= 15000 THEN '高富帅'
				  WHEN salary >= 10000 THEN '潜力股'
				  WHEN salary >= 5000 THEN '打工人'
				  # ELSE语句根据需要可以不写, 但是END必须有 -> 结果查询出来会显示NULL
				  ELSE '打工仔' END "details"		
FROM employees;

# CASE...WHEN...THEN...WHEN...THEN
# 这种情况只是department_id等于某个具体数值的情况, 并不能像上面那样进行判断
SELECT employee_id,last_name,CASE department_id WHEN 10 THEN '10号部门'
						WHEN 20 THEN '10号部门'
						WHEN 30 THEN '10号部门'
						ELSE '其他部门' END "details"		
FROM employees;



/*练习：
	查询部门号为 10,20, 30 的员工信息, 
	若部门号为 10, 则打印其工资的 1.1 倍, 
	20 号部门, 则打印其工资的 1.2倍, 
	30 号部门打印其工资的 1.3 倍数。
	
	这和这个员工的commission_pct没什么关系, 我们的限制条件时部门.
*/
SELECT employee_id,last_name,commission_pct,CASE department_id WHEN 10 THEN salary * 1.1
							       WHEN 20 THEN salary * 1.2
							       WHEN 30 THEN salary * 1.3
							       END "details"
FROM employees
WHERE department_id IN(10,20,30);










-- ------------------------------------------------------------------------------------------------------------
/*05
    其他函数
*/
/*
	database() 返回当前数据库名
	version() 返回当前数据库版本
	user() 返回当前登录用户名
	password(str) 返回字符串str的加密版本，41位长的字符串
	md5(str) 返回字符串str的md5值，也是一种加密方式
*/
SELECT DATABASE(),VERSION(),USER()
FROM DUAL;

# 当前端将数据发送到后台时, 一般就需要加密, MD5
SELECT PASSWORD('abcd'),
MD5('abcd'),MD5(MD5('abcd'))
FROM DUAL;












