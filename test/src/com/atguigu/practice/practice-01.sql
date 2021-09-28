# 1.查询员工12个月的工资总和，并起别名为ANNUAL SALARY
SELECT employee_id,last_name,salary,commission_pct,12 * (1 + IFNULL(commission_pct,0)) * salary "ANNUAL SALARY"
FROM employees;




# 2.查询employees表中去除重复的job_id以后的数据
SELECT DISTINCT job_id
FROM employees;




# 3.查询工资大于12000的员工姓名和工资
SELECT last_name,salary
FROM employees
WHERE salary > 12000;




# 4.查询员工号为176的员工的姓名和部门号
SELECT last_name,job_id
FROM employees
WHERE employee_id = 176;




# 5.选择工资不在5000到12000的员工的姓名和工资
SELECT last_name,salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;


SELECT last_name,salary
FROM employees
WHERE salary < 5000 OR salary > 12000;




# 6.选择在20或50号部门工作的员工姓名和部门号	(部门号在where中要使用, 但是可以不再select中出现, 也可以出现)
SELECT last_name,job_id
FROM employees
WHERE department_id IN(20,50);


SELECT last_name,job_id,department_id
FROM employees
WHERE department_id IN(20,50);



# 7.选择公司中没有管理者的员工姓名及job_id		IS NULL 用来判断是为空
SELECT last_name,job_id
FROM employees
WHERE manager_id IS NULL;




# 8.选择公司中有奖金的员工姓名，工资和奖金级别





# 9.选择员工姓名的第三个字母是a的员工姓名

# 10.选择姓名中有字母a和e的员工姓名