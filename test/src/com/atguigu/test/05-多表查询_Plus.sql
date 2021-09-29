/*05
    多表查询
    
*/
/*
    需求: 查询每个员工的id, 姓名, 部门名称
	但是employees表中只有前两个字段. 要用到连接查询. 
*/
# 下面这句话是不正确的, 出现了2889条数据. 107(员工数) * 27(部门数) = 2889
# 称为笛卡尔积错误
SELECT employee_id,last_name,department_name
FROM employees,departments;


# 正确的写法 -> 一定要有连接条件
SELECT employee_id,last_name,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;	# 多表的连接条件, 否则会出现错误



/*01
    因为 department_id字段在两个表中都有, 所以会出现模糊, 所以需要标出来. 
    当需要查询的某个字段在两站表中均存在时, 一定要标明, 例如: employees.department_id department_id字段来自于employees表的查询
    诸如前面的几个字段, employee_id, last_name, 这两个字段仅仅存在于employees表中, 所以不表明也可以. 
	但是, sql的查询引擎会到两个表中都搜索一遍字段名称. 这就会导致浪费时间, 有了下面的sql优化!!!
	对于指明了去那个表中查询的字段, 会提高查询速度. 
*/
SELECT employee_id,last_name,employees.department_id,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;


/*02
    sql优化 -> 还能这样写
*/
SELECT employees.employee_id,employees.last_name,employees.department_id,departments.department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;


/*03
    但是上面这样写, 可读性很差, 这个sql语句很长
	因此, 出现了表的别名. 前面讲的是列的别名, 列的别名只能用于order by语句. 
	而表的别名能用于select where语句. 
	表的别名和列的别名写法是一样的. 
	一个表一旦起了别名之后, where必须使用别名, 不能再使用原来的名字. 
*/
SELECT e.employee_id,e.last_name,e.department_id,d.department_name
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;




