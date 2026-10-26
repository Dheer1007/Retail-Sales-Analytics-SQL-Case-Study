/*
Retail Sales Analytics SQL Case Study
Data Cleaning Queries
*/
/*=====================================================
QUESTION 1

Write a query to identify the number of duplicates in
sales_transaction table. Also, create a separate table
containing unique values and remove the original table
from the database and replace it with the new table.

BUSINESS OBJECTIVE:
Identify and remove duplicate transactions to improve
data quality and reporting accuracy.
=====================================================*/

-- Solution

SELECT
    TransactionID,
    COUNT(*) AS duplicate_count
FROM sales_transaction
GROUP BY TransactionID
HAVING COUNT(*) > 1;

CREATE TABLE sales_transaction_new AS
SELECT DISTINCT *
FROM sales_transaction;

DROP TABLE sales_transaction;

ALTER TABLE sales_transaction_new
RENAME TO sales_transaction;


/*=====================================================
QUESTION 2

Identify discrepancies in product prices between
sales_transaction and product_inventory tables and
update them.

BUSINESS OBJECTIVE:
Ensure price consistency across all business systems.
=====================================================*/

-- Solution

SELECT
    st.ProductID,
    st.Price AS TransactionPrice,
    pi.Price AS InventoryPrice
FROM sales_transaction st
JOIN product_inventory pi
ON st.ProductID = pi.ProductID
WHERE st.Price <> pi.Price;

UPDATE sales_transaction st
JOIN product_inventory pi
ON st.ProductID = pi.ProductID
SET st.Price = pi.Price
WHERE st.Price <> pi.Price;


/*=====================================================
QUESTION 3

Identify NULL values in customer_profiles table and
replace them with 'Unknown'.

BUSINESS OBJECTIVE:
Improve completeness and consistency of customer data.
=====================================================*/

-- Solution

SELECT COUNT(*) AS NullCount
FROM customer_profiles
WHERE Age IS NULL
   OR Gender IS NULL
   OR Location IS NULL;

UPDATE customer_profiles
SET
    Age = COALESCE(Age,'Unknown'),
    Gender = COALESCE(Gender,'Unknown'),
    Location = COALESCE(Location,'Unknown');


/*=====================================================
QUESTION 4

Clean the TransactionDate column and convert it from
TEXT format to DATE format.

BUSINESS OBJECTIVE:
Enable time-series analysis and date calculations.
=====================================================*/

-- Solution

CREATE TABLE sales_transaction_new AS
SELECT
    *,
    STR_TO_DATE(TransactionDate,'%Y-%m-%d')
    AS TransactionDate_updated
FROM sales_transaction;

DROP TABLE sales_transaction;

ALTER TABLE sales_transaction_new
RENAME TO sales_transaction;
