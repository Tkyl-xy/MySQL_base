#进阶3：排序查询
/*
语法：
select 查询列表
from 表名
[where 筛选条件]
order by 排序的字段或表达式；

特点：
1.asc代表的是升序，可以省略,desc代表的式降序

2.order by子句可以支持单个字段、别名、代表式、函数、多个字段

3.order by字句在查询语句中的最后面，除了limit子句


*/
#案例1：查询员工的工资，从高到低排序
SELECT salary AS 工资 FROM employees ORDER BY salary DESC;
SELECT salary AS 工资 FROM employees ORDER BY salary;

#案例2：查询部门编号>=90的员工信息，按入职时间排序
SELECT * FROM employees WHERE department_id >=90 ORDER BY hiredate DESC;


#案例3：[按表达式排序]按年薪的高低显示员工的信息和年薪
SELECT *, salary * 12 * (1 + IFNULL(commission_pct,0)) AS 年薪
FROM employees
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;

#案例4：按姓名的长度来显示员工的姓名和工资【按函数排序】
SELECT 
LENGTH(last_name) AS 字节长度, 
last_name AS 姓名, 
salary AS 工资
FROM employees
ORDER BY LENGTH(last_name) DESC;

#案例5：查询员工信息，要求先按工资升序，在按员工编号降序【多个字段排序】

SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;


