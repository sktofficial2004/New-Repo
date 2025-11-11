-- SQL Practical 2 - Demonstration of SQL Objects: Table, View, Index, Sequence, Synonym
-- Aim: Design and develop SQL DDL statements which demonstrate the use of SQL objects.

-- 1. Use an existing database
USE Abhi;

-- 2. Create table client_master
CREATE TABLE client_master (
  client_no INT PRIMARY KEY,
  client_name VARCHAR(20),
  address VARCHAR(50),
  city VARCHAR(10),
  pincode INT,
  state VARCHAR(20),
  bal_due FLOAT
);

-- 3. Insert data into client_master
INSERT INTO client_master VALUES (1, 'abhi', 'nasik', 'nasik', 422004, 'MH', 5000);
INSERT INTO client_master VALUES (2, 'piyu', 'nasik', 'nasik', 422004, 'MH', 10000);
INSERT INTO client_master VALUES (3, 'abd', 'nasik', 'nasik', 422003, 'MH', 5000);
INSERT INTO client_master VALUES (4, 'abd', 'nasik', 'nasik', 422003, 'MH', 5000);
INSERT INTO client_master VALUES (5, 'abc', 'nasik', 'nasik', 422003, 'MH', 5000);
INSERT INTO client_master VALUES (6, 'xyz', 'nasik', 'nasik', 422004, 'MH', 6000);

-- 4. Display all records
SELECT * FROM client_master;

-- 5. Display specific columns
SELECT client_name, client_no FROM client_master;

-- 6. Create product_master table
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

-- 7. Insert data into product_master
INSERT INTO product_master VALUES (1, 'shampoo', 1, 'one', 4, 2, 10, 15);
INSERT INTO product_master VALUES (2, 'oil', 13, 'one', 4, 2, 11, 16);

-- 8. Add a new column to client_master
ALTER TABLE client_master ADD telephone_no INT;

-- 9. Create index on client_master
CREATE INDEX client_search ON client_master(client_no);

-- 10. Create auto-increment table
CREATE TABLE auto (
  roll_no INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20),
  PRIMARY KEY (roll_no)
);

-- 11. Insert data into auto
INSERT INTO auto VALUES (1, 'abc');
INSERT INTO auto VALUES (2, 'adc');

-- 12. Modify auto-increment starting value
ALTER TABLE auto AUTO_INCREMENT = 100;
INSERT INTO auto VALUES (NULL, 'abd');
INSERT INTO auto VALUES (NULL, 'reh');

-- 13. Update client_master data
UPDATE client_master SET client_name = 'nut' WHERE client_no = 4;

-- 14. Create index on multiple columns
CREATE INDEX client_find ON client_master(client_name, city);

-- 15. Rename client_master table
ALTER TABLE client_master RENAME TO c_master;

-- 16. Insert additional record in product_master
INSERT INTO product_master VALUES (3, 'nutela', 15, 'three', 40, 5, 110, 123);

-- 17. Modify column datatype in product_master
ALTER TABLE product_master MODIFY sell_price FLOAT(10,2);

-- 18. Create a view of client data
CREATE VIEW client AS SELECT client_no, client_name FROM c_master;

-- 19. Display data from the view
SELECT * FROM client;

-- 20. Display all tables
SHOW TABLES;
