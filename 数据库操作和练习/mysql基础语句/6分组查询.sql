#进阶5：分组查询
/*
语法：
	select 分组函数，列
	from 表
	【where 筛选条件】
	group by 分组列表
	【order by 子句】
注意：
	查询列表必须特许，要求是分组函数和group by后出现的字段
	
特点：
	1.分组查询中的筛选条件分为两类
	
	2.分组函数做条件肯定是放在having子句中
	
	3.能用分组前筛选的，就优先考虑使用分组前筛选的
	
	4.group by子句支持单个字段分组，多个字段分组（多个字段之间用逗号隔开没有顺序要求）
	
	5.也可以排序查询

*/
#1.简单的分组
#案例1：查询每个工种的员工平均工资
SELECT TRUNCATE(AVG(salary),1) AS 平均工资,job_id AS 工种
FROM employees
GROUP BY 工种;

#案例2：查询每个位置的部内个数(location_id)
SELECT COUNT(*) AS 个数, location_id AS 部门职位编号
FROM departments
GROUP BY 部门职位编号;

#2.可以实现分组前的筛选
#案例1：查询邮箱中包含a字符的，每个部门的最高工资
SELECT MAX(salary) AS 最高工资, department_id AS 部门
FROM employees
#利用模糊查询like的用法
WHERE email LIKE "%a%"
GROUP BY 部门;



#案例2：查询有奖金的每个领导手下员工的平均工资
SELECT AVG(salary) AS 平均工资, COUNT(*) AS 员工个数, manager_id AS 领导编号
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;



#3.分组后的筛选
#案例1：查询哪个部门的员工个数>5
SELECT COUNT(*) AS 员工个数, department_id AS 部门编号
FROM employees
GROUP BY department_id
HAVING 员工个数 > 5;


#案例2：每个工种有奖金的员工的最高工资>12000的工种编号和最高工资（job_id, salary）
SELECT MAX(salary) 最高工资,job_id
FROM employees
GROUP BY job_id
HAVING  MAX(salary) > 12000;


#案例3：领导编号>102的每个领导手下的最低工资大于5000的领导编号和最低工资
SELECT MIN(salary) AS 最低工资, manager_id AS 领导编号
FROM employees
GROUP BY manager_id
HAVING manager_id > 102 AND MIN(salary) > 5000;

#案例4：添加排序
#每个工种有奖金的员工的最高工资>6000的工种编号和最高工资,按最高工资升序
SELECT MAX(salary) AS  最高工资, job_id 工种编号
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary) > 6000
ORDER BY MAX(salary) DESC;


#案例5：按多个字段分组
#查询每个工种每个部门的最低工资，并按最低工资降序
SELECT MIN(salary) AS 最低工资, job_id AS 工种, department_id AS 部门
FROM employees
GROUP BY job_id, department_id
ORDER BY MIN(salary) DESC;

#按表达式或函数分组
#案例6：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些

SELECT COUNT(*) AS 员工个数, LENGTH(last_name) AS 员工长度
FROM employees
GROUP BY LENGTH(last_name)
HAVING COUNT(*) > 5;





























