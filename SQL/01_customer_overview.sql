-- Customer Overview

-- Q1: Total number of customers

SELECT COUNT(*)
FROM customers;

-- Result: 7043


-- Q2: Number of churned customers

SELECT COUNT(*)
FROM customers
WHERE Churn = 'Yes';

-- Result: 1869