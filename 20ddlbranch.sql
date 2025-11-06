CREATE TABLE Customer(CustID INT PRIMARY KEY, Name VARCHAR(50), Cust_Address VARCHAR(100), Phone_no VARCHAR(15), Email_ID VARCHAR(50), Age INT);
CREATE TABLE Branch(Branch_ID INT PRIMARY KEY, Branch_Name VARCHAR(50), Address VARCHAR(100));
CREATE TABLE Account(Account_no INT PRIMARY KEY, Branch_ID INT, CustID INT, open_date DATE, Account_type VARCHAR(20), Balance DECIMAL(10,2), FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID), FOREIGN KEY (CustID) REFERENCES Customer(CustID));
INSERT INTO Customer VALUES (101,'Alice','Mumbai','9876543210','alice@mail.com',30),(102,'Bob','Delhi','9876543211','bob@mail.com',40),(103,'Charlie','Chennai','9876543212','charlie@mail.com',38);
INSERT INTO Branch VALUES (1,'Main Branch','Mumbai'),(2,'City Branch','Pune');
INSERT INTO Account VALUES (1001,1,101,'2018-08-16','Saving',50000),(1002,2,102,'2018-08-16','Saving',60000),(1003,1,103,'2018-02-16','Loan',150000);

-- 1 Saving account view displaying the customer details with the open date as 16/8/2018
CREATE VIEW Saving_Account AS 
SELECT c.* FROM Customer c 
JOIN Account a ON c.CustID=a.CustID 
WHERE a.Account_type='Saving' 
      AND a.open_date='2018-08-16';

-- 2 Update the View with Cust_Address as Pune for CustID =103.
UPDATE Customer
SET Cust_Address = 'Pune'
WHERE CustID = 103;

-- 3 View as Loan account displaying the customer details with the open date as 16/2/2018
CREATE VIEW Loan_Account AS 
SELECT c.* FROM Customer c 
JOIN Account a ON c.CustID=a.CustID 
WHERE a.Account_type='Loan' 
      AND a.open_date='2018-02-16';

-- 4 Index on primary key column of table Customer
CREATE INDEX idx_customer_id ON Customer(CustID);

-- 5 Index on primary key column of table Branch
CREATE INDEX idx_branch_id ON Branch(Branch_ID);

-- 6 sequence explain auto_increment working

-- 7 synonym
CREATE VIEW Cust_info AS
SELECT * FROM Branch;