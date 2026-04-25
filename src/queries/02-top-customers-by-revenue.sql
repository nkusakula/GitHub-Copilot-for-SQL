-- =============================================================================
-- Query:       Top 10 Customers by Revenue
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Returns the top 10 customers ranked by total revenue from
--              shipped orders, including order count and average order value.
-- Database:    adventure_works
-- Used in:     Copilot Chat Demo 2
-- =============================================================================

SELECT TOP 10
    c.CustomerID,
    c.FirstName + ' ' + c.LastName      AS CustomerName,
    c.CompanyName,
    COUNT(soh.SalesOrderID)             AS OrderCount,
    SUM(soh.TotalDue)                   AS TotalRevenue,
    AVG(soh.TotalDue)                   AS AvgOrderValue
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.Status = 5                    -- Shipped orders only
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.CompanyName
ORDER BY TotalRevenue DESC;
