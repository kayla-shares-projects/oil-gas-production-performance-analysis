--Question 1: Which counties are experiencing sustsained growth or sustained decline in production
WITH 
	yearlyprod AS(
		SELECT sum(volume) as sumtime, fips_code, extract(year from production_date) as by_year 
		FROM performance_analysis
		GROUP BY by_year, fips_code
	),
	yearlydiff AS (
		SELECT 
			sumtime, 
			fips_code, 
			by_year, 
			sumtime -
				LAG(sumtime) OVER(
				PARTITION BY fips_code
				ORDER BY by_year) as yearlychange
		FROM yearlyprod	
	)
SELECT avg(yearlychange) as avg_yearly_change, fips_code 
FROM yearlydiff
GROUP BY fips_code

--When paired with the below query we can compare the average yearly difference in production to the amount of years the asset has been on our records. This is to avoid attributing spikes because of recent open or closure to overall county trends
SELECT COUNT(DISTINCT EXTRACT(year from production_date)), 
fips_code 
FROM production
GROUP BY fips_code

--Comments: Our time window was defined by the 10 years on our records. And growth was defined by average year over year change, and looking at a trend slope.

	
--Question 2: Which counties have already passed peak production, and which are still growing?
WITH 
	yearlyprod AS(
		SELECT sum(volume) as yearlytotal, fips_code, extract(year from production_date) as byyear 
		FROM performance_analysis
		GROUP BY byyear, fips_code
	),
	rankedprod AS(
		SELECT 
			fips_code, 
			yearlytotal, 
			byyear,
			RANK()OVER(
				PARTITION BY fips_code
				ORDER BY yearlytotal DESC
			) AS prodrank
		FROM yearlyprod	
	),
	latestyear AS (
		SELECT
			fips_code,
			MAX(byyear)AS maxyear
		FROM yearlyprod
		GROUP BY fips_code
	)


SELECT 
	rp.fips_code,
	rp.byyear AS peakyear,
	rp.yearlytotal AS peakvalue,
	ly.maxyear,
	CASE 
    	WHEN rp.byyear = ly.maxyear THEN 'At Peak'
    	ELSE 'Post-Peak'
	END as Status
FROM rankedprod rp
JOIN latestyear ly ON rp.fips_code = ly.fips_code
WHERE rp.prodrank = 1

--Comments:
