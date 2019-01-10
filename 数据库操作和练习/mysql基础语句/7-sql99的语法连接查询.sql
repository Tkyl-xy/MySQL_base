#二、sql199语法
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名 on 连接条件
	
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by排序列表】
	
分类：
内连接（）:inner
外链接
	左外（）:left 【outer】
	右外（）:right 【outer】
	全外：full 【outer】
交叉连接：cross join 

*/
#一、内连接

/*
语法：
select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件
【where 筛选条件】
【order by 排序条件】
【having 筛选条件】;

特点：
1.添加排序、分组、筛选
2.inner可以省略
3.筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
4.inner join连接和SQL192语法中的等值连接效果是一样的，都是查询多表的交集

分类：
等值
非等值
自连接



*/

#1.等值连接
#案例1.查询员工名、部门名
SELECT last_name, department_name
FROM departments d
INNER JOIN employees e
ON e.`department_id` = d.`department_id`;

#案例2.查询名字中包含e的员工名和工种名（添加筛选）
SELECT last_name, job_title
FROM employees AS e
INNER JOIN jobs AS j
ON e.`job_id` = j.`job_id`
ORDER BY e.last_name LIKE "%e%";

#案例3.查询部门个数>3的城市名和部门个数(添加分组和筛选)
SELECT l.`city` 城市名, COUNT(*) 部门个数
FROM locations l
INNER JOIN departments d
ON l.`location_id` = d.`location_id`
GROUP BY l.city
HAVING 部门个数 > 3;


#案例4.查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序(添加排序)

SELECT d.`department_name` AS 部门名, COUNT(*) AS 员工个数
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
GROUP BY d.`department_name`
HAVING 员工个数 > 3
ORDER BY COUNT(*) DESC;

#案例5.查询员工名、部门名、工种名，并按部门名降序(三表连接)
#注意三表连接是要注意前后顺序

SELECT e.`last_name` AS 员工名, d.`department_name` AS 部门名, j.`job_title` AS 工种名
FROM employees AS e
INNER JOIN departments AS d ON e.`department_id`=d.`department_id`
INNER JOIN jobs AS j ON e.`job_id` = j.`job_id`
ORDER BY d.`department_name` DESC;


#2) 非等值连接
#案例：查询员工的工资级别

SELECT salary 员工的工资, grade_level 工资级别
FROM employees e
INNER JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`;

#案例：查询工资级别的个数 > 20的个数，并且按工资级别降序
SELECT COUNT(*) 工资级别个数, grade_level
FROM employees e
INNER JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY grade_level
HAVING COUNT(*) > 20
ORDER BY grade_level DESC;

#3) 自连接
#案例：查询员工的名字、上级的名字
SELECT e.last_name 员工名, m.last_name 上级名
FROM employees e
INNER JOIN employees m
ON e.`employee_id` = m.`manager_id`;




#二、外链接
/*
应用场景：用于查询一个表中有，另一个表没有的记录

特点：
1、外链接的查询结果为主表中的所有记录
如果从表中有和它匹配的，则显示匹配的值
如果从表中没有和它匹配的，则显示null
外连接查询结果=内连接结果+主表中有而从表中没有的记录


2、左外连接，left join左边的是主表
右外连接，right join右边的是主表

3、左外和右外交接两个表的顺序，可以实现同样的效果
4、全外连接=内连接的结果+表1中有但表2没有的+表2中有但表1中没有的


语法：
select 查询表
from 表
left outer join 左边的是主表
right outer join 右边是主表
on （判断条件）
其他的筛选条件和排序条件

*/

#引入：查询男朋友 不在男神表中的女神名
#一） 左外连接
SELECT b.`name` AS 女神名
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`
WHERE bo.`id` IS NULL;


#二） 右外连接
SELECT b.`name` AS 女神名
FROM boys bo
RIGHT OUTER JOIN beauty AS b
ON bo.`id`=b.`boyfriend_id`
WHERE bo.`id` IS NULL;


#案例1:查询哪个部门没有员工

#使用左外连接来实现
SELECT d.*, e.`employee_id`
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;


#三、交叉连接
USE girls;
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;





#多表连接

#案例一、查询编号>3的女神的男朋友信息，如果有则列出详细，如果没有，用null填充

SELECT b.*, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE b.`id` > 3;

#案例二、查询哪个城市没有部门

USE myemployees;
SELECT l.`city`
FROM departments AS d
RIGHT OUTER JOIN locations AS l
ON d.`location_id` = l.`location_id`
WHERE d.`department_id` IS NULL;



#案例三、查询部门名为SAL或IT的员工信息


SELECT e.*,d.`department_name`
FROM departments AS d
LEFT OUTER JOIN employees AS e
ON d.`department_id`=e.`department_id`
WHERE d.`department_name` IN("SAL","IT");







