-- Search Operators

-- Like will Search for a Pattern in a text

/*
There are two pattern exact(_) and anything(%) 
So if i say like M% this means that the first character must be M and the remaining can be anything
Another example is %in this means the first characters can be anything but the last characters must be in
Another one is %r% what this means is doesn't matter what other characters are as long as there is an r that word is acceptable be it Martin or Peter

Now for _:
if i have a patter like this: __b%:
what this means is that at the first two __ there is something and then b is a must only after those two characters and after b there can be anything
if we give them numbers then lets say 1._, 2._, 3.b,4.% meaning b must only appear as the third character of a word. like Robert or Albert
*/

-- Find all customers whose first_name starts with an 'M'

SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first_name ends with an 'n'

SELECT *
FROM customers
WHERE first_name LIKE '%n'

-- Find all customers whose first_name contains an 'r'

SELECT *
FROM customers
WHERE first_name LIKE '%r%'

-- Find all customers whose first_name has 'r' in the third position

SELECT *
FROM customers
WHERE first_name LIKE '__r%'