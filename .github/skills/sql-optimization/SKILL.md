---
name: sql-optimization
description: 'Universal SQL performance optimization assistant for comprehensive query tuning, indexing strategies, and database performance analysis across all SQL databases (MySQL, PostgreSQL, SQL Server, Oracle).'
---

# SQL Performance Optimization

Perform comprehensive SQL performance optimization analysis on the selected code (or entire file if no selection).

## 🎯 Core Optimization Areas

### Query Performance Analysis
- Identify inefficient query patterns (`SELECT *`, functions in `WHERE`, implicit joins)
- Detect correlated subqueries that should be rewritten using JOINs or CTEs
- Review `ORDER BY` and `GROUP BY` for index alignment
- Check for sargable vs non-sargable predicates

### Index Strategy
- Missing indexes on frequently filtered/joined columns
- Composite index column order (most selective first)
- Covering index opportunities (`INCLUDE` columns)
- Partial indexes for filtered result sets
- Over-indexing detection (impacts INSERT/UPDATE performance)

### Subquery Optimization
- Correlated subquery → CTE or window function
- `IN` subquery → `EXISTS` or JOIN (whichever is faster)
- Nested subqueries → CTEs for readability and optimizer hints

## 📊 Performance Tuning Techniques

### JOIN Optimization
- Verify appropriate join types and order
- Filter early — push `WHERE` conditions into JOINs
- Replace `LEFT JOIN` with `INNER JOIN` where NULLs are not needed

### Aggregation Optimization
- Consolidate multiple `COUNT` queries into one with conditional aggregation
- Replace correlated aggregates with window functions

### Pagination
- Replace `OFFSET`-based pagination with cursor/keyset pagination for large tables

## 🔍 SQL Server-Specific Checks

### Parameter Sniffing
- Detect optional `NULL` parameter patterns that cause plan instability
- Recommend `OPTION (RECOMPILE)` or local variable workaround where needed

### Statistics & Execution Plans
- Flag queries that would benefit from `UPDATE STATISTICS`
- Suggest reviewing the actual execution plan for key lookups and scans

### T-SQL Best Practices
- `SET NOCOUNT ON` in stored procedures
- Avoid `NOLOCK` hints unless explicitly justified
- Use `DATEADD`/date ranges instead of `YEAR()`/`MONTH()` functions in `WHERE`

## 🎯 Universal Optimization Checklist

- [ ] No `SELECT *` in production queries
- [ ] Appropriate JOIN types used
- [ ] WHERE clauses are sargable (no functions on indexed columns)
- [ ] Indexes exist for frequently queried/filtered columns
- [ ] Covering indexes used where beneficial
- [ ] Large result sets use `TOP` or pagination
- [ ] Batch operations used for bulk data changes
- [ ] Execution plan reviewed for scans, lookups, and spills
- [ ] Parameter sniffing risk assessed for stored procedures with optional params

## 📝 Optimization Methodology

1. **Identify**: Find the bottleneck (slow query, missing index, scan vs seek)
2. **Analyze**: Examine the execution plan
3. **Optimize**: Apply the appropriate technique
4. **Test**: Verify improvement with realistic data volumes
5. **Monitor**: Track performance over time

Focus on measurable, testable improvements. Always include before/after code examples with expected performance gains.
