#进阶6：连接查询
/*
含义：又称多表查询，当查询的字段来自于多个表示，就会用到连接查询

笛卡尔乘积现象: 表1 有m行, 表2 有n行，结果为n*m行
发生的原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：
	按年代分类:
	sql 192标准：仅仅支持内连接
	
	
	sql 199标准：【推荐大家使用】支持所有内连接+外链接(左外和右外)+交叉连接
	
	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接；
			左外连接
			右外连接
			全外连接
			
		交叉连接
		




*/
SELECT * FROM beauty;
SELECT * FROM boys;
SELECT * FROM admin;

#一、sql 192标准(内连接)
#1.等值连接
#案例1： 查询女生名和对应男生的名
SELECT `name`,`boyName` FROM boys,beauty
WHERE beauty.`boyfriend_id`=boys.`id`;

#案例2：查询员工名和对应的部门名
SELECT last_name,department_name 
FROM employees,departments
WHERE employees.`department_id`=departments.`department_id`;

#2.为表起别名
/*
  一、提高语句的简洁度
  二、区分多个重名

  注意：如果为表名起别名，原来的名字就不能使用了  
  */
#查询员工名、工种号、工种名
#(这里的两个表可以调换的，不影响)
SELECT 
  e.last_name,
  e.job_id,
  j.job_title 
FROM
  employees AS e,
  jobs AS j 
WHERE e.`job_id` = j.`job_id` ;


#3.可以加筛选
#案例：查询有奖金的员工名、部门名
SELECT 
  last_name,
  department_name,
  commission_pct 
FROM
  employees AS e,
  departments AS d 
WHERE e.`department_id` = d.`department_id` 
  AND commission_pct IS NOT NULL ;

#案例2：查询城市名中第二个字符为o的部门名和城市名
SELECT 
  department_name,
  city 
FROM
  departments AS d,
  locations AS l
WHERE d.`location_id`=l.`location_id` AND city LIKE "_o%";


#4.可以加分组
#案例1：查询每个城市的部门个数
SELECT 
  COUNT(*) 个数,
  city 
FROM
  departments d,
  locations l 
WHERE d.`location_id` = l.`location_id` 
GROUP BY city ;


#案例2：查询有奖金的每个部门的部门名和部门领导的编号和该部门的最低工资
SELECT 
  MIN(salary) AS 最低工资,
  department_name AS 部门名,
  d.manager_id AS 部门领导的编号 
FROM
  employees AS e,
  departments AS d 
WHERE e.`department_id` = d.`department_id` 
  AND commission_pct IS NOT NULL
GROUP BY department_name, d.manager_id;


#5、可以加排序
#案例：查询每个工种的工种名和员工的个数，并且按员工个数降序
SELECT 
  job_title 工种名,
  COUNT(*) 员工个数 
FROM
  jobs j,
  employees e
WHERE j.`job_id` = e.`job_id`
GROUP BY job_title
ORDER BY COUNT(*) DESC;



#6、可以实现三表连接
#案例：查询员工名、部门名和所在的城市,并查找到所在城市中含有s的城市
SELECT 
  last_name,
  department_name,
  city 
FROM
  employees e,
  departments d,
  locations l 
WHERE e.`department_id` = d.`department_id` 
  AND l.`location_id` = d.`location_id` AND city LIKE "%s%";
  
  
#二：非等值连接
#查询员工的工资级别
SELECT 
  salary AS 工资,
  grade_level AS 工资级别 
FROM
  employees e,
  job_grades j
WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;


#查询工资级别的个数>20的个数，并且按工资级别降序
SELECT 
  COUNT(*),
  grade_level 
FROM
  employees e,
  job_grades j 
WHERE e.`salary` BETWEEN j.`lowest_sal` 
  AND j.`highest_sal` 
GROUP BY grade_level 
HAVING COUNT(*) > 20
ORDER BY grade_level DESC ;


#三：自连接
#查询员工的名字、上级的名字
SELECT 
  e.last_name AS 员工名,
  m.last_name AS 上级的名字
FROM
  employees e,
  employees m
WHERE e.`manager_id` = m.`employee_id`;


#查询姓名中包含字符k的员工的名字、上级的名字
SELECT 
  e.last_name 员工名字,
  m.last_name 上级名字 
FROM
  employees AS e,
  employees AS m 
WHERE e.`manager_id`=m.`employee_id`
HAVING m.`last_name` LIKE "%k%";


