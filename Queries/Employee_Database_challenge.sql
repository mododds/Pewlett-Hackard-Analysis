-- DELIVERABLE 1: Retirement Info tables
-- Create new table to hold retirement titles info
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retire_titles
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, e.last_name DESC;

-- Use Dictinct with Orderby to remove duplicate rows & create new table
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO retire_unique
FROM retire_titles 
WHERE to_date = '9999-01-01'
ORDER BY emp_no, last_name DESC;


-- Create new table to total the number of employees by title
SELECT COUNT(emp_no), title
INTO retire_count
FROM retire_unique
GROUP BY title
ORDER BY count(emp_no) DESC;

-- DELIVERABLE 2: Mentorship Program Tables
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentor_eligible
FROM employees as e	
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, e.last_name DESC;	 