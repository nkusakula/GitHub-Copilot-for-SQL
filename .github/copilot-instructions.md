# Copilot Instructions

## Persona
- I am an experienced SQL Server developer working with production AdventureWorks data.
- Use a concise, professional tone. Explain your reasoning briefly.
- When multiple approaches exist, mention the tradeoffs.

## Safety and Execution Guardrails
- Treat this as a production database unless I explicitly say otherwise.
- For queries that could scan large tables, always add a `TOP 100` or date range
  filter first, and offer the full version separately.
- Never generate `DROP`, `TRUNCATE`, or `DELETE` without an explicit `WHERE` clause.
- Always warn before suggesting schema modifications.

## Code Style
- Always schema-qualify object names (e.g., `SalesLT.Customer`, not `Customer`).
- Use `INNER JOIN` / `LEFT JOIN` syntax — never implicit comma joins.
- Place each `JOIN` condition on its own line with `ON` on a new line.
- Always alias tables with short, readable abbreviations:
  - `c` for `Customer`
  - `soh` for `SalesOrderHeader`
  - `sod` for `SalesOrderDetail`
  - `p` for `Product`
  - `pc` for `ProductCategory`
  - `pm` for `ProductModel`
  - `a` for `Address`
- Always qualify every column reference with its table alias.
- Use UPPERCASE for all T-SQL keywords (`SELECT`, `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`).
- Never use `SELECT *` — always list column names explicitly.
- Use tabs for indentation.
- Align column aliases with `AS` for readability.

## Business Rules
- Revenue is defined as `SUM(LineTotal)` from `SalesLT.SalesOrderDetail`
  filtered to orders where `SalesLT.SalesOrderHeader.Status = 5` (Shipped).
- `SalesOrderHeader.Status` encoding:
  - 1 = In Process, 2 = Approved, 3 = Backordered
  - 4 = Rejected, 5 = Shipped, 6 = Cancelled
- Customer full name is `FirstName + ' ' + LastName`.
- `CompanyName` is the B2B account name on the `Customer` table.

## Naming Conventions
- Tables: PascalCase singular (`Customer`, `Product`)
- Stored procedures: `usp_<Action><Entity>` (e.g., `usp_GetCustomerOrders`)
- Views: `v_<Description>` (e.g., `v_CustomerRevenueSummary`)
- Functions: `fn_<Description>` (e.g., `fn_GetOrderTotal`)
- Temp tables: `#<PascalCase>` (e.g., `#TopCustomers`)
- Indexes: `IX_<Table>_<Columns>`

## Documentation
- Add inline comments for any non-obvious JOIN condition or business filter.
- For all stored procedures, views, and functions, include a header comment block:

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
