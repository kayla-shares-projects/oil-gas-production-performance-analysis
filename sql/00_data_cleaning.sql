-- Data Cleaning Script
-- Purpose: Prepare production data for analytical querying
-- Source: Raw production reporting dataset
-- Output: Cleaned production table for analysis

ALTER TABLE production ALTER COLUMN "Production Date"
TYPE date
USING "Production Date"::date

UPDATE production
SET "Volume" = REPLACE("Volume",',','')

ALTER TABLE production ALTER COLUMN "Volume"
TYPE bigint
USING "Volume"::bigint

'NEXT CHANGE TABLE NAMES'
