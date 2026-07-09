CREATE DATABASE company_db;
USE company_db;
CREATE TABLE customer_info (
id INT,
customer_name VARCHAR(500)
);
INSERT INTO customer_info(id,customer_name) VALUES
(1,'YOLANDA'),
(2,'SAM'),
(3,'IVY');
SELECT id FROM customer_info;
DESCRIBE customer_info;
INSERT INTO customer_info(id,customer_name) VALUES
(4,'joey');
SELECT * FROM customer_info;
SET SQL_SAFE_UPDATES = 0;
UPDATE customer_info SET customer_name = 'JOEY' where id = 4;
ALTER TABLE customer_info
ADD phone varchar (500);
SELECT * FROM customer_info;
INSERT INTO customer_info (id,phone) VALUES
(1, 678798),
(2, 677799),
(3,898090);
SELECT * FROM customer_info;
DELETE FROM customer_info WHERE id = null;
SELECT * FROM customer_info;
TRUNCATE TABLE customer_info;
INSERT INTO customer_info(id,customer_name,phone) VALUES
(1,'YOLANDA', 2322434),
(2,'SAM',232324),
(3,'IVY',232324);
ALTER TABLE customer_info ADD PRIMARY KEY (id);
CREATE TABLE company_db.orders (
OrderID INT PRIMARY KEY,
OrderDate DATE,
CustumerID INT,
FOREIGN KEY (CustumerID) REFERENCES customer_info(id)
	ON DELETE RESTRICT
    ON UPDATE CASCADE
    );
SELECT * FROM orders;
INSERT INTO orders (OrderID,OrderDate,CustumerID)
VALUES (1001,'2026-06-29',2),
(1002,'2026-07-02',1),
(1003,'2026-07-07',3);
ALTER TABLE orders ADD product varchar (500) DEFAULT 'kitchenware';
INSERT INTO orders (OrderID,OrderDate,CustumerID,product)
VALUES (1004,'2026-06-29',2,'wok'),
(1005,'2026-07-02',1,'ricecooker');
UPDATE  customer_info SET id= 4 WHERE id = 3;
