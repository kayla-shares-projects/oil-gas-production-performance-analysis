## DATA CLEANING SCRIPT
-- Purpose: Prepare production data for analytical querying
-- Source: Raw production reporting dataset
-- Output: Cleaned production table for analysis

## DATA CLASSIFICATIONS FOR ANALYSIS
#usable_for_time_series_totals: 
  --zero volumes, negative adjustments, records without FIPS can be included
  --all dates seem valid and so none need exclusion
  CREATE VIEW time_series_analysis AS
  SELECT * FROM production
  --returns 470,830 records
  
#usable_for_geographic_analysis:
  --zero volume records, negative adjustments can be included
  --records without FIPS codes should be excluded as they don't have enough geographical information for analysis
  CREATE VIEW geographical_analysis AS
  SELECT * FROM production
  WHERE FIPS_code IS NOT NULL
  --returns 454,200 records
  
#usable_for_performance_comparisons:
  --positive production volumes, valid FIPS codes
  --any null FIPS codes, and zero or negative volume records
  CREATE VIEW performance_analysis AS
  SELECT * FROM production
  WHERE FIPS_code IS NOT NULL
  AND volume > 0
  --returns 153,709

## QUERIES AND COMMENTS
--Change table type from text to date
ALTER TABLE production ALTER COLUMN "Production Date"
TYPE date
USING "Production Date"::date

--Remove commas from numbers and changing data type from text to bigint
UPDATE production
SET "Volume" = REPLACE("Volume",',','')

ALTER TABLE production ALTER COLUMN "Volume"
TYPE bigint
USING "Volume"::bigint

--Change column names to remove quotations
ALTER TABLE production
RENAME COLUMN "Commodity" to Commodity
ALTER TABLE production
RENAME COLUMN "Volume" to Volume
ALTER TABLE production
RENAME COLUMN "Disposition Description" to Disposition_Description
ALTER TABLE production
RENAME COLUMN "Disposition Code" to Disposition_Code
--etc...
