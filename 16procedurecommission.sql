CREATE TABLE Employee (emp_id NUMBER, dept_id NUMBER, emp_name VARCHAR(50), DoJ DATE, salary NUMBER(10,2), commission NUMBER(10,2), job_title VARCHAR(50));
INSERT INTO Employee VALUES (1, 10, 'alice', DATE '2010-01-15', 12000, NULL, 'manager');
INSERT INTO Employee VALUES (2, 10, 'bob', DATE '2012-06-20', 8000, NULL, 'developer');
INSERT INTO Employee VALUES (3, 20, 'charlie', DATE '2005-03-10', 2500, NULL, 'technician');
INSERT INTO Employee VALUES (4, 20, 'david', DATE '2018-11-05', 6000, NULL, 'analyst');
INSERT INTO Employee VALUES (5, 30, 'eve', DATE '2000-07-25', 9500, NULL, 'manager');

-- 1 record the employee commission based on following conditions
CREATE OR REPLACE PROCEDURE update_employee_commission IS
BEGIN
  UPDATE Employee
  SET commission = CASE
                     WHEN salary > 10000 THEN salary * 0.004
                     WHEN salary < 3000 THEN salary * 0.0025
                     WHEN salary < 10000 AND MONTHS_BETWEEN(SYSDATE, DoJ)/12 > 10 THEN salary * 0.0035
                     ELSE salary * 0.0015
                   END;
  COMMIT;
END;
/

EXEC update_employee_commission;

SELECT * FROM Employee;

-- 2  takes department ID and returns the name of the manager of the department

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION get_dept_manager(p_dept_id IN NUMBER)
RETURN VARCHAR IS
  v_manager_name VARCHAR(100);
BEGIN
  SELECT emp_name 
  INTO v_manager_name
  FROM Employee
  WHERE dept_id = p_dept_id
    AND job_title = 'manager';

  RETURN v_manager_name;
EXCEPTION
  WHEN NO_DATA_FOUND THEN RETURN 'No Manager Found';
  WHEN TOO_MANY_ROWS THEN RETURN 'Multiple Managers Found';
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE('Manager of dept 10: ' || get_dept_manager(10));
  DBMS_OUTPUT.PUT_LINE('Manager of dept 20: ' || get_dept_manager(20));
  DBMS_OUTPUT.PUT_LINE('Manager of dept 30: ' || get_dept_manager(30));
END;
/