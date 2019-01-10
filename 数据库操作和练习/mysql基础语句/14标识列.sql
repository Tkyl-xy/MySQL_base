#标识列
/*
又称为自增长列
含义：可以不用手动的插入值，系统提供默认的序列值

特点：
1，标识列必须和主键搭配吗？不一定，但要求是一个key(也可以是unique)
2，一个表可以有几个标识列？至多一个
4，标识的类型只能是数值
3，标识列可以通过set auto_increment_increment=3;设置步长可以通过手动插入值，设置起始值

*/

#一，创建表时设置标识列
DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,#自动增长
	NAME VARCHAR(20)
);

INSERT INTO tab_identity VALUES(NULL,"Tom");
INSERT INTO tab_identity(NAME) VALUES("Jack");

SELECT * FROM tab_identity;

#这里是查看库里面的参数默认设置值
SHOW VARIABLES LIKE "%auto_increment%";

#这里是设置自增长+3
SET auto_increment_increment = 3;


#二，修改表时设置标识列
DROP TABLE  IF EXISTS test2;

CREATE TABLE test2(
	id INT PRIMARY KEY,
	NAME VARCHAR(20)
);

ALTER TABLE test2 MODIFY COLUMN id INT AUTO_INCREMENT;
DESC test2;

TRUNCATE TABLE test2;

#I,修改表时删除标识列

ALTER TABLE test2 MODIFY COLUMN id INT;









