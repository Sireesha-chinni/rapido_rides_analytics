# 🛵 Rapido Ride Analytics — July 2025

> An end-to-end data analytics project: from **30,453 messy raw records** to a clean database, SQL insights, Python EDA and an interactive Power BI dashboard.

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-Pandas%20%7C%20Seaborn-yellow?logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Excel](https://img.shields.io/badge/Excel-Data%20Modeling-217346?logo=microsoftexcel&logoColor=white)

---

## 📌 Project Overview

Rapido is one of India's largest bike-taxi and auto-ride platforms. This project analyses **one month of ride data (July 2025)** across **5 cities** to answer questions a business team would actually ask:

- How many rides are completed vs. cancelled?
- Who cancels more — customers or drivers?
- Which cities, vehicles and payment methods drive the most bookings?
- How do customer and driver ratings look?
- How do bookings and cancellations trend day by day?

This was my **first complete data analytics project**, covering the full workflow: **clean → model → query → visualise → report.**

---

## 📊 Key Numbers

| Metric | Value |
|---|---|
| Total bookings | **30,000** (after cleaning) |
| Unique customers | **8,676** |
| Unique drivers | **900** |
| Completed rides | **82.1%** |
| Cancelled rides | **11.9%** |
| Incomplete rides | **6.0%** |
| Customer cancellation rate | **7.04%** |
| Driver cancellation rate | **4.82%** |
| Average customer rating | **4.01 / 5** |
| Average driver rating | **4.00 / 5** |
| Cities covered | Delhi, Hyderabad, Bengaluru, Chennai, Pune |
| Period | 1 – 31 July 2025 |

---

## 🔍 Key Insights

- **Bikes dominate:** Bikes account for **70%** of bookings (21,001) versus **30%** for autos (8,999).
- **UPI is king:** About **50%** of rides are paid via UPI, followed by Wallet (25%), Cash (20%) and Card (5%).
- **Demand is evenly spread:** All five cities have roughly 5,900–6,100 bookings each. Delhi is slightly ahead.
- **Customers cancel more than drivers:** Customer cancellations (7.0%) are about 1.5× driver cancellations (4.8%).
- **Cancellation is a platform-wide pattern, not a city problem:** Customer cancellation rates sit in a narrow 6.9%–7.2% band across all cities.
- **Ratings are consistent:** Customer and driver ratings both average around 4.0, which suggests stable service quality.

---

## 🧰 Tools & Skills Used

| Stage | Tool | What I did |
|---|---|---|
| Data cleaning | **MySQL** | Trimming, standardising text, fixing typos, handling nulls/placeholders, validating ranges with constraints |
| Data modeling | **Excel** | Split the cleaned data into 3 related tables (Booking, Customer, Driver) linked by `Booking_ID` |
| Analysis | **MySQL** | KPIs, aggregations, `CASE WHEN` segmentation, `GROUP BY`, ranking with `LIMIT` |
| EDA | **Python** (Pandas, NumPy, Matplotlib, Seaborn) | Merged tables, trends, distributions, outlier detection |
| Dashboard | **Power BI** | Interactive dashboard of KPIs and trends |

---

## 🗂️ Repository Structure

```
📦 rapido-ride-analytics
 ┣ 📄 rapido_july2025_raw.csv                # Original messy dataset (30,453 rows)
 ┣ 📄 rapido_july2025_cleaned_data.sql       # SQL data cleaning script
 ┣ 📄 rapido_july2025_cleaned_data.xlsx      # Cleaned data (3 sheets: Booking, Customer, Driver)
 ┣ 📄 rapido_data_analysis.sql               # SQL KPIs & business analysis
 ┣ 📓 rapido_data_analysis.ipynb             # Python EDA & visualisations
 ┣ 📊 rapido_data_analysis.pbix              # Power BI dashboard
 ┗ 📄 README.md
```

---

## 🧹 Step 1 — Data Cleaning (SQL)

The raw file was intentionally messy. Here is what I fixed in `rapido_july2025_cleaned_data.sql`:

| Problem in raw data | Example | Fix |
|---|---|---|
| Extra spaces | `" Delhi "` | `TRIM()` on every column |
| Inconsistent casing | `completed`, `COMPLETED` | `UPPER()` / `LOWER()` / `CONCAT()` to standardise |
| Typos in status | `Completd`, `Cancelld`, `In-Complete` | `CASE WHEN` mapping to `Completed`, `Cancelled`, `Incomplete` |
| City name variants | `Bangalore`, `Blr`, `Madras`, `Hyd`, `Dehli`, `Poona` | Mapped to 5 standard cities |
| Vehicle name variants | `Two Wheeler`, `Motorbike`, `Auto-Rickshaw` | Standardised to `Bike` / `Auto` |
| Payment name variants | `GPay`, `PhonePe`, `Paytm Wallet`, `Debit Card` | Grouped into `UPI`, `Wallet`, `Card`, `Cash` |
| ID format issues | `4176`, `cust-4176` | Standardised to `CUST_4176` |
| Units inside numbers | `"12 KM"`, `"6 min"` | Stripped text, converted to numeric |
| Placeholders and blanks | `-`, empty strings | Removed invalid rows or imputed |
| Out-of-range ratings | Rating above 5 | Corrected and enforced with `CHECK` constraints |
| Missing numeric values | Zero distance / time | Replaced with the column average |

**Result:** 30,453 raw rows → **30,000 clean, analysis-ready rows.**

---

## 🗄️ Step 2 — SQL Analysis

`rapido_data_analysis.sql` answers business questions with queries on KPIs and segments:

**KPIs:** total bookings, customers, drivers, completed rides, cancelled rides, average ratings, customer and driver cancellation rates.

**Deeper analysis:**
- Top 10 customers by number of rides
- Customer segmentation by rating level (Low / Medium / High)
- City-wise cancellation rates (customer and driver)
- Cancellation rate by rating
- Rides by vehicle type, payment method and booking status
- Top 10 drivers by rating
- Customer-wise summary (rides, average rating, cancellations)

**Sample query:**

```sql
-- Customer segmentation by rating level
SELECT
  CASE
    WHEN customer_rating < 3.5 THEN 'Low'
    WHEN customer_rating < 4.5 THEN 'Medium'
    ELSE 'High'
  END AS customer_rating_level,
  COUNT(*) AS number_of_customers
FROM rapido_table
GROUP BY customer_rating_level;
```

---

## 🐍 Step 3 — Python EDA

In `rapido_data_analysis.ipynb` I:

1. Loaded the 3 cleaned sheets (`Booking_Data`, `Customer_Data`, `Driver_Data`)
2. Merged them on `Booking_ID` into one 30,000-row DataFrame
3. Checked nulls, duplicates and data types
4. Built visualisations:
   - Ride status distribution (pie)
   - Payment method distribution (pie)
   - Bookings by vehicle type (bar)
   - Daily booking trend for July 2025 (line)
   - Daily customer-cancelled rides (line)
   - Customer rating distribution and rating levels
   - Outlier detection on ratings (box plot)

---

## 📈 Step 4 — Power BI Dashboard

`rapido_data_analysis.pbix` brings the analysis together in an interactive dashboard with KPI cards and visuals for bookings, cancellations, cities, vehicles, payments and ratings.

<img width="1205" height="677" alt="dashboard-1" src="https://github.com/user-attachments/assets/00d299eb-def3-4049-9572-a4977d95910b" />
<img width="1202" height="676" alt="dashboard-2" src="https://github.com/user-attachments/assets/a588b005-0bf5-407c-800f-8c078f4fced7" />
<img width="1205" height="677" alt="dashboard-3" src="https://github.com/user-attachments/assets/c269a410-8640-404a-88a5-d5be6c4fb613" />


---

## 💡 Business Recommendations

1. **Reduce customer cancellations (7%)** — introduce small cancellation fees or reminders, or show accurate ETAs before booking.
2. **Push UPI offers** — half of all rides already use UPI, so cashback can strengthen this habit and reduce cash handling.
3. **Invest in bike supply** — with 70% of demand, bike availability matters most for completion rates.
4. **Investigate the 6% incomplete rides** — understanding why rides stop midway can recover revenue.
5. **Focus on driver retention programs** — with 900 drivers serving 8,600+ customers, each driver is highly valuable.

---

## ▶️ How to Run This Project

1. **Clone the repo**
   ```bash
   git clone https://github.com/<your-username>/rapido-ride-analytics.git
   ```
2. **SQL:** load `rapido_july2025_raw.csv` into MySQL, then run `rapido_july2025_cleaned_data.sql` and `rapido_data_analysis.sql`.
3. **Python:** install the libraries and open the notebook.
   ```bash
   pip install pandas numpy matplotlib seaborn openpyxl jupyter
   jupyter notebook rapido_data_analysis.ipynb
   ```
4. **Power BI:** open `rapido_data_analysis.pbix` in Power BI Desktop.

---

## 🎯 What I Learned

- Cleaning real-world messy data end to end with SQL
- Turning raw numbers into KPIs and business insights
- Combining SQL, Python and Power BI in a single workflow
- Telling a story with data, not just writing queries

---

## 👤 About Me

**Ch Sai Sireesha**
Aspiring Data Analyst

📧 your.email@example.com
🔗 [LinkedIn](https://linkedin.com/in/sireesha-chinni) • [GitHub](https://github.com/Sireesha-chinni)

⭐ If you found this project useful, please give it a star!

---

*Note: This is a learning project built on a sample dataset and is not affiliated with Rapido.*
