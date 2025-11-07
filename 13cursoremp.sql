CREATE TABLE Employee ( Emp_id NUMBER, Emp_Name VARCHAR(100), Salary NUMBER(12,2));
INSERT INTO Employee(Emp_id, Emp_Name, Salary) VALUES (101,'Vikram Singh',120000);
INSERT INTO Employee(Emp_id, Emp_Name, Salary) VALUES (102,'Rita Ghosh',50000);
INSERT INTO Employee(Emp_id, Emp_Name, Salary) VALUES (103,'Kiran Desai',40000);

SET SERVEROUTPUT ON;

-- 1 explicit cursor for sal > 50000
DECLARE
  CURSOR c IS 
    SELECT Emp_id, Emp_Name, Salary 
    FROM Employee 
    WHERE Salary > 50000;
BEGIN
    FOR rec IN c LOOP
    DBMS_OUTPUT.PUT_LINE('Employee: ' || rec.Emp_Name || ' | Salary: ' || rec.Salary);
  END LOOP;
END;
/

-- 2 implicit cursor for  total number of tuples in Employee table
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Employee;
  DBMS_OUTPUT.PUT_LINE('Total employees: ' || v_count);
END;
/

-- 3 Parameterized Cursor displaying salary of employee entered by the user
DECLARE
  v_empid NUMBER := &empid;  -- ask for input once
  CURSOR c(emp NUMBER) IS 
    SELECT Salary FROM Employee WHERE Emp_id = emp;
BEGIN
  FOR r IN c(v_empid) LOOP
    DBMS_OUTPUT.PUT_LINE('Salary of Employee ' || v_empid || ': ' || r.Salary);
  END LOOP;
END;
/