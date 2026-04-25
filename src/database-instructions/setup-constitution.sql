-- =============================================================================
-- Script:      Setup Database Constitution for GitHub Copilot
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Installs a database-wide CONSTITUTION.md extended property.
--              The constitution is the highest-precedence instruction applied
--              by GitHub Copilot in SSMS for all users of this database.
-- Database:    adventure_works
-- Note:        Only one CONSTITUTION.md can exist per database.
--              Use sp_updateextendedproperty to modify an existing one.
-- Requires:    SSMS 22.3+, GitHub Copilot with Copilot access
-- =============================================================================

IF NOT EXISTS (
    SELECT 1
    FROM sys.extended_properties
    WHERE name  = N'CONSTITUTION.md'
      AND class = 0   -- Database-level property
)
BEGIN
    EXECUTE sp_addextendedproperty
        @name  = N'CONSTITUTION.md',
        @value = N'All T-SQL generated for this database must comply with the following standards:
1. Always schema-qualify object names (e.g., SalesLT.Customer, not just Customer).
2. Never use SELECT * - always list column names explicitly.
3. Always alias tables and qualify every column reference with its alias.
4. Queries that could scan large tables must include a TOP clause, date range filter, or indexed key predicate.
5. JOIN conditions must use explicit INNER JOIN / LEFT JOIN syntax - never implicit comma joins.
6. Revenue = SUM(LineTotal) from SalesLT.SalesOrderDetail filtered to SalesOrderHeader.Status = 5 (Shipped) only.';

    PRINT 'Database constitution created successfully.';
END
ELSE
BEGIN
    PRINT 'Constitution already exists. To update it, run:';
    PRINT 'EXECUTE sp_updateextendedproperty @name = N''CONSTITUTION.md'', @value = N''<new text>''';
END
GO
