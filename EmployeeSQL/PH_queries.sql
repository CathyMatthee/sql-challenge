-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s on e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
JOIN employees AS e on dm.emp_no = e.emp_no
JOIN departments AS d on dm.dept_no = d.dept_no
ORDER BY dm.dept_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
-- Place into a view to use in #7 below
CREATE VIEW dept_empl_details AS
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e on de.emp_no = e.emp_no
JOIN departments AS d on de.dept_no = d.dept_no
ORDER BY de.dept_no;

SELECT * FROM dept_empl_details;

-- 5. List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
-- Tried subquery method
SELECT emp_no AS "emp_no in Sales Dept", last_name, first_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
))
ORDER BY emp_no;

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- Using the view from #4 above with 'where' condition
SELECT * FROM dept_empl_details
WHERE dept_name IN ('Sales', 'Development') --could have used OR as well
ORDER BY dept_no DESC;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "frequency count"
FROM employees
GROUP BY last_name
ORDER BY "frequency count" DESC; -- assumed ordering based on count column not last name