#视图
/*
含义：虚拟表，和普通表一样使用
mysql5.1版本出现的新特性，是通过表动态生成的数据
只保存了sql逻辑，不保存查询结果

应用场景：
	多个地方用到同样的查询结果
	该查询结果使用的sql语句教复杂

use myemployees;

*/
#查询员工号为100的部门名字


#以前用内链接的做法
SELECT department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE employee_id=100;

#现在用的是视图的做法
CREATE VIEW dv1
AS
SELECT department_name,employee_id
FROM employees e
INNER JOIN departments d
ON e.`department_id`=d.`department_id`;
#注：as下面部分的语句代码代表的是执行出来的结果当做一个表来使用

SELECT department_name,employee_id FROM dv1
WHERE employee_id=100;



#案例练习  (用视图来解决)
#1.查询姓名中包含a字符的员工名，部门名和工种信息
#注：员工名为last_name,部门名为department_name，工种信息为job_title

CREATE VIEW myv1
AS
SELECT last_name, department_name, job_title
FROM employees e
INNER JOIN departments d ON e.department_id=d.department_id
INNER JOIN jobs j ON j.job_id=e.job_id;

SELECT * FROM myv1
WHERE last_name LIKE "%a%";

#2.查询各部门的平均工资的级别
#I，先查询各部门的平均工资

DROP TABLE IF EXISTS myv2;


CREATE VIEW myv2
AS
SELECT AVG(salary) ag, department_id
FROM employees
GROUP BY department_id;

#II，在查询级别
SELECT mm.`ag` AS 工资, grade_level 工资级别
FROM myv2 mm
INNER JOIN job_grades ON mm.`ag`BETWEEN lowest_sal AND highest_sal;


#3.查询平均工资最低的部门信息
SELECT * FROM myv2 ORDER BY ag LIMIT 1;


#4.查询平均工资最低的部门名和工资等信息
#视图可以嵌套使用
CREATE VIEW myv3
AS
SELECT * FROM myv2 ORDER BY ag LIMIT 1;

SELECT d.*, mmm.`ag`
FROM myv3 mmm
INNER JOIN departments d
ON d.`department_id`=mmm.`department_id`;

/*
视图的语法:
	create view 视图名
	as
	查询语句;
	
	
视图的好处:
	重用sql语句
	简化复杂的sql操作，不必知道它的查询细节
	保护数据，提高安全性
*/


#二、视图的修改
#方式以：
/*
create or replave view 视图名
as
查询语句;


alter view 视图名
as
查询语句;
*/

#三、删除视图
/*
drop view 视图名

*/
DROP VIEW IF exis`myemployees`ts dv1;


#四、查看视图

DESC myv1;
SHOW CREATE VIEW myv1;

#五、视图更新

CREATE OR REPLACE VIEW myv3
AS
SELECT last_name,email
FROM employees;
SELECT * FROM myv3;

#1、插入
INSERT INTO myv3 VALUES("张飞","zf@qq.com");

#2、修改
UPDATE myv3 SET last_name="张无忌",email="zhangwuji@qq.com" WHERE last_name="张飞";

#3、删除
DELETE FROM myv3 WHERE last_name="张无忌";



#一般设置视图为只读的权限(为了安全)
#具备以下特点的视图不允许更新
#I包含以下关键字的sql语句：分租函数、distinct、group by、having、 union、或者union all

CREATE OR REPLACE VIEW dv1
AS 
SELECT MAX(salary) AS m, department_id
FROM employees
GROUP BY department_id;

SELECT * FROM dv1;

UPDATE dv1 SET m=9000 WHERE department_id=10;
#提示The target table dv1 of the UPDATE is not updatable




















