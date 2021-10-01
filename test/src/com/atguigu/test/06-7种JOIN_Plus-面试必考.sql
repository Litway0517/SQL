/*01
    7中JOIN操作

*/
/*02
    中图 -> 属于内连接		106条
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;





/*03
    左上图 -> 属于 左外连接	107条
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;





/*04
    右上图 -> 属于 右外连接	122条
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;






/*05
    左中图 -> 是左上图的一些苛刻条件造成的结果	1条
    IS NULL是用来判空的
	怎样理解呢? 
	    - 最好的方法是画图. 然后写出来表达式. 
	    - 还有一种方法. 就是, 先观察左上图写出来的sql的查询结果, 然后就知道了, 只需要加一个where限制就能够得到左中图
	    - 第三种方法. 记住, 这里面有一个公式, 在笔记里面. 
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL;		# IS NULL是用来判空的, 最后只选择department_id为null的数据
						# 上面的这行where是用来扣掉剩下的B集合的. 





/*06
    右中图 -> 是右上图的一些苛刻条件造成的结果	16条

*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;			# 这行是公式的写法, 就是说, 匹配不符号条件的结果
# WHERE e.employee_id is null;				# 这行也行, 用这个过滤条件也可以. 而且更容易理解






/*07
    左下图 -> 可以看作是    左中图 + 右上图 的结果	123条
	   -> 还可以看作是  左上图 + 右中图 的结果	123条(略)
	UNION
		- 取两个子sql语句的查询结果的并集, 但是对sql-1的查询结果和sql-2的查询结果中相同的行 去重. 
	UNION ALL
		- 取两个子sql语句的查询结果的并集, 但是对sql-1的查询结果和sql-2的查询结果中相同的行 不去重. 
		
	sql优化 -> 如果在使用 UNION 和 UNION ALL 都能达到查询目的情况下,
		   尽量使用UNION ALL. 因为没有去重操作, 会节省时间. 
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL
UNION ALL						# 取并集
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;





/*08
    右下图 -> 左中图+ 右中图 的结果	17行
*/
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL
UNION ALL
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;


# 结论: 能是用UNION ALL的查询sql, 就不适用UNION. 避免因为去重, 效率低. 









