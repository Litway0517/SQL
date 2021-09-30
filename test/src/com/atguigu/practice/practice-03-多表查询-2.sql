#1.所有有门派的人员信息 
（ A、B两表共有）
/*
    分析 ->
	先厘清t_dept和t_emp这两张表的内容.
	修改了表之后, 信息相对比较容易查询
	
*/
SELECT te.id,te.name,td.deptName
FROM t_emp te,t_dept td
WHERE te.deptId = td.deptId;






#2.列出所有用户，并显示其机构信息 
 （A的全集）
 /*
    分析 ->
	需求字段: emp_id可以直接在te表中查
		  emp_name可以直接在te表中查
		  empno是机构信息, 直接在te表中查
	
	需要查询的是所有用户, 因此需要使用左外连接. 
 
 
 */
# sql-1
SELECT * 
FROM t_emp te
LEFT JOIN t_dept td
ON te.deptId = td.deptId;






#3.列出所有门派 
（B的全集）
/*
    分析 -> 
	
*/
# sql-1
SELECT * 
FROM  t_dept  b;




#4.所有不入门派的人员 
（A的独有）
/*
    分析 -> 
	一个人有没有门派是根据t_emp表中的其deptId字段有没有值确定的. 
*/
SELECT * 
FROM t_emp te
LEFT JOIN t_dept td
ON te.deptId = td.deptId
WHERE td.deptId IS NULL;





#5.所有没人入的门派 
（B的独有）
/*
    分析 ->
	有的门派没有人加入
*/
SELECT * 
FROM t_dept td
LEFT JOIN t_emp te
ON td.deptId = te.deptId
WHERE te.deptId IS NULL;



#6.列出所有人员和机构的对照关系
(AB全有)
#MySQL Full Join的实现 因为MySQL不支持FULL JOIN,下面是替代方法 
#left join + union(可去除重复数据)+ right join
/*
    分析 ->
	
*/







 
#7.列出所有没入派的人员和没人入的门派
（A的独有+B的独有）
/*
    分析 ->
	
*/











