-- SQL Practical 3 - SQL Queries using DML Statements and Set Operators
-- Aim: Design at least 10 SQL queries using DML operations (Insert, Select, Update, Delete) along with functions and set operators.

-- 1. Show existing databases
SHOW DATABASES;

-- 2. Use an existing database
USE Abhi;

-- 3. Create Employee table
CREATE TABLE Employee (
  emp_no INT,
  emp_name VARCHAR(20),
  date DATE,
  position VARCHAR(20)
);

-- 4. Add a new column 'salary'
ALTER TABLE Employee ADD salary INT;

-- 5. Insert records into Employee table
INSERT INTO Employee VALUES (1, 'abc', '2018-07-11', 'clerk', 50000);
INSERT INTO Employee VALUES (2, 'abhi', '2018-05-11', 'ceo', 150000);
INSERT INTO Employee VALUES (3, 'xyz', '2018-05-21', 'hr', 100000);
INSERT INTO Employee VALUES (4, 'aqwgy', '2018-06-21', 'te', 10000);
INSERT INTO Employee VALUES (5, 'sfhjfh', '2018-07-21', 'gt', 12000);

-- 6. Create another table TE
CREATE TABLE TE (
  emp_no INT,
  emp_name VARCHAR(20),
  join_date DATE,
  position VARCHAR(20),
  salary INT
);

-- 7. Insert records into TE
INSERT INTO TE VALUES (1, 'abc', '2018-07-11', 'clerk', 50000);
INSERT INTO TE VALUES (2, 'abhi', '2018-05-11', 'ceo', 150000);
INSERT INTO TE VALUES (3, 'xyz', '2018-05-21', 'hr', 100000);
INSERT INTO TE VALUES (4, 'aqwgy', '2018-06-21', 'te', 10000);
INSERT INTO TE VALUES (5, 'sfhjfh', '2018-07-21', 'gt', 12000);

-- 8. Display data from TE and Employee tables
SELECT * FROM TE;
SELECT * FROM Employee;

-- 9. Update a record in TE table
UPDATE TE SET emp_name = 'gjgj' WHERE emp_no = 5;

-- 10. Use UNION operator
SELECT * FROM Employee UNION SELECT * FROM TE;

-- 11. Use UNION ALL operator
SELECT * FROM Employee UNION ALL SELECT * FROM TE;

-- 12. Use subquery with IN operator
SELECT DISTINCT emp_no FROM Employee WHERE emp_no IN (SELECT emp_no FROM TE);

-- 13. Use subquery with IN operator on emp_name
SELECT DISTINCT emp_name FROM Employee WHERE emp_name IN (SELECT emp_name FROM TE);

-- 14. Aggregate Functions
SELECT MIN(salary) AS Min_Salary FROM Employee;
SELECT MAX(salary) AS Max_Salary FROM Employee;
SELECT SUM(salary) AS Total_Salary FROM Employee;
SELECT AVG(salary) AS Avg_Salary FROM Employee;
SELECT COUNT(salary) AS Total_Employees FROM Employee;

-- 15. String Functions
SELECT LCASE(emp_no) FROM Employee;
SELECT UCASE(emp_no) FROM Employee;
SELECT LCASE(salary) FROM Employee;
SELECT MID(emp_no, 1, 3) FROM Employee;
SELECT MID(salary, 1, 3) FROM Employee;
SELECT MID(salary, 1, 5) FROM Employee;
SELECT MID(emp_no, 1, 2) FROM Employee;
