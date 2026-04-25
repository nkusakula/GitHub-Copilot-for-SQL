-- =============================================================================
-- Script:      Setup Database Instructions for GitHub Copilot
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Installs business rule instructions as AGENTS.md extended
--              properties on database objects. These are automatically read
--              by GitHub Copilot in SSMS and applied to all user interactions.
--              Run once per database to establish Copilot context.
-- Database:    adventure_works
-- Requires:    SSMS 22.3+, GitHub Copilot with Copilot access
-- =============================================================================

PRINT '------------------------------------------------------------';
PRINT 'Installing GitHub Copilot database instructions...';
PRINT '------------------------------------------------------------';
GO

-- ----------------------------------------------------------------------------
-- Table: SalesLT.SalesOrderDetail
-- Instruction: Revenue definition
-- ----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM sys.extended_properties ep
    INNER JOIN sys.tables t  ON ep.major_id = t.object_id
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE ep.name    = N'AGENTS.md'
      AND s.name     = N'SalesLT'
      AND t.name     = N'SalesOrderDetail'
      AND ep.minor_id = 0
)
BEGIN
    EXECUTE sp_addextendedproperty
        @name       = N'AGENTS.md',
        @value      = N'Revenue is defined as SUM(LineTotal) only for orders where the parent SalesOrderHeader.Status = 5 (Shipped). Always exclude orders with Status <> 5 from revenue calculations.',
        @level0type = N'SCHEMA', @level0name = N'SalesLT',
        @level1type = N'TABLE',  @level1name = N'SalesOrderDetail';
    PRINT 'Instruction added: SalesLT.SalesOrderDetail';
END
ELSE
    PRINT 'Instruction already exists: SalesLT.SalesOrderDetail';
GO

-- ----------------------------------------------------------------------------
-- Column: SalesLT.SalesOrderHeader.Status
-- Instruction: Status code encoding
-- ----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM sys.extended_properties ep
    INNER JOIN sys.tables t   ON ep.major_id = t.object_id
    INNER JOIN sys.schemas s  ON t.schema_id = s.schema_id
    INNER JOIN sys.columns c  ON ep.major_id = c.object_id AND ep.minor_id = c.column_id
    WHERE ep.name = N'AGENTS.md'
      AND s.name  = N'SalesLT'
      AND t.name  = N'SalesOrderHeader'
      AND c.name  = N'Status'
)
BEGIN
    EXECUTE sp_addextendedproperty
        @name       = N'AGENTS.md',
        @value      = N'Status column encoding: 1=In Process, 2=Approved, 3=Backordered, 4=Rejected, 5=Shipped, 6=Cancelled. Use Status = 5 to filter for completed/shipped orders in revenue and fulfillment queries.',
        @level0type = N'SCHEMA', @level0name = N'SalesLT',
        @level1type = N'TABLE',  @level1name = N'SalesOrderHeader',
        @level2type = N'COLUMN', @level2name = N'Status';
    PRINT 'Instruction added: SalesLT.SalesOrderHeader.Status';
END
ELSE
    PRINT 'Instruction already exists: SalesLT.SalesOrderHeader.Status';
GO

-- ----------------------------------------------------------------------------
-- Table: SalesLT.Customer
-- Instruction: Customer data conventions
-- ----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM sys.extended_properties ep
    INNER JOIN sys.tables t  ON ep.major_id = t.object_id
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE ep.name    = N'AGENTS.md'
      AND s.name     = N'SalesLT'
      AND t.name     = N'Customer'
      AND ep.minor_id = 0
)
BEGIN
    EXECUTE sp_addextendedproperty
        @name       = N'AGENTS.md',
        @value      = N'Customer full name is constructed as FirstName + '' '' + LastName. CompanyName is the B2B account name. Use CustomerID as the join key to SalesOrderHeader.',
        @level0type = N'SCHEMA', @level0name = N'SalesLT',
        @level1type = N'TABLE',  @level1name = N'Customer';
    PRINT 'Instruction added: SalesLT.Customer';
END
ELSE
    PRINT 'Instruction already exists: SalesLT.Customer';
GO

PRINT '------------------------------------------------------------';
PRINT 'Database instructions setup complete.';
PRINT '';
PRINT 'To verify, run:';
PRINT 'SELECT OBJECT_SCHEMA_NAME(major_id), OBJECT_NAME(major_id),';
PRINT '       COL_NAME(major_id, minor_id), CAST(value AS NVARCHAR(MAX))';
PRINT 'FROM sys.extended_properties WHERE name = ''AGENTS.md'';';
PRINT '------------------------------------------------------------';
