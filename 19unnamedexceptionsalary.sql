CREATE TABLE Employee (emp_id NUMBER, dept_id NUMBER, emp_name VARCHAR2(50), DoJ DATE, salary NUMBER(10,2), commission NUMBER(5,2), job_title VARCHAR2(50));
CREATE TABLE Salary_Increment (emp_id NUMBER, new_salary NUMBER(10,2));
INSERT INTO Employee VALUES (115, 10, 'John Doe', DATE '2012-01-01', 50000, NULL, 'Developer');
INSERT INTO Employee VALUES (116, 20, 'Jane Smith', DATE '2018-06-15', 40000, NULL, 'Analyst');

SET SERVEROUTPUT ON;

DECLARE
    v_emp_id NUMBER := &Enter_Emp_ID;
    v_new_salary NUMBER;
    e_emp_not_found EXCEPTION;
BEGIN
    BEGIN
        SELECT CASE
                WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, DoJ)/12) > 10 THEN salary * 1.20
                WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, DoJ)/12) > 5 THEN salary * 1.10
                ELSE salary * 1.05
               END
        INTO v_new_salary
        FROM Employee
        WHERE emp_id = v_emp_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE e_emp_not_found;
    END;

    INSERT INTO Salary_Increment VALUES(v_emp_id, v_new_salary);
    DBMS_OUTPUT.PUT_LINE('Salary incremented for emp_id ' || v_emp_id || '. New Salary: ' || v_new_salary);

EXCEPTION
    WHEN e_emp_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

SELECT * FROM Salary_Increment;
