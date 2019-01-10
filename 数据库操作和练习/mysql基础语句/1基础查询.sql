#进阶1：基础查询
/*
语法：
select 查询列表 from 表名;

特点:
1、查询列表可以是:表中的字段、常量值、表达式、函数
2、查询的结果是一个虚拟的表格

*/
#1、查询表中的单个字段

SELECT last_name FROM employees;

#2、查询表中的多个字段
SELECT last_name,salary,email FROM employees;

#3.查询表中所有的字段，F12可以将代码对齐
#第一种方式
SELECT 
  `employee_id`,
  `first_name`,
  `last_name`,
  `email`,
  `phone_number`,
  `job_id`,
  `salary`,
  `commission_pct`,
  `manager_id`,
  `department_id`,
  `hiredate` 
FROM employees;

#第二种方式
#这种方式的顺序是按照正常的数据库的
SELECT * FROM employees;

#4.查询常量值
SELECT 100;
SELECT "yang";

#5.查询表达式
SELECT 100%90;

#6.查询函数
SELECT VERSION();
SELECT DATABASE();

#7.起别名
/*
①:便于理解
②:如果要查询的字段有重名的情况，使用别名可以区分开来
*/
#方式一：使用as
SELECT 100*100 AS 结果;
SELECT last_name AS 姓, first_name AS 名 FROM employees;
#方式二：使用空格
SELECT 100*200 结果;

#案列：查询last_name,显示结果为out put
SELECT last_name AS "out put" FROM employees;

#8.去重

#只重复一遍,在select后面加上distinct就可以了
#案列：查询员工表中的涉及到的所有部门编号
SELECT DISTINCT department_id FROM employees;
SELECT department_id FROM employees;
#9.+号的作用
/*
mysql中的+号：
仅仅只是一个功能：运算符

select 100+100;两个操作数为数值型,则作为加法运算
select "123"+100;	
#其中一方为字符型，试图将字符型数值转换成数值型
#如果转换成功，则继续做加法运算
#如果失败，则将字符型数值转换为0

select "john"+90;
select null+50;	只要其中一方为null，则结果肯定为null

*/

#9.拼接
#案列：查询员工名和姓连接成一个字段，并显示为姓名
SELECT CONCAT("a","b", "c") AS 结果;

SELECT 
  CONCAT(last_name,"-",first_name) AS 姓名 
FROM
  employees;