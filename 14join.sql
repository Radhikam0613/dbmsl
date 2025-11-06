CREATE TABLE Locations (location_id INT,street_address VARCHAR(200),postal_code VARCHAR(20), city VARCHAR(50),states VARCHAR(50),country_id VARCHAR(5));
CREATE TABLE Departments (department_id INT, department_name VARCHAR(50), manager_id INT, location_id INT);
CREATE TABLE Manager ( manager_id INT, manager_first_name VARCHAR(50), manager_last_name VARCHAR(50));
CREATE TABLE Employee ( employee_id INT, first_name VARCHAR(50), last_name VARCHAR(50), hire_date DATE, salary INT, job_title VARCHAR(50), manager_id INT, department_id INT);
INSERT INTO Locations VALUES (1,'123 Main St','411001','Pune','Maharashtra','IN'),(2,'456 Elm St','10001','New York','NY','US');
INSERT INTO Manager VALUES (1,'Alice','Johnson'),(2,'Bob','Smith');
INSERT INTO Departments VALUES (10,'IT',1,1),(20,'HR',2,2);
INSERT INTO Employee VALUES (101,'Rita','Ghosh',DATE '2015-03-01',50000,'Developer',1,10),(102,'Kiran','Desai',DATE '2012-04-10',40000,'Analyst',2,20),(103,'Amit','Singh',DATE '2016-07-15',60000,'Manager',1,10),(104,'John','Jones',DATE '2013-09-20',45000,'Analyst',2,20);

-- 1 higher salary than the employee whose last_name=''Singh”
SELECT e.first_name, e.last_name, e.salary
FROM Employee e
WHERE e.salary > (SELECT salary 
                  FROM Employee 
                  WHERE last_name='Singh');

-- 2 have a manager and work for a department based in the United States
SELECT e.first_name, e.last_name
FROM Employee e
JOIN Departments d ON e.department_id = d.department_id
JOIN Locations l ON d.location_id = l.location_id
WHERE e.manager_id IS NOT NULL
  AND l.country_id = 'US';

-- 3 salary is greater than the average salary
SELECT first_name, last_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- 4 find the employee id, name (last_name) along with their manager_id, manager name (last_name)
SELECT e.employee_id, e.last_name AS employee_last_name, 
       e.manager_id, m.manager_last_name
FROM Employee e
LEFT JOIN Manager m ON e.manager_id = m.manager_id;

-- 5 names and hire date of the employees who were hired after 'Jones'
SELECT e.first_name, e.last_name, e.hire_date
FROM Employee e
WHERE e.hire_date > (SELECT hire_date 
                     FROM Employee 
                     WHERE last_name='Jones');
