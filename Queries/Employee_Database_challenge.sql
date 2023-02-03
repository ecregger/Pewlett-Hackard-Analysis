--Deliverable 1
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t 
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Unique Titles
SELECT DISTINCT ON(emp_no)
emp_no, 
first_name,
last_name, 
title
INTO futureretirees
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

--Retiring Titles
SELECT title, COUNT(emp_no) AS "count"
INTO retiring_titles
FROM futureretirees
GROUP BY title
ORDER BY "count" DESC;

--Mentorship
SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligible
FROM employees AS e
JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1965-01-01' 
		 AND '1965-12-31')
ORDER BY emp_no;

--Mentorship Eligible by title
SELECT title, COUNT(emp_no) AS "count"
INTO mentor_eligible_titles
FROM mentorship_eligible
GROUP BY title
ORDER BY "count" DESC;

--Current Employees
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO current_employees
FROM employees AS e
JOIN titles AS t 
ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
ORDER BY emp_no;

--Current Employee Titles
SELECT title, COUNT(emp_no) AS "count"
INTO current_employees_title
FROM current_employees
GROUP BY title
ORDER BY "count" DESC;