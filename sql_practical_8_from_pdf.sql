-- SQL Practical 8 - Database Triggers (Row Level and Statement Level, Before and After)
-- Aim: Write a database trigger on Library table that keeps track of records being updated or deleted.
-- The old value of updated or deleted records should be added to Library_Audit table.

-- 1. Use existing database
USE info;

-- 2. Create the main table (Library or Borrower)
CREATE TABLE borrower1 (
  roll_no INT,
  name VARCHAR(20),
  date_of_issue DATE,
  book_name VARCHAR(50),
  status VARCHAR(20),
  author VARCHAR(20)
);

-- 3. Insert sample data into borrower1
INSERT INTO borrower1 VALUES (1, 'nick', '2018-06-10', 'wings_of_fire', 'available', 'APJ');
INSERT INTO borrower1 VALUES (2, 'mira', '2018-05-11', 'leaves_life', 'not_available', 'borwarkar');
INSERT INTO borrower1 VALUES (3, 'rina', '2018-02-12', 'unusual', 'available', 'johar');
INSERT INTO borrower1 VALUES (4, 'harsha', '2018-06-20', 'sky_limit', 'available', 'ingale');
INSERT INTO borrower1 VALUES (5, 'tej', '2018-04-20', 'highway', 'not_available', 'klm');

-- 4. Create audit table to log changes
CREATE TABLE audit1 (
  roll_no INT,
  name VARCHAR(20),
  date_of_issue DATE,
  book_name VARCHAR(50),
  status VARCHAR(20),
  author VARCHAR(20),
  ts TIMESTAMP
);

-- 5. AFTER INSERT Trigger
DELIMITER //
CREATE TRIGGER after_insert_library
AFTER INSERT ON borrower1
FOR EACH ROW
BEGIN
  INSERT INTO audit1 VALUES (NEW.roll_no, NEW.name, NEW.date_of_issue, NEW.book_name, NEW.status, NEW.author, CURRENT_TIMESTAMP);
END;//
DELIMITER ;

-- Test INSERT Trigger
INSERT INTO borrower1 VALUES (6, 'xyz', '2018-09-06', 'aaa', 'available', 'xxx');
SELECT * FROM audit1;

-- 6. AFTER UPDATE Trigger
DELIMITER //
CREATE TRIGGER after_update_library
AFTER UPDATE ON borrower1
FOR EACH ROW
BEGIN
  INSERT INTO audit1 VALUES (NEW.roll_no, NEW.name, NEW.date_of_issue, NEW.book_name, NEW.status, NEW.author, CURRENT_TIMESTAMP);
END;//
DELIMITER ;

-- Test UPDATE Trigger
UPDATE borrower1 SET roll_no = 8, book_name = 'leaf' WHERE name = 'xyz';
SELECT * FROM audit1;

-- 7. BEFORE DELETE Trigger
DELIMITER //
CREATE TRIGGER before_delete_library
BEFORE DELETE ON borrower1
FOR EACH ROW
BEGIN
  INSERT INTO audit1 VALUES (OLD.roll_no, OLD.name, OLD.date_of_issue, OLD.book_name, OLD.status, OLD.author, CURRENT_TIMESTAMP);
END;//
DELIMITER ;

-- Test DELETE Trigger
DELETE FROM borrower1 WHERE roll_no = 8;
SELECT * FROM audit1;

-- 8. Statement-Level Trigger Example
DELIMITER //
CREATE TRIGGER after_update_statement
AFTER UPDATE ON borrower1
BEGIN
  INSERT INTO audit1 (roll_no, name, book_name, status, author, ts)
  VALUES (NULL, 'Statement Trigger', 'N/A', 'Updated All', 'System', CURRENT_TIMESTAMP);
END;//
DELIMITER ;

-- 9. Drop Triggers
DROP TRIGGER after_insert_library;
DROP TRIGGER after_update_library;
DROP TRIGGER before_delete_library;
DROP TRIGGER after_update_statement;

-- 10. Drop Tables
DROP TABLE borrower1;
DROP TABLE audit1;
