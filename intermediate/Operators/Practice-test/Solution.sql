-- Comparison Operators

--Task 1. Retrieve all customers whose score is exactly 750.

SELECT * 
FROM customers 
WHERE score = 750

--Task 2. Retrieve all customers who are not from the UK.

SELECT * 
FROM customers 
WHERE country <> 'UK'

		--	OR --
SELECT * 
FROM customers 
WHERE country != 'UK'

/*
Task 3. Retrieve all customers whose score is greater than or equal to 350
but you must exclude Maria from the result using only a comparison operator
on the score column.
*/

SELECT * 
FROM customers 
WHERE score > 350

-- Logical Operators

/*
Task 4. Retrieve all customers who are from Germany AND have a score less
than 400.
*/

SELECT *
FROM customers
WHERE country = 'Germany' AND score < 400

/*
 Task 5. Retrieve all customers who are either from the UK OR have a score
of 0
*/

SELECT *
FROM customers
WHERE country = 'UK' OR score = 0

--Task 6. Retrieve all customers who are NOT from the USA.

SELECT *
FROM customers 
WHERE country <> 'USA'

	-- OR --

SELECT *
FROM customers 
WHERE country != 'USA'

-- Range Operators

/*
Task 7. Retrieve all customers whose score falls between 300 and 750
(boundaries inclusive).
*/


SELECT *
FROM customers
WHERE score BETWEEN 300 AND 750

/*
Task 8. Retrieve all customers whose score falls between 300 and 750 using
comparison operators instead of BETWEEN.
*/

SELECT *
FROM customers
WHERE score >= 300 AND score <= 750

-- Membership Operators

/*
Task 9. Retrieve all customers who are from Germany, UK, or USA using `IN`.
*/

SELECT *
FROM customers 
WHERE country IN ('Germany', 'UK', 'USA')

-- Task 10. Retrieve all customers who are NOT from Germany or UK using `NOT IN`.

SELECT *
FROM customers 
WHERE country NOT IN ('Germany', 'UK')

-- Search operators

-- Task 11. Retrieve all customers whose first_name starts with the letter 'P'.

SELECT *
FROM customers
WHERE first_name LIKE 'P%'

--Task 12. Retrieve all customers whose first_name ends with the letter 'a'.

SELECT *
FROM customers
WHERE first_name LIKE '%a'

--Task 13. Retrieve all customers whose first_name contains the letter 'o'.

SELECT *
FROM customers
WHERE first_name LIKE '%o%'

-- Task 14. Retrieve all customers whose first_name has 'e' as the second character.

SELECT *
FROM customers
WHERE first_name LIKE '_e%'

-- NULL Operators

--Task 15.  Retrieve all customers whose score is NULL.

SELECT *
FROM customers
WHERE score IS NULL

--Task 16. Retrieve all customers whose country is NOT NULL and whose score is greater than 400.

SELECT *
FROM customers
WHERE score > 400 AND country IS NOT NULL 

-- Bonus Questions

/*
Task 17.  Retrieve all customers who are from Germany or the USA AND have a
score between 300 and 600.
*/

SELECT *
FROM customers 
WHERE country IN ('Germany', 'USA') 
AND score BETWEEN 300 AND 600

	-- OR --

SELECT * FROM customers 
WHERE (country = 'Germany' OR country = 'USA') 
AND (score >= 300 AND score <= 600);

/*
Task 18. Retrieve all customers whose first_name starts with 'M' and who
are NOT from the USA.
*/

SELECT *
FROM customers
WHERE first_name LIKE 'M%' 
AND country <> 'USA' 

