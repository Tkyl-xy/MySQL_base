#1.查询工资最低的员工信息：last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

#2.查询平均工资最低的部门信息

#方式一：
# I 各部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;


#II在查询 I 上的最低平均工资
SELECT MIN(ag)
FROM (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) ag_dep;


#III在查询哪个部门的平均工资=II
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
		SELECT MIN(ag)
	FROM (
		SELECT AVG(salary) ag, department_id
		FROM employees
		GROUP BY department_id
	) ag_dep
);

#IV查询部门信息
SELECT d.*
FROM departments d
WHERE d.`department_id` = (
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
		SELECT MIN(ag)
	FROM (
		SELECT AVG(salary) ag, department_id
		FROM employees
		GROUP BY department_id
	) ag_dep
)	
);


#方式二：
#i 查询最低平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;


#ii在i中查询部门最低的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;

#iii在ii基础上查询最低平均工资的成员的信息
SELECT d.*
FROM departments d
WHERE d.`department_id` = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
);


#3.查询平均工资最高的job信息
#I查询最高的job的平均工资
SELECT AVG(salary), job_id
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC
LIMIT 1;


#II 查询job的信息
SELECT *
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);



#4.查询平均工资高于公司平均工资的部门有哪些？
#i查询平均工资
SELECT AVG(salary)
FROM employees;


#ii查询每个部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP  BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary)
	FROM employees
);


SELECT *
FROM employees
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees
);
#5.查询出公司中所有manager的详细信息.

# i 查询所有manager的员工编号
SELECT DISTINCT manager_id
FROM employees;


# ii 查询详细信息，满足employee_id = i

SELECT *
FROM employees
WHERE employee_id IN (
	SELECT manager_id
	FROM employees
);








