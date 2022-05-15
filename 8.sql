--drop tables
--drop table employees, salaries, titles, departments, dept_manager, dept_emp


-- Create new tables
CREATE TABLE employees (
  emp_no int Primary Key,
	emp_title_id VARCHAR,
	birthdate date,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date date
);

CREATE TABLE salaries (
  emp_no int primary key,
  salary int
);

CREATE TABLE titles (
  title_id VARCHAR primary key,
  title VARCHAR
);

CREATE TABLE departments (
  dept_no VARCHAR Primary Key,
  dept_name VARCHAR
);

CREATE TABLE dept_manager (
  dept_no VARCHAR references departments,
  emp_no int references employees,
	Primary Key (dept_no, emp_no)
);

CREATE TABLE dept_emp (
  emp_no int references employees,
  dept_no VARCHAR references departments,
	Primary Key (dept_no, emp_no)
);


--List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees e
join salaries s on
e.emp_no = s.emp_no



--List first name, last name, and hire date for employees who were hired in 1986.
select e.first_name, e.last_name, e.hire_date
from employees e
where hire_date >= '01/01/1986' and 
		hire_date < '01/01/1987'
order by hire_date



--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
from departments d
join dept_manager dm on
d.dept_no = dm.dept_no
join employees e on
dm.emp_no = e.emp_no



--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
join dept_emp de on
e.emp_no = de.emp_no
join departments d on
de.dept_no = d.dept_no



--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select e.first_name, e.last_name, e.sex
from employees e
where  first_name = 'Hercules' and
		last_name like 'B%'



--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
join dept_emp de on
e.emp_no = de.emp_no
join departments d on
de.dept_no = d.dept_no
where e.emp_no in (
	select de.emp_no
	from dept_emp
	where de.dept_no in (
		select d.dept_no
		from departments
		where d.dept_name = 'Sales'
		)
	)



--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
join dept_emp de on
e.emp_no = de.emp_no
join departments d on
de.dept_no = d.dept_no
where e.emp_no in (
	select de.emp_no
	from dept_emp
	where de.dept_no in (
		select d.dept_no
		from departments
		where d.dept_name = 'Sales' or d.dept_name = 'Development'
		)
	)



--List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
select e.last_name, count(e.last_name)
from employees e
group by last_name
order by e.last_name desc