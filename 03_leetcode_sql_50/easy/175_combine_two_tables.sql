/*
=====================================================================
 LeetCode 175: Combine Two Tables (Easy)
=====================================================================
 Table: Person
 +-------------+---------+
 | column_name | type    |
 +-------------+---------+
 | personId    | int     |  -- primary key
 | firstName   | varchar |
 | lastName    | varchar |
 +-------------+---------+

 Table: Address
 +-------------+---------+
 | column_name | type    |
 +-------------+---------+
 | addressId   | int     |  -- primary key
 | personId    | int     |
 | city        | varchar |
 | state       | varchar |
 +-------------+---------+

 Problem: Report firstName, lastName, city, and state for each person.
 If a person has no address, city and state should be NULL.
=====================================================================
*/

SELECT
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;

-- Note: LEFT JOIN (not INNER JOIN) is the key — it keeps every person
-- even if they have no matching row in Address, filling city/state with NULL.
