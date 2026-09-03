/*
=====================================================================
 Module 2: Introduction to Relational Databases, Tables & DDL Commands
 Course : IBM Databases and SQL for Data Science with Python
 Author : Prem Tiwari (premt99)
=====================================================================
*/

-- -----------------------------------------------------------------
-- 1. DDL vs DML Overview
-- -----------------------------------------------------------------
-- DDL (Data Definition Language): Commands that define/modify database structure.
--   Examples: CREATE, ALTER, DROP, TRUNCATE, RENAME
--
-- DML (Data Manipulation Language): Commands that manage data within objects.
--   Examples: SELECT, INSERT, UPDATE, DELETE


-- -----------------------------------------------------------------
-- 2. CREATE TABLE — Schema Definition with Constraints
-- -----------------------------------------------------------------

-- Create a master Departments table with a primary key
CREATE TABLE IF NOT EXISTS departments (
    dept_id     INT NOT NULL,
    dept_name   VARCHAR(50) NOT NULL,
    location    VARCHAR(50) DEFAULT 'Mumbai',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_departments PRIMARY KEY (dept_id)
);

-- Create an Employees table with constraints and data types
CREATE TABLE IF NOT EXISTS employees (
    emp_id      INT NOT NULL,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) UNIQUE,
    salary      DECIMAL(10, 2) CHECK (salary > 0),
    dept_id     INT,
    hire_date   DATE NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_id),
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- -----------------------------------------------------------------
-- 3. ALTER TABLE — Schema Evolution Operations
-- -----------------------------------------------------------------

-- Add a new column to an existing table
ALTER TABLE employees
    ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

-- Add a contact phone number column
ALTER TABLE employees
    ADD COLUMN phone_number VARCHAR(15);

-- Modify an existing column's data type / constraint
ALTER TABLE employees
    MODIFY COLUMN email VARCHAR(150);

-- Rename a column
ALTER TABLE employees
    RENAME COLUMN phone_number TO contact_number;

-- Drop an obsolete column
ALTER TABLE employees
    DROP COLUMN contact_number;


-- -----------------------------------------------------------------
-- 4. DML Operations — Populating and Modifying Records
-- -----------------------------------------------------------------

-- Insert sample records into Departments
INSERT INTO departments (dept_id, dept_name, location)
VALUES
    (101, 'Core Engineering',     'Mumbai LTBP'),
    (102, 'Data Platform',        'Bengaluru'),
    (103, 'Process Automation',   'Mumbai Mahape');

-- Insert sample records into Employees
INSERT INTO employees (emp_id, first_name, last_name, email, salary, dept_id, hire_date, is_active)
VALUES
    (1, 'Prem',  'Tiwari', 'prem.tiwari@example.com',  85000.00, 103, '2025-07-01', TRUE),
    (2, 'Aarav', 'Sharma', 'aarav.sharma@example.com', 92000.00, 101, '2024-03-15', TRUE),
    (3, 'Neha',  'Verma',  'neha.verma@example.com',   78000.00, 102, '2025-01-10', FALSE);

-- Update an existing record
UPDATE employees
SET salary = 95000.00
WHERE emp_id = 1;


-- -----------------------------------------------------------------
-- 5. TRUNCATE vs DROP vs DELETE — Critical Data Engineering Distinction
-- -----------------------------------------------------------------

-- Temporary table for deletion testing
CREATE TABLE IF NOT EXISTS staging_pipeline_logs (
    log_id          INT PRIMARY KEY,
    pipeline_name   VARCHAR(100),
    status          VARCHAR(20),
    execution_time  TIMESTAMP
);

-- Insert a dummy log entry
INSERT INTO staging_pipeline_logs (log_id, pipeline_name, status, execution_time)
VALUES (1, 'vahan_portal_extraction', 'SUCCESS', CURRENT_TIMESTAMP);

-- A. DELETE — DML command; removes rows one by one
--    (can be rolled back, logs each row)
DELETE FROM staging_pipeline_logs WHERE status = 'SUCCESS';

-- B. TRUNCATE — DDL command; quickly removes ALL rows and resets table space
--    (high performance, cannot be rolled back easily)
TRUNCATE TABLE staging_pipeline_logs;

-- C. DROP — DDL command; completely deletes the data AND the table's schema
--    definition from the database
DROP TABLE IF EXISTS staging_pipeline_logs;


-- -----------------------------------------------------------------
-- Notes / gotchas from this module
-- -----------------------------------------------------------------
-- - DDL statements auto-commit in most databases — there's no undo once run.
-- - DELETE is DML (logged, filterable, rollback-able); TRUNCATE and DROP are
--   DDL (fast, but irreversible in most engines).
-- - FOREIGN KEY constraints enforce referential integrity between employees
--   and departments — you can't insert an employee with a dept_id that
--   doesn't exist in departments.
