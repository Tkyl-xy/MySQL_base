USE myemployees;
#1.查询员工的姓名和部门号和年薪，按年薪降序 按姓名升序
SELECT 
  last_name AS 名字,
  department_id AS 部门号,
  salary * (1 + IFNULL(commission_pct, 0)) AS 年薪 
FROM
  employees 
ORDER BY 年薪 DESC,
  last_name ASC ;

#2.选择工资不在8000到17000的员工