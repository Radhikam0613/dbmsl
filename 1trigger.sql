CREATE TABLE Employee (emp_id INT,first_name VARCHAR(50),last_name VARCHAR(50), designation VARCHAR(50),salary DECIMAL(12,2), dept VARCHAR(50));
CREATE TABLE Salary_Backup (emp_id INT, old_salary DECIMAL(12,2),new_salary DECIMAL(12,2),salary_difference DECIMAL(12,2));


INSERT INTO Employee VALUES (1, 'Alice', 'Khan', 'Developer', 60000, 'IT');
INSERT INTO Employee VALUES (2, 'Bob', 'Sharma', 'CEO', 200000, 'Management');
INSERT INTO Employee VALUES (3, 'Carol', 'Iyer', 'Manager', 90000, 'HR');

CREATE OR REPLACE TRIGGER trg_salary_update
AFTER UPDATE OF salary ON Employee
FOR EACH ROW
BEGIN
  IF :NEW.salary <> :OLD.salary THEN
    INSERT INTO Salary_Backup (emp_id, old_salary, new_salary, salary_difference)
    VALUES (:NEW.emp_id, :OLD.salary, :NEW.salary, :NEW.salary - :OLD.salary);
  END IF;
END;
/

UPDATE Employee SET salary = 65000 WHERE emp_id = 1;
SELECT * FROM Salary_Backup;

CREATE OR REPLACE TRIGGER trg_prevent_delete
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
  IF :OLD.designation = 'CEO' THEN
    RAISE_APPLICATION_ERROR(-20000, 'Cannot delete CEO');
  END IF;
END;
/

DELETE FROM Employee WHERE designation = 'CEO';