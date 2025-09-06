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
<img src="https://github.com/user-attachments/assets/6ebcc5e6-a8b7-459d-86d5-fb556a1e8f9d" width="805" height="490" alt="Dashboard" />

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

```
---

📈 Insights

May recorded higher sales compared to April, showing positive MoM growth.

Weekends outperform weekdays in terms of sales volume.

Coffee dominates as the top product category.

Morning hours (8–10 AM) drive peak sales, highlighting customer behavior patterns.

Store location analysis shows downtown outlets as top performers.

📑 License

This project is licensed under the MIT License – see the LICENSE
 file for details.
You are free to use the queries, visuals, and documentation with proper attribution.

👤 Author

Aman Kumar
📧 a.m.a.n.shreewastav11@gmail.com
💼 https://www.linkedin.com/in/aman-kumar-shrivastav


---

Since this is a **portfolio project**, add an **MIT License** file.  
Here’s the content for your `LICENSE` file:

```text
MIT License

Copyright (c) 2025 Aman Kumar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 
```

