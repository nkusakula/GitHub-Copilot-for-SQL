---
description: 'Guidelines for generating SQL statements and stored procedures'
applyTo: '**/*.sql'
---

# SQL Development

## Database Schema Design
- All tables should have a primary key constraint
- All foreign key constraints should have a name and be defined inline
- All foreign key constraints should have `ON DELETE CASCADE` and `ON UPDATE CASCADE`
- All foreign key constraints should reference the primary key of the parent table

## SQL Coding Style
- Use UPPERCASE for SQL keywords (`SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`)
- Use consistent indentation (tabs) for nested queries and conditions
- Include comments to explain complex logic
- Break long queries into multiple lines for readability
- Organize clauses consistently: SELECT, FROM, JOIN, WHERE, GROUP BY, HAVING, ORDER BY

## SQL Query Structure
- Use explicit column names in SELECT statements — never `SELECT *`
- Always schema-qualify object names (e.g., `SalesLT.Customer`, not `Customer`)
- Always qualify column names with a table alias when using multiple tables
- Use `INNER JOIN` / `LEFT JOIN` syntax — never implicit comma joins
- Place each JOIN condition on its own line with `ON` on a new line
- Limit result sets with `TOP` or `WHERE` filters for large-table queries
- Avoid using functions on indexed columns in `WHERE` clauses

## Stored Procedure Naming Conventions
- Prefix stored procedure names with `usp_`
- Use PascalCase for stored procedure names
- Use descriptive names that indicate purpose (e.g., `usp_GetCustomerOrders`)

## Parameter Handling
- Prefix parameters with `@`
- Provide default values for optional parameters
- Validate parameter values before use
- Document parameters with inline comments
- Arrange parameters: required first, optional later

## Stored Procedure Structure
- Include `SET NOCOUNT ON` at the start
- Include a header comment block:

```sql
-- =============================================================================
-- Object: <Type>: <Name>
-- Author: <Name>
-- Date: <YYYY-MM-DD>
-- Description: <What it does>
-- Parameters: <If applicable>
-- Change History:
--   <YYYY-MM-DD>  <Author>  <What changed>
-- =============================================================================
```

## SQL Security Best Practices
- Parameterize all queries to prevent SQL injection
- Use prepared statements when executing dynamic SQL
- Avoid embedding credentials in SQL scripts
- Implement proper error handling without exposing system details
- Avoid dynamic SQL string concatenation within stored procedures

## Transaction Management
- Explicitly begin and commit transactions
- Use appropriate isolation levels
- Avoid long-running transactions that lock tables
- Use batch processing for large data operations
- Include `SET NOCOUNT ON` for stored procedures that modify data
