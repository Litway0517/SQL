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
# sql-1 -> 自写(子查询方式)		14条
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
WHERE e.`manager_id` IN (
			  SELECT employee_id
			  FROM employees e
			  WHERE last_name = 'King'
			 );


# sql-2 -> 视频(自连接方式)		14条
SELECT emp.employee_id,emp.last_name,emp.salary
FROM employees emp JOIN employees mgr
ON emp.`manager_id` = mgr.`employee_id`
WHERE mgr.`last_name` = 'King';


# sql-3 -> 连接条件还能改一下
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
WHERE e.`manager_id` = ANY(
			    SELECT employee_id
			    FROM employees e
			    WHERE last_name = 'King'
			   );







#7.查询工资最低的员工信息: last_name, salary
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
WHERE salary IN (
		  SELECT MIN(e.salary)
		  FROM employees e
		 );






#8.查询平均工资最低的部门信息
/*
    分析 -> 
	这题看似简单, 其实非常难. 需要一步一步查. 

    sql-1是自写. 
    
    sql-2和其他几条是答案参考.

*/

# sql-1 -> 自写. 关键是确定 部门id 的时候, 写的太乱了. 没想到having
SELECT *
FROM departments d
JOIN
(
SELECT department_id
FROM (
	SELECT e1.department_id,AVG(e1.salary) "e1_avg_sal"
	FROM employees e1
	GROUP BY e1.department_id
      ) dept_avg_sal_1 
JOIN 
     (
	SELECT MIN(e2_avg_sal) "e2_avg_sal"
	FROM (
		SELECT AVG(e2.salary) "e2_avg_sal"
		FROM employees e2
		GROUP BY e2.department_id
	      ) dept_avg_sal_2
      ) min_sal_end
ON dept_avg_sal_1.e1_avg_sal = min_sal_end.e2_avg_sal
) min_sal_dept_id
ON d.`department_id` = min_sal_dept_id.department_id;



# sql-2 -> 视频写法
SELECT *
FROM departments
WHERE department_id = (
			SELECT e.department_id
			FROM employees e
			GROUP BY department_id
			HAVING AVG(salary) = (
						SELECT MIN(e2_avg_sal) "e2_avg_sal"
						FROM (
							SELECT AVG(e2.salary) "e2_avg_sal"
							FROM employees e2
							GROUP BY e2.department_id
						      ) dept_avg_sal
			)
);


# sql-3 -> 视频写法
SELECT *
FROM departments
WHERE department_id = (
			SELECT e.department_id
			FROM employees e
			GROUP BY department_id
			HAVING AVG(salary) <= ALL(		# 小于等于ALL -> 意味着下雨等于查出来的结果的最小的值
						  SELECT AVG(e2.salary) "e2_avg_sal"
						  FROM employees e2
						  GROUP BY e2.department_id
						  )
			);


# sql-4 -> 视频写法
SELECT *
FROM departments
WHERE department_id = (
			SELECT e.department_id
			FROM employees e
			GROUP BY department_id
			HAVING AVG(salary) = (
						SELECT AVG(e2.salary) "e2_avg_sal"
						FROM employees e2
						GROUP BY e2.department_id
						ORDER BY `e2_avg_sal`
						LIMIT 0,1
						)
			);


# sql-5 -> 视频写法
# 这里是一个小细节, 如果不表明d表. 那么会多出来内查询的两个字段e.department_id,AVG(e.salary) avg_sal
SELECT d.*
FROM departments d
JOIN
	(
	   SELECT e.department_id,AVG(e.salary) avg_sal
	   FROM employees e
	   GROUP BY department_id
	   ORDER BY `avg_sal`
	   LIMIT 0,1
	) dept_min_avg_Sal
ON d.`department_id` = dept_min_avg_sal.department_id;

			













#9.查询平均工资最低的部门信息和该部门的平均工资（难）
/*
     分析 ->
	对于第8题来说, 仅仅差了一个平均工资
*/
# sql-1 -> 这样来写是最简单的, 但是避开了一个知识点! 
SELECT d.*,dept_min_avg_sal.avg_sal
FROM departments d
JOIN
	(
	   SELECT e.department_id,AVG(e.salary) avg_sal
	   FROM employees e
	   GROUP BY department_id
	   ORDER BY `avg_sal`
	   LIMIT 0,1
	) dept_min_avg_Sal
ON d.`department_id` = dept_min_avg_sal.department_id;


# sql-2 -> 
SELECT d.*,(SELECT AVG(salary) FROM employees WHERE department_id = d.`department_id`) "avg_sal"
FROM departments d
WHERE department_id = (
			SELECT e.department_id
			FROM employees e
			GROUP BY department_id
			HAVING AVG(salary) = (
						SELECT MIN(e2_avg_sal) "e2_avg_sal"
						FROM (
							SELECT AVG(e2.salary) "e2_avg_sal"
							FROM employees e2
							GROUP BY e2.department_id
						      ) dept_avg_sal
			)
);








#10.查询平均工资最高的 job 信息

SELECT *
FROM jobs


SELECT job_id,MAX(avg_sal)
FROM (
	SELECT job_id,AVG(salary) "avg_sal"
	FROM employees
	GROUP BY department_id
      ) dept_avg_sal








#11.查询平均工资高于公司平均工资的部门有哪些?




#12.查询出公司中所有 manager 的详细信息.




#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少?






#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary






