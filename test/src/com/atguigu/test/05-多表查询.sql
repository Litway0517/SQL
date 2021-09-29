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
















