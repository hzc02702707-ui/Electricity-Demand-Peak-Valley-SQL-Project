USE electricity_project;
#summary1:monthly total demand
SELECT
    COUNT(*) AS total_hourly_observations,
    COUNT(DISTINCT demand_date) AS total_days,
    ROUND(AVG(demand_mwh), 2) AS avg_demand_mwh,
    MAX(demand_mwh) AS max_demand_mwh,
    MIN(demand_mwh) AS min_demand_mwh
FROM caiso_demand_july2024;
#summary2:largest 5 days in peak_valley_gap
SELECT
    demand_date,
    MAX(demand_mwh) AS daily_peak_mwh,
    MIN(demand_mwh) AS daily_valley_mwh,
    MAX(demand_mwh) - MIN(demand_mwh) AS peak_valley_gap_mwh,
    ROUND((MAX(demand_mwh) - MIN(demand_mwh)) / MIN(demand_mwh) * 100, 2) AS peak_valley_gap_pct
FROM caiso_demand_july2024
GROUP BY demand_date
ORDER BY peak_valley_gap_mwh DESC
LIMIT 5; 
#summary3:forecast error
SELECT
    COUNT(*) AS total_hourly_observations,
    ROUND(AVG(forecast_error_mwh), 2) AS avg_forecast_error_mwh,
    ROUND(AVG(abs_forecast_error_mwh), 2) AS avg_abs_forecast_error_mwh,
    MAX(abs_forecast_error_mwh) AS max_abs_forecast_error_mwh,
    ROUND(AVG(abs_forecast_error_pct), 2) AS avg_abs_forecast_error_pct
FROM caiso_forecast_error_july2024;