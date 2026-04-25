-- =============================================================================
-- Query:       Product Profit Margin Analysis
-- Author:      Data Team
-- Date:        2026-04-25
-- Description: Returns active products priced above $500 with calculated
--              profit margin percentage.
-- Database:    adventure_works
-- Used in:     Copilot Chat Demo 3 (inline chat starting point)
-- Demo note:   For the inline chat demo, start with just Name, Color,
--              ListPrice, StandardCost -- then ask Copilot to add the
--              margin column and the availability filter.
-- =============================================================================

SELECT
    p.Name                                                          AS ProductName,
    p.Color,
    p.ListPrice,
    p.StandardCost,
    CAST(
        ((p.ListPrice - p.StandardCost) / p.ListPrice) * 100
        AS DECIMAL(5, 2)
    )                                                               AS ProfitMarginPct
FROM SalesLT.Product p
WHERE p.ListPrice > 500
  AND p.SellEndDate IS NULL               -- Currently available for sale
  AND p.DiscontinuedDate IS NULL          -- Not discontinued
ORDER BY p.ListPrice DESC;
