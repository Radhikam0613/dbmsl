CREATE TABLE Account (Account_No NUMBER, Cust_name VARCHAR(20), Balance NUMBER(12,2), DoJ DATE);
CREATE TABLE Earned_Interest ( Account_No NUMBER, Interest_Amt NUMBER(12,2), Calculated_On DATE DEFAULT SYSDATE);
INSERT INTO Account(Account_No, Cust_name, Balance, DoJ) VALUES (1001, 'Tina', 150000, DATE '2018-01-01');
INSERT INTO Account(Account_No, Cust_name, Balance, DoJ) VALUES (1002, 'Riya', 220000, DATE '2020-06-15');
INSERT INTO Account(Account_No, Cust_name, Balance, DoJ) VALUES (1003, 'Siya', 30000, DATE '2020-03-1');

CREATE OR REPLACE PROCEDURE add_interest(p_acct IN NUMBER, p_rate IN NUMBER) IS
BEGIN
  INSERT INTO Earned_Interest(Account_No, Interest_Amt)
  SELECT Account_No, Balance * p_rate / 100
  FROM Account
  WHERE Account_No = p_acct;
END add_interest;
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

BEGIN
  FOR rec IN (SELECT * FROM Account WHERE Balance > 50000) LOOP
    DBMS_OUTPUT.PUT_LINE(
      'Account: ' || rec.Account_No ||
      ', Name: ' || rec.Cust_Name ||
      ', Balance: ' || rec.Balance ||
      ', DOJ: ' || rec.DoJ
    );
  END LOOP;
END;
/