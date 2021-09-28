/*
    排序
    分页
*/
/*
  第一部分: 排序
      按照员工的工资, 从高到低排序
      DESC : descend, 降序(10 -> 1)
      ASC: ascend, 升序(1 -> 10)
      
      注意关键词, 前面需要指出ORDER BY. 如果没给出DESC ASC, 那么默认是升序ASC. 
*/
SELECT employee_id,salary
FROM employees
ORDER BY salary DESC;

SELECT employee_id,salary
FROM employees
ORDER BY salary ASC;


# 使用列的别名也可以进行排序
# 别名是可以使用在order by中的  ->  别名也只能在order by中使用. 其他不行
SELECT employee_id,last_name,salary sal
FROM employees
ORDER BY sal;
# 错误
SELECT employee_id,last_name,salary sal
FROM employees
WHERE sal >= 6000;


# where 和 order by同时出现时, 要先写where(前面提到过, where紧跟在from后), 再写order by. 先查出来结果再对结果排序. 
SELECT employee_id,last_name,salary
FROM employees
WHERE salary > 6000
ORDER BY last_name ASC;


# 二级排序. 我们先按照部门号进行排序, 但是一个部门号中会有很多人, 怎么排序, 再按照薪资排序. 字段后不写出ASC或DESC的默认为ASC.
SELECT employee_id,last_name,department_id,salary
FROM employees
ORDER BY department_id,salary DESC;	# 先按部门号升序, 再按薪资降序


/*
==========================================
*/


/*
    分页
*/
# 每页显示20条数据, 显示第1页数据
SELECT employee_id,last_name,salary
FROM employees
LIMIT 0,20;

# 每页显示20条数据, 显示第2页数据
SELECT employee_id,last_name,salary
FROM employees
LIMIT 20,20;

# 每页显示20条数据, 显示第3页数据
SELECT employee_id,last_name,salary
FROM employees
LIMIT 40,20;

# 每页显示pageSize条数据, 显示第pageNo页数据
# limit (pageNo - 1) * pageSize,pageSize;		# 从上一页到下一页


# 练习: 查询工资最高的20个员工信息(top-N需求)  先把结果查出来(order by), 再用limit取前20条数据.
SELECT employee_id,last_name,salary
FROM employees
ORDER BY salary DESC
LIMIT 0,20;





















