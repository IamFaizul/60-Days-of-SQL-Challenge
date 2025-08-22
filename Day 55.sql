use 90daysofsql;

-- Q102. Find employees who joined before their manager.

select * from Employeestable e1 
inner join Employeestable e2 
on e1.manager_id = e2.employee_id
where e1.join_date > e2.join_date;

-- Q103. Find departments where the average salary is higher than the company-wide average salary.

select department, round(avg(salary),2) as dept_avg, (select round(avg(salary),2) from Employeestable) as company_wise_avg from Employeestable e 
group by department
having avg(salary) > (select avg(salary) from Employeestable);

-- Q104. Find employees who do not manage anyone.

SELECT 
    *
FROM
    Employeestable
WHERE
    manager_id IS NULL;