-- Data Cleaning Script
-- Purpose: Prepare production data for analytical querying
-- Source: Raw production reporting dataset
-- Output: Cleaned production table for analysis

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
