USE electricity_project;
#1. Average demand by hour of day
-- Purpose:
-- Identify which hours usually have the highest and lowest electricity demand.
SELECT
    hour_of_day,
    ROUND(AVG(demand_mwh), 2) AS avg_demand_mwh,
    MAX(demand_mwh) AS max_demand_mwh,
    MIN(demand_mwh) AS min_demand_mwh
FROM caiso_demand_july2024
GROUP BY hour_of_day
ORDER BY avg_demand_mwh DESC;
#2. Hourly demand pattern ordered by time
-- Purpose:
-- Show the daily load curve from 00:00 to 23:00.
SELECT
    HOUR(DATE_SUB(period_time, INTERVAL 7 HOUR)) AS hour_pdt,
    ROUND(AVG(demand_mwh), 2) AS avg_demand_mwh,
    MAX(demand_mwh) AS max_demand_mwh,
    MIN(demand_mwh) AS min_demand_mwh
FROM caiso_demand_july2024
GROUP BY hour_pdt
ORDER BY hour_pdt;
