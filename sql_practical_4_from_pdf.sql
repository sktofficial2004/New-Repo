-- SQL Practical 4 - Joins, Subqueries, and Views
-- Aim: Design at least 10 SQL queries demonstrating joins, subqueries, and views.

-- 1. Use the database
USE Abhi;

-- 2. Create tables
CREATE TABLE capital (
  cap_no INT PRIMARY KEY,
  cap_name VARCHAR(20),
  state_no INT
);

CREATE TABLE state (
  state_no INT PRIMARY KEY,
  state_name VARCHAR(20),
  state_code INT,
  capital VARCHAR(20)
);

CREATE TABLE customer (
  cust_no INT PRIMARY KEY,
  cust_name VARCHAR(20),
  cust_add VARCHAR(20),
  phone_no INT
);

CREATE TABLE product_master (
  product_no INT PRIMARY KEY,
  description VARCHAR(20),
  profit_per FLOAT,
  unit_measure VARCHAR(10),
  quantity INT,
  reorder INT,
  sell_price FLOAT,
  cost_price FLOAT
);

-- 3. Insert data into capital table
INSERT INTO capital VALUES (1, 'MH', 1);
INSERT INTO capital VALUES (2, 'RAJ', 2);
INSERT INTO capital VALUES (3, 'GOA', 3);
INSERT INTO capital VALUES (4, 'GUJ', 4);
INSERT INTO capital VALUES (5, 'KAR', 5);

-- 4. Insert data into state table
INSERT INTO state VALUES (1, 'MH', 1, 'MUM');
INSERT INTO state VALUES (2, 'RAJ', 2, 'JAI');
INSERT INTO state VALUES (3, 'GOA', 3, 'PAN');
INSERT INTO state VALUES (4, 'GUJ', 4, 'SUR');
INSERT INTO state VALUES (5, 'KAR', 5, 'BAN');

-- 5. INNER JOIN Example
SELECT capital.cap_no, state.state_no
FROM capital INNER JOIN state ON capital.cap_no = state.state_no;

-- 6. LEFT JOIN Example
SELECT capital.cap_no, state.state_no
FROM capital LEFT JOIN state ON capital.cap_no = state.state_no;

-- 7. RIGHT JOIN Example
SELECT capital.cap_no, state.state_no
FROM capital RIGHT JOIN state ON capital.cap_no = state.state_no;

-- 8. FULL OUTER JOIN (Simulated using UNION)
SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no
FROM capital LEFT JOIN state ON capital.cap_no = state.state_no
UNION
SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no
FROM capital RIGHT JOIN state ON capital.cap_no = state.state_no;

-- 9. CROSS JOIN Example
SELECT * FROM capital c1, state s1 WHERE c1.cap_no = s1.state_no;

-- 10. CROSS JOIN with non-matching condition
SELECT * FROM capital c1, state s1 WHERE c1.cap_no != s1.state_no;

-- 11. Subquery Example 1
SELECT * FROM state WHERE state_no = (SELECT state_no FROM state WHERE state_name = 'MH');

-- 12. Subquery Example 2
SELECT * FROM state WHERE state_no = (SELECT state_no FROM state WHERE state_name = 'GUJ');

-- 13. Subquery Example 3
SELECT * FROM state WHERE state_no = (SELECT capital.state_no FROM capital WHERE cap_name = 'KAR');

-- 14. Create a view combining capital and state data
CREATE VIEW capital_state AS
SELECT capital.cap_no, capital.cap_name, state.capital, state.state_no
FROM capital INNER JOIN state ON capital.cap_no = state.state_no;

-- 15. Display data from the created view
SELECT * FROM capital_state;

-- 16. Drop all created objects
DROP VIEW capital_state;
DROP TABLE capital;
DROP TABLE state;
DROP TABLE customer;
DROP TABLE product_master;
