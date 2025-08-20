use 90daysofsql;

-- Drop table if it already exists
DROP TABLE IF EXISTS Employees;

-- Create the Employees table
CREATE TABLE EmployeesTable (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT,
    join_date DATE,
    FOREIGN KEY (manager_id) REFERENCES EmployeesTable(employee_id)
);

-- Insert sample data
INSERT INTO EmployeesTable (employee_id, name, department, salary, manager_id, join_date) VALUES
(1, 'Arif', 'Tech', 70000, NULL, '2020-01-10'),
(2, 'Borsha', 'Tech', 60000, 1, '2021-03-15'),
(3, 'Rahim', 'HR', 50000, NULL, '2019-11-20'),
(4, 'Tanvir', 'HR', 40000, 3, '2022-01-12'),
(5, 'Sabiha', 'Finance', 55000, NULL, '2021-07-30'),
(6, 'Imran', 'Tech', 62000, 1, '2022-09-01'),
(7, 'Farhana', 'Finance', 52000, 5, '2023-02-18');


-- Q100. Find the employees who earn more than their manager.

SELECT 
    e.employee_id,
    e.name AS employee_name,
    e.salary AS employee_salary,
    m.name AS manager_name,
    m.salary AS manager_salary
FROM EmployeesTable e
JOIN EmployeesTable m 
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;


-- Q101. Find the second highest salary in each department.

with salarytable as 

(
	select employee_id, name, department, 
    row_number() over(partition by department order by salary desc) as rn
    from EmployeesTable 
   


)
select employee_id, name, department from salarytable where rn = 2;
















