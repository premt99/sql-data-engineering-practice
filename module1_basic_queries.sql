/*
=====================================================================
 Module 1: Basic Queries
 Course : IBM Data Engineering Professional Certificate — Course 5
 Topics : SELECT, WHERE, COUNT, DISTINCT
 Dialect: (fill in — e.g. PostgreSQL / MySQL / DB2)
=====================================================================
*/

-- -----------------------------------------------------------------
-- 1. Basic SELECT
-- -----------------------------------------------------------------
-- Problem: Retrieve all columns from a table.
-- Note   : Avoid SELECT * in production code — list columns explicitly.

SELECT *
FROM employees;


-- -----------------------------------------------------------------
-- 2. SELECT with specific columns
-- -----------------------------------------------------------------
-- Problem: Retrieve only the columns you need.

SELECT first_name, last_name, department
FROM employees;


-- -----------------------------------------------------------------
-- 3. WHERE clause — filtering rows
-- -----------------------------------------------------------------
-- Problem: Find employees in a specific department.

SELECT first_name, last_name
FROM employees
WHERE department = 'Engineering';


-- -----------------------------------------------------------------
-- 4. COUNT — aggregate row counts
-- -----------------------------------------------------------------
-- Problem: Count how many employees are in each department.

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- -----------------------------------------------------------------
-- 5. DISTINCT — unique values
-- -----------------------------------------------------------------
-- Problem: List all unique department names.

SELECT DISTINCT department
FROM employees;


-- -----------------------------------------------------------------
-- Notes / gotchas from this module
-- -----------------------------------------------------------------
-- - WHERE filters rows before aggregation; HAVING filters after (covered in module 3).
-- - COUNT(*) counts all rows including NULLs; COUNT(column) skips NULLs in that column.
