create database Science_qtech;
use Science_qtech;
#Q1.	Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database 
#from the given resources

create table emp_record_table
(EMP_ID varchar(30) not null,
FIRST_NAME varchar(30),
LAST_NAME varchar(30),
GENDER varchar(10),
ROLE varchar(30),
DEPT varchar (30),
EXP int (10),
COUNTRY varchar (30),
CONTINENT varchar(20),
SALARY int (30),
EMP_RATING varchar(20),
MANAGER_ID varchar (20),
PROJ_ID varchar(20),
PRIMARY KEY (EMP_ID));

create table proj_table
(PROJECT_ID varchar(30) not null,
PROJ_NAME varchar(30),
DOMAIN varchar(30),
START_DATE varchar(10),
CLOSURE_DATE varchar(30),
DEV_QTR varchar (30),
STATUS varchar (10),
PRIMARY KEY (PROJECT_ID));

create table Data_science_team
(EMP_ID varchar(30) not null,
FIRST_NAME varchar(30),
LAST_NAME varchar(30),
GENDER varchar(10),
ROLE varchar(30),
DEPT varchar (30),
EXP varchar(30),
COUNTRY varchar (10),
CONTINENT varchar (30),
PRIMARY KEY (EMP_ID));

INSERT INTO emp_record_table VALUES
('E001','Arthur','Black','M','PRESIDENT','ALL','20','USA','NORTH AMERICA','16500','5','NULL','NULL'),
('E005','Eric','Hoffman','M','LEAD DATA SCIENTIST','FINANCE','11','USA','NORTH AMERICA','8500','3','E103','P105'),
('E010','William','Butler','M','LEAD DATA SCIENTIST','AUTOMOTIVE','12','FRANCE','EUROPE','9000','2','E428','P204'),
('E052','Dianna','Wilson','F','SENIOR DATA SCIENTIST','HEALTHCARE','6','CANADA','NORTH AMERICA','5500','5','E083','P103'),
('E057','Dorothy','Wilson','F','SENIOR DATA SCIENTIST','HEALTHCARE','9','USA','NORTH AMERICA','7700','1','E083','P302'),
('E083','Patrick','Voltz','M','MANAGER','HEALTHCARE','15','USA','NORTH AMERICA','9500','5','E001','NULL'),
('E103','Emily','Grove','F','MANAGER','FINANCE','14','CANADA','NORTH AMERICA','10500','4','E001','NULL'),
('E204','Karene','Nowak','F','SENIOR DATA SCIENTIST','AUTOMOTIVE','8','GERMANY','EUROPE','7500','5','E428','P204'),
('E245','Nian','Zhen','M','SENIOR DATA SCIENTIST','RETAIL','6','CHINA','ASIA','6500','2','E583','P109'),
('E260','Roy','Collins','M','SENIOR DATA SCIENTIST','RETAIL','7','INDIA','ASIA','7000','3','E583','NA'),
('E403','Steve','Hoffman','M','ASSOCIATE DATA SCIENTIST','FINANCE','4','USA','NORTH AMERICA','5000','3','E103','P105'),
('E428','Pete','Allen','M','MANAGER','AUTOMOTIVE','14','GERMANY','EUROPE','11000','4','E001','NULL'),
('E478','David','Smith','M','ASSOCIATE DATA SCIENTIST','RETAIL','3','COLOMBIA','SOUTH AMERICA','4000','4','E583','P109'),
('E505','Chad','Wilson','M','ASSOCIATE DATA SCIENTIST','HEALTHCARE','5','CANADA','NORTH AMERICA','5000','2','E083','P103'),
('E532','Claire','Brennan','F','ASSOCIATE DATA SCIENTIST','AUTOMOTIVE','3','GERMANY','EUROPE','4300','1','E428','P204'),
('E583','Janet','Hale','F','MANAGER','RETAIL','14','COLOMBIA','SOUTH AMERICA','10000','2','E001','NULL'),
('E612','Tracy','Norris','F','MANAGER','RETAIL','13','INDIA','ASIA','8500','4','E001','NULL'),
('E620','Katrina','Allen','F','JUNIOR DATA SCIENTIST','RETAIL','2','INDIA','ASIA','3000','1','E612','P406'),
('E640','Jenifer','Jhones','F','JUNIOR DATA SCIENTIST','RETAIL','1','COLOMBIA','SOUTH AMERICA','2800','4','E612','P406');


#STEPS TO LOAD DATA DIRECTLY FROM EXCEL TO SQL
#show global variables like 'local_infile';
#go to cmd: 
#1.cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
#2.mysql --local_infile=1 -u root -pIndra@009 Science_qtech
#3.use Science_qtech
#4.load data local infile 'F:/DATA-SCIENTIST-COURSE-MATERIAL/My SQL/ScienceQtech-EmployeePerformance/proj_table.csv' into table proj_table
#>>FIELDS TERMINATED BY ','
#>>LINES TERMINATED BY '\n'
#>>IGNORE 1 LINES;

select *from proj_table;

load data local infile 'F:/DATA-SCIENTIST-COURSE-MATERIAL/My SQL/ScienceQtech-EmployeePerformance/data_science_team.csv' into table Data_science_team;

select *from Data_science_team;

#Q2.Create an ER diagram for the given employee database.

