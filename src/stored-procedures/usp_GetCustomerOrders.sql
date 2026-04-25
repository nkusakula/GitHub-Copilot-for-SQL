-- =============================================================================
-- Stored Procedure: usp_GetCustomerOrders
-- Author:           Data Team
-- Date:             2026-04-25
-- Description:      Returns all orders for a given customer within a specified
--                   date range, including product line item details.
-- Parameters:
--   @CustomerID   INT       The ID of the customer to retrieve orders for
--   @StartDate    DATETIME  Start of the date range (inclusive)
--   @EndDate      DATETIME  End of the date range (inclusive)
-- Change History:
--   2026-04-25  Data Team  Initial creation
-- Used in:     Custom Instructions Demo 9
-- =============================================================================

CREATE OR ALTER PROCEDURE SalesLT.usp_GetCustomerOrders
    @CustomerID   INT,
    @StartDate    DATETIME,
    @EndDate      DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        soh.SalesOrderID,
        soh.SalesOrderNumber,
        soh.OrderDate,
        soh.DueDate,
        soh.ShipDate,
        soh.Status,
        soh.TotalDue,
        p.Name                          AS ProductName,
        pc.Name                         AS Category,
        sod.OrderQty,
        sod.UnitPrice,
        sod.UnitPriceDiscount,
        sod.LineTotal
    FROM SalesLT.SalesOrderHeader soh
    INNER JOIN SalesLT.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN SalesLT.Product p
        ON sod.ProductID = p.ProductID
    INNER JOIN SalesLT.ProductCategory pc
        ON p.ProductCategoryID = pc.ProductCategoryID
    WHERE soh.CustomerID = @CustomerID
      AND soh.OrderDate BETWEEN @StartDate AND @EndDate
    ORDER BY
        soh.OrderDate DESC,
        soh.SalesOrderID;
END;
GO

-- Example usage:
-- EXEC SalesLT.usp_GetCustomerOrders
--     @CustomerID = 29736,
--     @StartDate  = '2008-01-01',
--     @EndDate    = '2008-12-31';
