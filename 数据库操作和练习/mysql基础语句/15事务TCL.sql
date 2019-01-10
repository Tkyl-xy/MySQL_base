#TCL
/*
Transaction Control Language 事务控制语言

事务：
     一个或一组SQL语句组成一个执行单元，这个执行单元要么全部执行，要么全部不执行
(事务由单独单元的一个或多个SQL语句组成，在这个单元中，每个MySQL语句时相互依赖的)

     
     而整个单独单元作为一个不可分割的整体，如果单元中某条SQL语句一旦执行失败或产生错误，
 整个单元将会回滚，所有受到影响的数据将返回到事务开始以前的状态；如果单元中的所有SQL语句
 都执行成功，则事务被顺利执行

事务的特性：
ACID
原子性：一个事务不可再分割，要么都执行，要么都不执行
一致性：一个事务执行会使数据从一个一致状态切换到另外一个一致状态
隔离性：一个事务的执行不受其他事务的干扰
持久性：一个事务一旦提交，则会永久性的改变数据库里的数据


*/

#查看mysql支持的存储引擎
SHOW ENGINES;

#这个是查询mysql5的隔离级别类型
SELECT @@tx_isolation;


#这个是查询mysql8.0的隔离级别的类型
SHOW VARIABLES LIKE "transaction_isolation";



USE test1;
SHOW TABLES;
DESC meassage;
SHOW CREATE TABLE meassage;


#修改数据库的编码
ALTER TABLE test DEFAULT CHARACTER SET utf8;

DROP TABLE IF EXISTS test;
DESC test;
CREATE TABLE test(
	balance 	INT(10)		PRIMARY KEY,
	username	CHAR(50)
); 
SHOW CREATE TABLE test;
ALTER TABLE test CHANGE username username CHAR(50) CHARACTER SET utf8;
INSERT INTO test VALUES(50,"张无忌");
SELECT * FROM test;
INSERT INTO test VALUES(200,"赵敏");

#开启事务
SET autocommit=0;
START TRANSACTION;
#编写一组事务的语句
UPDATE test SET balance = 50 WHERE username="张无忌";
UPDATE test SET balance = 200 WHERE username="赵敏";

#结束事务
#rollback是回滚的意思
#Rollback;

#commit是提交的意思
COMMIT;

SELECT * FROM test;

#查询当前全局事务
SELECT @@global.tx_isolation;

#查询当前会话事务
SELECT @@session.tx_isolation;




#设置当前MySQL连接的隔离级别（已提交读）
SET TRANSACTION ISOLATION LEVEL READ COMMIT;

#设置当前MySQL连接的隔离级别（未提交读）
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;


#一般MySQL中选择的是repeatable read（不会出现像：幻读，脏读，不可重复读）
#设置当前MySQL连接的隔离级别（可重复读）
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

#设置当前MySQL连接的隔离级别（可串可行）
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


/*
#事务的隔离级别：
			脏读		不可重复读		幻读
read uncommitted	 yes		   yes			  yes

read committed		 x		   yes			  yes

repeatable read		 x		    x  		           yes

serializable		  x		     x			   x

mysql中默认	第三个隔离级别	repeatable read
oracle中默认	第二个隔离级别	read committed

*/

#savepoint a设置保存点与rollback to a搭配使用

SET autocommit=0;
START TRANSACTION;
DELETE FROM account WHERE id=25;
SAVEPOINT a;#设置保存点
DELETE FROM account WHERE id=28;
ROLLBACK TO a;#回滚到保存点


SELECT * FROM account;

