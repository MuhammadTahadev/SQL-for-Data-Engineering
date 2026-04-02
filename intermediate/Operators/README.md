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

## 2. logical_operators.sql

### Query 1 — Retrieve all customers from the USA AND with a score greater than 500
```sql
SELECT *
FROM customers
WHERE country = 'USA'
AND score > 500
```

**Breakdown:**
- `AND` combines two conditions. A row is only returned if **both** conditions are true at the same time.
- `country = 'USA'` must be true **and** `score > 500` must also be true.
- If either condition fails for a row, that row is excluded.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |

> Peter is from the USA but his score is 0, so he fails the second condition and is excluded.

---

### Query 2 — Retrieve all customers from the USA OR with a score greater than 500
```sql
SELECT *
FROM customers
WHERE country = 'USA'
OR score > 500
```

**Breakdown:**
- `OR` combines two conditions. A row is returned if **at least one** condition is true.
- A row only gets excluded if it fails **both** conditions simultaneously.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 5  | Peter      | USA     | 0     |

> Georg is not from the USA but his score is 750 > 500, so he passes on the second condition.
> Peter's score is 0 but he is from the USA, so he passes on the first condition.
> Maria and Martin are from Germany with scores below 500 — they fail both conditions and are excluded.

---

### Query 3 — Retrieve all customers with a score NOT less than 500
```sql
-- Option 1
SELECT *
FROM customers
WHERE score >= 500

-- Option 2
SELECT *
FROM customers
WHERE NOT score < 500
```

**Breakdown:**
- `NOT` inverts a single condition. It does not combine two conditions like `AND` and `OR` do — it simply flips the result of whatever condition follows it.
- `NOT score < 500` means: exclude any row where score is less than 500. What remains are all rows where score is 500 or above.
- Both options produce identical results. Option 1 is the cleaner and more readable approach. Option 2 demonstrates how `NOT` works as a logical flip.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |

---

### Key Takeaway

The three logical operators each serve a distinct purpose:

| Operator | Behavior                                          |
|----------|---------------------------------------------------|
| `AND`    | All conditions must be true — stricter filter     |
| `OR`     | At least one condition must be true — wider net   |
| `NOT`    | Inverts a single condition — flips true and false |

A practical rule of thumb: `AND` shrinks your result set, `OR` expands it.
`NOT` is not a combining operator — it wraps around one condition to negate it.

In Data Engineering, logical operators are used heavily inside transformation
queries to route, exclude, or flag records based on multiple business rules
at once. Combining them correctly — especially `AND` with `OR` using
parentheses to control precedence — is a skill that prevents subtle data
bugs in pipelines.

---

## 3. range_operators.sql

### Query 1 — Retrieve all customers whose score falls between 100 and 500
```sql
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500
```

**Breakdown:**
- `BETWEEN` checks whether a value falls within a defined range.
- It requires two boundaries — a lower boundary and an upper boundary — written as `BETWEEN lower AND upper`.
- **Both boundaries are inclusive**, meaning rows where score equals exactly `100` or exactly `500` are included in the result.
- Any value outside the range on either side evaluates to false and that row is excluded.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

> Peter (score = 0) is below the lower boundary of 100 so he is excluded.
> John (score = 900) and Georg (score = 750) are above the upper boundary of 500 so they are excluded.
> Martin (score = 500) is included because the upper boundary is inclusive.

---

### Query 2 — Equivalent query using comparison operators
```sql
SELECT *
FROM customers
WHERE score >= 100 AND score <= 500
```

**Breakdown:**
- This produces the exact same result as `BETWEEN`. It manually replicates the inclusive boundaries using `>=` and `<=` combined with `AND`.
- `BETWEEN` is essentially shorthand for this pattern.
- Both approaches are valid. `BETWEEN` is preferred when you want cleaner, more readable SQL — especially useful when working with date ranges in Data Engineering.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

---

### Key Takeaway

`BETWEEN` is a range operator that filters rows falling within two inclusive
boundaries. The word inclusive is the most important detail — beginners often
assume `BETWEEN` works like a strict `>` and `<`, which leads to boundary
rows being unexpectedly included or excluded.

Always remember:
```
BETWEEN 100 AND 500  =  >= 100 AND <= 500
```

