#实验楼的实验教程
CREATE DATABASE mysql_shiyan;

USE mysql_shiyan;

CREATE TABLE department(
	dpt_name CHAR(20) NOT NULL,
	peole_num INT(10) DEFAULT 10,
	CONSTRAINT dpt_pk PRIMARY KEY (dpt_name)
	
);

CREATE TABLE employee(
	id 	INT(10) PRIMARY KEY,
	NAME 	CHAR(20),
	age 	INT(10),
	salary 	INT(10) NOT NULL,
	phone	INT(12) NOT NULL,
	in_dpt	CHAR(20)NOT NULL,
	UNIQUE 	(phone),
	CONSTRAINT emp_fk FOREIGN KEY(in_dpt) REFERENCES department(dpt_name)
);

CREATE TABLE project(
	proj_num	INT(10) NOT NULL,
	proj_name	CHAR(20) NOT NULL,
	start_date 	DATE NOT NULL,
	end_date	DATE DEFAULT '2015-04-01',
	of_dpt		CHAR(20) REFERENCES deparment(dpt_name),
	
	#这里定义的时复合主键
	CONSTRAINT proj_pk PRIMARY KEY (proj_num,proj_name)
);
SHOW TABLES;

DESC department;
DESC employee;
DESC project;


SHOW INDEX FROM department;
SHOW INDEX FROM project;
SHOW INDEX FROM employee;




#默认值约束
#这里正常插入数据
INSERT INTO department(dpt_name,peole_num)
VALUES('dpt1',11);
SHOW TABLES;
DESC department;
SHOW INDEX FROM department;
SELECT * FROM department;


#当正常插入新的数据，peole_num为空时，使用默认值
INSERT INTO department(dpt_name)
VALUES('dpt2');



#唯一约束(unique)，在表的employee中的列phone
DESC employee;
INSERT INTO employee VALUES(01,"Tom",12,300,1111,"dpt1");

#insert into employee values(02,"Alice",13,300,1111,"dpt2");
#这一条的语句中的phone唯一unique约束了，所以不允许重复插入



#外键约束(foreign key)既能确保数据的完整性，也能表现表之间的关系
#例子：如下条语句，在insert时，如果被外键约束的值没有在参考列中有对应值
INSERT INTO employee VALUES(03,"Alice",13,500,112255,"dpt3");














