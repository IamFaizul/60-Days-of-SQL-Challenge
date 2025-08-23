use 90daysofsql;

-- Q105. Find the highest paid employee(s) in each department.

WITH dept_salary_rank AS (
    SELECT 
        employee_id,
        name,
        department,
        salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM Employeestable
)
SELECT employee_id, name, department, salary
FROM dept_salary_rank
WHERE rnk = 1;
