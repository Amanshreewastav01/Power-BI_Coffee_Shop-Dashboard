Create Database Coffee_Shop_Sales_db;

Use Coffee_Shop_Sales_db;

Select count(*) From coffee_shop_sales;

Select * From coffee_shop_sales;

Describe coffee_shop_sales;

SET SQL_SAFE_UPDATES = 0;

/* Transaction Date Update */

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y');

ALTER TABLE coffee_shop_sales
MODIFY transaction_date DATE;

/* Transaction Time Update */

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');

ALTER TABLE coffee_shop_sales
MODIFY transaction_time TIME;

/* Total Sales Analysis */

/* Total Sales for each respective Month */

SELECT ROUND(SUM(transaction_qty * unit_price)) as Total_Sales
From coffee_shop_sales
WHERE MONTH(transaction_date) = 5; -- May Month

/* Determine MOM Increase & Decrease in Sales And Difference in Sales between selected Month & Previous Month */

SELECT 
MONTH(transaction_date) AS Month, 
ROUND(SUM(transaction_qty * unit_price)) AS Total_Sales,
(SUM(transaction_qty * unit_price) - LAG(SUM(transaction_qty * unit_price),1)
OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty * unit_price),1)
OVER(ORDER BY MONTH(transaction_date)) * 100 AS MOM_Increase_Percentage 
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5) 
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

/* Total Order Analysis */

/* Total No. of Orders for each respective Month */

SELECT COUNT(transaction_id) as Total_Orders
From coffee_shop_sales
WHERE MONTH(transaction_date) = 5; -- May Month

/* Determine MOM Increase & Decrease in No. of Orders And Difference in No. of Orders between selected Month & Previous Month */

SELECT 
MONTH(transaction_date) AS Month, 
COUNT(transaction_id) AS Total_Orders,
(COUNT(transaction_id) - LAG(COUNT(transaction_id),1)
OVER(ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id),1)
OVER(ORDER BY MONTH(transaction_date)) * 100 AS MOM_Increase_Percentage 
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5) 
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

/* Total Quantity Sold Analysis */

/* Total Quantity Sold for each respective Month */

SELECT SUM(transaction_qty) AS Total_Quantity
From coffee_shop_sales
WHERE MONTH(transaction_date) = 5; -- May Month

/* Determine MOM Increase & Decrease in Quantity Sold And Difference in Quantity Sold between selected Month & Previous Month */

SELECT 
MONTH(transaction_date) AS Month, 
SUM(transaction_qty) AS Total_Quantity,
(SUM(transaction_qty) - LAG(SUM(transaction_qty),1)
OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty),1)
OVER(ORDER BY MONTH(transaction_date)) * 100 AS MOM_Increase_Percentage 
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5) 
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

/* Charts Requirement */

/* Calendar Heat Map */

SELECT 
      CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS Total_Sales,
      CONCAT(ROUND(COUNT(transaction_id)/1000,1),"K") AS Total_Orders,
      CONCAT(ROUND(SUM(Transaction_qty)/1000,1),"K") AS Total_qty_Sold
      FROM coffee_shop_sales
      WHERE transaction_date = '2023-05-18';
      
/* Sales Analysis by Weekdays & Weekends */      

SELECT 
      CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekend'
      ELSE 'Weekday'
      END Data_Type,
      CONCAT(ROUND(SUM(transaction_qty * Unit_Price)/1000,1),"K") AS Total_Sales
      FROM coffee_shop_sales
      WHERE MONTH(transaction_date) = 5
      GROUP BY CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekend'
      ELSE 'Weekday'
      END;
      
/* Sales Analysis By Store Location */  

SELECT store_location, 
       CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") As Total_Sales
       FROM coffee_shop_sales
       WHERE MONTH(transaction_date) = 5
       GROUP BY store_location
       ORDER BY SUM(transaction_qty * unit_price);
       
/* Daily Analysis With Average Line */
#Average_Line

SELECT CONCAT(ROUND(AVG(total_sales)/1000,1),"K") AS avg_sales
FROM
    (SELECT SUM(transaction_qty * unit_price) AS total_sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY transaction_date) AS internal_query;

#Daily_Sales

SELECT 
      DAY(transaction_date) AS day_of_month,
      CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date);

#Daily_Sales With Average_Line

SELECT day_of_month,
	CASE
        WHEN total_sales < avg_sales THEN 'Below Average'
        WHEN total_sales > avg_sales THEN 'Above Average'
        ELSE 'Equal to Average'
        END AS sales_status,
        total_sales
FROM
    (SELECT 
      DAY(transaction_date) AS day_of_month,
	  SUM(transaction_qty * unit_price) AS total_sales,
      AVG(SUM(transaction_qty * unit_price)) OVER() AS avg_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date)) AS sales_data
ORDER BY day_of_month;

/* Slaes Analysis by Product Category */
#Sales Performance across different Product Categories

SELECT Product_category,
CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_category;

#Which Product categories contribute the most to overall sales

SELECT Product_category,
CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales
FROM coffee_shop_sales
GROUP BY product_category
ORDER BY SUM(transaction_qty * unit_price) desc;

/* TOP 10 Product by Sales */

#TOP 10 Product based on Sales Volume

SELECT Product_type,
CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 AND product_category = 'Coffee'
GROUP BY Product_type
ORDER BY SUM(transaction_qty * unit_price) desc
LIMIT 10;

/* Sales Analysis by Days & Hours */

SELECT 
      CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales,
      COUNT(*) AS total_orders,
      SUM(transaction_qty) AS total_qty
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
AND DAYOFWEEK(transaction_date) = 1 -- Name_of_Day
AND HOUR(transaction_time) = 8; -- Hours

#Sales Volume Based on each hours a month

SELECT 
HOUR(transaction_time) AS HOUR,
CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY HOUR(transaction_time)
ORDER BY HOUR(transaction_time);

#Sales Volume Based on Week Days Name

SELECT CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),"K") AS total_sales,
       CASE
       WHEN DAYOFWEEK(transaction_date) = 1 THEN 'Sunday'
       WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
       WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
       WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
       WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thrusday'
       WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
       ELSE 'Saturday'
       END AS Day_Name
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY (CASE
       WHEN DAYOFWEEK(transaction_date) = 1 THEN 'Sunday'
       WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
       WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
       WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
       WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thrusday'
       WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
       ELSE 'Saturday'
       END )
       ORDER BY SUM(transaction_qty * unit_price) DESC;

       
      