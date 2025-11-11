-- SQL Practical 5 - PL/SQL Program with Control Structures and Exception Handling
-- Aim: Write a PL/SQL block of code that uses control structures and exception handling.
-- Scenario: Borrower and Fine management system.

-- 1. Use existing database
USE Abhi;

-- 2. Create Borrower table
CREATE TABLE Borrower (
  roll_no INT PRIMARY KEY,
  name VARCHAR(20),
  DOI DATE,
  book_name VARCHAR(20),
  status VARCHAR(20)
);

-- 3. Create Fine table
CREATE TABLE Fine (
  roll_no INT,
  fine_date DATE,
  amount FLOAT
);

-- 4. Insert sample records into Borrower
INSERT INTO Borrower VALUES (12, 'patel', '2018-07-01', 'xyz', 'issued');
INSERT INTO Borrower VALUES (14, 'shinde', '2018-06-01', 'oop', 'issued');
INSERT INTO Borrower VALUES (16, 'bhangale', '2018-05-01', 'coa', 'returned');
INSERT INTO Borrower VALUES (18, 'rebello', '2018-06-15', 'toc', 'returned');
INSERT INTO Borrower VALUES (20, 'patil', '2018-05-15', 'mp', 'issued');

-- 5. Create Stored Procedure with Control Structure and Exception Handling
DELIMITER //
CREATE PROCEDURE B(roll_new INT, book_name VARCHAR(20))
BEGIN
  DECLARE X INT;
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN
    SELECT 'NOT FOUND';
  END;

  -- Calculate number of days between issue date and today
  SELECT DATEDIFF(CURDATE(), DOI) INTO X FROM Borrower WHERE roll_no = roll_new;

  -- Fine Calculation Logic
  IF (X > 15 AND X < 30) THEN
    INSERT INTO Fine VALUES (roll_new, CURDATE(), (X * 5));
  END IF;

  IF (X > 30) THEN
    INSERT INTO Fine VALUES (roll_new, CURDATE(), (X * 50));
  END IF;

  -- Update status after book submission
  UPDATE Borrower SET status = 'returned' WHERE roll_no = roll_new;
END;//
DELIMITER ;

-- 6. Execute the Stored Procedure
CALL B(12, 'xyz');
CALL B(20, 'mp');

-- 7. Display all records from Fine table
SELECT * FROM Fine;

-- 8. Display all records from Borrower table
SELECT * FROM Borrower;
