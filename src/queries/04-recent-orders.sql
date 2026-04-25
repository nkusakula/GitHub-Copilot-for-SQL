-- =============================================================================
-- Query:       Recent Orders (Last 12 Months)
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Returns all orders placed in the last 12 months, including
--              customer name and shipping address details.
-- Database:    adventure_works
-- Used in:     Copilot Chat Demo 5 (file reference demo with #recent-orders.sql)
-- =============================================================================

SELECT
    soh.SalesOrderID,
    soh.SalesOrderNumber,
    soh.OrderDate,
    soh.DueDate,
    soh.ShipDate,
    soh.TotalDue,
    c.FirstName + ' ' + c.LastName      AS CustomerName,
    c.CompanyName,
    a.City,
    a.StateProvince,
    a.CountryRegion
FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
    ON soh.CustomerID = c.CustomerID
INNER JOIN SalesLT.Address a
    ON soh.ShipToAddressID = a.AddressID
WHERE soh.OrderDate >= DATEADD(YEAR, -1, GETDATE())
ORDER BY soh.OrderDate DESC;
