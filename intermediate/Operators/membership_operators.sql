-- Membership Operators

-- Retrieve all customers from either Germany or USA
-- This Task can be solved in two ways

SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA'

SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')

-- Use IN instead of OR incase you have multiple values to simplify SQL

-- Retrieve all customers except from either Germany or USA

SELECT *
FROM customers
WHERE country != 'Germany' AND country != 'USA'

SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'USA')