#Q3.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of 
#employees and details of their department

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT from emp_record_table;

#Q4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
#•	less than two
#•	greater than four 
#•	between two and four


select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,EMP_RATING from emp_record_table
where (EMP_RATING<2)
or (EMP_RATING>4)
or (EMP_RATING between 2 and 4);

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,EMP_RATING from emp_record_table
where (EMP_RATING<2);

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,EMP_RATING from emp_record_table
where (EMP_RATING>4);

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,EMP_RATING from emp_record_table
where (EMP_RATING between 2 and 4);
 
 #Q5.Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give 
			#the resultant column alias as NAME

select * from emp_record_table;

SELECT FIRST_NAME,LAST_NAME,CONCAT(FIRST_NAME,"  ",LAST_NAME) AS Full_name FROM emp_record_table
where DEPT='FINANCE';

#6.	Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters 
#(including the President).

SELECT EMP_ID,CONCAT(FIRST_NAME,"  ",LAST_NAME) AS Full_name,MANAGER_ID,ROLE FROM emp_record_table
where MANAGER_ID in(SELECT MANAGER_ID FROM emp_record_table
group by MANAGER_ID
having count(*)>1);

#Q7.Write a query to list down all the employees from the healthcare and finance departments using union. 
#Take data from the employee record table.

SELECT emp_record_table.FIRST_NAME
 FROM emp_record_table
 WHERE emp_record_table.DEPT='HEALTHCARE'  
 UNION
 SELECT emp_record_table.FIRST_NAME
 FROM emp_record_table
 WHERE emp_record_table.DEPT='FINANCE';
 
 #Q8.Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
 #Also include the respective employee rating along with the max emp rating for the department.
 
SELECT  EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EMP_RATING,
max(EMP_RATING) OVER(PARTITION BY DEPT) AS "MAX_DEPT_RATING"
FROM emp_record_table 
ORDER BY DEPT;

#Q9.Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

SELECT EMP_ID, FIRST_NAME,LAST_NAME,ROLE FROM emp_record_table
WHERE ROLE IN(select ROLE from emp_record_table
GROUP BY ROLE);


#Q10.Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP,
RANK() OVER(ORDER BY EXP) EXP_RANK
FROM emp_record_table;

#Q11. Write a query to create a view that displays employees in various countries whose salary is 
#more than six thousand. Take data from the employee record table.


CREATE VIEW emp_country AS SELECT EMP_ID, FIRST_NAME,LAST_NAME,ROLE
FROM emp_record_table WHERE salary > 6000; 

select * from emp_country;

#Q12.Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.

select * from emp_record_table 
where EXP>10 order by EXP DESC;

SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP FROM emp_record_table
WHERE EMP_ID IN(SELECT manager_id FROM emp_record_table);

#Q13.Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. 
#Take data from the employee record table.

delimiter &&
CREATE PROCEDURE exp_emp()
BEGIN
SELECT EXP
FROM emp_record_table where EXP>3;
END &&
delimiter ;;

call exp_emp();

#Q14.Write a query using stored functions in the project table to check whether the job profile assigned to each employee in 
#the data science team matches the organization’s set standard.
#The standard being:
#For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
#For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
#For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
#For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
#For an employee with the experience of 12 to 16 years assign 'MANAGER'.


DELIMITER &&
CREATE FUNCTION Employee_ROLE(EXP int)
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
DECLARE Employee_ROLE VARCHAR(40);
IF EXP>12 AND 16 THEN
SET Employee_ROLE="MANAGER";
ELSEIF EXP>10 AND 12 THEN
SET Employee_ROLE ="LEAD DATA SCIENTIST";
ELSEIF EXP>5 AND 10 THEN
SET Employee_ROLE ="SENIOR DATA SCIENTIST";
ELSEIF EXP>2 AND 5 THEN
SET Employee_ROLE ="ASSOCIATE DATA SCIENTIST";
ELSEIF EXP<=2 THEN
SET Employee_ROLE ="JUNIOR DATA SCIENTIST";
END IF;
RETURN (Employee_ROLE);
END &&



#Q15.Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.

CREATE INDEX idx_first_name
ON emp_record_table(FIRST_NAME(20));
SELECT * FROM emp_record_table
WHERE FIRST_NAME='Eric';

#Q16. 16.	Write a query to calculate the bonus for all the employees, based on their ratings and salaries
# (Use the formula: 5% of salary * employee rating).


SET SQL_SAFE_UPDATES = 0;
update emp_record_table 
set salary=salary+(salary*.05*EMP_RATING)
where salary>8000
select *from emp_record_table;

#Q.17 Write a query to calculate the average salary distribution based on the continent and country. 
#Take data from the employee record table.

SELECT EMP_ID,FIRST_NAME,LAST_NAME,SALARY,COUNTRY,CONTINENT,
AVG(salary)OVER(PARTITION BY COUNTRY)AVG_salary_IN_COUNTRY,
AVG(salary)OVER(PARTITION BY CONTINENT)AVG_salary_IN_CONTINENT, 
COUNT(*)OVER(PARTITION BY COUNTRY)COUNT_IN_COUNTRY,
COUNT(*)OVER(PARTITION BY CONTINENT)COUNT_IN_CONTINENT
FROM emp_record_table;





