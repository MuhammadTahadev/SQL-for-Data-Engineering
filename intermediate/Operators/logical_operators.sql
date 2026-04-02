-- Logical Operators

-- Retrieve all customers who are from the USA AND have a score greater then 500

SELECT *
FROM customers
WHERE country = 'USA'
AND score > 500
-- So in AND All conditions must be true for you to get a result

SELECT *
FROM customers
WHERE country = 'USA'
OR score > 500
-- Any row fulfilling any one of the condition will be displayed in the output

-- So what NOT operator does that it will exclude the matching values from the output
--NOT is different from AND and OR it is not used to combine two conditions
-- Retrieve all customers with a score NOT less then 500

SELECT *
FROM customers 
WHERE score >= 500
-- OR --

SELECT *
FROM customers
WHERE NOT score < 500


