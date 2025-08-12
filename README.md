# Task 5 - Sales Trend Analysis (MySQL)

## 📌 Overview
This project creates a MySQL database to store sales order data, cleans and formats the dataset, and generates a **monthly sales trend analysis** showing total revenue and order volume.

The script:
- Creates the database and tables
- Imports order data
- Cleans the `amount` column
- Converts text dates into proper MySQL `DATE` format (handles multiple formats)
- Aggregates data by month
- Displays monthly revenue and order counts

---

## 🗂 Files in this Repository
- `task5_sales_analysis.sql` → Full SQL script for creating tables, cleaning data, and generating the analysis.
- `output_screenshot.png` → Example output of the final monthly aggregation query.

---

## ⚙️ Requirements
- **MySQL 8.x** or compatible version installed
- MySQL Workbench (recommended) or MySQL CLI
- CSV dataset with the following columns:
  - `order_id`
  - `order_date`
  - `amount`
  - `product_id`
  - `customer_id`

---

## 🚀 Steps to Run

1. **Open MySQL Workbench** and connect to your server.

2. **Run the SQL script** step-by-step:
   - Create the database:  
     ```sql
     CREATE DATABASE online_sales_db;
     USE online_sales_db;
     ```
   - Create the `orders` table as defined in the script.

3. **Import your CSV file** into the `orders` table.  
   Check if `secure_file_priv` is set:
   ```sql
   SHOW VARIABLES LIKE 'secure_file_priv';
