#>> I 全局变量
/*
作用域：服务器每次启动将为所有的全局变量赋予初始值，针对于所有的会话，和链接有效
*/
#1.查看所有的系统变量
SHOW GLOBAL VARIABLES;


#2.查看部分的全局变量
SHOW GLOBAL VARIABLES LIKE "%char%";


#3.查看指定的全局变量的值
SELECT @@global.autocommit;

SELECT @@global.transaction_isolation;


#4.为某个指定的全局变量赋值
SET  @@global.autocommit=1;


#>> II 会话变量
/*
作用域：仅仅针对当前会话链接（有效）

*/
SHOW SESSION VARIABLES;
SHOW VARIABLES;


SHOW SESSION VARIABLES LIKE "%auto%";
SHOW VARIABLES LIKE "%isolation%";



#>> III 用户自定义变量
/*
说明：变量是用户自定义的，不是由系统的

使用步骤：
	1.声明
	2.赋值
	3.使用(查看，比较，运算等)
*/
#用户变量

/*
作用域：针对当前会话(链接有效),和会话变量的作用域一样
运用在任何地方
赋值的操作符：= 或 :=
*/
#1.声明并初始化
/*
set @用户变量名=值;
set @用户变量名:=值;
select @用户变量名:=值;
*/


#2赋值(更新用户变量的值)
/*
方式一：通过set或select
	set @用户变量=值;
	set @用户变量=值;
	select @用户变量名:=值;
*/	
#案例:
SET @name='yang';
SET @name=199;


/*
方式二：通过select into(这里的字段是一个值，不能是一组值)
	select 字段 into @变量名
	from 表;
*/

SELECT COUNT(*) INTO @count
FROM employees;


#3.使用(查看用户变量名)
#用法为：select @用户变量名

SELECT @name;
SELECT @count;




#>> IV局部变量
/*
作用域：仅仅在定义它的begin end 中有效


*/
#1,声明
DECLARE 变量名 类型;
DECLARE 变量名 类型 DEFAULT 值;

#2,赋值
/*
方式一：通过set或select
	set 用户变量=值;
	set 用户变量=值;
	select @用户变量名:=值;
*/
/*
方式二：通过select into(这里的字段是一个值，不能是一组值)
	select 字段 into 变量名
	from 表;
*/

#3,查看
SELECT 变量名;


对比用户变量和局部变量:
			作用域			定义和使用的位置			语法
用户变量		当前会话		会话中任何位置				必须加@符号,不用限定类型

局部变量		BEGIN END 中		只能在 BEGIN END 中，且为第一句话	一般不用加@符号，需要加限定类型


#案例：声明两个变量并附初始值，求和，并显示结果

#用户变量的
SET @a=10;
SET @b=10;
SET @sum = @a + @b;
SELECT @sum;

#局部变量的
DECLARE c INT DEFAULT 10;
DECLARE d INT DEFAULT 10;
DECLARE SUM INT;
SET SUM = c + d;
SELECT SUM;

















	














