#4常见函数的练习和测试
#1.显示系统时间（日期+时间）
SELECT NOW();

#2.将员工的姓名按首字母排序，并写出姓名的长度(length)
SELECT LENGTH(last_name) AS 姓名长度,SUBSTR(last_name,1,1) AS 首字母,last_name AS 姓名
FROM employees
ORDER BY 首字母 DESC;

#5.	使用case-when，按照下面的条件：
/*
job                  grade
AD_PRES            A
ST_MAN             B
IT_PROG             C
SA_REP              D
ST_CLERK           E
产生下面的结果
Last_name	Job_id	Grade
king	AD_PRES	A
*/
SELECT 
last_name AS 姓名,
job_id AS job,
CASE job_id
WHEN "AD_PRES" THEN "A"
WHEN "ST_MAN" THEN "B"
WHEN "IT_PROG" THEN "C"
WHEN "SA_REP" THEN "D"
WHEN "ST_CLERK" THEN "E"
ELSE "come on babay!!"
END AS grade
FROM employees;
