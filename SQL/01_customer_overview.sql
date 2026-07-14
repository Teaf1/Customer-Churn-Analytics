--total number of customers
SELECT COUNT(*)
FROM customers;

--total number of churned customers
SELECT COUNT(*)
FROM customers
WHERE Churn = 'Yes';

--average tenure of churned customers
SELECT avg(tenure)FROM customers WHERE Churn='Yes';

-- --average tenure of active customers
SELECT avg(tenure)FROM customers WHERE Churn='No';

--total customers by contract type
SELECT Contract ,count(*) FROM customers GROUP by Contract;

--churned customers by contract type 
SELECT Contract ,count(*) FROM customers WHERE Churn='Yes'GROUP by Contract;

-- Overall churn rate

SELECT ROUND(COUNT(*) * 100.0 /

(SELECT COUNT(*) FROM customers), 2) AS Churn_Rate

FROM customers

WHERE Churn = 'Yes';

-- Churn rate by contract type
SELECT T.Contract,T.Total_Customers,C.Churned_Customers,
    ROUND(C.Churned_Customers * 100.0 / T.Total_Customers, 2) AS Churn_Rate
FROM(SELECT Contract,count(*) as Total_Customers
FROM customers GROUP by Contract)as T
JOIN
(SELECT Contract,count(*) as Churned_Customers
FROM customers WHERE Churn='Yes' GROUP by Contract)as C
on T.Contract=C.Contract;
-- Insight:
-- Customers with month-to-month contracts have the highest churn rate,
-- while customers with two-year contracts have the lowest churn rate.


-- Churn rate by Payment Method
SELECT
    T.PaymentMethod,
    T.Total_Customers,
    C.Churned_Customers,
    ROUND(C.Churned_Customers * 100.0 / T.Total_Customers, 2) AS Churn_Rate
FROM
(
    SELECT
        PaymentMethod,
        COUNT(*) AS Total_Customers
    FROM customers
    GROUP BY PaymentMethod
) AS T
JOIN
(
    SELECT
        PaymentMethod,
        COUNT(*) AS Churned_Customers
    FROM customers
    WHERE Churn = 'Yes'
    GROUP BY PaymentMethod
) AS C
ON T.PaymentMethod = C.PaymentMethod;

-- Insight:
-- Customers using Electronic Check have the highest churn rate (45.29%),
-- indicating that this payment method is associated with a significantly higher
-- risk of customer churn. Customers using Credit Card (automatic) have the
-- lowest churn rate (15.24%), suggesting better customer retention.


-- Churn rate by Internet Service
SELECT
    T.InternetService,
    T.Total_Customers,
    C.Churned_Customers,
    ROUND(C.Churned_Customers * 100.0 / T.Total_Customers, 2) AS Churn_Rate
FROM
(
    SELECT
        InternetService,
        COUNT(*) AS Total_Customers
    FROM customers
    GROUP BY InternetService
) AS T
JOIN
(
    SELECT
        InternetService,
        COUNT(*) AS Churned_Customers
    FROM customers
    WHERE Churn = 'Yes'
    GROUP BY InternetService
) AS C
ON T.InternetService = C.InternetService;

-- Insight:
-- Customers using Fiber Optic internet service have the highest churn rate (41.89%),
-- while customers with no internet service have the lowest churn rate (7.40%).
-- This suggests that customers using Fiber Optic service are more likely to churn
-- compared to customers using other internet service types.