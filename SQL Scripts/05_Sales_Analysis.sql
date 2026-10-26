/*
Sales Analysis Queries
*/
/*=====================================================
QUESTION 1

Identify sales trend.

BUSINESS OBJECTIVE:
Understand company revenue pattern.
=====================================================*/

SELECT
    TransactionDate_updated AS DATETRANS,
    COUNT(TransactionID) AS NumberOfTransactions,
    SUM(QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(QuantityPurchased * Price),2)
    AS TotalSales
FROM sales_transaction
GROUP BY TransactionDate_updated
ORDER BY DATETRANS DESC;


/*=====================================================
QUESTION 2

Calculate Month-over-Month Growth Rate.

BUSINESS OBJECTIVE:
Measure monthly business growth.
=====================================================*/

WITH monthly_sales AS (
    SELECT
        MONTH(TransactionDate_updated) AS Month,
        ROUND(
            SUM(QuantityPurchased * Price),
            2
        ) AS TotalSales
    FROM sales_transaction
    GROUP BY MONTH(TransactionDate_updated)
)

SELECT
    Month,
    TotalSales,
    ROUND(
        LAG(TotalSales)
        OVER(ORDER BY Month),
        2
    ) AS PreviousMonthSales,
    ROUND(
        (
            (
                TotalSales -
                LAG(TotalSales)
                OVER(ORDER BY Month)
            )
            /
            LAG(TotalSales)
            OVER(ORDER BY Month)
        ) * 100,
        2
    ) AS MoM_Growth_Percentage
FROM monthly_sales
ORDER BY Month;
