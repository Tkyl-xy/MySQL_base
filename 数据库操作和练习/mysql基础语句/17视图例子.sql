/*
create database if not exists python;
show databases;
use python;
show tables;

drop table if exists trade;
create table trade(
	id int(4) unsigned not null auto_increment,
	name varchar(8) not null comment "用户真实姓名",
	account varchar(21) not null comment "银行账号",
	saving 	decimal(8,2) unsigned  default 0.00 comment "账户储蓄金额",
	expend	decimal(8,2) unsigned  DEFAULT 0.00 comment "账户支出总计",
	income 	decimal(8,2) unsigned  DEFAULT 0.00 comment "账户收入总计",
	primary key(id),
	unique(name)
);
insert into trade values(1,"乔布斯","88888888",null,null,null);
insert into trade(id,name,account) values(2,"比尔盖茨","1232456");
drop database if exists python;


use performance_schema;
select * from address;
*/



#一、创建视图emp_v1，要求查询电话号码以"011"开头的员工姓名和工资，邮箱
USE myemployees;

CREATE OR REPLACE VIEW emp_v1
AS
SELECT last_name, salary, email
FROM employees
WHERE phone_number LIKE "011%";

SELECT * FROM emp_v1;


#二、创建视图emp_v2，要求查询部门的最高工资高于12000的部门信息
CREATE OR REPLACE VIEW emp_v2
AS
SELECT MAX(salary) max_salary,department_id
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 12000;


SELECT d.*,emp.`max_salary`
FROM departments d
JOIN emp_v2 emp
ON d.`department_id`=emp.`department_id`;















