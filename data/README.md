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

## Data Classifications for Analysis
### usable_for_time_series_totals: 
  - zero volumes, negative adjustments, records without FIPS can be included
  - all dates seem valid and so none need exclusion
  - returns 470,830 records
  
### usable_for_geographic_analysis:
  - zero volume records, negative adjustments can be included
  - records without FIPS codes should be excluded as they don't have enough geographical information for analysis
  - returns 454,200 records
  
### usable_for_performance_comparisons:
  - positive production volumes, valid FIPS codes
  - any null FIPS codes, and zero or negative volume records
  - returns 153,709

## Data Cleaning Notes
Any assumptions, exclusions, or known data limitations encountered during cleaning are documented as they make themselves relevant. 
### So far, the known data quality issues are as follows:
- NULL production volumes exist and are excluded from volume-based metrics
- Negative production values represent adjustments and are treated separately from performance metrics
- Zero production records are retained to reflect inactivity periods
- Asset identification is limited to county-level FIPS codes
- Records with missing FIPS codes are excluded from geographic analysis but usable for totals

### Counts of:
- zero-volume records: 296,558
- negative-volume records: 13,036
- missing-FIPS records: 16,630

