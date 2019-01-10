USE myemployees;
SHOW DATABASES;

#一、按条件表达式筛选

#1.查询工资>9000的员工信息
SELECT 
  * 
FROM
  employees 
WHERE salary > 9000;


#2.查询部门编号不等于90号的员工名和部门编号
SELECT 
  last_name,
  department_id 
FROM
  employees 
WHERE department_id != 90 ;



#二、按逻辑表达式筛选
#3.查询工资z在10000到20000之间的员工名、工资、以及奖金
SELECT 
  last_name,
  salary,
  commission_pct
FROM
  employees 
WHERE 
  salary >= 10000 AND salary <= 20000 ;
  
SELECT last_name, salary,commission_pct
FROM employees
WHERE salary BETWEEN 10000 AND 20000;
  
#4.查询部门编号不是在90到110之间，或者工资高于15000的员工信息
SELECT 
  department_id,
  salary
FROM
  employees 
WHERE NOT (
    department_id > 90 
    AND department_id < 110
  ) 
  OR salary > 15000 ;


#三、模糊查询
/*
like

between and
in
is null | is not null

*/
#1.like的用法
/*
特点：
（1）一般和通配符搭配使用
	通配符:
	% 任意多个字符，包含0个字符
	_ 任意单个字符
	

*/
#1.查询员工名中包含字符a的员工信息
SELECT 
  last_name 
FROM
  employees 
WHERE last_name LIKE '%a%' ;	#abc

#2.查询员工名中第三个字符为e，第五个字符为a的员工名和工资
SELECT 
  last_name,
  salary 
FROM
  employees 
WHERE last_name LIKE '__e_a%';

#3.查询员工名中第二个字符为_的员工名
SELECT 
  last_name 
FROM
  employees 
#这里的$是转义字符，可以写其他的,也可以用反斜杠\来表示转义字符
WHERE last_name LIKE "_a_%" ESCAPE "a";
#WHERE last_name LIKE '_\_%';


#4.between and
/*
(1)使用between and 可以提高语句的简洁度
(2)包含临界值
(3)两个临界值不要调换顺序

*/
#案例一：查询员工编号在100到200之间的员工信息
SELECT 
  * 
FROM
  employees 
WHERE employee_id >= 100 
  AND employee_id <= 200 ;

#-------------------------------------------
SELECT 
  * 
FROM
  employees 
WHERE employee_id BETWEEN 100 
  AND 200 ;
  
  
  
#5.in的用法
/*
含义：判断某字段的值是否属于in列表中的某一项
特点:
	(1)使用in可以提高语句简洁度
	(2)in列表的值类型必须一致或兼容
	(3)in列表中不支持通配符
	
*/  
  
#案例二：查询员工的工种编号是IT_PROG、AD_VP、AD_PRES中的一个员工名和工种编号
SELECT 
  last_name,
  job_id 
FROM
  employees 
WHERE job_id = "IT_PROG" 
  OR job_id = "AD_VP" 
  OR job_id = "AD_PRES" ;
  
#---------------------------  
SELECT 
  last_name,
  job_id 
FROM
  employees
WHERE job_id IN ("IT_PROG", "AD_VP", "AD_PRES") ;



#6.is null 
/*
=或者是<>不能用于判断Null的值
is null 或 is not null 可以判断null的值

is null可以相当于 <=> null

单is 不能用于判断数值

<=>是安全等于

*/
#案例一：查询没有奖金的员工名和奖金率(last_name, commission_pct)
SELECT 
  last_name,
  commission_pct 
FROM
  employees 
WHERE commission_pct IS NOT NULL ;

#--------------也可以为-------------------
SELECT 
  last_name,
  commission_pct 
FROM
  employees 
WHERE commission_pct <=> NULL ;

#案例二：查询工资为12000的员工信息(last_name, salary)
SELECT 
  last_name,
  salary 
FROM
  employees 
WHERE salary <=> 12000;

#is null可读性比<=>的低
#所以推荐使用安全等于 <=>,
/*
因为is null：仅仅可以判断null的值而已，可读性较高
<=>：既可以判断Null的值，又可以判断普通的数值，兼容性比较好
*/