In Data Engineering, `BETWEEN` is used most frequently with date ranges — for
example filtering records created within a specific month or quarter. Getting
the boundary behaviour right is critical because an off-by-one day error in
a date filter can silently miscount millions of records in a pipeline.

---

## 4. membership_operators.sql

### Query 1 — Retrieve all customers from Germany or USA
```sql
-- Option 1
SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA'

-- Option 2
SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')
```

**Breakdown:**
- Both options produce identical results.
- Option 1 uses `OR` to chain multiple equality checks — readable with two values but gets messy fast as the list grows.
- Option 2 uses `IN`, which checks whether the column value is a member of a provided list of values written inside parentheses.
- `IN` is essentially a cleaner shorthand for chaining multiple `OR` conditions on the same column.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

> Georg (UK) is the only customer excluded since UK is not in the list.

---

### Query 2 — Retrieve all customers except from Germany or USA
```sql
-- Option 1
SELECT *
FROM customers
WHERE country != 'Germany' AND country != 'USA'

-- Option 2
SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'USA')
```

**Breakdown:**
- `NOT IN` is the inverse of `IN` — it excludes any row where the column value matches anything in the list.
- Option 1 uses `!=` with `AND` to manually exclude each value. Notice that exclusion requires `AND` not `OR` — a row must be not Germany **and** not USA simultaneously to be excluded from both.
- Option 2 with `NOT IN` handles this logic automatically and is far cleaner.
- A common beginner mistake is writing `!=` conditions with `OR` instead of `AND`, which returns everything because no single row can be both Germany and USA at the same time.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 3  | Georg      | UK      | 750   |

> Georg is the only customer whose country does not appear in the exclusion list.

---

### Key Takeaway

`IN` and `NOT IN` are membership operators that check whether a value belongs
to a defined list. The practical rule is simple:

| Situation                        | Use this         |
|----------------------------------|------------------|
| Matching 1 value                 | `=`              |
| Matching 2+ values, same column  | `IN`             |
| Excluding 1 value                | `!=` or `<>`     |
| Excluding 2+ values, same column | `NOT IN`         |

Also note the `AND` vs `OR` distinction when excluding manually:
- Including multiple values → `OR` (`country = 'Germany' OR country = 'USA'`)
- Excluding multiple values → `AND` (`country != 'Germany' AND country != 'USA'`)

This is one of the most common sources of logic errors in SQL filtering.
`NOT IN` sidesteps the confusion entirely, which is why it is preferred.

In Data Engineering, `IN` is frequently used to filter records by a known
set of category values, status codes, or region identifiers — making queries
both cleaner and easier to maintain when the list needs updating.

---

## 5. search_operators.sql

### How LIKE Works

`LIKE` searches for a pattern inside a text column rather than matching an
exact value. It uses two wildcard characters to build patterns:

| Wildcard | Meaning                              |
|----------|--------------------------------------|
| `%`      | Any sequence of zero or more characters |
| `_`      | Exactly one character, any character |

You combine these with literal characters to define what the pattern must look like.

---

### Query 1 — Find all customers whose first_name starts with 'M'
```sql
SELECT *
FROM customers
WHERE first_name LIKE 'M%'
```

**Breakdown:**
- `'M%'` means the first character must be `M` and anything can follow after it — zero or more characters.
- Only the starting character is fixed. The rest of the name does not matter.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

---

### Query 2 — Find all customers whose first_name ends with 'n'
```sql
SELECT *
FROM customers
WHERE first_name LIKE '%n'
```

**Breakdown:**
- `'%n'` means anything can come before, but the last character must be `n`.
- The `%` at the start absorbs all characters before the final `n`.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 4  | Martin     | Germany | 500   |

---

### Query 3 — Find all customers whose first_name contains 'r'
```sql
SELECT *
FROM customers
WHERE first_name LIKE '%r%'
```

**Breakdown:**
- `'%r%'` means anything can appear before or after, as long as an `r` exists somewhere in the value.
- The `r` can be at any position — first, last, or anywhere in the middle.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 5  | Peter      | USA     | 0     |

> Maria contains `r` at position 4. Peter contains `r` at position 3.
> Martin also has an `r` but it appears as the second character — wait, let's
> check: M-a-r-t-i-n. Yes, Martin contains `r` at position 3 as well.

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

---

### Query 4 — Find all customers whose first_name has 'r' in the third position
```sql
SELECT *
FROM customers
WHERE first_name LIKE '__r%'
```

