CREATE DATABASE retail_db;

USE retail_db;

CREATE TABLE IF NOT EXISTS Categories (
    CategoryID   INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryName TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    ProductID    INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName  TEXT    NOT NULL,
    CategoryID   INTEGER NOT NULL,
    StockCount   INTEGER NOT NULL DEFAULT 0,
    CostPrice    REAL    NOT NULL,
    SellingPrice REAL    NOT NULL,
    ExpiryDate   DATE    NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE IF NOT EXISTS SalesTransactions (
    TransactionID   INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductID       INTEGER  NOT NULL,
    QuantitySold    INTEGER  NOT NULL,
    PriceAtSale     REAL     NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

"""REPORT 1: EXPIRING SOON Products expiring within 7 days with stock > 50"""

SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.ExpiryDate,
FROM Products p
JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE p.ExpiryDate >  DATE('now')              
  AND p.ExpiryDate <= DATE('now', '+7 days')  
  AND p.StockCount > 50                        
ORDER BY p.ExpiryDate ASC;          

"""REPORT 2: DEAD STOCK - Products with no sales in the last 60 days"""

SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.SellingPrice,
FROM Products p
JOIN Categories c ON c.CategoryID = p.CategoryID
LEFT JOIN SalesTransactions st
       ON st.ProductID = p.ProductID
      AND st.TransactionDate >= DATE('now', '-60 days')
WHERE st.TransactionID IS NULL
ORDER BY p.StockCount DESC;

"""REPORT 3: REVENUE BY CATEGORY — LAST CALENDAR MONTH"""

SELECT
    c.CategoryName,
    ROUND(SUM(st.QuantitySold * st.PriceAtSale), 2)  AS TotalRevenue,
FROM SalesTransactions st
JOIN Products p   ON p.ProductID   = st.ProductID
JOIN Categories c ON c.CategoryID  = p.CategoryID
WHERE STRFTIME('%Y-%m', st.TransactionDate)
    = STRFTIME('%Y-%m', DATE('now', '-1 month'))
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;