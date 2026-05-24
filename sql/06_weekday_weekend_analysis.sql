USE electricity_project;
# 1. Label each date as weekday or weekend
-- Purpose:
-- Check the day type for each demand date.
SELECT DISTINCT
    demand_date,
    DAYNAME(demand_date) AS day_name,
    CASE
        WHEN DAYOFWEEK(demand_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type
FROM caiso_demand_july2024
ORDER BY demand_date;
#2. Average demand by day type
-- Purpose:
-- Compare electricity demand between weekdays and weekends.
SELECT
    CASE
        WHEN DAYOFWEEK(demand_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS hourly_observations,
    ROUND(AVG(demand_mwh), 2) AS avg_demand_mwh,
    MAX(demand_mwh) AS max_demand_mwh,
    MIN(demand_mwh) AS min_demand_mwh
FROM caiso_demand_july2024
GROUP BY day_type
ORDER BY avg_demand_mwh DESC;
#3. Peak-valley gap by day type
-- Purpose:
-- Compare daily demand fluctuation between weekdays and weekends.
SELECT
    day_type,
    COUNT(*) AS number_of_days,
    ROUND(AVG(daily_peak_mwh), 2) AS avg_daily_peak_mwh,
    ROUND(AVG(daily_valley_mwh), 2) AS avg_daily_valley_mwh,
    ROUND(AVG(peak_valley_gap_mwh), 2) AS avg_peak_valley_gap_mwh,
    MAX(peak_valley_gap_mwh) AS max_peak_valley_gap_mwh
FROM 
(SELECT
        demand_date,
        CASE
            WHEN DAYOFWEEK(demand_date) IN (1, 7) THEN 'Weekend'
            ELSE 'Weekday'
        END AS day_type,
        MAX(demand_mwh) AS daily_peak_mwh,
        MIN(demand_mwh) AS daily_valley_mwh,
        MAX(demand_mwh) - MIN(demand_mwh) AS peak_valley_gap_mwh
    FROM caiso_demand_july2024
    GROUP BY demand_date) daily_stats
    GROUP BY day_type
ORDER BY avg_peak_valley_gap_mwh DESC;
#4. Hourly demand pattern by day type
-- Purpose:
-- Compare hourly load curves between weekdays and weekends.
SELECT
    CASE
        WHEN DAYOFWEEK(demand_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    hour_of_day,
    ROUND(AVG(demand_mwh), 2) AS avg_demand_mwh
FROM caiso_demand_july2024
GROUP BY day_type, hour_of_day
ORDER BY day_type, hour_of_day;