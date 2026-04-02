# Intermediate SQL — Data Engineering

This section builds on the basics and focuses on writing more precise,
expressive, and powerful queries. The emphasis here is on filtering data
intelligently using operators and conditions — skills that are used constantly
in real Data Engineering pipelines for cleaning, transforming, and validating data.

---

## What You Will Learn

### 1. Operators & Filtering
Operators are the building blocks of every WHERE clause. This module covers
all major operator types used in T-SQL to filter, match, and narrow down data.

| Operator Type        | Keywords / Syntax                        |
|----------------------|------------------------------------------|
| Comparison Operators | `=`, `!=`, `<>`, `>`, `<`, `>=`, `<=`   |
| Logical Operators    | `AND`, `OR`, `NOT`                       |
| Range Operators      | `BETWEEN ... AND ...`                    |
| Membership Operators | `IN`, `NOT IN`                           |
| Search Operators     | `LIKE`, `NOT LIKE`, Wildcards (`%`, `_`) |
| NULL Operators       | `IS NULL`, `IS NOT NULL`                 |

> All of these operators work together with `WHERE` and `HAVING` clauses
> to filter rows at different stages of a query.

---

## Folder Structure
```
intermediate/
├── operators/
│   ├── comparison_operators.sql
│   ├── logical_operators.sql
│   ├── range_operators.sql
│   ├── membership_operators.sql
│   ├── search_operators.sql
│   ├── null_operators.sql
│   ├── EXPLANATION.md
│   └── practice/
│       ├── questions.md
│       ├── solutions.sql
│       └── solutions_explained.md
├── [more topics coming soon...]
└── README.md
```

---

## Why This Matters for Data Engineering

In Data Engineering, raw data is rarely clean or complete. You will constantly
use these operators to:

- Filter out NULL or missing values before loading into a warehouse
- Validate data ranges (e.g. dates, prices, quantities)
- Match patterns in messy string columns (e.g. email formats, codes)
- Build conditional logic inside transformation queries and stored procedures

---

## Tools & Environment

- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Transact-SQL)
- **Client:** SQL Server Management Studio (SSMS)

---

## Progress

| Topic              | Status         |
|--------------------|----------------|
| Operators          | 🔄 In Progress |
