# ☕ Coffee Shop Sales Analysis (SQL + Power BI)

This project analyzes **Coffee Shop Sales** data using **MySQL** for data cleaning & analysis and **Power BI** for visualization.  
It demonstrates end-to-end skills: SQL data transformation, KPI calculations, and dashboard design.

---

## 📂 Project Structure

---

## 🔑 Key Objectives
- Clean & format **transaction_date** and **transaction_time** using SQL.
- Perform **sales, orders, and quantity analysis**.
- Calculate **MoM (Month-over-Month) growth** with SQL Window Functions.
- Build **Power BI dashboard** with interactive visuals:
  - 📅 Calendar heat map  
  - 🛍️ Sales by product category & product type  
  - 📍 Sales by store location  
  - 📈 Daily sales trend with average line  
  - ⏰ Sales by weekday/weekend & hourly trends  
  - 🏆 Top 10 products by sales  

---

## 🛠️ Tools & Technologies
- **SQL (MySQL Workbench)** → Data cleaning & analysis  
- **Power BI** → Dashboard & storytelling  
- **Excel / CSV** → Raw dataset  

---

## 📊 Dashboard Preview
### Main Dashboard  
![Dashboard](screenshots/Dashboard.png)

### Background & Layout  
![Background](screenshots/Background%20Image.png)

---

## 🔍 SQL Highlights
Some example queries used in analysis:

```sql
-- Month-over-Month Sales Growth
SELECT 
  MONTH(transaction_date) AS Month, 
  ROUND(SUM(transaction_qty * unit_price)) AS Total_Sales,
  (SUM(transaction_qty * unit_price) - 
   LAG(SUM(transaction_qty * unit_price),1) OVER(ORDER BY MONTH(transaction_date))) 
   / LAG(SUM(transaction_qty * unit_price),1) OVER(ORDER BY MONTH(transaction_date)) * 100 
   AS MOM_Increase_Percentage
FROM coffee_shop_sales
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);
