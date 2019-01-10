#1.下面的语句是否可以执行成功
SELECT 
  last_name,
  job_id,
  salary AS 工资
FROM employees;

#2.下面的语句是否可以执行成功
SELECT * FROM employees;


#3.显示表departments的结构，并查询其中的全部数据

DESC departments;

SELECT * FROM `departments`;


#4.显示出表employees中的全部job_id(不能重复)
SELECT DISTINCT job_id FROM employees;


#5.显示出表employees的全部列，各个列之间用逗号连接，列头显示成out_put
SELECT 
  IFNULL(commission_pct, 0) AS 奖金率
FROM
  employees;
  
SELECT 
  CONCAT(
    first_name,
    ",",
    last_name,
    ",",
    IFNULL(commission_pct, 0)
  ) AS "out put" 
FROM
  employees ;

