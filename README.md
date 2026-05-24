# Electricity Demand Peak-Valley Analysis Using MySQL

## Project Overview

This is an independent SQL portfolio project analyzing hourly electricity demand patterns in CAISO during July 2024.

The project focuses on peak-valley demand gaps, hourly demand patterns, forecast errors, and weekday-weekend demand differences. It also discusses potential battery energy storage use cases such as peak shaving, valley filling, and grid flexibility support.

## Data Source

- Data Source: EIA Hourly Electric Grid Monitor
- Region: California Independent System Operator (CAISO)
- Period: July 2024
- Frequency: Hourly
- Raw Records: 2,980
- Demand View Records: 744

## Tools Used

- MySQL Workbench
- Python
- Excel

## Key SQL Skills Demonstrated

- Data filtering and cleaning
- Date and time conversion
- SQL view creation
- Aggregation with GROUP BY
- Conditional classification using CASE WHEN
- Window functions such as RANK() OVER()
- Forecast error calculation
- Weekday and weekend demand comparison

## Main Analysis Questions

1. What is the average hourly electricity demand pattern in CAISO?
2. Which days had the largest daily peak-valley demand gaps?
3. When do daily peak and valley demand hours usually occur?
4. How large were the forecast errors between actual demand and day-ahead forecasts?
5. How do weekday and weekend demand patterns differ?
6. What do these patterns imply for battery energy storage use cases?

## Key Findings

- CAISO electricity demand showed clear intraday variation in July 2024.
- Average demand was relatively low during early morning hours and higher during evening peak periods.
- Several days had large peak-valley gaps, suggesting stronger potential value for peak shaving and valley filling.
- Forecast errors varied across the month, indicating that demand uncertainty was not constant.
- Weekday demand was generally higher than weekend demand, especially during afternoon and evening hours.
- Battery energy storage may create operational value by charging during lower-demand periods and discharging during peak-load periods.

## Storage Use Case Implications

This project does not directly estimate storage revenue or investment returns. Instead, it provides an initial demand-side foundation for understanding where battery storage may create operational value.

Potential storage use cases include:

- Peak shaving
- Valley filling
- Real-time flexibility support
- Response to forecast errors
- Weekday peak-load support

## Limitations and Future Work

This project focuses only on July 2024 and does not include electricity price data, weather variables, renewable generation data, or detailed battery technical parameters.

Future work could extend the analysis by:

- Expanding the dataset to a full year or multiple years
- Adding CAISO electricity price data
- Including weather and renewable generation variables
- Estimating storage arbitrage opportunities
- Building regression or time-series models

## Project Report

The full written report is available here:

[Full Project Report](report/SQL_Electricity_Project_Report_Final.pdf).

## Reproducibility

The project can be reproduced through the following workflow:

1. Download CAISO hourly electricity data from the EIA API using the Python script in the `python` folder.
2. Clean column names and prepare the CSV file for MySQL import.
3. Import the cleaned CSV file into MySQL Workbench.
4. Run the SQL scripts in numerical order from `00` to `07`.
5. Export the result tables and generate charts for reporting.

## Author

Haozhe Chen (Eric)
