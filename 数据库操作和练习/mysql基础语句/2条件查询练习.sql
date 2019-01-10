#查询员工工号为170的所有员工的姓名和部门号和年薪
#last_name,	department_id,	年薪 salary
USE myemployees;
SELECT
	last_name, 
	department_id,
	salary * 12 *(1 + IFNULL(commission_pct,0)) AS 年薪
FROM
	employees
WHERE
	department_id <=> 50;