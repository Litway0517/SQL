# 1.显示系统时间(注：日期+时间)
SELECT NOW(),SYSDATE()
FROM DUAL;





# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT e.employee_id,e.last_name,e.salary,salary * 1.2 "new salary"
FROM employees e;





# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT e.employee_id,e.last_name,LENGTH(last_name) "name_length"
FROM employees e
ORDER BY last_name DESC;







# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT LPAD(CONCAT_WS('-',e.employee_id,e.last_name,e.salary),50,' ') "OUT_PUT"
FROM employees e;





# 5.做一个查询，产生下面的结果
/*
	<last_name> earns <salary> monthly but wants <salary*3> Dream Salary
	King earns 24000 monthly but wants 72000
*/
SELECT employee_id,last_name,LPAD(CONCAT('<',e.last_name,'>',' earns ',ROUND(e.salary,0),
					' monthly but wants ',TRUNCATE(salary * 3,0), ' Dream Salary.'),'75',' ') "details"
FROM employees e;







# 6.使用case-when，按照下面的条件：
/*
        job                  grade
        AD_PRES              A
        ST_MAN               B
        IT_PROG              C
        SA_REP               D
        ST_CLERK             E

        产生下面的结果
        Last_name	    Job_id	    Grade
        king	        AD_PRES	    A

 */
SELECT e.employee_id,e.last_name "Last_name",e.job_id "Job_id",CASE e.job_id 
						WHEN 'AD_PRES' THEN 'A'
						WHEN 'ST_MAN' THEN 'B'
						WHEN 'IT_PROG' THEN 'C'
						WHEN 'SA_REP' THEN 'D'
						WHEN 'ST_CLERK' THEN 'E'
						ELSE 'OTHERS' END "Grade"
FROM employees e;




