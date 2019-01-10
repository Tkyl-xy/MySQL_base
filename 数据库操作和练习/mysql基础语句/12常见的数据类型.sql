#常见的数据类型
/*
数值型：
	整型
	小数：
	定点数
	浮点数
	
字符型：
	较短的文本：char，varchar
	
	较长的文本：text，blob（较长的二进制数据）
	

日期型：



*/

#一，整型
/*
分类：
tinyint,  smallint,  mediumint,  int/integer,  bigint

1	   2          3		  4		8

特点：

I：如果不设置无符号还是有符号，默认是有符号，如果先设置无符号，需要添加unsigned关键字
(unsigned关键字是指设置该类型为正整数，不能是负数)


II：如果插入的数值超出了整型的范围，会报out of range异常，并且插入临界值

III：如果不设置长度，会有默认的长度
这里的长度代表了显示的最大宽度，如果不够会用0在左边填充，但必须搭配zerofill使用!!
zerofill都是正数



*/



# I，如何设置无符号和有符号

DROP TABLE IF EXISTS tab_int;

CREATE TABLE tab_int(
	t1 INT(10) ZEROFILL,
	t2 INT(7)
);

DESC tab_int;
SHOW TABLES;
SELECT * FROM tab_int;

INSERT INTO tab_int VALUES(-1555,4294967296);
INSERT INTO tab_int VALUES(454,164);
INSERT INTO tab_int VALUES(123456,-729);


#二，小数
/*
分类：
	1.浮点型
	float(M, D)
	double(M, D)
	
	
	2.定点型
	dec(M, D)
	decimal(M, D)
	
	特点：
	I：
	M：整数部位 + 小数部位
	D：小数部位
	如果超过部位，则插入临界值
	超过默认精度则会四舍五入
	
	II：
	M和D都可以省略
	如果是decimal,则M默认为10，D默认为0
	如果是float和double，则会根据插入的数值的精度来决定精度
	
	
	III：定点型的精度较高，如果要求插入数值的精度较高如货币运算等，
	则考虑使用
	
	
	
*/

#测试M和D
USE dept;
DROP TABLE IF EXISTS tab_float;

CREATE TABLE tab_float(
	f1 FLOAT(5,2),
	f2 DOUBLE(5,2),
	f3 DECIMAL(5,2)
);
SHOW TABLES;
SELECT * FROM tab_float;
DESC tab_float;

INSERT INTO tab_float VALUES(123.4556, 123.45555, 123.622);
INSERT INTO tab_float VALUES(123.4, 123.4, 123.459);
INSERT INTO tab_float VALUES(123.4, 123.4523, 122.412);


#三，字符型
/*
较短的文本:

char
varchar

其他：

binary和varbinary用于保存较短的二进制
enum用于保存枚举
set用于保存集合


较长的文本：
text
blob(较大的二进制)

特点：
写法	M的意思		特点					空间的耗费	效率
char	char(M)		最大的字符数，可以省略，默认为1		固定长度的字符	高
varchar	varchar(M)	最大的字符数，不可以省略		可变长度的字符	低

char(0~255)
varchar(0~65535)


*/

DROP  TABLE IF EXISTS tab_char;

CREATE TABLE tab_char(
	c1 CHAR,
	c2 VARCHAR(10)
);
SHOW TABLES;
SELECT * FROM tab_char;
DESC tab_char;

INSERT INTO tab_char VALUES("男","boy");
INSERT INTO tab_char VALUES("女","girls");
INSERT INTO tab_char VALUES("d","dog");

DELETE FROM tab_char;


CREATE TABLE tab_char(
	c3 ENUM("a","b","c")
);
SELECT * FROM tab_char;
DESC tab_char;


INSERT INTO tab_char VALUES("a");
INSERT INTO tab_char VALUES("b");
INSERT INTO tab_char VALUES("c");
INSERT INTO tab_char VALUES("m");
INSERT INTO tab_char VALUES("A");



DROP TABLE IF EXISTS tab_set;

CREATE TABLE tab_set(
	s1 SET("a","b","c","d")
);
SELECT * FROM tab_set;
DESC tab_set;

INSERT INTO tab_set VALUES("a");
INSERT INTO tab_set VALUES("a,b");
INSERT INTO tab_set VALUES("a,c,d");



#4日期型

/*
分类：
	date 只保存日期
	time 只保存时间
	year 只保存年份
	
	datetime 保存日期+时间
	timestamp 保存日期+时间
	
特点：
	字节		范围		时区等的影响
	datetime	1000-9999	不受
	timestamp	1970-2038	受

*/

CREATE TABLE tab_date(
	t1 DATETIME,
	t2 TIMESTAMP
);
SELECT * FROM tab_date;
DESC tab_date;


INSERT INTO tab_date VALUES(NOW(), NOW());

SHOW VARIABLES LIKE "basedir";




DESC test;
SELECT * FROM test;

