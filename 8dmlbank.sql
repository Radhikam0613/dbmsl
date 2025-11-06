CREATE DATABASE corp_db;
USE corp_db;
CREATE TABLE Customer (CustID INT ,Name VARCHAR(100),Cust_Address VARCHAR(200),Phone_no VARCHAR(20),Email_ID VARCHAR(100),Age INT);
CREATE TABLE Account (Account_no INT , Branch_ID INT, CustID INT, date_open DATE, Account_type VARCHAR(50), Balance INT);
CREATE TABLE Branch ( Branch_ID INT, Branch_Name VARCHAR(20), Address VARCHAR(20));
  -- FOREIGN KEY (CustID) REFERENCES Customer(CustID)

INSERT INTO Customer VALUES (1, 'Alice Kumar', 'Pune', '9876543210', 'alice@gmail.com', 30),(2, 'Bob Sharma', 'Mumbai', '9123456780', 'bob@gmail.com', 45),(3, 'Anita Iyer', 'Pune', '9988776655', 'anita@gmail.com', 28),(4, 'Chetan Joshi', 'Delhi', '9871234567', 'chetan@gmail.com', 35);
INSERT INTO Branch VALUES (101, 'Pune Branch', 'FC Road, Pune'),(102, 'Mumbai Branch', 'Bandra, Mumbai');
INSERT INTO Account VALUES (1001, 101, 1, '2023-01-01', 'Saving Account', 60000),(1002, 102, 2, '2022-05-15', 'Current Account', 40000),(1003, 101, 3, '2023-03-20', 'Saving Account', 55000),(1004, 102, 4,'2021-12-10', 'Saving Account', 15000);

-- 1. alter column length 
ALTER TABLE Customer MODIFY Email_ID VARCHAR(20);

-- 2  set NOT NULL
ALTER TABLE Customer MODIFY Email_ID VARCHAR(20) NOT NULL;

-- 3. total customers with balance > 50000
SELECT COUNT(c.CustID) AS Total_Customers
FROM Customer c
JOIN Account a ON c.CustID = a.CustID
WHERE a.Balance > 50000;

-- 4. average balance for Saving Account
SELECT AVG(Balance) AS Avg_Balance
FROM Account
WHERE Account_type = 'Saving Account';

-- 5. customers in Pune or name starts with 'A'
SELECT *
FROM Customer
WHERE Cust_Address = 'Pune' OR Name LIKE 'A%';

-- 6. create Saving_Account table from Account
CREATE TABLE Saving_Account AS
SELECT Account_no, Branch_ID, CustID, Date_open, Balance
FROM Account
WHERE Account_type = 'Saving Account';

-- 7. display customer details Age wise with balance>=20000
SELECT c.*
FROM Customer c
JOIN Account a ON c.CustID = a.CustID
WHERE a.Balance >= 20000
ORDER BY c.Age;