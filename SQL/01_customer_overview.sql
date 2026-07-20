-- Customer Churn Analysis


-- Total Customers
SELECT COUNT(*) AS Total_Customers
FROM customers;


-- Total Churned Customers
SELECT COUNT(*) AS Churned_Customers
FROM customers
WHERE Churn = 'Yes';


-- Average Tenure (Churned Customers)
SELECT AVG(Tenure) AS Average_Tenure
FROM customers
WHERE Churn = 'Yes';


-- Average Tenure (Active Customers)
SELECT AVG(Tenure) AS Average_Tenure
FROM customers
WHERE Churn = 'No';


-- Customers by Contract Type
SELECT
    Contract,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY Contract;


-- Churned Customers by Contract Type
SELECT
    Contract,
    COUNT(*) AS Churned_Customers
FROM customers
WHERE Churn = 'Yes'
GROUP BY Contract;


-- Overall Churn Rate
SELECT
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customers),
        2
    ) AS Churn_Rate
FROM customers
WHERE Churn = 'Yes';


-- Churn Rate by Contract Type
WITH TotalCustomers AS
(
    SELECT
        Contract,
        COUNT(*) AS Total_Customers
    FROM customers
    GROUP BY Contract
),
ChurnedCustomers AS
(
    SELECT
        Contract,
        COUNT(*) AS Churned_Customers
    FROM customers
    WHERE Churn = 'Yes'
    GROUP BY Contract
)

SELECT
    T.Contract,
    T.Total_Customers,
    C.Churned_Customers,
    ROUND(
        C.Churned_Customers * 100.0 / T.Total_Customers,
        2
    ) AS Churn_Rate
FROM TotalCustomers AS T
JOIN ChurnedCustomers AS C
ON T.Contract = C.Contract
ORDER BY Churn_Rate DESC;

-- Insight:
-- Month-to-month contracts have the highest churn rate.
-- Two-year contracts have the lowest churn rate.


-- Churn Rate by Payment Method
WITH TotalCustomers AS
(
    SELECT
        PaymentMethod,
        COUNT(*) AS Total_Customers
    FROM customers
    GROUP BY PaymentMethod
),
ChurnedCustomers AS
(
    SELECT
        PaymentMethod,
        COUNT(*) AS Churned_Customers
    FROM customers
    WHERE Churn = 'Yes'
    GROUP BY PaymentMethod
)

SELECT
    T.PaymentMethod,
    T.Total_Customers,
    C.Churned_Customers,
    ROUND(
        C.Churned_Customers * 100.0 / T.Total_Customers,
        2
    ) AS Churn_Rate
FROM TotalCustomers AS T
JOIN ChurnedCustomers AS C
ON T.PaymentMethod = C.PaymentMethod
ORDER BY Churn_Rate DESC;

-- Insight:
-- Electronic Check has the highest churn rate.
-- Credit Card (automatic) has the lowest churn rate.


-- Churn Rate by Internet Service
WITH TotalCustomers AS
(
    SELECT
        InternetService,
        COUNT(*) AS Total_Customers
    FROM customers
    GROUP BY InternetService
),
ChurnedCustomers AS
(
    SELECT
        InternetService,
        COUNT(*) AS Churned_Customers
    FROM customers
    WHERE Churn = 'Yes'
    GROUP BY InternetService
)

SELECT
    T.InternetService,
    T.Total_Customers,
    C.Churned_Customers,
    ROUND(
        C.Churned_Customers * 100.0 / T.Total_Customers,
        2
    ) AS Churn_Rate
FROM TotalCustomers AS T
JOIN ChurnedCustomers AS C
ON T.InternetService = C.InternetService
ORDER BY Churn_Rate DESC;

-- Insight:
-- Fiber Optic has the highest churn rate.
-- Customers without internet service have the lowest churn rate.


-- Customer Count by Senior Citizen Status
SELECT
    CASE
        WHEN SeniorCitizen = 1 THEN 'Senior'
        ELSE 'Non-Senior'
    END AS Customer_Type,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY
    CASE
        WHEN SeniorCitizen = 1 THEN 'Senior'
        ELSE 'Non-Senior'
    END;

-- Insight:
-- Most customers are Non-Senior.
-- Senior customers make up a smaller portion of the customer base.