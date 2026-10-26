/*
Customer Segmentation Queries
*/
/*=====================================================
QUESTION 1

Segment customers based on total quantity purchased.

Low    : 1 - 10
Medium : 11 - 30
High   : Above 30

BUSINESS OBJECTIVE:
Enable targeted marketing campaigns.
=====================================================*/

CREATE TABLE customer_segment AS
SELECT
    cp.CustomerID,
    SUM(st.QuantityPurchased)
    AS TotalQuantityPurchased,

    CASE
        WHEN SUM(st.QuantityPurchased)
             BETWEEN 1 AND 10
             THEN 'Low'

        WHEN SUM(st.QuantityPurchased)
             BETWEEN 11 AND 30
             THEN 'Medium'

        WHEN SUM(st.QuantityPurchased)
             > 30
             THEN 'High'
    END AS CustomerSegment

FROM customer_profiles cp
JOIN sales_transaction st
ON cp.CustomerID = st.CustomerID
GROUP BY cp.CustomerID;


SELECT
    CustomerSegment,
    COUNT(CustomerID) AS CustomerCount
FROM customer_segment
GROUP BY CustomerSegment;
