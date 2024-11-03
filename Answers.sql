use employees;

SELECT * FROM employees

-- 1. List of Employees by Department
-- Question: Write a query to list all employees along with their respective department names. Include employee number, first name, last name, department number, and department name.
SELECT 
    e.emp_no, d.dept_no, d.dept_name, e.first_name, e.last_name
FROM
    employees AS e
        JOIN
    dept_emp AS depte ON e.emp_no = depte.emp_no
        JOIN
    departments AS d ON depte.dept_no = d.dept_no;
    
-- 2. Current and Past Salaries of an Employee
-- Question: Write a query to retrieve all the salary records of a given employee (by employee number). Include employee number, salary, from_date, and to_date.

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10009'

-- 3. Employees with Specific Titles
-- Question: Write a query to find all employees who have held a specific title (e.g., 'Engineer'). Include employee number, first name, last name, and title.
SELECT 
    e.emp_no, t.title, e.first_name, e.last_name
FROM
    employees AS e
        JOIN
    titles AS t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Engineer';

-- 4. Departments with Their Managers
-- Question: Write a query to list all departments along with their current managers. Include department number, department name, manager's employee number, first name, and last name.
SELECT 
    d.dept_no, e.emp_no, d.dept_name, e.first_name, e.last_name
FROM
    employees AS e
        JOIN
    dept_manager AS dm ON e.emp_no = dm.emp_no
        JOIN
    departments AS d ON dm.dept_no = d.dept_no;
 
-- 5. Employee Count by Department
-- Question: Write a query to count the number of employees in each department. Include department number, department name, and employee count
SELECT 
    dept_name, COUNT(emp_no) AS emp_count
FROM
    departments AS d
        JOIN
    dept_emp AS de ON d.dept_no = de.dept_no
GROUP BY dept_name;

--  6. Employees' Birthdates in a Given Year
-- Question: Write a query to find all employees born in a specific year (e.g., 1953). Include employee number, first name, last name, and birth date.

SELECT 
    e.emp_no, e.first_name, e.last_name, e.birth_date
FROM
    employees.employees AS e
WHERE
    YEAR(birth_date) = '1953';

-- 7. Employees Hired in the Last 50 Years
-- Question: Write a query to find all employees hired in the last 50 years. Include employee number, first name, last name, and hire date.
SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date
FROM
    employees.employees AS e
WHERE
    hire_date >= DATE_SUB(CURDATE(), INTERVAL 50 YEAR);

-- 8. Average Salary by Department
-- Question: Write a query to calculate the average salary for each department. Include department number, department name, and average salary.
SELECT d.dept_no,d.dept_name,avg(s.salary)  as avg_salary
FROM
    employees.departments AS d
        JOIN
    dept_emp AS de ON de.dept_no = d.dept_no
        JOIN
    salaries AS s ON de.emp_no = s.emp_no
GROUP BY d.dept_no,d.dept_name;

-- 9.Gender Distribution in Each Department
-- Question: Write a query to find the gender distribution (number of males and females) in each department. Include department number, department name, count of males, and count of females.
SELECT 
    d.dept_no,
    d.dept_name,
    SUM(CASE
        WHEN e.gender = 'M' THEN 1
        ELSE 0
    END) AS male_count,
    SUM(CASE
        WHEN e.gender = 'F' THEN 1
        ELSE 0
    END) AS female_count
FROM
    departments AS d
        JOIN
    dept_emp AS de ON de.dept_no = d.dept_no
        JOIN
    employees AS e ON de.emp_no = e.emp_no
GROUP BY d.dept_no , d.dept_name;

-- 10. Longest Serving Employees
-- Question: Write a query to find the employees who have served the longest in the company. Include employee number, first name, last name, and number of years served.

SELECT 
    emp_no,
    first_name,
    last_name,
    TIMESTAMPDIFF(YEAR,
        hire_date,
        CURDATE()) AS year_served  
FROM
    employees
ORDER BY year_served DESC
LIMIT 1;