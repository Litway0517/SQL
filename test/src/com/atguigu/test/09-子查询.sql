/*
    子查询
*/


/*
    需求 -> 谁的工资比Abel的工资高
*/
# sql-1 -> 方式1 -> 先查出来Abel的工资是多少
SELECT salary
FROM employees
WHERE last_name = 'Abel';

# sql-2 -> 再查询比这个数字大的员工信息(接力查询)
SELECT employee_id,salary
FROM employees
WHERE salary > 11000;

# sql-3 ->  方式2 -> 使用自连接查询
SELECT e1.employee_id,e1.salary
FROM employees e1 JOIN employees e2
ON e1.`salary` > e2.`salary`
WHERE e2.`last_name` = 'Abel';		# e1表中工资大于e2表中某几个叫做Abel的员工的工资



# sql-4 -> 方式3 -> 使用子查询
SELECT e.employee_id,e.salary
FROM employees e
WHERE e.salary > (
		SELECT e.salary
		FROM employees e
		WHERE e.last_name = 'Abel'
		);


/*
	子查询的概念: 外层: 外查询(或者称为主查询). 
		      内层: 内查询(或者称为子查询).
	
	子查询的分类 : 单行子查询, 多行子查询
*/



-- -------------------------------------------------------------------------------------------------------------
/*
    1 -> 单行子查询
	可以使用的 比较符号 :  =  >  >=  <  <=  <>  !=	
*/
/*
    下面主要是练习 -> 主要的知识和前面的查询结构差不多, 到了后面还有一点新知识
    
    练习1 -> 返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
*/
/*
    分析 ->
	先忽略前面的限制定语 "job_id与141号员工相同，salary比143号员工多的".
	直接看最后面, 需要查询的字段是什么, 然后写上. 
	再看限制条件.
*/
/*
	select e.last_name,e.job_id,salary
	from employees e
	where job_id = ()
	and salary > ();
*/
SELECT e.last_name,e.job_id,salary
FROM employees e
WHERE job_id = (
		SELECT job_id
		FROM employees
		WHERE employee_id = 141
		)
AND salary > (
		SELECT salary
		FROM employees
		WHERE employee_id = 143
		);


/*
     练习2 -> 返回公司工资最少的员工的last_name,job_id和salary
*/
SELECT last_name,job_id,salary
FROM employees
WHERE salary = (
		SELECT MIN(salary)
		FROM employees
		);


/* 
    写子查询sql的两种方式. 1. 从外往里写: 就是先确定最后中需要查询的字段, 写出来. 如果有不确定的条件, 就用()代替
					  然后, 接着往下面写. 
			   2. 从里往外写: 就是先根据小的过滤条件, 就当即把语句写出来, 然后再去向外写, 套上刚才这一层结果.
					 一层一层向外写. 
    原因. 当两层嵌套的时候, 1方式比较容易思考. 但是一旦遇到三层甚至四层查询, 大概率会写错. 
*/



