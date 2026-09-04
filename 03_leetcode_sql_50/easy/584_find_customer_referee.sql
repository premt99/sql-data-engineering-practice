/*
=====================================================================
 LeetCode 584: Find Customer Referee (Easy)
=====================================================================
 Table: Customer
 +-------------+---------+
 | column_name | type    |
 +-------------+---------+
 | id          | int     |  -- primary key
 | name        | varchar |
 | referee_id  | int     |
 +-------------+---------+

 Problem: Find the names of customers who are NOT referred by
 the customer with id = 2.
=====================================================================
*/

SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;

-- Note: referee_id != 2 alone silently excludes NULL rows, because
-- comparisons against NULL evaluate to NULL/unknown, not TRUE.
-- You must explicitly add "OR referee_id IS NULL" to include customers
-- who were never referred by anyone.
