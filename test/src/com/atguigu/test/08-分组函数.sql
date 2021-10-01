/*
    分组函数
    也叫做多行函数
*/
/*
	上篇：avg() / sum() / max() / min() / count()
*/
# 1 -> avg() / sum() , 一般只适用于数值类型, 其他是没有意义的. 
SELECT AVG(salary),SUM(salary),AVG(last_name),SUM(last_name)
FROM employees;


# 2 -> min() / max() , 适用于数值类型, 日期类型, 字符串类型
SELECT MIN(salary),MAX(salary),MIN(employee_id),MIN(last_name),
MIN(hire_date),MAX(hire_date)
FROM employees;


# 3 -> count() , 适用于数值类型, 日期类型, 字符串类型
# count()是用来计数的, 如果某条记录是NULL, 那么不考虑在内
SELECT COUNT(last_name),COUNT(hire_date),COUNT(commission_pct)
FROM employees;


# 需求 -> 统计员工表中的员工个数
# 推荐使用count(*), 使用其他字段必须确保该字段不为null
SELECT COUNT(employee_id),COUNT(last_name),COUNT(1),COUNT(2),COUNT(*)
FROM employees;


# count 与 avg, sum三者之间的关系  avg = sum / count
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

















