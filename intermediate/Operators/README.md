# Operators — Explanation & Breakdown

This file documents all query files inside the `operators/` folder.
Each section covers one `.sql` file with a full breakdown, expected results,
and a key takeaway.

Reference table used throughout this module:

**customers**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

---

## 1. comparison_operators.sql

### Query 1 — Retrieve all customers from Germany
```sql
SELECT *
FROM customers
WHERE country = 'Germany'
```

**Breakdown:**
- `SELECT *` returns all columns for matching rows.
- `WHERE country = 'Germany'` uses the `=` operator to match only rows where the `country` column value is exactly `'Germany'`. String comparisons in T-SQL are case-insensitive by default.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

---

### Query 2 — Retrieve all customers who are not from Germany
```sql
SELECT *
FROM customers
WHERE country != 'Germany'
```

**Breakdown:**
- `!=` is the "not equal to" operator. In T-SQL you can also write this as `<>` — both work identically.
- Returns every row where `country` does not match `'Germany'`.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 5  | Peter      | USA     | 0     |

---

### Query 3 — Retrieve all customers with a score greater than 500
```sql
SELECT *
FROM customers
WHERE score > 500
```

**Breakdown:**
- `>` is the "greater than" operator. It is a strict comparison — rows where `score` is exactly `500` are excluded.
- Only rows with a score strictly above 500 are returned.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |

> Martin (score = 500) is excluded because 500 is not greater than 500.

---

### Query 4 — Retrieve all customers with a score of 500 or more
```sql
SELECT *
FROM customers
WHERE score >= 500
```

**Breakdown:**
- `>=` is the "greater than or equal to" operator. Unlike `>`, this is inclusive — rows where `score` equals exactly `500` are also returned.
- This is a common adjustment when boundary values need to be included.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

> Martin (score = 500) is now included because 500 >= 500 is true.

---

### Query 5 — Retrieve all customers with a score less than 500
```sql
SELECT *
FROM customers
WHERE score < 500
```

**Breakdown:**
- `<` is the "less than" operator. Again strict — rows where `score` equals exactly `500` are excluded.
- Returns only rows where the score falls strictly below 500.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 5  | Peter      | USA     | 0     |

---

### Query 6 — Retrieve all customers with a score of 500 or less
```sql
SELECT *
FROM customers
WHERE score <= 500
```

**Breakdown:**
- `<=` is the "less than or equal to" operator. Inclusive version of `<`.
- Returns all rows where score is 500 or below, including the boundary value.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

> Martin (score = 500) is included because 500 <= 500 is true.

---

### Key Takeaway

Comparison operators let you filter rows based on exact values, inequalities,
and boundaries. The critical distinction to always keep in mind is:

| Operator | Boundary value included? |
|----------|--------------------------|
| `>`      | No                       |
| `>=`     | Yes                      |
| `<`      | No                       |
| `<=`     | Yes                      |

In Data Engineering this matters when filtering date ranges, score thresholds,
price bands, or any numeric boundary where off-by-one errors can silently
drop or duplicate records in a pipeline.

Also note: `!=` and `<>` are interchangeable in T-SQL. Most teams standardize
on one — `<>` is the ANSI SQL standard and slightly more portable across
database engines.

---