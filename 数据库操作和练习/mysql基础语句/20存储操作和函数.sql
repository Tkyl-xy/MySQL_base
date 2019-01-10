#存储过程和函数
/*
存储过程和函数：类似于Java中的方法
好处：
	1.提高代码的重用性
	2.简化操作
*/

#存储过程
/*
定义：一组预先编译好的SQL语句的集合，理解成批处理SQL语句
1，提高代码的重用性
2，简化操作
3，减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率

*/
#一、创建语法

CREATE PROCEDURE 存储过程名(参数列表)
BEGIN
	存储过程体(一组合法的SQL语句)
END

#注意：
/*
1、参数列表包含三部分
参数模式	参数名		参数类型
举例：
in 参数名 varchar(20)

参数模式:
in:	该参数可以作为输入,也就是该参数需要调用方传入值
out:	该参数可以作为输出,也就是该参数可以作为返回值
inout:	该参数既可以作为输入又可以作为输出，也就是该参数即需要传入值，又可以返回值


2、如果存储过程体仅仅只有一句话，begin end可以省略
存储过程体中的每条sql语句的结尾要求必须加分号
存储过程的结尾可以使用delimiter重新设置
语法：
delimiter 结束标记
案例:
delimiter $
*/
#二、调用语法
CALL 存储过程名(实参列表);






#1.空参列表
#案例：插入到admin表中的五条记录(在girls库中的表admin)
USE girls;
SELECT * FROM admin;

#delimiter, procedure
DELIMITER $
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO admin(username, PASSWORD) VALUES
	("alice","0000"),("tom","0000"),("jack","0000"),("rose","0000"),("tommes","0000");
END $

#调用
CALL myp1()$


#2.创建带in模式参数的存储过程
#案例1：创建存储过程中实现  根据女神名，查询对应的男神信息
CREATE PROCEDURE myp2(IN beautyname VARCHAR(20))
BEGIN
	SELECT bo.*
	FROM boys bo
	RIGHT JOIN beauty b ON bo.id=b.boyfriend_id
	WHERE b.name=beautyname;
END $

#调用
CALL myp2("赵敏")$



#案例2：创建存储过程实现,用户是否登录成功
DELIMITER $
CREATE PROCEDURE myp3(IN username VARCHAR(20),IN PASSWORD VARCHAR(20))
BEGIN
	DECLARE result INT DEFAULT 0;#声明并初始化
	SELECT COUNT(*) INTO result #赋值
	FROM admin
	WHERE admin.`username`=username
	AND admin.`password`=PASSWORD;
	
	SELECT IF(result>0,"成功","失败");#使用
END$


#3.创建out模式参数的存储过程
#案例1:根据输入的女神名，返回对应的男神名

CREATE PROCEDURE myp4(IN beautyname VARCHAR(20), OUT boyname VARCHAR(20))
BEGIN
	SELECT bo.boyname INTO boyname
	FROM boys bo
	RIGHT JOIN beauty b
	ON b.boyfriend_id = bo.id
	WHERE b.name = beautyname;
END$


DELIMITER $
BEGIN
	SELECT * FROM admin;
END$





