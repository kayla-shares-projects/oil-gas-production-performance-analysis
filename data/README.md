# Data Overview and Preparation

## Raw Data
The `raw/` folder contains unmodified source data as obtained from the original provider. These files are not altered to preserve reproducibility.

## Cleaned Data
The `cleaned/` folder contains processed versions of the raw data used for analysis. Cleaning steps are performed using SQL and/or Python and focus on improving consistency, usability, and analytical reliability.

## Data Cleaning Objectives
- Standardize date formats and reporting periods
- Normalize measurement units where applicable
- Handle missing, duplicate, or invalid records
- Ensure consistent naming for categorical fields
- Derive analytical fields (e.g., response duration, reporting lag)

## Notes
Any assumptions, exclusions, or known data limitations encountered during cleaning will be documented alongside the cleaning scripts.
