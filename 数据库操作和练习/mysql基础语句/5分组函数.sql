#5、分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数
分来：
sum 求和、avg 平均值、max 最大值、min 最小值、count 计算个数


特点：
1.avg和min、max、count都会忽略null值
2.sum和avg只处理数值型，其他的可以支持非空的值

3.可以和distinct函数实现联合使用

4.count函数的详细介绍

5.和分组函数一同查询的字段要求是group by是同一个字段

*/
#1.简单的使用
SELECT SUM(salary) 总和, AVG(salary) 平均值, MAX(salary) 最大值, MIN(salary) 最小值, COUNT(salary) 个数
FROM employees;

#2.可以忽略null值
SELECT SUM(commission_pct), MAX(commission_pct) FROM employees;

#可以和distinct搭配使用
SELECT SUM(DISTINCT(salary)), SUM(salary) FROM employees;
SELECT COUNT(DISTINCT(salary)), COUNT(salary) FROM employees;


#3、count函数的详细介绍
#实现统计行的个数
SELECT COUNT(*) FROM employees;

SELECT COUNT(1) FROM employees;

SELECT COUNT("函数") FROM employees;


效率：
MYISAM 存储引擎下, COUNT(*) 的效率高
INNODB 存储引擎下, COUNT(1) 和 COUNT(*) 的效率比较高，比 COUNT(字段) 要高一些