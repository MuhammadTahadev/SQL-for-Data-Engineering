# Operators — Practice Questions

Use the following table for all questions:

**customers**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |
| 7  | Asim       | NULL    | NULL  |

---

## Comparison Operators

**Q1.** Retrieve all customers whose score is exactly 750.

**Q2.** Retrieve all customers who are not from the UK.

**Q3.** Retrieve all customers whose score is greater than or equal to 350
but you must exclude Maria from the result using only a comparison operator
on the score column.

---

## Logical Operators

**Q4.** Retrieve all customers who are from Germany AND have a score less
than 400.

**Q5.** Retrieve all customers who are either from the UK OR have a score
of 0.

**Q6.** Retrieve all customers who are NOT from the USA.

---

## Range Operators

**Q7.** Retrieve all customers whose score falls between 300 and 750
(boundaries inclusive).

**Q8.** Retrieve all customers whose score falls between 300 and 750 using
comparison operators instead of BETWEEN.

---

## Membership Operators

**Q9.** Retrieve all customers who are from Germany, UK, or USA using `IN`.

**Q10.** Retrieve all customers who are NOT from Germany or UK using `NOT IN`.

---

## Search Operators

**Q11.** Retrieve all customers whose first_name starts with the letter 'P'.

**Q12.** Retrieve all customers whose first_name ends with the letter 'a'.

**Q13.** Retrieve all customers whose first_name contains the letter 'o'.

**Q14.** Retrieve all customers whose first_name has 'e' as the second character.

---

## NULL Operators

**Q15.** Retrieve all customers whose score is NULL.

**Q16.** Retrieve all customers whose country is NOT NULL and whose score
is greater than 400.

---

## Mixed (Bonus)

**Q17.** Retrieve all customers who are from Germany or the USA AND have a
score between 300 and 600.

**Q18.** Retrieve all customers whose first_name starts with 'M' and who
are NOT from the USA.