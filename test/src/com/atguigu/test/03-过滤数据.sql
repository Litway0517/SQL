/*
    过滤数据
*/
/*01
    查询部门号为90号的员工信息
	使用where进行数据的过滤. 
	where语句必须 紧跟 在from语句后面. 其他子句要注意位置. 
		
*/
SELECT employee_id,last_name,department_id,salary
FROM employees
WHERE department_id = 90;

SELECT employee_id,last_name,department_id,salary
FROM employees
WHERE salary > 5000;			# 工资大于5000
# WHERE department_id <> 90;		# 部门号不等于90
# WHERE department_id != 90;		# 部门号不等于90




/*02
    查询工资 大于等于6000 并且小于等于 8000的员工信息
    
    使用between...and...(包含边界)	between 下面别 and 上边界 -> 边界的位置不能调换
*/
SELECT employee_id,last_name,salary
FROM employees
WHERE salary >= 6000 && salary <= 8000;		# && 可以替换为 AND

SELECT employee_id,last_name,salary
FROM employees
WHERE salary BETWEEN 6000 AND 8000;		# between...and...的查询结果包括边界




/*03
    in(set) -> 查询满足set集合的员工信息
    where department_id in(30,40,50) -> 部门号为30或40或50的员工信息
    IN(A,B,C) -> 是指where后面的字段的具体指等于A或B或C, 那么就是符合条件.
*/
SELECT employee_id,last_name,department_id,salary
FROM employees
WHERE department_id IN(30,40,50);




/*04
    模糊查询like
        _ -> 一个下划线_表示的是, 在这个位置上有一个字符(具体是什么不知道, 哪个都行)
        % -> 表示有0个, 1个, 或者多个字符
        \ -> 反斜线是默认的转义字符
    精准查询
	查询名称为king的员工信息. 字符串和日期需要用''. 不要用""
*/
SELECT employee_id,last_name
FROM employees
WHERE last_name = 'King';	# 使用单引号''
# WHERE hire_data = '1991-5-21';


# 查询员工姓名中包含字符'a'的员工
# % : %表示的是0个, 1个, 或者多个字符
SELECT employee_id,last_name
FROM employees
WHERE last_name LIKE '%a%';	# 名字中只要包含a就可以, 前面或者后面有多个字符都可以


# 查询员工姓名中包含字符'a'且包含字符'e'的员工(2种写法)
SELECT employee_id,last_name
FROM employees
WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';
# Where last_name LIKE '%a%' AND last_name like '%e%';


# 查询员工姓名中第二个字符为'a'的员工信息
# _ : _表示的是一个不确定的字符
SELECT employee_id,last_name
FROM employees
WHERE last_name LIKE '_a%';


# 查询员工姓名中第二个字符为_第三个字符为a的员工信息
# \_ : \是转义字符
SELECT employee_id,last_name
FROM employees
WHERE last_name LIKE '_\_a%';


# 默认\是转义字符, 但是能够自定义. 比如让#当作转义字符
SELECT employee_id,last_name
FROM employees
WHERE last_name LIKE '_#_a%' ESCAPE '#';	# 这时候, #是转义字符(用ESCAPE指定转义字符)




/*05
    IS NULL : 空值
*/
# 查询commission_pct字段为null的员工信息
SELECT employee_id,last_name,commission_pct,salary
FROM employees
WHERE commission_pct IS NULL;


# 查询commission_pct字段 不为null 的员工信息
SELECT employee_id,last_name,commission_pct,salary
FROM employees
WHERE commission_pct IS NOT NULL;	# 习惯这样写



/*06
    异或XOR
    查询这样的员工 -> 要么部门号是10或者20, 要么工资大于7000. 
    满足其中一个条件即可, 但是不能满足两个. 
    翻译过来就是: 查询部门号10或20中的工资小于7000的员工 和 部门号不是10或20的工资大于7000的员工
*/
SELECT employee_id,department_id,salary
FROM employees
WHERE department_id IN(10,20) XOR salary > 7000;




/*
    07取模运算  + - * /(DIV) %(MOD)
    
*/
SELECT employee_id,department_id,salary
FROM employees
WHERE department_id MOD 20 = 0;





























