CREATE TABLE Account( Account_No NUMBER PRIMARY KEY, Cust_Name VARCHAR2(50), Balance NUMBER, NoOfYears NUMBER);
CREATE TABLE Earned_Interest(Account_No NUMBER,Interest_Amt NUMBER);

INSERT INTO Account VALUES(101, 'Alice', 60000, 5);
INSERT INTO Account VALUES(102, 'Bob', 45000, 3);
INSERT INTO Account VALUES(103, 'Charlie', 80000, 2);

CREATE OR REPLACE PROCEDURE add_interest(p_acct IN NUMBER, p_rate IN NUMBER) IS
BEGIN
  INSERT INTO Earned_Interest(Account_No, Interest_Amt)
  SELECT Account_No, Balance * p_rate * NoOfYears / 100
  FROM Account
  WHERE Account_No = p_acct;
END;
/

EXEC add_interest(&Enter_Account_No, &Enter_Interest_Rate);
SELECT * FROM Earned_Interest;

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION get_high_balance RETURN SYS_REFCURSOR IS
  rc SYS_REFCURSOR;
BEGIN
  OPEN rc FOR 
    SELECT * FROM Account WHERE Balance > 50000;
  RETURN rc;
END;
/

DECLARE
  rc SYS_REFCURSOR;
  rec Account%ROWTYPE;
BEGIN
  rc := get_high_balance;
  LOOP
    FETCH rc INTO rec;
    EXIT WHEN rc%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Account: '||rec.Account_No||', Name: '||rec.Cust_Name||', Balance: '||rec.Balance||', Years: '||rec.NoOfYears);
  END LOOP;
  CLOSE rc;
END;
/
