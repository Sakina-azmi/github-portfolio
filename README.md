# github-portfolio

# 🌍 Global Superstore Analytics Project

This project analyzes 4 years of transactional data from a multinational retail chain, **Superstore USA**, with the goal of identifying performance gaps, improving profitability, and optimizing logistics. It demonstrates a full-stack analytics workflow using **SQL, Python, Excel, Power BI, and Tableau**—turning raw data into measurable business outcomes.

---

## 🎯 Business Objectives

Superstore USA faced three critical challenges:
1. **Declining profit margins**, especially in high-revenue categories.
2. **Uneven regional performance**, with unexplained underperformance in certain states.
3. **Ineffective discount strategies**, applied uniformly without data-backed analysis.

This project aimed to:
- Identify **key drivers of profitability** (by product and region)
- Optimize **discount thresholds** to protect margins while increasing sales
- Provide **real-time dashboards** for executive decision-making
- Streamline **logistics and shipping costs** using data insights

---

## 🧰 Tools & Technologies

| Tool        | Use Case                                                                 |
|-------------|--------------------------------------------------------------------------|
| **SQL (BigQuery)**     | Data extraction, joins, aggregation, time-series queries              |
| **Python (Pandas, Seaborn)** | Data cleaning, statistical analysis, discount impact modeling         |
| **Excel**    | Forecasting, pivot table validation, sensitivity analysis              |
| **Power BI** | KPI dashboards, dynamic DAX measures, operational reports               |
| **Tableau**  | Geo-spatial analysis, interactive storytelling dashboards               |

---

📊 Phase-wise Breakdown

### 📌 Phase 1: Data Extraction & Cleaning  
**Tools Used**: SQL + Python + Excel  
- Connected to structured retail datasets via **BigQuery**
- Wrote 15+ SQL queries to join `Orders`, `Returns`, and `Customers` tables
- Created custom date logic for year-on-year and quarterly trend analysis
- Used Python (Pandas) for handling missing values, correcting discount logic
- Validated with Excel using pivot tables & basic regression models


### 📌 Phase 2: Analysis & Insight Discovery
Tools Used: Python + Tableau

Created a discount_impact feature: how profit changes with discount %

Found a strong negative correlation (r = -0.71) between high discounts (>15%) and profit

Conducted region-wise performance clustering using seaborn heatmaps

Identified low-margin product segments and poorly performing shipping modes

python

df['discount_impact'] = df['profit'] / (df['sales'] * (1 - df['discount']))
🧠 Key Insight:
Discounts above 15% reduced profits by 22%, statistically significant (p-value < 0.01)

### 📌 Phase 3: Dashboarding & Reporting
Tools Used: Power BI + Tableau

🟢 Power BI (Operational Reporting)
Built dynamic dashboards with drill-through filters for Category, Region, and Segment

Created KPIs using DAX:

dax

Profit Margin = DIVIDE([Total Profit], [Total Sales], 0)
Set alerts for regions with <5% margin to notify sales teams

🔵 Tableau (Exploratory Insights)
Interactive maps showing sales density by ZIP

Discount vs profit sensitivity curves

Year-over-year and seasonal trends

✅ Tableau Public Link: https://public.tableau.com/views/Book1_17362600500780/AnalyticsReport?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

🔍 Business Insights Summary
Category	Sales Share	Profit Margin	Action Taken
Technology	36.4%	12.1%	Reduced discounting
Office Supplies	31.3%	15.8%	Increased marketing
Furniture	22.3%	8.4%	Rerouted logistics

🧭 Region Insights:

Top Regions: Texas, Washington, Florida

Problem Area: Montana (negative margins, high logistics cost)

💰 Financial Impact:

+12% potential profit from marketing reallocation

$1.4M/year savings from optimized shipping routes

5% higher conversion using targeted discount caps

📈 Final Dashboards Preview
📌 Power BI Screenshot

📌 Tableau – Discount Curve

🔄 Automation Setup
SQL → Power BI via daily refresh with scheduled dataflows

Python scripts scheduled weekly to generate Tableau extracts

🚀 Lessons Learned
Combining SQL + Python is powerful for performance diagnostics

Power BI is best for internal tracking; Tableau excels at storytelling

Excel models still build trust with non-technical stakeholders

Every tool has a role; integration > specialization

✅ Next Steps
Incorporate real-time inventory and order tracking

Use time series forecasting (Prophet/ARIMA) for predicting seasonal sales

Add user segmentation and targeted marketing insights

📬 Contact
Created by Sakina Azmi
💼 Data Analyst | Skilled in SQL, Power BI, Python, Tableau
📫 Reach out for collaboration, feedback, or opportunities!
