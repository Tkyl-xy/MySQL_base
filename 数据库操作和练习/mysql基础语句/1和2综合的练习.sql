USE myemployees;
#一、查询没有奖金，且工资小于18000的salary, last_name

SELECT 
	salary,
	last_name,
	commission_pct
FROM 
	employees
WHERE	
	commission_pct IS NULL AND salary<18000;


#二、查询employees表中， job_id不为"IT"或者工资为12000员工信息
SELECT
	CONCAT(`first_name`,"-",`last_name`) AS 姓名,
	`email` AS 邮件,
	`phone_number` AS 电话号码,
	`job_id` AS 工作岗位,
	`manager_id` AS 工作编号,
	`department_id` AS 部门编号,
	`hiredate` AS 入职时间
FROM
	employees
WHERE
	job_id != "IT" OR salary < 12000;

#三、查看部门departments表的结构
DESC departments;
	

#四、查询部门表中涉及到了哪些位置编号
#distinct是去重的意思
SELECT
	DISTINCT location_id AS 位置编号
FROM
	departments;


#is null的用法，判断isnull的值时候为null，如果是null则为1，否则为0
SELECT ISNULL(commission_pct) AS 判断的值, commission_pct FROM employees;



