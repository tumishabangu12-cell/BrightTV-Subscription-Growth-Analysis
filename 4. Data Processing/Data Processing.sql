--1. Top channels by viewing hours
SELECT
    Channel,
    COUNT(*) AS Sessions,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
GROUP BY Channel
ORDER BY Total_Hours DESC;

-- 2. Peak viewing day

SELECT
    DATE_FORMAT(View_Date, 'EEEE') AS Day_Name,
    COUNT(*) AS Sessions,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
GROUP BY DATE_FORMAT(View_Date, 'EEEE')
ORDER BY Total_Hours DESC;

--- 3. Low-consumption day

SELECT
    DATE_FORMAT(View_Date, 'EEEE') AS Day_Name,
    COUNT(*) AS Sessions,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
GROUP BY DATE_FORMAT(View_Date, 'EEEE')
ORDER BY Total_Hours ASC;

---4. Weekday vs weekend
SELECT
    CASE
        WHEN DATE_FORMAT(View_Date, 'E') IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    COUNT(*) AS Sessions,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
GROUP BY
    CASE
        WHEN DATE_FORMAT(View_Date, 'E') IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY Total_Hours DESC;

---5. Time-of-day analysis
SELECT
    CASE
        WHEN HOUR(View_Time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(View_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(View_Time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Late Night'
    END AS Time_Period,
    COUNT(*) AS Sessions,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
GROUP BY
    CASE
        WHEN HOUR(View_Time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(View_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(View_Time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Late Night'
    END
ORDER BY Total_Hours DESC;

--- 6. Age group analysis

SELECT
    Age_Group,
    COUNT(*) AS Views,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
WHERE Age_Group IS NOT NULL
GROUP BY Age_Group
ORDER BY Total_Hours DESC;

---7. Province analysis
SELECT
    Province,
    COUNT(*) AS Views,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long
WHERE Province IS NOT NULL
GROUP BY Province
ORDER BY Total_Hours DESC;

--8. Top channels on low-consumption days
WITH day_hours AS (
    SELECT
        DATE_FORMAT(View_Date, 'EEEE') AS Day_Name,
        ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
    FROM brighttv_analysis_long
    GROUP BY DATE_FORMAT(View_Date, 'EEEE')
),
peak_day AS (
    SELECT Day_Name
    FROM day_hours
    ORDER BY Total_Hours DESC
    LIMIT 1
)
SELECT
    b.Channel,
    COUNT(*) AS Sessions,
    ROUND(SUM(b.Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long b
JOIN peak_day p
    ON DATE_FORMAT(b.View_Date, 'EEEE') = p.Day_Name
GROUP BY b.Channel
ORDER BY Total_Hours DESC;

--- 9. Top channels on peak day
WITH day_hours AS (
    SELECT
        DATE_FORMAT(View_Date, 'EEEE') AS Day_Name,
        ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
    FROM brighttv_analysis_long
    GROUP BY DATE_FORMAT(View_Date, 'EEEE')
),
peak_day AS (
    SELECT Day_Name
    FROM day_hours
    ORDER BY Total_Hours DESC
    LIMIT 1
)
SELECT
    b.Channel,
    COUNT(*) AS Sessions,
    ROUND(SUM(b.Duration_Minutes) / 60, 2) AS Total_Hours
FROM brighttv_analysis_long b
JOIN peak_day p
    ON DATE_FORMAT(b.View_Date, 'EEEE') = p.Day_Name
GROUP BY b.Channel
ORDER BY Total_Hours DESC;

--- 10. Full summary table for reporting

CREATE OR REPLACE TABLE brighttv_master_summary AS
SELECT
    Channel,
    Province,
    Age_Group,
    DATE_FORMAT(View_Date, 'EEEE') AS Day_Name,
    CASE
        WHEN DATE_FORMAT(View_Date, 'E') IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    CASE
        WHEN HOUR(View_Time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(View_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(View_Time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Late Night'
    END AS Time_Period,
    COUNT(*) AS Total_Views,
    COUNT(DISTINCT UserID) AS Unique_Viewers,
    ROUND(SUM(Duration_Minutes), 2) AS Total_Minutes,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours,
    ROUND(AVG(Duration_Minutes), 2) AS Avg_Minutes_Per_View,
    ROUND(MAX(Duration_Minutes), 2) AS Max_Session_Minutes,
    ROUND(MIN(Duration_Minutes), 2) AS Min_Session_Minutes
FROM brighttv_analysis_long
GROUP BY
    Channel,
    Province,
    Age_Group,
    DATE_FORMAT(View_Date, 'EEEE'),
    CASE
        WHEN DATE_FORMAT(View_Date, 'E') IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END,
    CASE
        WHEN HOUR(View_Time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(View_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(View_Time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Late Night'
    END;
---11 QUICK CHECK OF YOUR FINAL TABLE

SELECT*
FROM brighttv_master_summary
LIMIT 20;

--- 12. Best SQL for your presentation opening slide
   SELECT
    COUNT(*) AS Total_Sessions,
    COUNT(DISTINCT UserID) AS Unique_Viewers,
    ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Viewing_Hours,
    ROUND(AVG(Duration_Minutes), 2) AS Avg_Minutes_Per_Session
FROM brighttv_analysis_long;
