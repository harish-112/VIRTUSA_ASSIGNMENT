CREATE DATABASE retail_db;

USE retail_db;

CREATE TABLE IF NOT EXISTS Categories (
    CategoryID   INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    ProductID    INT PRIMARY KEY AUTO_INCREMENT,
    ProductName  VARCHAR(255) NOT NULL,
    CategoryID   INT NOT NULL,
    StockCount   INT NOT NULL DEFAULT 0,
    CostPrice    DECIMAL(10, 2) NOT NULL,
    SellingPrice DECIMAL(10, 2) NOT NULL,
    ExpiryDate   DATE NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE IF NOT EXISTS SalesTransactions (
    TransactionID   INT PRIMARY KEY AUTO_INCREMENT,
    ProductID       INT NOT NULL,
    QuantitySold    INT NOT NULL,
    PriceAtSale     DECIMAL(10, 2) NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


"""REPORT 1: EXPIRING SOON Products expiring within 7 days with stock > 50"""
    
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.ExpiryDate
FROM Products p
JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE p.ExpiryDate > CURRENT_DATE
  AND p.ExpiryDate <= DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY)
  AND p.StockCount > 50
ORDER BY p.ExpiryDate ASC;


"""REPORT 2: DEAD STOCK - Products with no sales in the last 60 days"""
    
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.SellingPrice
FROM Products p
JOIN Categories c ON c.CategoryID = p.CategoryID
LEFT JOIN SalesTransactions st
       ON st.ProductID = p.ProductID
      AND st.TransactionDate >= DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY)
WHERE st.TransactionID IS NULL
ORDER BY p.StockCount DESC;


-- REPORT 3: REVENUE BY CATEGORY — LAST CALENDAR MONTH

SELECT
    c.CategoryName,
    ROUND(SUM(st.QuantitySold * st.PriceAtSale), 2) AS TotalRevenue
FROM SalesTransactions st
JOIN Products p   ON p.ProductID=st.ProductID
JOIN Categories c ON c.CategoryID=p.CategoryID
WHERE YEAR(st.TransactionDate)=YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
  AND MONTH(st.TransactionDate)=MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;    