/*04
    需求: 选择员工的id, last_name, 工作部门名称, 城市
*/
SELECT e.employee_id,e.last_name,d.department_name,l.city
FROM employees e,departments d,locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`;


/*
    结论: 实现n个表之间的链接查询, 那么至少需要 n - 1 个连接条件. 否则会出现笛卡尔积错误.   
*/





-- ------------------------------------------------------------------------------------------------------
/*05
    查询的分类
    - 等值连接	VS	非等值连接(从概率上来说, 和等值连接一样常用)
    - 自连接	VS	非自连接
    - 内连接	VS	外连接
*/
/*
    第一类
	等值连接和不等值连接
	等值连接上面讲的都是的, 下面看看不等值连接
	
    解释下面这个sql语句 -> 查询员工工号, 姓, 薪资, 工资等级. 按照这个员工的工资的具体值, 到表job_grades中去匹配合适条件. 
	将得到的结果给grade_level, 然后输出. 
*/
SELECT e.employee_id,e.last_name,salary,j.grade_level
FROM employees e,job_grades j
WHERE e.`salary` >= j.lowest_sal 
AND e.`salary`<= j.`highest_sal`;

# 等同于下面的sql
SELECT e.employee_id,e.last_name,salary,j.grade_level
FROM employees e,job_grades j
WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;



/*06
    自连接
	在上面的where e.`department_id` = d.`department_id`语句中, 等号两边的表是不一样的, 这个是非自连接
	反之, 如果两边都是通过一个表, 那么就是自连接
	
	练习 -> 查询员工的employee_id,last_name及其管理者的employee_id,last_name
*/
SELECT emp.employee_id,emp.last_name,mgr.employee_id mgr_id,mgr.last_name mgr_name
FROM employees emp,employees mgr
WHERE emp.`manager_id` = mgr.`employee_id`;	# 这里不能写反了 -> emp.`employee_id` = mgr.`manager_id`





-- ------------------------------------------------------------------------------------------------------
/*07
    内连接与外连接定义 -> 
	内连接
		- 合并具有同一列的两个以上的表的行, 结果集中不包含一个表与另一个表不匹配的行
	
	外连接
	    左外连接	
		- 两个表在连接过程中除了返回满足连接条件的行以外还返回 左表 中不满足条件的行, 这种连接称为 左外连接。
		  没有匹配的行时, 结果表中相应的列为空(NULL)
		  左外连接 就是, 查询左表中无匹配关系的数据, 就是说, 即使左表中某行数据在右表中没有匹配, 这行数据你也得显示出来. 
	    左外连接	
		- 两个表在连接过程中除了返回满足连接条件的行以外还返回 右表 中不满足条件的行, 这种连接称为 右外连接。
		  没有匹配的行时, 结果表中相应的列为空(NULL)
		  右外连接 就是, 查询右表中无匹配关系的数据, 就是说, 即使右表中某行数据在左表中没有匹配, 这行数据你也得显示出来. 

*/
/*
    内连接的例子 -> 查询员工的工号, last_name, 部门号
    sql的结果只有106行. 实际上有一个哥们没有部门, 可能是新来的, 还没安排好. 
	因为其他的员工, 从employees表中拿到他们的部门号之后再去departments表中挨个比对, 发现关系是成立的(=关系), 因此就输出结果.
	然后, null是不匹配的, 和上面的定义一致. 所以只有106行结果. 这是内连接
*/
SELECT e.employee_id,e.last_name,d.department_id
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;







-- ------------------------------------------------------------------------------------------------------
/*08
    sql-99语法
	orcale的实现方式比较简单, 直接在 需要展现数据的一侧添加  (+)  即可. 
	但是这里需要使用sql-99的语法结构实现
	先学一下sql-99语法, 然后再使用sql-99实现外连接. 
*/
# 例子1 -> sql-99语法实现内连接 -> 这和上面的select...from...where是一样的, 还没开始外连接. 
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e INNER JOIN departments d 	# INNER关键词能够省略, 一般我们是省略的, 但是为了和下面形成对比, 而写了出来
ON e.`department_id` = d.`department_id`;	# 这里的ON就相当于WHERE的作用了. 



# 例子2 -> sql-99语法扩展, 实现刚才的那个查询城市的sql
SELECT employee_id,last_name,department_name,city
FROM employees e JOIN departments d 		# 为了查询department_name而JOIN(添加了)departments表, 每次JOIN一个表都要有ON
ON e.`department_id` = d.`department_id`
JOIN locations l 				# 同样的, 为了查询员工的city信息, 需要再次JOIN locations表, 一旦出现了JOIN就得有匹配的ON
ON d.`location_id` = l.`location_id`;





/*09
    左外连接 -> 
	需求: 查询所有员工的employee_id,last_name,department_name信息
	注意: 一旦提到了 '所有' 类型的查询, 就需要注意, 有些字段之间可能不匹配, 但是还是需求查询所有, 一般是外连接. 
	      而且外连接的情况比较常见. 
    
    使用sql-99语法实现左外连接
    
    左外连接是为了 把不满足匹配条件的数据也给查出来的手段. 
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT OUTER JOIN departments d 		# 实际上OUTER能够省略, 因为一旦有了LEFT或者RIGHT那么就是外连接了
ON e.`department_id` = d.`department_id`;




/*010
    右外连接 -> 
        这个sql很有意思.
        我们把上面的 左外连接 的sql, 直接改成, 右外连接. 
        
        这时候的需求就变成了 -> 在departments表(部门表)中获取部门的id号, 再去employees表(员工表)中挨个比对, 看一下有哪些员工在这个部门中
        但是, 因为是右连接, 所以, 就是是有的部门中一个员工都没有, 那么也得把这个部门名称显示出来. 
		为什么显示的是部门名称? 因为上面的select查询的就是department_name字段. 
	
	最后有122行, 这就说明有一些部门虽然设立了, 但是这部分部门没有一个员工. 122 - 107 + 1 = 16. 因此有16个部门是空部门. 
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;


# 与上一个需求一样 -> 左外和右外能够转换, 但是在开发中我们提倡使用左外. 
# 就是说, 当那个表的数据比较多, 你又想让这个表显示出来, 那么就让这张表在JOIN的左面, FROM的右面. 
SELECT e.employee_id,e.last_name,d.department_name
FROM departments d LEFT JOIN employees e
ON e.`department_id` = d.`department_id`;








-- ------------------------------------------------------------------------------------------------------
/*011
    满外连接的定义
	两个表在连接过程中除了返回满足连接条件的行以外还返回 左表和右表表中 中不满足条件的行, 这种连接称为 满外连接。
	没有匹配的行时, 结果表中相应的列为空(NULL)
	
    但是mysql不支持FULL JOIN这个语法
*/
# 下面的sql是错的
SELECT e.employee_id,e.last_name,d.department_name
FROM departments d FULL JOIN employees e
ON e.`department_id` = d.`department_id`;




























