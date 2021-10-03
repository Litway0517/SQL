#1.where子句可否使用组函数进行过滤? 
# No, 需要使用having




#2.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(e.salary),MIN(e.salary),AVG(e.salary),SUM(e.salary)
FROM employees e;






#3.查询各job_id的员工工资的最大值，最小值，平均值，总和
SELECT e.job_id,MAX(e.salary),MIN(e.salary),AVG(e.salary),SUM(e.salary)
FROM employees e
GROUP BY job_id;





#4.选择具有各个job_id的员工人数








# 5.查询员工最高工资和最低工资的差距（DIFFERENCE）
SELECT MAX(salary) - MIN(salary) "DIFFERENCE"
FROM employees;







# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
# sql-1 -> 格局有点大了, 这样写就是把问题复杂了, 没有认清group by真正的作用
SELECT emp.employee_id,mgr.employee_id,MIN(emp.salary)
FROM employees emp JOIN employees mgr
ON emp.`manager_id` = mgr.`employee_id`
GROUP BY mgr.employee_id	# group by emp.manager_id <- 这样分组也可以, 是同一个字段(角度不同)
HAVING MIN(emp.salary) >= 6000;

# sql-2
SELECT e.manager_id,MIN(e.salary)
FROM employees e
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000;

# 分析 -> sql-1和sql-2一样的结果, 但是sql-1的查询效率低了太多太多!!







# 7.查询所有部门的名字，location_id，员工数量和工资平均值
SELECT department_name
FROM departments
WHERE ISNULL(`manager_id`);

SELECT d.department_name "d_name",d.department_id "d_id",d.location_id,COUNT(e.employee_id) "emp_num",TRUNCATE(AVG(e.salary),2) "avg_salary"
FROM departments d LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
GROUP BY d.department_name,d.`location_id`,d.`department_id`;