/*
    语文学不好, sql也写不出来!
    练习3 -> 查询最低工资大于50号部门最低工资的部门id和其最低工资. 部门id为空则不计算. 
*/
/*
    分析 ->
	根据语义来看, 最后需要查询的是部门id. 与部门有关的字段. 
	这里面, MIN()是组函数, 但是department_id字段不是. 所以d需要出现在group by中
*/
SELECT department_id,MIN(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY `department_id`
HAVING MIN(salary) > (
			SELECT MIN(salary)
			FROM employees
			WHERE department_id = 60
			);



/*
    空值的情况
*/
SELECT last_name,job_id
FROM employees
WHERE job_id = (
		SELECT job_id
		FROM employees
		WHERE last_name = 'Hass'
		);


/*
    非法使用子查询
*/
# 下面的sql是错误的
SELECT employee_id,last_name
FROM employees
WHERE salary = (
		SELECT MIN(salary)
		FROM employees
		GROUP BY department_id
		);
/*
错误代码： 1242
Subquery returns more than 1 row
*/

			



-- -------------------------------------------------------------------------------------------------------------
/*
    2 -> 多行子查询
    
    多行子查询能够使用的 比较操作符 : IN ALL ANY
    
*/
# in
SELECT employee_id,last_name,department_id
FROM employees
WHERE salary IN (
		SELECT MIN(salary)
		FROM employees
		GROUP BY department_id
		);


/*
    练习4 -> 返回其它job_id中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
    
    只要小于IT_PROG中的任意一个员工的工资就可以, 小于4200叫做小于, 小于9000也是满足条件的. 
    这就是ANY
*/
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY(
		SELECT salary
		FROM employees
		WHERE job_id = 'IT_PROG'
		);


/*
    练习5 -> 返回其它job_id中比job_id为‘IT_PROG’部门所有工资都低的员工的员工号、姓名、job_id以及salary
    比job_id为 IT_PROG 的所有员工的工资都要低 的其他job_id的员工的工号, 姓名, job_id, salary
*/
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE job_id <> 'IT_PROG'			# 扣除job_id为'IT_PROG'这个工种
AND salary < ALL(
		SELECT salary
		FROM employees
		WHERE job_id = 'IT_PROG'
		);






-- -------------------------------------------------------------------------------------------------------------
/*
    练习6(有相关性) -> 查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
*/
# 先看另一个练习(没有相关性) -> 查询员工中工资大于本公司平均工资的员工的last_name,salary和其department_id
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
WHERE e.salary > (
		  SELECT AVG(salary)
		  FROM employees 
		);


# sql-2 -> 相关子查询写法1
SELECT e1.employee_id,e1.last_name,e1.salary
FROM employees e1
WHERE e1.salary > (
		  SELECT AVG(salary)
		  FROM employees e2
		  WHERE e2.`department_id` = e1.`department_id`
		);



# sql-3 -> 相关子查询写法2
/*
    除了group by和limit 这两个位置一般不写子查询, 其实其他地方也能写, 比如下面的from后面
    用department_id和avg_salary两个字段构成一个表, 然后from这个表. 就是从这个结果集中查询. 
	构造出来一张表, 这张表包括 [department_id(部门id字段), avg_sal该部门平均工资]
	这张表是求各个部门的平均工资, 所以需要对部门id这个字段分组 group by department_id
    
    
    还有一些字段问题, 需要注意, 字段需要重命名. 
	比如: 内查询的 AVG(salary) avg_sal 重命名为avg_sal, 是因为后面会用到这个字段, 如果直接写AVG(salary)可能不会被识别.
*/
SELECT e.employee_id,e.last_name,e.salary
FROM employees e,(
		    SELECT department_id,AVG(salary) avg_sal
		    FROM employees
		    GROUP BY department_id
		) dept_avg_sal
WHERE e.`department_id` = dept_avg_sal.department_id
AND e.`salary` > dept_avg_sal.avg_sal;




/*
     练习7 -> 查询员工的employee_id，last_name，要求按照department_name从小到大排序
     体验一下将子查询写在ORDER BY中
*/
SELECT employee_id,last_name
FROM employees e
ORDER BY (
	   SELECT department_name
	   FROM departments d
	   WHERE e.`department_id` = d.`department_id`
	) DESC;








-- -------------------------------------------------------------------------------------------------------------
/*
    EXISTS关键字
    练习8 -> 查询公司管理者的employee_id,last_name,job_id,department_id信息
*/
# sql-1 -> 方式一
SELECT e.employee_id,e.last_name,e.job_id,e.department_id
FROM employees e
WHERE employee_id IN (
			SELECT DISTINCT e.manager_id
			FROM employees e
		     );


# sql-2 -> 方式二 用exists
SELECT e.employee_id,e.last_name,e.job_id,e.department_id
FROM employees e
WHERE EXISTS (
		SELECT 'X'
		FROM employees e2
		WHERE e.`employee_id` = e2.`manager_id`
	      );


/*
    sql-2语句的分析 ->
	带有子查询的sql语句的总体执行顺序是:
		S1. 主查询送一条数据进入子查询
		S2. 子查询判断完该数据会返回给主查询
		S3. 主查询利用该返回的数据继续做判断, 是不是该保留S1中送入的数据 
		
		
	sql-2的执行顺序	
	外查询是employees表的所有数据, 一行一行的送进内查询. 
	第一条数据送进内查询, 那么第一行 外查询的表的employee_id字段 和 内查询的表的manager_id字段做等值比较.
		如果相等, 返回TRUE. exists判断为真, 则保留该条数据为结果集中的一条数据.
			此时对于外表的这行送入的数据来说, 就已经完成任务了, 即一旦匹配成功就会返回. 不会再向下比较. 
		如果不相等, 返回FALSE. 该条数据不是要查询的数据, 转入下一条数据. 
*/










