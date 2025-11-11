-- SQL Practical 1 - Study of Open Source Relational Database: MySQL
-- Aim: To perform basic SQL operations such as creating databases, tables, inserting, updating, deleting, and viewing data.

-- 1. Use existing database
USE info;

-- 2. Show available databases
SHOW DATABASES;

-- 3. Create a table named 'info'
CREATE TABLE info (
  roll_no INT,
  name VARCHAR(30),
  class VARCHAR(20),
  marks FLOAT,
  dob DATE
);

-- 4. Insert records into the table
INSERT INTO info VALUES (1, 'harsha', 'be', 98.0, '1996-07-12');
INSERT INTO info VALUES (2, 'tej', 'te', 98.1, '1997-07-12');
INSERT INTO info VALUES (3, 'keshav', 'te', 98.2, '1998-05-11');

-- 5. Display all records
SELECT * FROM info;

-- 6. Display specific columns
SELECT roll_no, marks FROM info;

-- 7. Delete a particular record
DELETE FROM info WHERE name = 'tej';

-- 8. Create and drop a new database
CREATE DATABASE new1;
SHOW DATABASES;
DROP DATABASE new1;
SHOW DATABASES;

-- 9. Update record data
UPDATE info SET class = 'secomp' WHERE roll_no = 1;

-- 10. Add a new column
ALTER TABLE info ADD sirname VARCHAR(20);

-- 11. Modify column datatype
ALTER TABLE info MODIFY roll_no FLOAT;

-- 12. Describe table structure
DESC info;

-- 13. Drop a column
ALTER TABLE info DROP sirname;

-- 14. Rename a column
ALTER TABLE info CHANGE name fullname VARCHAR(20);

-- 15. Insert new records with renamed column
INSERT INTO info VALUES (101, 'sai', 'se', 80, '2017-01-12', 'xyz');
INSERT INTO info VALUES (102, 'ram', 'se', 90, '2018-01-12', 'uvw');

-- 16. Create a view
CREATE VIEW te AS SELECT roll_no, fullname, class FROM info;

-- 17. Display data from the view
SELECT * FROM te;

-- 18. Drop the view
DROP VIEW te;

-- 19. Display final table
SELECT * FROM info;
