#1.查询和Zlokey相同的部门的员工姓名（使用列子查询）

#一：先查询Zlokey的部门
SELECT department_id
FROM employees
WHERE last_name="Zlotkey";

#二：查询部门号=一的姓名和工资
SELECT last_name AS 姓名, salary 工资, department_id 部门号
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	WHERE last_name = "Zlotkey"
);


#2.查询工资比公司平均工资还高的员工的员工号，姓名和工资。

#一：先查询平均工资
SELECT AVG(salary)
FROM employees;

#二：查询有关工资 > 一的平均工资的员工姓名，员工号，工资
SELECT e.`employee_id` AS 员工号, e.`last_name` AS 员工姓名, e.`salary` AS 员工工资
FROM employees e 
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);


#三：查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资

#①查询各部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;


SELECT salary, department_id
FROM employees;

#②连接①结果集和employees表，进行筛选
SELECT e.`employee_id` AS 员工号, e.`last_name` AS 姓名, e.`salary` AS 工资, e.department_id
FROM employees AS e
INNER JOIN(
	SELECT AVG(salary) AS av_g, department_id
	FROM employees
	GROUP BY department_id
) AS ag_dep
ON e.`department_id`=ag_dep.department_id
WHERE e.`salary` > ag_dep.av_g;



#4.查询和姓名中包含字母u的员工在相同部门的员工号和姓名
SELECT DISTINCT department_id
FROM employees
WHERE last_name LIKE "%u%";



SELECT last_name, employee_id
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM employees
	WHERE last_name LIKE "%u%"
);


#5.查询在部门的location_id为1700的部门工作的员工的员工号

#查询location_id为1700的部门
SELECT department_id
FROM departments
WHERE location_id = 1700;


#然后在查询部门号=1700中的任意一个的员工号
SELECT employee_id
FROM employees
WHERE department_id IN (
	SELECT department_id
	FROM departments
	WHERE location_id = 1700
);



#6.查询管理者是K_ing的员工姓名和工资

SELECT employee_id
FROM employees
WHERE last_name = "K_ing";

SELECT last_name, salary, employee_id
FROM employees
WHERE manager_id IN (
	SELECT employee_id
	FROM employees
	WHERE last_name = "K_ing"
);



#7.查询工资最高的员工的姓名，要求first_name和last_name显示为一列，列名为姓·名

SELECT CONCAT(first_name,'-',last_name) "姓·名"
FROM employees
WHERE salary=(
	SELECT MAX(salary)
	FROM employees
);


















