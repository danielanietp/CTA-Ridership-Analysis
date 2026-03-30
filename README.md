# CTA Ridership Analysis

## Overview
This project analyzes ridership trends for the Chicago Transit Authority (CTA) using SQL and Tableau.

The goal was to transform raw transit data into a clean, structured dataset and uncover insights about:
- Station-level ridership trends
- Line-level usage patterns
- Year-over-year growth
- Geographic distribution of ridership

---

## Tech Stack
- SQL (MySQL)
- Beekeeper Studio
- Tableau Public

---

## Data Pipeline

1. **Data Ingestion**
   - Pulled CTA datasets via API
   - Stored raw CSV files

2. **Data Cleaning**
   - Converted boolean fields (TRUE/FALSE → 1/0)
   - Parsed location into latitude and longitude
   - Standardized station identifiers using `station_id`

3. **Data Modeling**
   - Built a station dimension table (`l_stops_clean`)
   - Aggregated ridership per station and year

4. **Feature Engineering**
   - Allocated rides proportionally across lines that shared the same station
   - Created line-level metrics
   - Computed year-over-year growth using window functions

5. **Output**
   - Exported clean datasets for visualization in Tableau

---

## Key Insights

- The **Red Line consistently has the highest ridership**
- Significant **ridership drop in 2020 (COVID impact)**
- Some stations serve multiple lines, requiring proportional allocation

---

## Dashboard
[View Tableau Dashboard](https://public.tableau.com/app/profile/daniela.nieto.prada5218/viz/CTADashboard_17748976779800/Dashboard1)

The dashboard includes:
- Ridership trends over time
- Geographic station map
- Line-level analysis

---

## How to Run

1. Fetch data
   bash scripts/fetch_data.sh
   
2. Load SQL scripts in order:
   - `01_create_tables.sql`
   - `02_load_data.sql`
   - `03_clean_data.sql`
   - `04_sanity_checks.sql`
   - `05_add_missing_stations.sql`
   - `06_yearly_rides_per_station_line.sql`
   - `07_yearly_rides_yoy_per_line.sql`


3. Export final tables:
   - `yearly_rides_per_station_line`
   - `yearly_rides_yoy_per_line`

4. Import CSVs into Tableau

---

## Author
Daniela Nieto Prada
