-- NULL Operators

--they are used to find if there are any null values in a data set here is an example:

SELECT * FROM customers where country IS NULL

SELECT * FROM customers WHERE country IS NOT NULL

-- In case you don't have a row with null values you can always insert one for practice here i have added 1 for demonstration

INSERT into customers (id, first_name, country, score)
VALUES (7, 'Asim', NULL, NULL)