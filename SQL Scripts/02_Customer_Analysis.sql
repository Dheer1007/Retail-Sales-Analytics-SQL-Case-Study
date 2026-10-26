/*
Customer Analysis Queries
*/
/*=====================================================
QUESTION 1

Count number of transactions per customer.

BUSINESS OBJECTIVE:
Understand customer purchase frequency.
=====================================================*/

SELECT
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions
FROM sales_transaction
GROUP BY CustomerID
ORDER BY NumberOfTransactions DESC;


/*=====================================================
QUESTION 2

Identify high-frequency customers.

BUSINESS OBJECTIVE:
Identify high-value customers.
=====================================================*/

SELECT
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions,
    ROUND(SUM(QuantityPurchased * Price),2)
    AS TotalSpent
FROM sales_transaction
GROUP BY CustomerID
HAVING COUNT(TransactionID) > 10
   AND SUM(QuantityPurchased * Price) > 1000
ORDER BY TotalSpent DESC;


/*=====================================================
QUESTION 3

Identify low-frequency customers.

BUSINESS OBJECTIVE:
Identify occasional customers.
=====================================================*/

SELECT
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions,
    ROUND(SUM(QuantityPurchased * Price),2)
    AS TotalSpent
FROM sales_transaction
GROUP BY CustomerID
HAVING COUNT(TransactionID) <= 2
ORDER BY NumberOfTransactions ASC,
         TotalSpent DESC;


/*=====================================================
QUESTION 4

Identify repeat purchases.

BUSINESS OBJECTIVE:
Understand repeat buying behaviour.
=====================================================*/

SELECT
    CustomerID,
    ProductID,
    COUNT(TransactionID) AS TimesPurchased
FROM sales_transaction
GROUP BY CustomerID, ProductID
HAVING COUNT(TransactionID) > 1
ORDER BY TimesPurchased DESC;


/*=====================================================
QUESTION 5

Customer Loyalty Analysis.

BUSINESS OBJECTIVE:
Measure customer retention period.
=====================================================*/

SELECT
    CustomerID,
    MIN(TransactionDate_updated) AS FirstPurchaseDate,
    MAX(TransactionDate_updated) AS LastPurchaseDate,
    DATEDIFF(
        MAX(TransactionDate_updated),
        MIN(TransactionDate_updated)
    ) AS DaysBetweenPurchases
FROM sales_transaction
GROUP BY CustomerID
HAVING DaysBetweenPurchases > 0
ORDER BY DaysBetweenPurchases DESC;
