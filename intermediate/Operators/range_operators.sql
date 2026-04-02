/*
Between is used to check the Range for that you need two things 
the Lower Boundry and the Upper Boundry. Once you have two boundries 
You have a range and everything BETWEEN those two boundries
is going to be true and everything outside those boundries is
Going to be False

One more thing the boundries are inclusive
*/

--Retrieve all customers whose score falls in the range between 100 and 500

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500

-- You can also use an alternative way to get the same data 

SELECT *
FROM customers
WHERE score >= 100 AND score <= 500