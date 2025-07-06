-- MYSQL Assignment Solution

-- Q1: SELECT with WHERE, AND, DISTINCT, LIKE
-- Fetch employee number, first name, and last name of Sales Reps reporting to employee 1102
SELECT employeeNumber, firstName, lastName 
FROM employees 
WHERE jobTitle = 'Sales Rep' AND reportsTo = 1102;

-- Show unique productLine values containing 'cars' at the end
SELECT DISTINCT productLine 
FROM products 
WHERE productLine LIKE '%cars';

-- Q2: CASE Statement for Segmentation
SELECT customerNumber, customerName,
  CASE 
    WHEN country IN ('USA', 'Canada') THEN 'North America'
    WHEN country IN ('UK', 'France', 'Germany') THEN 'Europe'
    ELSE 'Other' 
  END AS CustomerSegment
FROM customers;

-- Q3: Group By with Aggregation and HAVING Clause
-- Top 10 products with highest total order quantity
SELECT productCode, SUM(quantityOrdered) AS totalQuantity
FROM orderdetails
GROUP BY productCode
ORDER BY totalQuantity DESC
LIMIT 10;

-- Count payments per month where count > 20
SELECT MONTHNAME(paymentDate) AS Month, COUNT(*) AS PaymentCount
FROM payments
GROUP BY Month
HAVING COUNT(*) > 20
ORDER BY PaymentCount DESC;

-- Q4: Creating Tables with Constraints
CREATE DATABASE Customers_Orders;
USE Customers_Orders;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2) CHECK (total_amount > 0),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Q5: Joins - Top 5 countries by order count
SELECT country, COUNT(orderNumber) AS OrderCount
FROM classicmodels.customers c
JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber
GROUP BY country
ORDER BY OrderCount DESC
LIMIT 5;


-- Q6: Self Join - Find employees and their managers
CREATE TABLE project (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female'),
    ManagerID INT
);

SELECT e1.FullName AS Employee, e2.FullName AS Manager
FROM project e1
LEFT JOIN project e2 ON e1.ManagerID = e2.EmployeeID;


-- Q7: DDL Commands
CREATE TABLE facility (
    Facility_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    City VARCHAR(100) NOT NULL,
    State VARCHAR(50),
    Country VARCHAR(50)
);

-- Q8: Views in SQL


CREATE VIEW product_category_sales AS 
SELECT pl.productLine, 
       SUM(od.quantityOrdered * od.priceEach) AS total_sales,
       COUNT(DISTINCT o.orderNumber) AS number_of_orders
FROM classicmodels.productlines pl
JOIN classicmodels.products p ON pl.productLine = p.productLine
JOIN classicmodels.orderdetails od ON p.productCode = od.productCode
JOIN classicmodels.orders o ON od.orderNumber = o.orderNumber
GROUP BY pl.productLine;

-- Q9: Stored Procedure for country payments
DELIMITER //
CREATE PROCEDURE Get_country_payments(IN yearInput INT, IN countryInput VARCHAR(50))
BEGIN
    SELECT YEAR(paymentDate) AS Year, country, ROUND(SUM(amount)/1000, 0) AS TotalAmountK
    FROM classicmodels.customers c
    JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
    WHERE YEAR(paymentDate) = yearInput AND country = countryInput
    GROUP BY Year, country;
END //
DELIMITER ;


-- Q10: Window Functions
-- Rank customers based on order frequency
SELECT c.customerNumber, c.customerName, 
       COUNT(o.orderNumber) AS OrderCount,
       RANK() OVER (ORDER BY COUNT(o.orderNumber) DESC) AS OrderRank
FROM classicmodels.customers c
JOIN classicmodels.orders o 
	ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber;

-- Yearly order count with YoY change
WITH MonthlyOrders AS (
    SELECT YEAR(orderDate) AS Year, MONTHNAME(orderDate) AS Month, 
           COUNT(*) AS OrderCount
    FROM classicmodels.orders
    GROUP BY YEAR(orderDate), MONTHNAME(orderDate)
),
YoYChange AS (
    SELECT Year, Month, OrderCount,
           LAG(OrderCount) OVER (ORDER BY Year, MONTH(STR_TO_DATE(CONCAT(Year, '-', Month, '-01'), '%Y-%M-%d'))) AS PrevOrderCount
    FROM MonthlyOrders
)
SELECT Year, Month, OrderCount,
       CONCAT(ROUND(((OrderCount - PrevOrderCount) / PrevOrderCount) * 100, 0), '%') AS YoYChange
FROM YoYChange;


-- Q11: Subquery - Count product lines with above-average buy price

SELECT *
FROM classicmodels.products;

SELECT productLine, COUNT(*) AS Count
FROM classicmodels.products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM classicmodels.products)
GROUP BY productLine;


-- Q12: Error Handling in SQL

CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    EmailAddress VARCHAR(100)
);

DELIMITER //
DROP PROCEDURE Insert_Emp_EH;
CREATE PROCEDURE Insert_Emp_EH(IN empID INT, IN empName VARCHAR(50), IN emailAddress VARCHAR(100))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error occurred' AS Message;
    END;
    
    INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress) VALUES (empID, empName, emailAddress);
END //

DELIMITER ;

-- Q13: Triggers
CREATE TABLE Emp_BIT (
    Name VARCHAR(50),
    Occupation VARCHAR(50),
    Working_date DATE,
    Working_hours INT
);

DELIMITER //
CREATE TRIGGER before_insert_trigger
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = ABS(NEW.Working_hours);
    END IF;
END //
DELIMITER ;
