-- =============================================================================
-- Query:       Orders Without Table Aliases (NES Alias Demo - Starting Point)
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Intentionally written without table aliases to demonstrate the
--              GitHub Copilot Next Edit Suggestions alias propagation feature.
-- Demo:        Add alias 'soh' to SalesOrderHeader and 'c' to Customer in
--              the FROM/JOIN clause, then let NES update all column references.
-- Database:    adventure_works
-- Used in:     NES Demo 2
-- =============================================================================

SELECT
    SalesOrderHeader.SalesOrderID,
    SalesOrderHeader.OrderDate,
    SalesOrderHeader.TotalDue,
    Customer.FirstName,
    Customer.LastName,
    Customer.CompanyName
FROM SalesLT.SalesOrderHeader
INNER JOIN SalesLT.Customer
    ON SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE SalesOrderHeader.TotalDue > 1000
ORDER BY SalesOrderHeader.OrderDate DESC;
