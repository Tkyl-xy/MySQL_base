#1、查询员工表中的最大入职时间和最小入职时间的相差天数

#2、利用datediff是一个日期函数，可以计算天数
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) AS 相差天数 FROM employees;


#3、查询部门编号为90的员工个数
SELECT COUNT(*)
FROM employees
WHERE department_id = 90;