**Breakdown:**
- `'__r%'` breaks down position by position:
  - Position 1: `_` — exactly one character, anything
  - Position 2: `_` — exactly one character, anything
  - Position 3: `r` — must be the literal character `r`
  - Position 4+: `%` — anything can follow or nothing at all
- Only names where `r` appears specifically as the third character will match.

Checking each name against the pattern:

| first_name | Position 1 | Position 2 | Position 3 | Match? |
|------------|------------|------------|------------|--------|
| Maria      | M          | a          | r          | ✅ Yes |
| John       | J          | o          | h          | ❌ No  |
| Georg      | G          | e          | o          | ❌ No  |
| Martin     | M          | a          | r          | ✅ Yes |
| Peter      | P          | e          | t          | ❌ No  |

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 4  | Martin     | Germany | 500   |

---

### Key Takeaway

`LIKE` is a search operator that matches patterns in text rather than exact
values. The two wildcards serve completely different purposes:

- `%` is flexible — it absorbs any number of characters including none
- `_` is strict — it reserves exactly one character position

They can be combined in any order to describe exactly where a character or
sequence must appear within a value.

In Data Engineering, `LIKE` is used heavily during data cleaning and
validation — for example finding malformed email addresses, filtering product
codes that follow a naming convention, or identifying records where a field
starts with an unexpected prefix. It is powerful but can be slow on very
large tables without proper indexing, so in production pipelines it is used
carefully.

---

## 6. null_operators.sql

### What is NULL?

NULL in SQL means the absence of a value — it is not zero, not an empty
string, and not a space. It simply means the data is unknown or missing.
Because of this, NULL cannot be compared using regular operators like `=`
or `!=`. You cannot write `WHERE country = NULL` — it will never return
results. Instead, T-SQL provides `IS NULL` and `IS NOT NULL` specifically
for this purpose.

---

### Setup — Inserting a NULL row for practice
```sql
INSERT INTO customers (id, first_name, country, score)
VALUES (7, 'Asim', NULL, NULL)
```

**Breakdown:**
- This inserts a new row where both `country` and `score` have no value — they are explicitly set to `NULL`.
- This is a common practice when learning or testing NULL behaviour since real datasets may not always have missing values available.

**Updated customers table after insert:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |
| 7  | Asim       | NULL    | NULL  |

---

### Query 1 — Find all customers with no country value
```sql
SELECT *
FROM customers
WHERE country IS NULL
```

**Breakdown:**
- `IS NULL` checks whether a column contains no value at all.
- This is the only correct way to filter for missing values in SQL. Using `= NULL` does not work because NULL is not equal to anything — not even itself.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 7  | Asim       | NULL    | NULL  |

---

### Query 2 — Find all customers who have a country value
```sql
SELECT *
FROM customers
WHERE country IS NOT NULL
```

**Breakdown:**
- `IS NOT NULL` is the inverse — it returns only rows where the column actually contains a value.
- This is commonly used at the start of a transformation query to exclude incomplete records before processing.

**Expected Result:**

| id | first_name | country | score |
|----|------------|---------|-------|
| 1  | Maria      | Germany | 350   |
| 2  | John       | USA     | 900   |
| 3  | Georg      | UK      | 750   |
| 4  | Martin     | Germany | 500   |
| 5  | Peter      | USA     | 0     |

> Asim is excluded because his country value is NULL.

---

### Key Takeaway

NULL represents missing or unknown data — not zero, not blank, not false.
This distinction matters enormously in SQL because:

| What you might try  | Does it work? | Why                          |
|---------------------|---------------|------------------------------|
| `= NULL`            | ❌ No         | NULL is not equal to anything |
| `!= NULL`           | ❌ No         | NULL cannot be compared       |
| `IS NULL`           | ✅ Yes        | Correct way to check for NULL |
| `IS NOT NULL`       | ✅ Yes        | Correct way to exclude NULL   |

In Data Engineering, NULL handling is one of the most critical skills.
Raw data from source systems almost always contains missing values. Before
loading data into a warehouse or running aggregations, you need to identify,
filter, or replace NULLs — otherwise they silently propagate through
calculations. For example, `AVG(score)` ignores NULLs automatically in SQL,
but `SUM(score) / COUNT(*)` does not — that kind of inconsistency can corrupt
metrics in a pipeline if NULL rows are not handled explicitly beforehand.

---