-- =============================================================================
-- Query:       Customer Revenue by Product Category
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Returns total units sold and revenue per product category.
--              Revenue = SUM(LineTotal) for shipped orders only (Status = 5).
-- Database:    adventure_works
-- Used in:     Copilot Chat Demo 2, Database Instructions Demo 1 & 4
-- =============================================================================

SELECT
    pc.Name                             AS Category,
    p.Name                              AS Product,
    SUM(sod.OrderQty)                   AS UnitsSold,
    SUM(sod.LineTotal)                  AS Revenue
FROM SalesLT.SalesOrderDetail sod
INNER JOIN SalesLT.SalesOrderHeader soh
    ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN SalesLT.Product p
    ON sod.ProductID = p.ProductID
INNER JOIN SalesLT.ProductCategory pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE soh.Status = 5                    -- Shipped orders only
GROUP BY
    pc.Name,
    p.Name
ORDER BY Revenue DESC;
