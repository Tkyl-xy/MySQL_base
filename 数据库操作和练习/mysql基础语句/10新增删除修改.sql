#DML语言

/*
数据库操作语言

插入：insert
修改：update
删除：delete
]*/

#一：插入语句
#方式一：经典插入

/*
语法：
insert into 表名(列名,……) values(值1,……)


*/
SELECT * FROM beauty;

#1，插入的值的类型要与列的类型一致或兼容
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,"刘亦菲","女","1882-4-21","123456789",NULL,2);

#2，不可以为null的列不能省略还是要插入值哪怕是空
#方式I：
INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(14,"刘亦菲1","女","1882-4-21","123456789",NULL,2);

#方式II：

INSERT INTO beauty(id,NAME,sex,phone)
VALUES(16,"刘备","男","112");

INSERT INTO beauty(id,NAME,sex,phone)
VALUES(15,'娜扎','女','1388888888');

#3，列的顺序可以改变的,还有列数和值的个数必须一致
INSERT INTO beauty(NAME,id,sex,phone)
VALUES("逐客令",17,"女","100");

SELECT * FROM beauty;

#5.可以省略列名，默认所有列，而且列的顺序和表中列的顺序一致
INSERT INTO beauty
VALUES(18,"华纳","女","1995-5-21","114454",NULL,NULL);


#方式二：
/*
语法：
insert into 表名
set 列名=值 ，列名=值，....
*/
INSERT INTO beauty
SET id=19,NAME="华语",phone="110";

#两种方式的大PK
#方式一支持多行插入，方式二不支持
INSERT INTO beauty(id,NAME,phone)
VALUES(20,"张一","112"),
(21,"张二","113"),
(23,"张三","114");

SELECT * FROM beauty;

#方式一支持子查询，方式二不支持
INSERT INTO beauty(id,NAME,phone)
SELECT 24,"宋小宝","154654";

#二,修改语句
/*
1.修改单表的记录

语法：
update 表名
set 列=新值，列=新值，……
where 筛选条件




*/
#1.修改单表的记录的案例
#案例1：修改beauty表中的姓张的性别为男
UPDATE beauty
SET sex = "g"
WHERE NAME LIKE "张%";


SELECT * FROM beauty;

SELECT * FROM boys;

INSERT INTO boys
VALUES(5,"张飞",10);


#案例2：修改boys表中id为5的名称为刘备，魅力值为1000
UPDATE boys
SET boyName = "刘备",userCP=1000
WHERE id=5;


#2.修改多表的记录

#案例1：修改张无忌的女朋友的手机号码为114,并且修改张无忌的魅力值为1000
UPDATE boys bo
INNER JOIN beauty b
ON bo.`id`=b.`boyfriend_id`
SET b.`phone`="456789",bo.`userCP`=1000
WHERE bo.`boyName`="张无忌";


#案例2：修改没有男朋友的女神的男朋友编号都为2号
UPDATE boys bo
INNER JOIN beauty b
ON bo.`id`=b.`boyfriend_id`
SET b.`boyfriend_id`=2
WHERE bo.`id` IS NULL;

SELECT * FROM boys;





#三，删除语句
/*
方式一：delete
语法：
1，单表的删除【💗】
delete from 表名 where 筛选条件;

2，多表的删除【补充】

delete 表一的别名，表二的别名
from 表一的别名，表二的别名
where 连接条件





方法二：truncate
语法：truncate table 表名;

*/



#方式一：delete
#1.单表的删除
#案例1：删除名字为张的女神信息

DELETE FROM beauty WHERE NAME LIKE "张%";

SELECT * FROM beauty;

DELETE FROM beauty WHERE NAME LIKE "刘%";

#2.多表的删除

#案例：删除张无忌的女朋友的信息

SELECT * FROM boys;

SELECT * FROM beauty;


DELETE b
FROM boys bo
INNER JOIN beauty b
ON bo.`id`=b.`boyfriend_id`
WHERE bo.`boyName`="张无忌";


#案例：删除黄晓明的信息以及他女朋友的信息
SELECT * FROM beauty;

SELECT * FROM boys;


DELETE bo, b
FROM boys bo
INNER JOIN beauty b
ON b.`boyfriend_id`=bo.`id`
WHERE bo.`boyName`="黄晓明";



#方式二：truncate语句

#案例：将魅力值 > 100的男神信息删除
TRUNCATE TABLE boys;

SELECT * FROM boys;


INSERT INTO boys(boyName,userCP)
VALUES("张无忌",1000),("鹿晗",500),("黄晓明",600),("刘备",1500);	


SELECT * FROM boys;

DELETE FROM boys;

#delete和truncate的区别和特点
/*
1，delete 可以加where条件, truncate不能加

2，truncate删除，效率比较高
3，假如要删除的表中有自增长
如果用delete删除后，再插入数据，自增长列的值从断点开始自+
而用truncate删除后，再插入数据，自增长列的值从1开始自+

4，truncate删除后没有返回值，delete删除有返回值
5，truncate删除不能回滚，delete删除后可以回滚
*/








