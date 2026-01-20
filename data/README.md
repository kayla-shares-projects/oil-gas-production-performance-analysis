# Data Overview and Preparation

## Raw Data
The `raw/` folder contains unmodified source data as obtained from the original provider. These files are not altered to preserve reproducibility.

## Cleaned Data
The `cleaned/` folder contains processed versions of the raw data used for analysis. Cleaning steps are performed using SQL and/or Python and focus on improving consistency, usability, and analytical reliability.

## Data Cleaning Objectives
- Standardize date formats and reporting periods if necessary
- Normalize measurement units where applicable
- Handle missing, duplicate, or invalid records
- Ensure consistent naming for categorical fields
- Derive analytical fields (e.g., response duration, reporting lag)

## Notes
Any assumptions, exclusions, or known data limitations encountered during cleaning are documented as they make themselves relevant. 
# So far, the known data quality issues are as follows:

- NULL production volumes exist and are excluded from volume-based metrics
- Negative production values represent adjustments and are treated separately from performance metrics
- Zero production records are retained to reflect inactivity periods
- Asset identification is limited to county-level FIPS codes
- Records with missing FIPS codes are excluded from geographic analysis but usable for totals

# Counts of:
zero-volume records: 296,558
negative-volume records: 13,036
missing-FIPS records: 16,630
