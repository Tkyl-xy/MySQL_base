#进阶4：常见函数
/*
概念：类似于Java的方法，将一组逻辑语句封装在方法体中，对外暴露方法名
好处：
1、隐藏了实现细节
2、提高代码的重用性

调用：
select 函数名（实参列表） from 表;

特点：
	1、单行函数
	如：concat、length、ifnull等 
	2、分组函数
	
	功能：做统计使用，又称统计函数、聚合函数、组函数
	
常见函数:
	一、单行函数
	字符函数：
	length:获取字节个数
	
	concat
	
	substr：索引函数，从1开始索引，还可以获取指定的长度函数
	
	instr:	索引函数，索引到第一个位置的函数如果索引不到就为0
	
	trim：	首尾相同的去掉，默认是去掉空格
	
	lpad：	用指定的字符实现左填充指定长度
	
	rpad：	用指定的字符实现右填充指定长度
	
	replace：替换字符或字符串
	
	二、数学函数：
	round:	四舍五入
	
	ceil:	也是进一发，向上取整法
	
	floor：	同上是，这是向下取整法
	
	truncate：截取，截取的是小数点后面的多少位
	
	mod：取余 (相当于公式：mod(a,b) -> a-a/b*b)
	
	
	三、日期函数：
	now:返回当前系统的日期+时间
	
	curdate：返回当前系统日期，不包含时间
	
	curtima：返回当前时间，不包含日期
	
	也可以指定的返回部分，比如:年、月、日、小时、分钟、秒
	
	str_to_date 将字符通过指定的格式转换成日期
	
	date_format 将日期转换成字符
	
	四、其他函数
	select version();查看系统版本
	
	select database();查看当前使用的库
	
	select user();查看当前的使用者
	
	五、流程控制函数
	1、if函数：拥有if else的效果
	
	
	2、case函数的使用一：相当于switch case的效果
	
	使用一的语法：
		case 要判断的字段或表达式
		when 常量1 then 要显示的值1或语句1;
		when 产量2 then 要显示的值2或语句2;
		……
		else 要显示的值n或语句n;
		end
		
		
	使用二的语法:
		case 
		when 条件1 then 要显示的值1或语句1;
		when 条件2 then 要显示的值2或语句2;
		...
		else 要显示的值n或语句n
		end
	
	
	
	


*/

#1.length 获取参数值的字节数
SELECT LENGTH("hello");
SELECT LENGTH("李四");

#2.拼接字符串	concat
SELECT CONCAT(last_name,"_",first_name) FROM employees;

#3.upper、lower
SELECT UPPER("wei");
SELECT LOWER("JONG");

#4.substr、substring
#索引是从1开始的
SELECT SUBSTR("我爱你我爱你我恨你!!",7) AS out_put;
SELECT SUBSTR("我爱你我爱你我恨你!!",1,6) AS out_put;

#案例一:姓名中首字母是大写，其他字母是小写，然后拼接起来，显示结果
SELECT 
  CONCAT(
    UPPER(SUBSTR(last_name, 1, 1)),
    "_",
    LOWER(SUBSTR(last_name, 2))
  ) AS 姓名 
FROM
  employees ;

#5.instr 返回子串第一次出现的索引，如果找不到返回0

SELECT INSTR('杨不殷六侠悔爱上了殷六侠','殷') AS out_put;


#6.trim

SELECT LENGTH(TRIM("     张三丰     ")) AS out_put;
SELECT 
  TRIM(
    'aa' FROM 'aaaaaaaaa张aaaaaaaaaaaa翠山aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  ) AS out_put ;


#7.lpad 用指定的字符实现左填充指定长度
SELECT LPAD("黄文洁",10,"我爱你") AS out_put;

#8.replace 替换
SELECT REPLACE("臭逼黄文洁","臭逼","亲爱的");




#二、数学函数

#round 四舍五入
SELECT ROUND(-1.4545);
SELECT ROUND(-1.68598);


#ceil 向上取整,返回>=该参数的最小整数
SELECT CEIL(-1.99);
SELECT CEIL(-1.45);

#floor 向下取整，返回<=该参数的最大整数
SELECT FLOOR(-1.2);

#truncate 截断
SELECT TRUNCATE(1.23442, 3) AS 截断结果;


#取余	mod

SELECT MOD(10,3);
SELECT MOD(-10,3);
SELECT MOD(10, -3);


#三、日期函数

#now 返回当前系统日期和时间
SELECT NOW();


#curdate返回当前的日期
SELECT CURDATE();


#curtime返回当前的时间，不包含日期
SELECT CURTIME();


#str_to_date 将字符通过指定的格式转换成日期
SELECT STR_TO_DATE("1992-6-5","%Y-%m-%d") AS 结果;


#查询入职日期时间为1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = (STR_TO_DATE("1992-4-3","%Y-%m-%d"));


#date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(),"%Y年%m月%d日") AS 现在的系统日期;

#查询有奖金的员工名和入职日期
SELECT last_name,DATE_FORMAT(hiredate,"%Y年%m月%d日") AS 入职日期
FROM employees
WHERE commission_pct IS NULL;




#五、条件控制流函数
#1.if函数：if else 的效果
#案例：列出员工的是否有工资的
SELECT last_name AS 姓名,
commission_pct AS 奖金, IF(commission_pct IS NULL,"没奖金，心痛!!","嘻嘻，好高兴!!") AS 备注
FROM employees;



#2.case函数:
#使用方法一：
/*
mysql中
	case 要判断的字段或表达式
	when 常量1 then 要显示的值1或语句1;
	when 常量2 then 要显示的值2或语句2;
	...
	else 要显示的值n或语句n;
	end

*/

/*
案例：查询员工的工资，要求

部门号=30,显示的工资为1.1倍
部门号=40,显示的工资为1.2倍
部门号=50,显示的工资为1.3倍
其他部门,显示的工资为原工资

*/
SELECT salary AS 原始工资,department_id AS 部门号,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新工资
FROM employees
ORDER BY department_id;

#case函数的使用二：类似于 多重if
/*
java中：
if(条件1){
	语句1；
}else if(条件2){
	语句2；
}
...
else{
	语句n;
}

mysql中：

case 
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值2或语句2
...
else 要显示的值n或语句n
end
*/
SELECT salary AS 工资,
CASE
WHEN salary>20000 THEN "A"
WHEN salary>15000 THEN "B"
WHEN salary>10000 THEN "C"
ELSE "D"
END AS 工资级别
FROM employees
ORDER BY salary DESC;
