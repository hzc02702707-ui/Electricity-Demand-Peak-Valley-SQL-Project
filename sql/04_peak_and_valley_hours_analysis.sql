USE electricity_project;
#1.Top 10 highest demand hours in July 2024
-- Note: period_time is in UTC.
-- In July, California local time is roughly UTC - 7 hours.
SELECT
    period_time AS period_time_utc,
    DATE_SUB(period_time, INTERVAL 7 HOUR) AS period_time_pdt,
    HOUR(period_time) AS hour_utc,
    HOUR(DATE_SUB(period_time, INTERVAL 7 HOUR)) AS hour_pdt,
    demand_mwh
FROM caiso_demand_july2024
ORDER BY demand_mwh DESC
LIMIT 10;
#2.Top 10 lowest demand hours in July 2024
-- Purpose:
-- Identify the hours with the lowest electricity demand.
-- Note: period_time is in UTC; period_time_pdt is California local time.
SELECT
    period_time AS period_time_utc,
    DATE_SUB(period_time, INTERVAL 7 HOUR) AS period_time_pdt,
    HOUR(period_time) AS hour_utc,
    HOUR(DATE_SUB(period_time, INTERVAL 7 HOUR)) AS hour_pdt,
    demand_mwh
FROM caiso_demand_july2024
ORDER BY demand_mwh
LIMIT 10;
#Daily peak and valley hour identification
-- Purpose:
-- Find the exact peak hour and valley hour for each day.
-- This uses window functions.
select
demand_date,
MAX(CASE WHEN peak_rank = 1 THEN period_time END) AS peak_time_utc,
MAX(CASE WHEN peak_rank = 1 THEN period_time_pdt END) AS peak_time_pdt,
MAX(CASE WHEN peak_rank = 1 THEN hour_pdt END) AS peak_hour_pdt,
MAX(CASE WHEN peak_rank = 1 THEN demand_mwh END) AS daily_peak_mwh,
MAX(CASE WHEN valley_rank = 1 THEN period_time END) AS valley_time_utc,
MAX(CASE WHEN valley_rank = 1 THEN period_time_pdt END) AS valley_time_pdt,
MAX(CASE WHEN valley_rank = 1 THEN hour_pdt END) AS valley_hour_pdt,
MAX(CASE WHEN valley_rank = 1 THEN demand_mwh END) AS daily_valley_mwh,
MAX(CASE WHEN peak_rank = 1 THEN demand_mwh END)- MAX(CASE WHEN valley_rank = 1 THEN demand_mwh END) AS peak_valley_gap_mwh        
from                 
       (SELECT
        demand_date,
        period_time,
        DATE_SUB(period_time, INTERVAL 7 HOUR) AS period_time_pdt,
        HOUR(period_time) AS hour_utc,
        HOUR(DATE_SUB(period_time, INTERVAL 7 HOUR)) AS hour_pdt,
        demand_mwh, 
        rank() over (partition by demand_date order by demand_mwh desc) peak_rank,
        rank() over (partition by demand_date order by demand_mwh) valley_rank
        from caiso_demand_july2024) ranked_demand
group by demand_date
order by MAX(CASE WHEN peak_rank = 1 THEN demand_mwh END)- MAX(CASE WHEN valley_rank = 1 THEN demand_mwh END) desc