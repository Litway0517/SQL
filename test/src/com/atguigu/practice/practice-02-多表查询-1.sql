# 1.显示所有员工的姓名，部门号和部门名称。
/*
    分析 -> 
	注意, 这里面是所有员工, 所以需要对employees这个表做外连接. 
	然而, 我们一般使用左外连接, 因此e表需要放在左面. 
	需求字段分为, 姓名, 部门号, 部门名称. 其中, 姓名, 部门号可以直接在e表中查到. 而部门名称需要在departments表种才能查到.
	这里需要用JOIN...ON... sql-99语法查询. 
*/
SELECT e.last_name,e.department_id,d.department_name
FROM employees e 
LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;





# 2.查询90号部门员工的job_id和90号部门的location_id
/*
    分析 -> 
	需求字段: 员工的job_id, 90号部门的location_id
		job_id在e表, 直接查询, 但是限制是部门号为90的员工的job_id. 
		90号部门的location_id, location_id在departments表, 可以直接查. 
	
	一种方便的解决方法, 就是, 去想一下  最终查询结果的表的样子是什么样的! 然后再推回来sql怎么写. 
	还有一种方法, 就是, 分步思想, 写了几行sql之后, 就能够确定某些字段了, 然后再加限制条件, 这样就能缩小范围了. 
		一步一步缩小查询范围, 直到完成需求. 
*/
# sql-1 -> 看着不太合适
SELECT e.job_id
FROM employees e
WHERE e.`department_id` = 90
UNION ALL
SELECT d.location_id
FROM departments d
WHERE d.department_id = 90;
# sql-2 -> 这个应该是正确的
SELECT e.job_id,e.department_id,d.location_id
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id` 
AND d.`department_id` = 90;






# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city
/*
    分析 -> 
	注意题目, 是所有, 有这两个字一般都是外连接. 
	需求字段: last_name字段可以直接查询. department_name字段需要e表和d表department_id连接查询. 
		  location_id字段同样也能够根据department_id连接查询. 
		  city字段需要根据location_id做连接查询. 
		  注意, 是所有有奖金的员工, commmission_pct为空的员工不查询. 
	
	有一个员工, 他有奖金, 但是他没有部门, 导致后面会查不到. 178号员工. 
		所以衍生了一个问题, 到底哪个表"长", 哪个表"短"? 这些问题都需要用sql先查出来验证, 之后再写sql语句!!
		或者换句话说, 左外连接就是为了解决表"短"的问题, 哪个表查出来的结果"短", 就对哪个表使用左外连接.
		
		又衍生出一个问题? 那究竟会在哪些字段出现不匹配的情况? 
			用哪个字段去连接, 哪个字段就有可能出现不匹配的情况!
	
	sql-1语句, 查询到, 有奖金的员工是35人, 但是, 问题是sql-2和sql-3只查询到了34条. 所以sql-2和-3都不正确.
	sql-4正确. 
*/
# sql-1		35条有奖金的员工
SELECT employee_id,commission_pct,department_id
FROM employees
WHERE `commission_pct` IS NOT NULL;

# sql-2		34条
SELECT e.last_name,d.department_name,d.location_id,l.city
FROM employees e,departments d,locations l
WHERE commission_pct IS NOT NULL 
AND e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`;

# sql-3		34条
SELECT e.last_name,d.department_name,d.location_id,l.city
FROM employees e 
LEFT JOIN departments d
ON d.`department_id` = e.`department_id`
JOIN locations l
ON d.`location_id` = l.`location_id`
WHERE e.`commission_pct` IS NOT NULL;

# sql-4		35条 -> 正确
SELECT e.employee_id,e.last_name,d.department_name,d.location_id,l.city
FROM employees e 
LEFT JOIN departments d
ON d.`department_id` = e.`department_id`
LEFT JOIN locations l
ON d.`location_id` = l.`location_id`
WHERE e.`commission_pct` IS NOT NULL;






# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name 
/*
    分析 -> 
	首先, 确定了员工的城市, 必须是Toronto.
	需求字段 : last_name字段直接在e表查询
		   job_id字段直接在e表查询
		   department_id字段直接在e表查询
		   department_name字段需要连接查询.
	
	根据需求, 发出来疑问? 是不是有员工是Totonto城市的, 
		但是这位员工的last_name, job_id, department_id, department_name 其中某个字段为空??
	答案是很可能!
	
	需要使用左外连接查询.
		这里使用了department_id字段和location_id字段做连接使用, 因此他们有可能是空的字段!
		进而导致了不匹配的情况, 所以有可能有一些数据查询不到, 比如这种数据: 有些员工在Toronto多伦多工作, 但是他没有部门(可能是新来的没有分配部门). 
*/
# sql-1 -> 先查看一下在Toronto城市的员工个数		2条(2个员工在Toronto多伦多城市工作)
SELECT e.employee_id,l.city
FROM employees e,departments d,locations l
WHERE e.`department_id` = d.`department_id` 
AND d.`location_id` = l.`location_id`
AND l.`city` = 'Toronto';

# sql-2 -> 最后查询到的结果				2条(符合上面的要求)
SELECT e.employee_id,e.last_name,e.department_id,department_name,l.city
FROM employees e,departments d,locations l
WHERE e.`department_id` = d.`department_id` 
AND d.`location_id` = l.`location_id`
AND l.`city` = 'Toronto';







# 5.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
/*
    分析 -> 
	因为, 每一位员工的管理者manager_id就在employees中, 这是一个自连接查询.
	需求字段 : employees(员工)字段直接在e表查询
		   Emp#(员工的管理者id)字段直接在e表查询
		   manager(employees的管理者姓名)字段直接在e表查询
		   Mgr#(管理者本人的id)字段直接在e表查询
*/
# sql-1先把manager_id为空的员工查出来看看, 因为后面我要用这个manager_id作为连接字段, 避免有不匹配情况导致结果集缺少数据
# 果然有一个员工没有manager_id, 这样查询出来的结果就会像sql-2那样少一条数据. 因为这条数据是不匹配的. 
SELECT e.employee_id,e.last_name,e.manager_id
FROM employees e
WHERE e.`manager_id` IS NULL;

# sql-2 -> 这句话可能会缺少数据		106条
SELECT emp.last_name employees,emp.employee_id "Emp#",mgr.last_name manager,mgr.employee_id "Mgr#"
FROM employees emp,employees mgr
WHERE emp.manager_id = mgr.employee_id;

# sql-3 -> 改用外连接查询		107条
SELECT emp.last_name employees,emp.employee_id "Emp#",mgr.last_name manager,mgr.employee_id "Mgr#"
FROM employees emp
LEFT OUTER JOIN employees mgr
ON emp.manager_id = mgr.employee_id;



/*
    employees	Emp#	manager	Mgr#
    kochhar		101	king	100
*/







