#库和表的管理的经典案例
#1.创建数据库dept，再创建表dept1
/*
NAME	NULL?	TYPE
id 		int(7)
name 		varchar(25)
*/
CREATE DATABASE dept;

SHOW DATABASES;

USE dept;

CREATE TABLE dept1(
	id INT(7),
	NAME VARCHAR(25)
);

SHOW TABLES;
DESC dept1;

#2.将表departments中的数据插入到库dept的新表dept2中
CREATE TABLE dept2
SELECT *
FROM myemployees.`departments`;

SHOW TABLES;
SELECT * FROM dept2;


DROP TABLE IF EXISTS dept2;

SHOW DATABASES;

#3.创建emp5
/*
name	null?	type
id 		int(7)
first_name	varchar(25)
last_name	varchar(25)
dept_id		int(7)
*/


CREATE TABLE emp5(
	id INT(7),
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	dept_id	INT(7)
);

SELECT * FROM emp5;

DESC emp5;

#4.将列last_name的长度增加到50
ALTER TABLE emp5 MODIFY COLUMN last_name VARCHAR(50);
DESC emp5;


#5.根据表emlployees创建employees2
CREATE TABLE employees2 LIKE myemployees.`employees`;

#复制myemployees.`employees`表的结构给employees2表中
DESC employees2;
SELECT * FROM employees2;


#6.删除表emp5

DROP TABLE IF EXISTS emp5;
SHOW TABLES;

#7.将表employees2重命名为emp5
ALTER TABLE employees2 RENAME TO emp5;
SHOW TABLES;

#8.在表dept1中添加新列test_column
DESC dept1;
ALTER TABLE dept1 ADD COLUMN test_column INT;


#9.直接删除表emp5中的列last_name
DESC emp5;
SELECT * FROM emp5;
ALTER TABLE emp5 DROP COLUMN last_name;








