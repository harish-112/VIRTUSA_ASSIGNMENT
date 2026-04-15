# Retail Database SQL Script

## Overview
This SQL script sets up a retail management database (`retail_db`) with three tables and three analytical reports to track products, sales, and inventory metrics.

---

## Database Schema

### 1. **Categories Table**
Stores product categories.

```sql
CREATE TABLE Categories (
    CategoryID   INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryName TEXT NOT NULL
);
```

| Column | Type | Description |
|--------|------|-------------|
| CategoryID | INTEGER | Unique category identifier (auto-increment) |
| CategoryName | TEXT | Name of the category |

---

### 2. **Products Table**
Stores product information including pricing, stock, and expiry dates.

```sql
CREATE TABLE Products (
    ProductID    INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName  TEXT    NOT NULL,
    CategoryID   INTEGER NOT NULL,
    StockCount   INTEGER NOT NULL DEFAULT 0,
    CostPrice    REAL    NOT NULL,
    SellingPrice REAL    NOT NULL,
    ExpiryDate   DATE    NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
```

| Column | Type | Description |
|--------|------|-------------|
| ProductID | INTEGER | Unique product identifier (auto-increment) |
| ProductName | TEXT | Name of the product |
| CategoryID | INTEGER | Reference to Categories table |
| StockCount | INTEGER | Current quantity in stock (default: 0) |
| CostPrice | REAL | Cost price of the product |
| SellingPrice | REAL | Selling price of the product |
| ExpiryDate | DATE | Expiration date of the product |

---

### 3. **SalesTransactions Table**
Records individual sales transactions.

```sql
CREATE TABLE SalesTransactions (
    TransactionID   INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductID       INTEGER  NOT NULL,
    QuantitySold    INTEGER  NOT NULL,
    PriceAtSale     REAL     NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

| Column | Type | Description |
|--------|------|-------------|
| TransactionID | INTEGER | Unique transaction identifier (auto-increment) |
| ProductID | INTEGER | Reference to Products table |
| QuantitySold | INTEGER | Quantity sold in this transaction |
| PriceAtSale | REAL | Price per unit at time of sale |
| TransactionDate | DATETIME | Date and time of transaction (default: current timestamp) |

---

## Reports

### REPORT 1: EXPIRING SOON
**Purpose:** Identify products expiring within 7 days with stock > 50

**Question:** Which products are at risk of expiring soon and have significant stock?

```sql
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.ExpiryDate
FROM Products p
JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE p.ExpiryDate >  DATE('now')              
  AND p.ExpiryDate <= DATE('now', '+7 days')  
  AND p.StockCount > 50                        
ORDER BY p.ExpiryDate ASC;
```

**Output Columns:**
- ProductID, ProductName — Product details
- CategoryName — Category of the product
- StockCount — Current inventory level
- ExpiryDate — When the product expires

**Filters:**
- Expiry date is within the next 7 days
- Stock count exceeds 50 units

---

### REPORT 2: DEAD STOCK
**Purpose:** Identify products with zero sales in the last 60 days

**Question:** Which products haven't sold in the past 2 months?

```sql
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
      AND st.TransactionDate >= DATE('now', '-60 days')
WHERE st.TransactionID IS NULL
ORDER BY p.StockCount DESC;
```

**Output Columns:**
- ProductID, ProductName — Product details
- CategoryName — Category of the product
- StockCount — Current inventory level
- SellingPrice — Selling price of the product

**Filters:**
- No sales transactions in the last 60 days
- Products sorted by stock count (highest first)

---

### REPORT 3: REVENUE BY CATEGORY
**Purpose:** Calculate revenue by category for the previous calendar month

**Question:** Which category generated the most revenue last month?

```sql
SELECT
    c.CategoryName,
    ROUND(SUM(st.QuantitySold * st.PriceAtSale), 2) AS TotalRevenue
FROM SalesTransactions st
JOIN Products p ON p.ProductID = st.ProductID
JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE STRFTIME('%Y-%m', st.TransactionDate) 
    = STRFTIME('%Y-%m', DATE('now', '-1 month'))
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;
```

**Output Columns:**
- CategoryName — Product category
- TotalRevenue — Total revenue (QuantitySold × PriceAtSale) rounded to 2 decimals

**Filters:**
- Transactions from the previous calendar month
- Results sorted by revenue (highest first)

---

## Key SQL Functions Used

| Function | Purpose |
|----------|---------|
| `DATE('now')` | Current date |
| `DATE('now', '+7 days')` | Date 7 days from today |
| `DATE('now', '-60 days')` | Date 60 days ago |
| `STRFTIME('%Y-%m', date)` | Format date as YYYY-MM (year-month) |
| `SUM()` | Sum aggregate function |
| `ROUND(value, 2)` | Round to 2 decimal places |
| `LEFT JOIN` | Outer join to include non-matching records |
| `GROUP BY` | Group results by category |

---

## How to Use

1. **Create the database:**
   ```sql
   CREATE DATABASE retail_db;
   USE retail_db;
   ```

2. **Run the table creation scripts** to set up the schema

3. **Insert sample data** into Categories, Products, and SalesTransactions tables

4. **Run individual reports** to generate business insights

---

## Notes
- All prices are stored as REAL (decimal) data type
- Expiry dates and transaction dates are stored in DATE/DATETIME format
- Foreign keys enforce referential integrity between tables
- Use `ORDER BY` clauses to sort results by relevance

