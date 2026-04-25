-- =============================================================================
-- View:        v_CustomerRevenueSummary
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Summarizes total revenue, order count, and average order value
--              per customer. Includes only shipped orders (Status = 5).
--              Revenue = SUM(TotalDue) for Status = 5 orders.
-- Database:    adventure_works
-- =============================================================================

CREATE OR ALTER VIEW SalesLT.v_CustomerRevenueSummary
AS
SELECT
    c.CustomerID,
    c.FirstName + ' ' + c.LastName      AS CustomerName,
    c.CompanyName,
    c.EmailAddress,
    COUNT(soh.SalesOrderID)             AS OrderCount,
    SUM(soh.TotalDue)                   AS TotalRevenue,
    AVG(soh.TotalDue)                   AS AvgOrderValue,
    MIN(soh.OrderDate)                  AS FirstOrderDate,
    MAX(soh.OrderDate)                  AS LastOrderDate
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.Status = 5                    -- Shipped orders only
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.CompanyName,
    c.EmailAddress;
GO
