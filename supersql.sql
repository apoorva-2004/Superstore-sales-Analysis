use superstore_db;
DROP TABLE IF EXISTS store;

select count(*) from ss; 

ALTER TABLE ss
RENAME COLUMN `Row ID` TO RowID;

ALTER TABLE ss
RENAME COLUMN `Order ID` TO OrderID;

ALTER TABLE ss
RENAME COLUMN `Order Date` TO OrderDate;

ALTER TABLE ss
RENAME COLUMN `Ship Date` TO ShipDate;

ALTER TABLE ss
RENAME COLUMN `Ship Mode` TO ShipMode;

ALTER TABLE ss
RENAME COLUMN `Customer ID` TO CustomerID;

ALTER TABLE ss
RENAME COLUMN `Customer Name` TO CustomerName;

ALTER TABLE ss
RENAME COLUMN `Postal Code` TO PostalCode;

ALTER TABLE ss
RENAME COLUMN `Product ID` TO ProductID;

ALTER TABLE ss
RENAME COLUMN `Sub-Category` TO SubCategory;

ALTER TABLE ss
RENAME COLUMN `Product Name` TO ProductName;

#Total Sales
select round(sum(Sales),2) as TotalSales from ss;

#Total Profit
select round(sum(Profit),2) as TotalProfit from ss;

#TotalQuantity
select round(sum(Quantity),2) as TotalOrders from ss;

#Sales by Region
select Region,round(sum(Sales),2) as totalSales 
from ss
group by Region
order by totalSales desc;

#top 10 products by profit
select ProductName,round(sum(Profit),2) as TotalProfit
from ss
group by ProductName
order by TotalProfit desc
limit 10;

#Category ,Sub-category Performance
select Category,SubCategory,
round(sum(Sales),2) as Sales,
round(sum(Profit),2) as Profit 
from ss
group by Category,SubCategory
order by Profit desc limit 15;

SET SQL_SAFE_UPDATES = 0;

SELECT DISTINCT OrderDate
FROM ss
WHERE OrderDate IS NOT NULL
LIMIT 10;

#monthly sales trend
SELECT
    DATE_FORMAT(STR_TO_DATE(OrderDate, '%m/%d/%Y'), '%Y-%m') AS Month,
    round(SUM(Sales),2) AS MonthlySales
FROM ss
WHERE OrderDate IS NOT NULL
GROUP BY Month
ORDER BY Month;

#customer name and product insights

#Top 10 customers
select CustomerName,
round(sum(Sales),2) as Sales,
round(sum(Profit),2) as Profit
from ss
group by CustomerName
order by Sales desc
limit 10;

#most profitable products
select ProductName,
round(sum(Profit),2) as Profit
from ss
group by ProductName
order by Profit desc
limit 10;

#Discount effect on profit
select Discount,
round(sum(Sales),2) as Sales,
round(sum(Profit),2) as Profit
from ss
group by Discount
order by Discount ;

#Extract year and month
SELECT
    YEAR(STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS OrderYear,
    MONTH(STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS OrderMonth
FROM ss
WHERE OrderDate IS NOT NULL;

#Profit by year
SELECT
    YEAR(STR_TO_DATE(OrderDate, '%m/%d/%Y')) AS OrderYear,
    SUM(Profit) AS AnnualProfit
FROM ss
WHERE OrderDate IS NOT NULL
GROUP BY OrderYear
ORDER BY OrderYear;

#Profit margin by category
SELECT 
    Category,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin
FROM ss
GROUP BY Category
ORDER BY Profit_Margin DESC;


