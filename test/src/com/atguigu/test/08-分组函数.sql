/*
    分组函数
    也叫做多行函数
*/
/*
	上篇：avg() / sum() / max() / min() / count()
*/
# 1 -> avg() / sum() , 一般只适用于数值类型, 其他是没有意义的, 但是结果会显示0. 
SELECT AVG(salary),SUM(salary),AVG(last_name),SUM(last_name)
FROM employees;


# 2 -> min() / max() , 适用于数值类型, 日期类型, 字符串类型
SELECT MIN(salary),MAX(salary),MIN(employee_id),MIN(last_name),
MIN(hire_date),MAX(hire_date)			# 最早入职和最晚入职的日期
FROM employees;


# 3 -> count() , 适用于数值类型, 日期类型, 字符串类型
# count()是用来计数的, 如果某条记录是NULL, 那么不考虑在内
SELECT COUNT(last_name),COUNT(hire_date),COUNT(commission_pct)
FROM employees;


# 需求 -> 统计员工表中的员工个数
# 推荐使用count(*), 若使用其他字段必须确保该字段不为null, 才能得到正确结果
# 尽量使用前面的字段, 这样速度会更快一些. 
SELECT COUNT(employee_id),COUNT(last_name),COUNT(1),COUNT(2),COUNT(*)
FROM employees;


# count 与 avg, sum三者之间的关系  avg = sum / count. 平均= 求总和 / 该字段的计数
SELECT AVG(salary),SUM(salary)/COUNT(salary)
FROM employees;

SELECT AVG(commission_pct),SUM(commission_pct)/COUNT(commission_pct),		# 前两个相等
SUM(commission_pct)/107
FROM employees;


# 需求 -> 查询员工的平均奖金级别? 
SELECT SUM(commission_pct)/COUNT(IFNULL(commission_pct,0)) "avg commission"
FROM employees;











-- --------------------------------------------------------------------------------------------------
/*
	下篇: group by / having
*/
/*
	查询公司所有员工的平均工资
*/
SELECT AVG(e.salary)
FROM employees e;

/*
	查询各个部门的平均工资
	这里需要分组
*/
# sql-1 -> 这个看不出来对应的部门的具体平均工资, 说白了就是结果中没有部门号这个字段
SELECT TRUNCATE(AVG(e.salary),0) "avg_salary"
FROM employees e
GROUP BY e.department_id;

# sql-2
SELECT e.department_id,TRUNCATE(AVG(e.salary),0) "avg_salary"
FROM employees e
GROUP BY e.department_id;

# sql-3 -> 按照工种计算平均工资
SELECT e.job_id,AVG(e.salary)
FROM employees e
GROUP BY job_id;

# sql-4 -> 计算同一部门中且同一工种中的员工平均工资. 这里需要根据多列分组
/*
	这里面, 按照逻辑, 会先按照department_id分组, 然后再按照department_id中的job_id分组. 最后再在分好的组内求avg(salary)
*/
SELECT e.department_id,e.job_id,AVG(e.salary)
FROM employees e
GROUP BY e.department_id,e.job_id;

# sql-5 -> 与sql-4结果是一样的
SELECT e.job_id,e.department_id,TRUNCATE(AVG(e.salary),0)
FROM employees e
GROUP BY e.job_id,e.department_id;


-- --------------------------------------------------------------------------------------------------------
# 下面的语句是正确的, 符合我们的逻辑需求
SELECT e.deparment_id,AVG(e.salary)
FROM employees e;

# 下面的语句是错误的, 在Oracle中直接不能运行
SELECT department_id,AVG(salary)
FROM employees;

/*
	结论 -> select 中出现了组函数和非组函数字段, 那么非组函数的字段一定要声明在group by中. 
		换句话说 -> 出现在select中的非组函数字段一定要出现在group by中. 
		反之, 声明在group by中的字段可以不声明在select中. 
*/














