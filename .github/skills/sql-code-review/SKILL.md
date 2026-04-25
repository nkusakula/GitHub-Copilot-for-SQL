---
name: sql-code-review
description: 'Universal SQL code review assistant that performs comprehensive security, maintainability, and code quality analysis across all SQL databases (MySQL, PostgreSQL, SQL Server, Oracle). Focuses on SQL injection prevention, access control, code standards, and anti-pattern detection.'
---

# SQL Code Review

Perform a thorough SQL code review of the selected code (or entire file if no selection) focusing on security, performance, maintainability, and database best practices.

## 🔒 Security Analysis

### SQL Injection Prevention
- Check for dynamic SQL construction with string concatenation
- Verify all user inputs are parameterized
- Look for `EXEC` / `sp_executesql` usage and validate it is safe

### Access Control & Permissions
- **Principle of Least Privilege**: Grant minimum required permissions
- **Role-Based Access**: Use database roles instead of direct user permissions
- **Schema Security**: Proper schema ownership and access controls

### Data Protection
- **Sensitive Data Exposure**: Avoid `SELECT *` on tables with sensitive columns
- **Audit Logging**: Ensure sensitive operations are logged
- **Encryption**: Verify encrypted storage for sensitive data

## ⚡ Performance Analysis

### Query Structure
- Identify `SELECT *` anti-patterns
- Check for functions in `WHERE` clauses that prevent index usage
- Detect correlated subqueries that could be rewritten as JOINs
- Identify missing `TOP` or row-limiting clauses on large tables

### Index Strategy
- Missing indexes on frequently filtered columns
- Over-indexing detection
- Composite index column order review

### Join Optimization
- Verify appropriate join types (`INNER` vs `LEFT` vs `EXISTS`)
- Identify Cartesian products from missing join conditions
- Subquery vs JOIN efficiency

## 🛠️ Code Quality

### SQL Style & Formatting
- UPPERCASE keywords
- Consistent indentation
- Meaningful aliases and column names
- Schema-qualified object names

### Naming Conventions
- Tables, columns, and constraints follow consistent patterns
- Stored procedures use `usp_<Action><Entity>` convention
- Avoid reserved words as identifiers

### Schema Design
- Appropriate normalization level
- Proper use of `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `NOT NULL`
- Optimal data type choices

## 📋 SQL Review Checklist

### Security
- [ ] All user inputs are parameterized
- [ ] No dynamic SQL with string concatenation
- [ ] Appropriate access controls and permissions
- [ ] Sensitive data is properly protected

### Performance
- [ ] No unnecessary `SELECT *`
- [ ] JOINs are optimized and use explicit types
- [ ] `WHERE` clauses are selective and use indexes
- [ ] Large-table queries include `TOP` or date filter

### Code Quality
- [ ] Consistent naming conventions
- [ ] Schema-qualified object names
- [ ] Header comment block present (for procs/views/functions)
- [ ] Appropriate data types
- [ ] Error handling implemented

## 🎯 Review Output Format

For each issue found:
```
[PRIORITY] [CATEGORY]: Brief Description
Location: <object name / line number>
Issue: <detailed explanation>
Recommendation: <specific fix with before/after code example>
Expected Improvement: <security benefit / performance gain>
```

Summary scores (1-10): **Security** | **Performance** | **Maintainability** | **Schema Quality**

Top 3 Priority Actions:
1. [Critical]: ...
2. [High]: ...
3. [Medium]: ...
