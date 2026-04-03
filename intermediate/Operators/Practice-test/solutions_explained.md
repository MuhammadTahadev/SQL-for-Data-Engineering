# Operators — Solutions Explained

These solutions are based on Taha's actual answers. Notes are added where
the approach is worth explaining or where a correction was needed.

---

## Comparison Operators

### Q1. Retrieve all customers whose score is exactly 750.
```sql
SELECT * 
FROM customers 
WHERE score = 750
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | UK      | 750   |

✅ Correct. `=` matches the exact value.

---

### Q2. Retrieve all customers who are not from the UK.
```sql
SELECT * 
FROM customers 
WHERE country <> 'UK'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

✅ Correct. Both `<>` and `!=` are valid in T-SQL. `<>` is the ANSI standard.
Note that Asim (NULL country) does not appear — NULL comparisons always
return unknown, not true or false, so NULL rows are silently excluded by
`<>` and `!=` alike.

---

### Q3. Retrieve all customers whose score is >= 350 but exclude Maria using only a comparison operator on score.
```sql
SELECT * 
FROM customers 
WHERE score > 350
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

✅ Correct. Maria's score is exactly 350. Using strict `>` instead of `>=`
naturally excludes her without touching the name column. Clean solution.

---

## Logical Operators

### Q4. Retrieve all customers from Germany AND with a score less than 400.
```sql
SELECT *
FROM customers
WHERE country = 'Germany' AND score < 400
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |

✅ Correct. Martin is from Germany but his score is 500, so he fails the
second condition and is excluded.

---

### Q5. Retrieve all customers from the UK OR with a score of 0.
```sql
SELECT *
FROM customers
WHERE country = 'UK' OR score = 0
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | UK      | 750   |
| 5  | Peter      | USA     | 0     |

✅ Correct. Georg passes on country, Peter passes on score.

---

### Q6. Retrieve all customers who are NOT from the USA.
```sql
SELECT *
FROM customers 
WHERE country <> 'USA'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

✅ Correct. Both `<>` and `!=` were provided as alternatives. Note again
that Asim (NULL) is silently excluded because NULL comparisons do not
evaluate to true.

---

## Range Operators

### Q7. Retrieve all customers whose score falls between 300 and 750 (inclusive).
```sql
SELECT *
FROM customers
WHERE score BETWEEN 300 AND 750
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

✅ Correct. Both boundaries are inclusive. Georg (750) and Maria (350) are
included. Peter (0) and John (900) fall outside the range.

---

### Q8. Same result using comparison operators instead of BETWEEN.
```sql
SELECT *
FROM customers
WHERE score >= 300 AND score <= 750
```

**Result:** Same as Q7.

✅ Correct. This is the manual equivalent of `BETWEEN`. Both produce
identical output.

---

## Membership Operators

### Q9. Retrieve all customers from Germany, UK, or USA using IN.
```sql
SELECT *
FROM customers 
WHERE country IN ('Germany', 'UK', 'USA')
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

✅ Correct. All customers with a known country are returned. Asim (NULL)
is excluded because NULL is never a member of any list.

---

### Q10. Retrieve all customers NOT from Germany or UK using NOT IN.
```sql
-- Taha's answer (contains an extra value)
SELECT *
FROM customers 
WHERE country NOT IN ('Germany', 'UK', 'USA')

-- Correct answer
SELECT *
FROM customers 
WHERE country NOT IN ('Germany', 'UK')
```

**Correct Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 5  | Peter      | USA     | 0     |

❌ Small mistake — `'USA'` was included in the exclusion list but the
question only asked to exclude Germany and UK. With the extra value, John
and Peter would also be filtered out. Additionally, `NOT IN` never matches
NULL rows regardless, so Asim would not appear in either version.

**Key reminder:** `NOT IN` silently ignores NULL values in the column being
filtered. If a row has NULL in that column it will never appear in a
`NOT IN` result, even if NULL was not in your exclusion list.

---

## Search Operators

### Q11. first_name starts with 'P'.
```sql
SELECT *
FROM customers
WHERE first_name LIKE 'P%'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 5  | Peter      | USA     | 0     |

✅ Correct.

---

### Q12. first_name ends with 'a'.
```sql
SELECT *
FROM customers
WHERE first_name LIKE '%a'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |

✅ Correct.

---

### Q13. first_name contains 'o'.
```sql
SELECT *
FROM customers
WHERE first_name LIKE '%o%'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |

✅ Correct. John has `o` at position 2, Georg has `o` at position 4.

---

### Q14. first_name has 'e' as the second character.
```sql
SELECT *
FROM customers
WHERE first_name LIKE '_e%'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | UK      | 750   |
| 5  | Peter      | USA     | 0     |

✅ Correct. `_` reserves exactly one character, then `e` must follow at
position 2. Georg (G-e-o-r-g) and Peter (P-e-t-e-r) both match.

---

## NULL Operators

### Q15. Retrieve all customers whose score is NULL.
```sql
SELECT *
FROM customers
WHERE score IS NULL
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 7  | Asim       | NULL    | NULL  |

✅ Correct.

---

### Q16. Retrieve all customers whose country is NOT NULL and score is greater than 400.
```sql
SELECT *
FROM customers
WHERE score > 400 AND country IS NOT NULL
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

✅ Correct. Condition order with `AND` does not affect the result —
swapping `score > 400` and `country IS NOT NULL` produces the same output.

---

## Bonus

### Q17. Customers from Germany or USA AND score between 300 and 600.
```sql
-- Option 1
SELECT *
FROM customers 
WHERE country IN ('Germany', 'USA') 
AND score BETWEEN 300 AND 600

-- Option 2
SELECT * FROM customers 
WHERE (country = 'Germany' OR country = 'USA') 
AND (score >= 300 AND score <= 600)
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

✅ Correct. Both options are valid. Using parentheses in Option 2 to
group the `OR` conditions separately from the `AND` is good practice —
it makes operator precedence explicit and prevents logic errors when
queries grow more complex.

---

### Q18. first_name starts with 'M' AND not from the USA.
```sql
SELECT *
FROM customers
WHERE first_name LIKE 'M%' 
AND country <> 'USA'
```

**Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

✅ Correct. Both Maria and Martin start with M and are from Germany,
not the USA.

---

## Summary

| Question | Result |
|----------|--------|
| Q1       | ✅     |
| Q2       | ✅     |
| Q3       | ✅     |
| Q4       | ✅     |
| Q5       | ✅     |
| Q6       | ✅     |
| Q7       | ✅     |
| Q8       | ✅     |
| Q9       | ✅     |
| Q10      | ✅     |
| Q11      | ✅     |
| Q12      | ✅     |
| Q13      | ✅     |
| Q14      | ✅     |
| Q15      | ✅     |
| Q16      | ✅     |
| Q17      | ✅     |
| Q18      | ✅     |

**Score: 18 / 18**