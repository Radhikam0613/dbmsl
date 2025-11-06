CREATE TABLE Employee (emp_id NUMBER, first_name VARCHAR2(50), last_name VARCHAR2(50), job_title VARCHAR2(50), dept_id NUMBER, salary NUMBER(12,2), DoJ DATE);
CREATE TABLE job_history (hist_id NUMBER, employee_id NUMBER, old_job_title VARCHAR2(50),old_dept_id NUMBER, start_date DATE, end_date DATE);

INSERT INTO Employee VALUES (101,'Rita','Ghosh','Developer',10,50000,DATE '2015-03-01');
INSERT INTO Employee VALUES (115,'Kiran','Desai','Analyst',20,40000,DATE '2012-04-10');

CREATE OR REPLACE TRIGGER trg_salary_dec
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
  IF :NEW.salary < :OLD.salary THEN
    RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be decreased');
  END IF;
END;
/

UPDATE Employee SET salary = 45000 WHERE emp_id = 101;  

CREATE OR REPLACE TRIGGER trg_job_history
AFTER UPDATE OF job_title ON Employee
FOR EACH ROW
BEGIN
  IF :OLD.job_title <> :NEW.job_title THEN
    INSERT INTO job_history(
      employee_id, old_job_title, old_dept_id, start_date, end_date
    )
    VALUES(
      :OLD.emp_id, :OLD.job_title, :OLD.dept_id, :OLD.DoJ, SYSDATE
    );
  END IF;
END;
/

UPDATE Employee SET job_title = 'Senior Developer' WHERE emp_id = 101;

SELECT * FROM job_history;
