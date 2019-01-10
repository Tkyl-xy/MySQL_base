#常见约束
/*
含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确性和可靠性
分类：六大约束
	NOT NULL:非空，用于保证该字段的值不能为空（如：姓名，学号等）
	
	DEFAULT：默认，用于保证该字段有默认值,比如：性别
	
	PRIMARY KEY:主键，用于保证该字段的值具有唯一性，并且非空
	(比如：学号，员工编号等)
	
	UNIOUE：唯一，用于保证该字段的值具有唯一性，可以为空(如：座位号)
	
	CHECK:检查约束【mysql中不支持】
	比如：年龄，性别
	
	FOREIGN KEY:外键，用于限制两表的关系，用于保证该字段的值必须来自于
	主表的关联列的值，在从表中外键约束，用于引用主表中某列的值
	比如：学生表的专业编号，员工表的部门编号
	
	
添加约束的时机：
	1.创建表时
	2.修改表时


约束的添加分类：
	初级约束:
		六大约束语法上都可以支持，但外键约束没有效果
	
	
	表级约束：
		除了非空，默认，其他的都支持


外键：
	1，要求在从表设置外键关系
	2，从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求
	3，主表在关联列必须是一个key（主键，唯一，外键）
	4，插入数据时，先插入主表，在删除从表
	删除数据时

*/

CREATE TABLE 表名(
	字段名	字段类型  约束,
	字段名	字段类型,
	表级约束
	
);



#1.添加列级约束
/*
语法：
直接在字段名和类型后面追加， 约束类型即可

只支持：默认，非空，主键，唯一
*/
CREATE DATABASE studens;
USE studens;


CREATE TABLE stuinfo(
	id INT(8) PRIMARY KEY,#主键
	stuName VARCHAR(20) NOT NULL,#非空
	gender CHAR(1) CHECK(gender="男" OR gender="女"),#检查
	seat INT UNIQUE,#唯一
	age INT DEFAULT 18,#默认约束
	majorId INT REFERENCES major(id)#外键
);


CREATE TABLE major(
	id INT PRIMARY KEY,#主键
	majorName VARCHAR(20)
);

SHOW TABLES;
DESC stuinfo;
SHOW INDEX FROM stuinfo;



#2，表级约束
/*
语法：在各个字段的最下面
【constraint 定义的约束名】 约束类型(字段名)
connstraint fk roreign key(从表) references(主表)
*/


DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo(
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	
	
	#constraint英文时约束的意思	
	CONSTRAINT pk PRIMARY KEY(id),#主键
	CONSTRAINT uq UNIQUE(seat),#唯一键
	CONSTRAINT ck CHECK(gender='男' OR gender='女'),#检查
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorid) REFERENCES major(id)#外键
	
);
DESC stuinfo;
SHOW INDEX FROM stuinfo;
#也可以省略constraint + 定于的约束名
CREATE TABLE stuinfo(
	id INT,
	stuName VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	
	PRIMARY KEY(id),#主键
	UNIQUE(seat),#唯一键
	CHECK(gender="男" OR gender="女"),#检查
	FOREIGN KEY(majorid) REFERENCES major(id)#外键
);

DESC stuinfo;
SHOW INDEX FROM stuinfo;




#primary key()主键
#unique()#唯一键
#check(列的数据or列的数据)#检查
#foreign key(主键的列名) references 从键的(列)

CREATE DATABASE IF NOT EXISTS test;
USE test;
SHOW DATABASES;
SHOW TABLES;


DROP TABLE IF EXISTS test1;

CREATE TABLE test1(
	id 	INT(10) 	PRIMARY KEY,
	tname 	CHAR(20)	NOT NULL,
	gender	CHAR(1)		CHECK(gender="男" OR gender="女"),
	expeid	INT,
	#majorid	int 		references expe(id)#外键
	#也可以这样写
	CONSTRAINT fk_expeid FOREIGN KEY(expeid) REFERENCES expe(id)
	
);

DROP TABLE IF EXISTS expe;
CREATE TABLE expe(
	id 	INT PRIMARY KEY,
	ename	VARCHAR(20)
	
	
);

#先插入主表的数据
SELECT * FROM expe;
DELETE FROM expe WHERE id=1;


INSERT INTO expe VALUES(201, "htm5");
INSERT INTO expe VALUES(202,"Java");

#在插入从表的数据
INSERT INTO test1 VALUES(1,"Tom","男",201);
INSERT INTO test1 VALUES(2,"Jack","女",202);
INSERT INTO test1 VALUES(3,"Alice","男",203);
SELECT * FROM test1;


SELECT e.*
FROM test1 t
INNER JOIN expe e
ON t.expeid=e.id;

DELETE FROM expe;
SELECT * FROM expe;

TRUNCATE TABLE test1;







#二，修改表的添加的约束操作
/*
1，添加列级约束
alter table 表名 modify column 字段名 字段类型 新约束
2, 添加表级约束
alter table 表名 add 【constraint 约束名】约束类型(字段名)
*/
DROP TABLE IF EXISTS test1;
CREATE TABLE test1(
	id 	INT(10) 	PRIMARY KEY,
	tname 	CHAR(20)	NOT NULL,
	gender	CHAR(1)		CHECK(gender="男" OR gender="女"),
	seat	INT(10)		UNIQUE,
	expeid	INT
	#majorid	int 		references expe(id)#外键
	#也可以这样写
	
);

CREATE TABLE major(
	id INT,
	mname VARCHAR(20)
);
DESC test1;
DESC major;

#1，修改空约束
ALTER TABLE test1 MODIFY COLUMN tname CHAR(20) NOT NULL;


#3，添加表中的主键
ALTER TABLE major ADD PRIMARY KEY(id);
#这个是列级中添加的主键约束
ALTER TABLE test1 MODIFY COLUMN id INT(10) PRIMARY KEY;
#下面这个是表级约束
ALTER TABLE test1 ADD PRIMARY KEY(id);

#4，添加默认约束
ALTER TABLE test1 MODIFY COLUMN tname CHAR(20) DEFAULT "Tom";

#5，添加外键约束
ALTER TABLE test1 ADD  CONSTRAINT fk_expeid FOREIGN KEY(expeid) REFERENCES major(id);
DESC test1;



#三，修改表时删除约束

#2，删除表中的唯一键
ALTER TABLE test1 DROP INDEX seat;

SHOW INDEX FROM test1;


 
#2，删除表中的主键
ALTER TABLE test1 DROP PRIMARY KEY;



#3，删除外键
ALTER TABLE test1 DROP FOREIGN KEY fk_expeid;
SHOW INDEX FROM test1;

















