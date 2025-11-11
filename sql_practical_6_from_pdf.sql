-- SQL Practical 6 - Parameterized Cursor in PL/SQL
-- Aim: Write a PL/SQL block using a parameterized cursor that merges data from the newly created table N_RollCall with data in O_RollCall.
-- If the data in the first table already exists in the second table, it should be skipped.

-- 1. Use the database
USE Abhi;

-- 2. Create the old roll call table
CREATE TABLE o_rollcall (
  roll_no INT,
  name VARCHAR(20),
  address VARCHAR(20)
);

-- 3. Create the new roll call table
CREATE TABLE n_rollcall (
  roll_no INT,
  name VARCHAR(20),
  address VARCHAR(20)
);

-- 4. Insert records into o_rollcall
INSERT INTO o_rollcall VALUES (1, 'Hitesh', 'Nandura');
INSERT INTO o_rollcall VALUES (2, 'Piyush', 'MP');
INSERT INTO o_rollcall VALUES (3, 'Ashley', 'Nsk');
INSERT INTO o_rollcall VALUES (4, 'Kalpesh', 'Dhule');
INSERT INTO o_rollcall VALUES (5, 'Abhi', 'Satara');

-- 5. Create a parameterized cursor procedure
DELIMITER //
CREATE PROCEDURE p3(IN r1 INT)
BEGIN
  DECLARE r2 INT;
  DECLARE exit_loop BOOLEAN DEFAULT FALSE;
  DECLARE c1 CURSOR FOR SELECT roll_no FROM o_rollcall WHERE roll_no > r1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;

  OPEN c1;
  e_loop: LOOP
    FETCH c1 INTO r2;

    IF NOT EXISTS (SELECT * FROM n_rollcall WHERE roll_no = r2) THEN
      INSERT INTO n_rollcall SELECT * FROM o_rollcall WHERE roll_no = r2;
    END IF;

    IF exit_loop THEN
      CLOSE c1;
      LEAVE e_loop;
    END IF;
  END LOOP e_loop;
END //
DELIMITER ;

-- 6. Execute procedure to merge data where roll_no > 3
CALL p3(3);

-- 7. Display records in n_rollcall
SELECT * FROM n_rollcall;

-- 8. Execute procedure to merge all data
CALL p3(0);

-- 9. Display records after full merge
SELECT * FROM n_rollcall;

-- 10. Insert a new record into o_rollcall
INSERT INTO o_rollcall VALUES (6, 'Patil', 'Kolhapur');

-- 11. Execute procedure again to merge newly added data
CALL p3(4);

-- 12. Display final merged records
SELECT * FROM n_rollcall;
