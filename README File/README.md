# BrightTV-Subscription-Growth-Analysis

# BrightTV Viewership Analytics: Growth Strategy Case Study 📺
--

## 📌 Project Overview
This project was commissioned by the CEO of **BrightTV** to drive growth in the company's subscription base for the current financial year. As a Data Analyst, my objective was to provide actionable insights for the **Customer Value Management (CVM)** team by analyzing user profiles and viewer transaction data.

The goal is to understand usage trends, identify factors influencing consumption, and recommend initiatives to increase engagement on low-activity days.

---
## 🚀 Key Business Questions Addressed
1. **User Trends:** Who is watching BrightTV and where are they located?
2. **Consumption Factors:** What content types and channels drive the most engagement?
3. **Low-Consumption Analysis:** Which days show the lowest activity and why?
4. **Growth Strategy:** What initiatives will grow the user base and re-engage inactive subscribers?

---

## 🛠️ Tools Used
* **SQL (Databricks):** For data extraction, joining tables, and complex analysis.
* **Excel:** Used for Pivot Tables, data cleaning, and quick trend visualization.
* **Miro:** For project planning and data flow mapping.
* **Canva:** For the final executive presentation.
* **GitHub:** For version control and project documentation.

---

## 📊 Data Processing & Methodology
### 1. The "Clock Rule" (Timezone Correction)
As per project requirements, all timestamps were supplied in **UTC**. I applied a SQL transformation to convert these to **South African Standard Time (SAST)** ($UTC + 2$) to ensure the analysis reflected local viewing habits accurately.

### 2. Data Integration
I performed an `INNER JOIN` between the `user_profile` and `viewership` tables using the `UserID` as the primary key to link demographic data with viewing behavior.

### 3. Exploratory Data Analysis (EDA)
I executed 10 key SQL queries to identify:
* Peak viewing hours (Morning vs. Primetime).
* Provincial viewership distribution.
* High-value "Power Users" vs. Inactive users.
* Content popularity by age group and gender.

## 💡 Key Insights (Summary)
* **Peak Times:** [Viewership peaks at 19:00 SAST].
* **Low-Usage Days:** [Tuesdays show a 25% drop in sessions].
* **Top Segment:** [Young Adults (18-35) are the most active subscribers].

## 📂 Repository Structure
├── data/                   # Raw CSV data files
├── planning/               # Miro Flowchart & Project Gantt Chart
├── scripts/                # bright_tv_analysis.sql (Final SQL Code)
├── docs/                   # Case Study Brief (PDF) & Excel Analysis
├── presentation/           # Final Presentation Slides & Dashboard Link
└── README.md               # Project overview and documentation

