#1.查询和Zlotkey相同部门的员工姓名和工资
SELECT e.employee_id,e.last_name,e.salary,e.department_id
FROM employees e
WHERE e.`department_id` = (
			    SELECT e.department_id
			    FROM employees e
			    WHERE last_name = 'Zlotkey'
			    );






#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
WHERE e.`salary` > (
		    SELECT AVG(e.salary)
		    FROM employees e
		    );






#3.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（难）







#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
/*
    分析 -> 
    有点难. 主要是因为, 主查询和子查询之间的连接符号, 不容易确定, 导致难. 
    TODO: 后面再处理, 待查
    
*/
# sql-1 -> 
SELECT e.employee_id,e.last_name,e.department_id
FROM employees e
WHERE e.last_name IN (
			SELECT last_name
			FROM employees e
			WHERE last_name LIKE '%u%'
			)
GROUP BY department_id;


# sql-2 -> 标准答案(感觉不太正确)
SELECT e.employee_id,e.last_name,e.department_id
FROM employees e
WHERE e.department_id = ANY(
			   SELECT DISTINCT department_id
			   FROM employees
			   WHERE last_name LIKE '%u%'
			  );







#5.查询在部门的location_id为1700的部门工作的员工的员工号
/*
    分析 ->
	子查询查出来的是, location_id为1700的部门表, 在1700编号的这个城市有很多部门, 是一个多行子查询. 
	IN连接应该是符合条件的
*/
SELECT e.employee_id,e.last_name,e.department_id
FROM employees e
WHERE department_id IN (
			SELECT department_id 
			FROM departments d
			WHERE d.`location_id` = 1700
			);









#6.查询管理者是King的员工姓名和工资
/*
    分析 ->
	先把King的工号查出来, 再按照e表的结构, manager_id确定员工的管理者. 
*/
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
WHERE e.`manager_id` IN (
			  SELECT employee_id
			  FROM employees e
			  WHERE last_name = 'King'
			);









#7.查询工资最低的员工信息: last_name, salary







#8.查询平均工资最低的部门信息






#9.查询平均工资最低的部门信息和该部门的平均工资（难）






#10.查询平均工资最高的 job 信息





#11.查询平均工资高于公司平均工资的部门有哪些?




#12.查询出公司中所有 manager 的详细信息.




#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少?






#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary






