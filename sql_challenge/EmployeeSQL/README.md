# sql_challenge
Module 9 Challenge Assignment


Instructions:
Conduct a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

For this project, you’ll design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. That is, you’ll perform data modeling, data engineering, and data analysis, respectively.

Tables and data analysis:
#department table

CREATE TABLE departments (
    dept_no VARCHAR(4) PRIMARY KEY,
    dept_name VARCHAR(18) NOT NULL
 );
#dept_emp table

CREATE TABLE dept_emp (
    emp_no INT,
    dept_number VARCHAR(4) NOT NULL,
    PRIMARY KEY (emp_no, dept_number),
    FOREIGN KEY (dept_number) REFERENCES departments(dept_no)
);

#dept_manager table

CREATE TABLE dept_manager (
    dept VARCHAR(4) NOT NULL,
    emp_no INT,
    PRIMARY KEY (emp_no, dept),
    FOREIGN KEY (dept) REFERENCES departments (dept_no)
);


#titles table

CREATE TABLE titles (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(18) NOT NULL,
    );


#employees table

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title) REFERENCES titles(title_id)
                              
);

#salaries table

CREATE TABLE salaries (
  emp_no INT PRIMARY KEY,
  salary DECIMAL NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
  );

 ##Data Analysis##

1) List the employee number, last name, first name, sex, and salary of each employee

    SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
    FROM employees
    JOIN salaries ON employees.emp_no = salaries.emp_no

2) List the first name, last name, and hire date for the employees who were hired in 1986

    SELECT employees.first_name, employees.last_name, employees.hire_date 
    FROM employees
    WHERE hire_date > '12/31/1985'
    AND
    hire_date < '01/01/1987'
    
    ;


3) List the manager of each department along with their department number, department name, employee number, last name, and first name

    SELECT 
        departments.dept_no AS department_number,
        departments.dept_name AS department_name,
        dept_manager.emp_no AS manager_employee_number,
        employees.last_name AS manager_last_name,
        employees.first_name AS manager_first_name
    FROM 
        departments
    JOIN 
        dept_manager ON departments.dept_no = dept_manager.dept
    JOIN 
        employees ON dept_manager.emp_no = employees.emp_no and first name
    ;

4) List the department number for each employee along with that employee’s employee number, last name, first name and department name 

    SELECT 
        employees.emp_no AS employee_id,
        employees.last_name AS last_name,
        employees.first_name AS first_name,
        departments.dept_name AS department_name,
    	dept_emp.dept_number AS department_number
    	
    FROM 
        employees
    JOIN 
        dept_emp ON employees.emp_no = dept_emp.emp_no
    JOIN 
        departments ON dept_emp.dept_number = departments.dept_no and department name
    
      ;  

5) List first name, last name, and sex of each employee whose first name is Hercules and and whose last name begins with the letter B
  
    SELECT 
    employees.first_name AS first_name,
    employees.last_name AS last_name,
    employees.sex AS gender
    
    FROM employees
    
    WHERE employees.first_name = 'Hercules'
    
    AND employees.last_name LIKE '%B%'
    
    ;

6) List each employee in the Sales department, including their employee number, last name, and first name.
   
    SELECT 
    employees.emp_no AS employee_id,
    employees.last_name AS last_name,
    employees.first_name AS first_name,
    departments.dept_name AS dept_name
    
    FROM employees
    
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    
    JOIN departments ON dept_emp.dept_number = departments.dept_no
    
    WHERE departments.dept_name = 'Sales'
    ;

8) List each employee in the Sales and Development departments, including their employee number

    SELECT
    employees.emp_no AS employee_id,
    employees.last_name AS last_name,
    employees.first_name AS first_name,
    departments.dept_name AS department_name
    
    FROM employees
    
    JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
    
    JOIN departments ON dept_emp.dept_number = departments.dept_no
    
    WHERE departments.dept_name IN ('Sales', 'Development')
    ;


8) List the frequency counts, in descending order, of all the employee  last names (that is, how many employees share each last name).

    SELECT
        last_name,
        COUNT(*) AS frequency
    FROM
        employees
    GROUP BY
        last_name
    ORDER BY
        frequency DESC
        
    ;
 

