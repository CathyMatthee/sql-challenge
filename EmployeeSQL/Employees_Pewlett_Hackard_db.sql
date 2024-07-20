DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);
SELECT * FROM titles;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date VARCHAR(10) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex CHAR(1),
	hire_date VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
SELECT * FROM employees;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(30)
);
SELECT * FROM departments;

-- Junction table with 2 foreign keys of many to many relationship becomes composite key
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
SELECT * FROM dept_emp;

DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM dept_manager;

DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries(
	emp_no INT PRIMARY KEY,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM salaries;

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

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.


-- 5. List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).