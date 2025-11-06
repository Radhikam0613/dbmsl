CREATE TABLE Customer (CustID INT, Name VARCHAR(50), Cust_Address VARCHAR(100), Phone_no VARCHAR(15), Age INT);
CREATE TABLE Branch ( BranchID INT, Branch_Name VARCHAR(50), Address VARCHAR(100));
CREATE TABLE Account ( Account_no INT, BranchID INT, CustID INT, date_open DATE, Account_type VARCHAR(20), Balance INT);
INSERT INTO Customer VALUES (1, 'Alice', 'Pune', '9876543210', 40),(2, 'Bob', 'Mumbai', '9123456780', 30),(3, 'Charlie', 'Pune', '9988776655', 50),(4, 'David', 'Delhi', '9876501234', 28);
INSERT INTO Branch VALUES (101, 'Pune Branch', 'Pune'),(102, 'Mumbai Branch', 'Mumbai');
INSERT INTO Account VALUES (1001, 101, 1, '2020-01-01', 'Saving Account', 50000),(1002, 101, 3, '2018-05-10', 'Current Account', 20000),(1003, 102, 2, '2019-03-15', 'Saving Account', 15000),(1004, 102, 4, '2021-07-20', 'Current Account', 10000);

-- 1 Add the column “Email_Address” in Customer table
ALTER TABLE Customer ADD COLUMN Email_Address VARCHAR(50);

-- 2 Change the name of column “Email_Address” to “Email_ID” in Customer table
ALTER TABLE Customer CHANGE COLUMN Email_Address Email_ID VARCHAR(50);

-- 3 Display the customer details with highest balance in the account
SELECT c.*
FROM Customer c
JOIN Account a ON c.CustID = a.CustID
WHERE a.Balance = (SELECT MAX(Balance) FROM Account);

-- 4 lowest balance for account type= “Saving Account”
SELECT c.*
FROM Customer c
JOIN Account a ON c.CustID = a.CustID
WHERE a.Account_type = 'Saving Account'
  AND a.Balance = (SELECT MIN(Balance) FROM Account WHERE Account_type = 'Saving Account');

-- 5 live in Pune and have age greater than 35
SELECT *
FROM Customer
WHERE Cust_Address = 'Pune' AND Age > 35;

-- 6  Cust_ID, Name and Age of the customer in ascending order of their age
SELECT CustID, Name, Age
FROM Customer
ORDER BY Age ASC;

-- 7 Name and Branch ID of the customer group by the Account_type
SELECT a.Account_type, GROUP_CONCAT(c.Name) AS Customer_Names, a.BranchID
FROM Customer c
JOIN Account a ON c.CustID = a.CustID
GROUP BY a.Account_type, a.BranchID;
-- | Account_type | Customer_Names | Branch_ID |
-- | ------------ | -------------- | --------- |
-- | Saving       | Alice,Eve      | 101       |
-- | Saving       | Bob            | 102       |
-- | Current      | Charlie        | 101       |
-- | Current      | David          | 102       |