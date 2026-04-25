-- =============================================================================
-- Query:       CTE Rename Demo (NES Refactor - Starting Point)
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: CTE intentionally named 'SalesData' to demonstrate the GitHub
--              Copilot Next Edit Suggestions rename/refactor feature.
-- Demo:        Rename 'SalesData' to 'CustomerRevenueSummary' in the WITH
--              clause, then let NES propagate the rename to all references.
-- Database:    adventure_works
-- Used in:     NES Demo 3
-- =============================================================================

WITH SalesData AS (
    SELECT
        c.CustomerID,
        c.FirstName + ' ' + c.LastName  AS CustomerName,
        c.CompanyName,
        SUM(soh.TotalDue)               AS TotalRevenue,
        COUNT(soh.SalesOrderID)         AS OrderCount
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader soh
        ON c.CustomerID = soh.CustomerID
    WHERE soh.Status = 5
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName,
        c.CompanyName
)
SELECT
    SalesData.CustomerName,
    SalesData.CompanyName,
    SalesData.TotalRevenue,
    SalesData.OrderCount
FROM SalesData
WHERE SalesData.TotalRevenue > 5000
ORDER BY SalesData.TotalRevenue DESC;
