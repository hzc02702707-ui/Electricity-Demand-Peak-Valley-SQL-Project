USE electricity_project;
#finding Daily peak, valley, peak-valley gap，and peak-valley gap percentage of valley
SELECT
    demand_date,
    MAX(demand_mwh) AS daily_peak_mwh,
    MIN(demand_mwh) AS daily_valley_mwh,
    MAX(demand_mwh) - MIN(demand_mwh) AS peak_valley_gap_mwh,
    ROUND((MAX(demand_mwh) - MIN(demand_mwh)) / MIN(demand_mwh) * 100,2) AS peak_valley_gap_pct
FROM caiso_demand_july2024
GROUP BY demand_date
ORDER BY peak_valley_gap_mwh DESC;