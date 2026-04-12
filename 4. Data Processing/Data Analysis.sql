 VISUALIZATION (FINAL)

CREATE OR REPLACE TABLE brighttv_analysis_long AS
SELECT
    v.UserID,

    -- 👤 PROFILE DATA
    p.Name,
    p.Surname,
    p.Gender,
    p.Race,
    p.Age,
    p.Province,
    p.Age_Group,

    -- 📺 VIEWING DATA
    v.Channel,
    v.View_Date,
    v.View_Time,
    v.Duration_Minutes,

    -- 📅 DAY NAME
    DATE_FORMAT(v.View_Date, 'EEEE') AS Day_Name,

    -- 📆 WEEKDAY / WEEKEND
    CASE 
        WHEN DATE_FORMAT(v.View_Date, 'E') IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,

    -- ⏰ TIME PERIOD
    CASE
        WHEN HOUR(v.View_Time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(v.View_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(v.View_Time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Late Night'
    END AS Time_Period

FROM tv_viewer_final_clean v
LEFT JOIN tv_profile_final p
ON v.UserID = p.UserID;

SELECT *
FROM brighttv_analysis_long
LIMIT 20;

CREATE OR REPLACE TABLE brighttv_analysis_clean AS
SELECT *
FROM brighttv_analysis_long
WHERE Age IS NOT NULL;

CREATE OR REPLACE TABLE brighttv_analysis_matched_only AS
SELECT *
FROM brighttv_analysis_long
WHERE UserID IS NOT NULL
  AND Channel IS NOT NULL
  AND View_Date IS NOT NULL
  AND Duration_Minutes IS NOT NULL
  AND Name IS NOT NULL
  AND Gender IS NOT NULL
  AND Race IS NOT NULL
  AND Age IS NOT NULL
  AND Province IS NOT NULL
  AND Age_Group IS NOT NULL;

  CREATE OR REPLACE TABLE brighttv_analysis_long AS
SELECT
    v.UserID,

    -- 👤 PROFILE DATA
    p.Name,
    p.Surname,
    p.Gender,
    p.Race,
    p.Age,
    p.Province,
    p.Age_Group,

    -- 📺 VIEWING DATA
    v.Channel,
    v.View_Date,
    v.View_Time,
    v.Duration_Minutes,

    -- 📅 DAY NAME
    DATE_FORMAT(v.View_Date, 'EEEE') AS Day_Name,

    -- 📆 WEEKDAY / WEEKEND
    CASE 
        WHEN DATE_FORMAT(v.View_Date, 'E') IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,

    -- ⏰ TIME PERIOD
    CASE
        WHEN HOUR(v.View_Time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(v.View_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(v.View_Time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Late Night'
    END AS Time_Period

FROM tv_viewer_final_clean v
LEFT JOIN tv_profile_final p
ON v.UserID = p.UserID;


SELECT *
FROM brighttv_analysis_matched_only;
