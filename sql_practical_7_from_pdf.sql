-- SQL Practical 7 - PL/SQL Stored Procedure and Stored Function
-- Aim: Write a stored procedure and stored function for categorizing students based on total marks.

-- 1. Use existing database
USE Abhi;

-- 2. Create tables for storing marks and results
CREATE TABLE marks (
  roll_no INT PRIMARY KEY,
  name VARCHAR(20),
  total_marks INT
);

CREATE TABLE result (
  roll_no INT,
  name VARCHAR(20),
  class VARCHAR(20)
);

-- 3. Insert records into marks table
INSERT INTO marks VALUES (1, 'Abhi', 1400);
INSERT INTO marks VALUES (2, 'Piyush', 980);
INSERT INTO marks VALUES (3, 'Hitesh', 880);
INSERT INTO marks VALUES (4, 'Ashley', 820);
INSERT INTO marks VALUES (5, 'Partik', 740);
INSERT INTO marks VALUES (6, 'Patil', 640);

-- 4. Create stored procedure for grading students
DELIMITER //
CREATE PROCEDURE proc_grade(IN marks INT, OUT class VARCHAR(20))
BEGIN
  IF (marks <= 1500 AND marks >= 990) THEN
    SET class = 'Distinction';
  ELSEIF (marks < 990 AND marks >= 900) THEN
    SET class = 'First Class';
  ELSEIF (marks < 900 AND marks >= 825) THEN
    SET class = 'Higher Second Class';
  ELSEIF (marks < 825 AND marks >= 750) THEN
    SET class = 'Second Class';
  ELSEIF (marks < 750 AND marks >= 650) THEN
    SET class = 'Passed';
  ELSE
    SET class = 'Fail';
  END IF;
END //
DELIMITER ;

-- 5. Create stored function that calls the procedure and inserts data into result table
DELIMITER //
CREATE FUNCTION final_result3(R1 INT)
RETURNS INT
BEGIN
  DECLARE fmarks INT;
  DECLARE grade VARCHAR(20);
  DECLARE stud_name VARCHAR(20);

  SELECT total_marks, name INTO fmarks, stud_name FROM marks WHERE roll_no = R1;
  CALL proc_grade(fmarks, @grade);
  INSERT INTO result VALUES (R1, stud_name, @grade);

  RETURN R1;
END //
DELIMITER ;

-- 6. Execute the stored function for multiple students
SELECT final_result3(1);
SELECT final_result3(2);
SELECT final_result3(3);
SELECT final_result3(4);
SELECT final_result3(5);

-- 7. Display results
SELECT * FROM result;
