CREATE DATABASE company_db; 
USE company_db;
CREATE TABLE Manager (Manager_id INT ,Manager_name VARCHAR(100));
CREATE TABLE Departments (Department_id INT, Department_name VARCHAR(100), Manager_id INT,Location_id INT);
CREATE TABLE Locations (Location_id INT, Street_address VARCHAR(150), Postal_code VARCHAR(20), city VARCHAR(50), sta_te VARCHAR(50), Country_id VARCHAR(10));
CREATE TABLE Employee ( Employee_id INT, First_name VARCHAR(50), Last_name VARCHAR(50), Hire_date DATE, Salary INT, Job_title VARCHAR(100), Manager_id INT, Department_id INT);
INSERT INTO Manager VALUES (1, 'Amit Shah'), (2, 'Priya Mehta'), (3, 'Ravi Kumar');
INSERT INTO Locations VALUES (10, '123 MG Road', '411001', 'Pune', 'Maharashtra', 'IN'), (20, '56 Nehru Nagar', '400001', 'Mumbai', 'Maharashtra', 'IN');
INSERT INTO Departments VALUES (101, 'IT', 1, 10), (102, 'HR', 2, 20), (103, 'Finance', 3, 10);
INSERT INTO Employee VALUES (1, 'Alice', 'Khan', '2010-05-10', 70000, 'Developer', 1, 101),(2, 'Bob', 'Sharma', '2005-03-15', 90000, 'Manager', 1, 101),(3, 'Carol', 'Iyer', '2012-11-20', 40000, 'HR Executive', 2, 102),(4, 'David', 'Patil', '2007-02-25', 50000, 'Accountant', 3, 103),(5, 'Eva', 'Rao', '2002-06-01', 100000, 'CTO', 1, 101);

-- 1 Employees earning more than average salary working in IT departments
SELECT E.first_name, E.last_name, E.salary
FROM Employee E
JOIN Departments D 
ON E.department_id = D.department_id
WHERE 
      E.salary > (SELECT AVG(salary) FROM Employee)
      AND D.department_name = 'IT';

-- 2 Employees earning same as the minimum salary across all departments
SELECT first_name, last_name, salary
FROM Employee
WHERE salary = ( SELECT MIN(salary) FROM Employee);

-- 3 Employees whose salary is above average for their department
SELECT E.employee_id, E.first_name, E.last_name, E.salary
FROM Employee E
WHERE E.salary > (
  SELECT AVG(E2.salary)
  FROM Employee E2
  WHERE E2.department_id = E.department_id
);

-- 4 Display department name, manager name, and city
SELECT D.department_name, M.manager_name, L.city
FROM Departments D
JOIN Manager M ON D.manager_id = M.manager_id
JOIN Locations L ON D.location_id = L.location_id;

-- 5 Managers with more than 15 years of experience
SELECT E.first_name, E.last_name, E.hire_date, E.salary
FROM Employee E
WHERE E.job_title = 'Manager'
  AND TIMESTAMPDIFF(YEAR, E.hire_date, CURDATE()) > 15;
