#进阶9分页查询
/*
	select 查询列表
	from 表
	limit (page-1)*size,size; 这里的是查询公式
*/

#案例1：查询前五条员工信息

SELECT * FROM employees LIMIT 0,5;


#案例2：查询第11条到25条员工信息
SELECT * FROM employees LIMIT 10,15;



#案例3：有奖金的员工信息，并且工资较高的前10名显示出来
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC
LIMIT 0, 10;
