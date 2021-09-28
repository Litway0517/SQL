# 02基本的SELECT语句


/*
	01使用指定的数据库
*/
USE temp;	



/*
	02基本查询
*/
# 查询指定的几列
SELECT employee_id,last_name,email
FROM employees;

SELECT department_id,manager_id,location_id
FROM departments;

# 查询所有列		* 代表所有字段
SELECT *
FROM employees;



/*
	03列的别名(给列起别名)
		employee_id emp_id: employee_id后面紧跟emp_id指的是, 查出来的结果, employee_id列的名称用emp_id代替
		last_name AS lname: 效果和上面一样的
		salary "monthly salary": 想用monthly salary这个整体作为salary的别名, 需要用双引号("")括起来
*/
SELECT employee_id emp_id,last_name AS lname,salary "monthly salary"
FROM employees;



/*
	去除重复行
		在查询department_id字段时, 会出现重复数据(一个小组内, 不同的人他们的部门很能是相同的). 所以要去除重复值. 
		需要在select后面加上distinct -> SELECT DISTINCT
*/
SELECT department_id
FROM employees;

# 添加DISTINCT关键字
SELECT DISTINCT department_id
FROM employees;

# 去重操作一般只针对一行, 所以下面的sql不正确. 明显的employee_id有107行, DISTINCT department_id只有12行
SELECT employee_id,DISTINCT department_id
FROM employees;



/*
	空值问题
		空值表示没有赋值, 理解为null
		空值参与运算的问题 -> 结果也为空
		空值, 不等同于0, '', 'null'等值
*/
# 函数, IFNULL(字段名, 0) -> 如果字段是null, 那么用0替换, 如果不是null, 则用其原来的数值
SELECT employee_id,commission_pct,salary,salary * (1 + commission_pct),
salary * (1 + IFNULL(commission_pct, 0)) "real_salary"
FROM employees;



/*
	显示表结构
		DESC 表名;
		DESCRIBE 表名;
*/
DESC employees;
DESCRIBE employees;






