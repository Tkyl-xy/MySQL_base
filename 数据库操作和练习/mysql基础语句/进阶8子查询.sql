#进阶7：子查询
/*
含义：出现在其他语句的select语句，称为子查询或内查询
外部的查询语句，称为主查询

分类：
按子查询出现的位置：
	select 后面:
		仅仅支持标量子查询
	
	
	
	from 后面:
		支持表子查询
	
	
	where或having 后面：(重点) ※
		标量子查询（单行）√
		列子查询  （多行）√
		
		
		行子查询
	
	
	exists 后面（相关子查询）:
		表子查询

按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果只有一行多列）
	表子查询（结果有多行多列）

*/

#一）:当在where或having后面的子查询：
#1、标量子查询（单行子查询）


#2、列子查询（多行子查询）


#3、行子查询（多列多行）
/*
特点：：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用
如：>   <   >=   <=    <>   =
 
④列子查询，一般搭配着多行操作符的使用
IN/NOT IN  ANY/SOME   ALL

⑤子查询的执行条件优先于主查询的执行，主查询的条件用到了子查询的结果
*/





#1、标量子查询
#案例1：查询谁的工资比Abel高？
#①先查看Abel的工资
USE myemployees;
SELECT salary
FROM employees
WHERE last_name = "Abel";

#②查询员工的信息，满足salary>Abel的工资结果
SELECT last_name, salary
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE last_name = "Abel"
);



#案例2：返回job_id与141号员工相同，salary与143号员工多的员工、姓名、job_id和工资

#①查询job_id与141号员工相同
SELECT job_id
FROM employees
WHERE employee_id = 141;

#②查询143号的salary
SELECT salary
FROM employees
WHERE employee_id = 143;

#③查询员工的姓名，job_id和工资，要求job_id=①并且salary > 143的salary
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141
) AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 143
);


#案例3：返回公司工资最少的员工的last_name, job_id和salary
#①先查询公司最低的工资
SELECT MIN(salary)
FROM employees;

#② 查询last_name, job_id和salary，要求salary=①
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);


#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资

#①查询50号部门的最低工资
SELECT MIN(salary)
FROM employees
WHERE department_id = 50;

#②查询每个部门的最低工资
SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id;


#三在②的基础上筛选，满足min(salary)>①
SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

#注意：非法使用标量子查询




#2：列子查询（多行子查询，一列多行）


#案例一：返回location_id是1400或1700的部门中的所有员工姓名

#1.查询location_id是1400或1700之间的部门编号
SELECT department_id
FROM departments
WHERE location_id IN (1400, 1700);

#2.查询员工姓名，要求部门号在1列表中的某一个

SELECT last_name,department_id
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400,1700)
);


#案例2：返回其他工种比job_id为`IT_PROG`工种任一工资低的员工的员工号、姓名、job_id以及salary

#1）：先查询job_id为IT_PROG部门的任一工资
USE myemployees;
SELECT DISTINCT salary
FROM employees
WHERE job_id = "IT_PROG";


#2）：在查询员工号、姓名、job_id、salary < 1)中的任意一个
SELECT e.`employee_id`, e.`last_name`, e.`job_id`, e.`salary`
FROM employees AS e
WHERE salary < ANY(
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id = "IT_PROG"
) AND job_id <> "IT_PROG";


#另外一种写法：
SELECT e.`employee_id`, e.`last_name`, e.`job_id`, e.`salary`
FROM employees AS e
WHERE salary < (
	SELECT MAX(DISTINCT salary)
	FROM employees
	WHERE job_id = "IT_PROG"
) AND job_id <> "IT_PROG";





#案例4：返回其他工种比job_id为`IT_PROG`工种任一工资低的员工的员工号、姓名、job_id以及salary
SELECT e.`employee_id`, e.`last_name`, e.`job_id`, e.`salary`
FROM employees AS e
WHERE salary < ALL(
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id = "IT_PROG"
) AND job_id <> "IT_PROG";




#3、行子查询（结果集一行多列或多行多列）

#案例：查询员工编号最小并且工资最高的员工细信息

SELECT  *
FROM employees AS e
WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary)
	FROM employees
);


#或上面以前的方法
SELECT  *
FROM employees
WHERE employee_id=(
	SELECT MIN(employee_id)
	FROM employees
) AND salary=(SELECT MAX(salary) FROM employees);



#二）：select后面
#案例：查询每个部门的员工个数

SELECT d.*, (
	SELECT COUNT(*)
	FROM employees e
	WHERE e.department_id = d.`department_id`
) 员工个数
FROM departments AS d
ORDER BY d.`department_id`;

#案例2：查询员工号为102的部门名
SELECT (
	SELECT department_name
	FROM departments d
	INNER JOIN employees e
	ON d.department_id = e.department_id
	WHERE e.employee_id = 102
) 部门名;



#三，from后面

#查询每个部门的平均工资的工资等级

#1-先查询每个部门的平均工资
SELECT AVG(salary) 平均工资, department_id 部门号
FROM employees
GROUP BY department_id;

#2-再查询工资的级别
SELECT * FROM job_grades;


#然后2连接1的结果集和job_grades表,筛选条件平均工资 between lowest_sal and highest_sal

SELECT ag_dep.*, job_g.`grade_level` 工资等级
FROM (
	SELECT AVG(salary) av_g, department_id d_id
	FROM employees
	GROUP BY department_id
) ag_dep
INNER JOIN job_grades job_g
ON ag_dep.av_g BETWEEN job_g.`lowest_sal` AND job_g.`highest_sal`;


#四，放在exists后面（相关子查询）
/*
语法：
exists（完整的查询语句）
结果：
1或0


*/

SELECT EXISTS(SELECT employee_id FROM employees WHERE salary=30000) AS 结果;


#案例1：查询有员工的部门名

SELECT department_name
FROM departments d
WHERE EXISTS(
	SELECT *
	FROM employees e
	WHERE d.`department_id`=e.`department_id`
);


#也可以用连接查询来
SELECT department_name
FROM departments d
WHERE d.`department_id` IN (
	SELECT department_id
	FROM employees
);





#案例2：查询没有女盆友的男神信息

SELECT bo.*
FROM boys bo
WHERE EXISTS(
	SELECT boyfriend_id
	FROM beauty b
	WHERE bo.`id`=b.`boyfriend_id`
);








