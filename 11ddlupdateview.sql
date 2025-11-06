CREATE DATABASE corp; USE corp;
CREATE TABLE Branch (BranchID INT PRIMARY KEY AUTO_INCREMENT,Branch_Name VARCHAR(100),Address VARCHAR(200));
CREATE TABLE Customer (CustID INT PRIMARY KEY Name VARCHAR(100), Cust_Address VARCHAR(200), Phone_no VARCHAR(20), Email_ID VARCHAR(100), Age INT);
CREATE TABLE Account (Account_no INT PRIMARY KEY AUTO_INCREMENT,BranchID INT,CustID INT,date_open DATE,Account_type VARCHAR(50),Balance DECIMAL(12,2),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
  FOREIGN KEY (CustID) REFERENCES Customer(CustID));
INSERT INTO Branch (Branch_Name, Address)  VALUES ('Main Branch','Pune');
INSERT INTO Customer(Name, Cust_Address, Phone_no, Email_ID, Age) VALUES ('Sonal','Pune','9999999999','sonal@example.com',28);
INSERT INTO Account(BranchID, CustID, date_open, Account_type, Balance) VALUES (1,101,'2018-08-16','Saving Account',35000);

-- 1. Create an Index on primary key column of table Account
CREATE INDEX idx_account_balance ON Account(Balance);

-- 2 view as Customer_Info displaying the customer details for age less than 45
CREATE VIEW Customer_Info AS 
SELECT c.*, a.date_open, a.Account_type, a.Balance 
FROM Customer c 
JOIN Account a ON c.CustID=a.CustID 
WHERE c.Age < 45;

-- 3 Update the View with open date as 16/4/2017
UPDATE Account a
JOIN Customer c ON a.CustID=c.CustID
SET a.date_open='2017-04-16'
WHERE c.Age < 45;

CREATE SEQUENCE branch_seq START WITH 1 INCREMENT BY 1;

-- 7. Create synonym ‘Branch_info’ for branch table.
CREATE VIEW Branch_info AS
SELECT * FROM Branch;
SELECT * FROM Branch_info;
