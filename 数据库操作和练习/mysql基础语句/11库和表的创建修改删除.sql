#DDL
/*
数据定义语言

库和表的管理

一，库的管理
创建，修改，删除
二，表的管理
创建，修改，删除

创建：create
修改：alter
删除：drop

*/
#一库的管理
#1，库的创建
/*create database [if not exists] 库名*/


#案例：创建book库
CREATE DATABASE IF NOT EXISTS book;

#2，库的修改
#可以更改库的字符集
ALTER DATABASE book CHARACTER SET utf8;

#3，库的删除
DROP DATABASE IF EXISTS book;


#二，库中表的管理
#1，表的创建（重点）
/*
create table 表名(
	列名 列的类型【（长度） 约束】,
	列名 列的类型【（长度） 约束】,
	列名 列的类型【（长度） 约束】,
	....
	列名 列的类型【（长度） 约束】
)
*/

#案例：创建表Book
USE Book;
CREATE TABLE book(
	id INT,#书的编号
	bName VARCHAR(20),#图书名
	price DOUBLE,#价格
	authorId INT,#作者编号
	publishDate DATETIME#出版日期
);
DROP TABLE IF EXISTS book;
DESC Book;


CREATE TABLE IF NOT EXISTS autor(
	id INT,
	auName VARCHAR(20),
	nation VARCHAR(10)
);

DESC autor;


#2，表的修改
/*
alter table 表名 add|drop|modify|change column 列名【列类型或约束】
*/
#注意I是1，II是2，III是3，IV是4，V是5，VI是6，
#VII是7，VIII是8，IX是9，X是10

# I 修改列名
#使用change
/*语法是：alter table 加表 change column 旧列名 新列名 加类型*/
#主：column是列的意思,column可以省略
ALTER TABLE Book CHANGE COLUMN publishDate pubDate DATETIME;
DESC Book;

ALTER TABLE Book CHANGE authorId auID INT;
DESC Book;

# II 修改列的约束和类型
#使用modify
ALTER TABLE Book MODIFY COLUMN pubDate TIMESTAMP;

# III 添加新列,也可以添加到列的任何位置，
#alter atble 表名 add column 列名 类型还可以加约束,也可以插入的位置顺序【first|after 列名】
#使用add
ALTER TABLE book ADD COLUMN tab_column VARCHAR(8) AFTER id;

ALTER TABLE Book ADD COLUMN annual DOUBLE;
DESC Book;


# IV 删除列
#使用drop,不用加类型
ALTER TABLE Book DROP COLUMN annual;

# VI 修改表名
#使用rename to
ALTER TABLE autor RENAME TO Autor_Book;
SHOW TABLES;




#3.表的删除
DROP TABLE IF EXISTS Autor_Book;
SHOW TABLES;

#通用写法：

DROP DATABASE IF EXISTS 旧库名;
CREATE DATABASE 库名;

DROP TABLE IF EXISTS 旧表名
CREATE TABLE 表名();

#4，表的复制
INSERT INTO autor
VALUES(1,"宫崎骏","日本"),
(2,"莫言","中国"),
(3,"韩寒","中国"),
(4,"金庸","中国");

TRUNCATE autor;

SELECT * FROM autor;
DESC copy;

#1.仅仅复制表的结构
CREATE TABLE copy LIKE autor;

SELECT * FROM copy;
DESC copy;

#2.复制表的结构+数据
CREATE TABLE copy2
SELECT * FROM autor;

SELECT * FROM copy2;

DESC copy2;


#3.只复制部分数据
#案例：只复制autor的id, auName的数据，且nation是中国的
CREATE TABLE copy3
SELECT id,auName
FROM autor
WHERE nation="中国";

DESC copy3;

SELECT * FROM copy3;


#4.仅仅复制某些字段
CREATE TABLE copy4
SELECT id,auName
FROM copy2
WHERE 0;

SELECT * FROM copy4;
DESC copy4;


















