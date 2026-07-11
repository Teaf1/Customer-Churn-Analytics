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