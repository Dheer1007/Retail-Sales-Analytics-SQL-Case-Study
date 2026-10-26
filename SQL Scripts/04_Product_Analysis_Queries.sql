/*
Product Analysis Queries
*/
/*=====================================================
QUESTION 1

Summarize total sales and quantities sold per product.

BUSINESS OBJECTIVE:
Evaluate product performance.
=====================================================*/

SELECT
    ProductID,
    SUM(QuantityPurchased) AS Total_Quantity_Sold,
    ROUND(SUM(QuantityPurchased * Price),2) AS Total_Sales
FROM sales_transaction
GROUP BY ProductID
ORDER BY Total_Sales DESC;


/*=====================================================
QUESTION 2

Evaluate product category performance.

BUSINESS OBJECTIVE:
Identify categories that require marketing focus.
=====================================================*/

SELECT
    pi.Category,
    SUM(st.QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(st.QuantityPurchased * st.Price),2)
    AS TotalSales
FROM sales_transaction st
JOIN product_inventory pi
ON st.ProductID = pi.ProductID
GROUP BY pi.Category
ORDER BY TotalSales DESC;


/*=====================================================
QUESTION 3

Find top 10 products by revenue.

BUSINESS OBJECTIVE:
Identify products contributing most revenue.
=====================================================*/

SELECT
    ProductID,
    SUM(QuantityPurchased) AS TotalQuantitySold,
    ROUND(SUM(QuantityPurchased * Price),2)
    AS TotalRevenue
FROM sales_transaction
GROUP BY ProductID
ORDER BY TotalRevenue DESC
LIMIT 10;


/*=====================================================
QUESTION 4

Find bottom 10 products by quantity sold.

BUSINESS OBJECTIVE:
Identify underperforming products.
=====================================================*/

SELECT
    ProductID,
    SUM(QuantityPurchased) AS TotalUnitsSold
FROM sales_transaction
GROUP BY ProductID
HAVING SUM(QuantityPurchased) > 0
ORDER BY TotalUnitsSold ASC
LIMIT 10;
