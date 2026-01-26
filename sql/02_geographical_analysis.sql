--# Question 1: How is total production distributed geographically by county over time?
select sum(volume) as volume_sum, fips_code, extract (year from production_date) as by_year
from geographical_analysis
group by by_year, fips_code
having sum(volume) > 0
order by by_year
-- Comments: This query returns the total yearly production by county, making sure to separate inactive assets by filtering out where county production was zero in a year.

-- Question 2: 
	select sum(volume) as volume_sum, fips_code
	from geographical_analysis
	group by fips_code
	having sum(volume) > 0
	order by volume_sum desc
-- Comments: This query breaks down which county produced the highest volume over the 10-year period that our dataset recorded.

-- Question 3: Which counties consistently lead in yearly production?
WITH 
	prod_bycounty AS(
		select 
			sum(volume) as volume_sum, 
			fips_code, 
			extract (year from production_date) as by_year
		from geographical_analysis
		group by by_year, fips_code
		having sum(volume) > 0
	),
	ranked AS(
		select 
			by_year,
			volume_sum, 
			fips_code, 
			rank()over(
				partition by by_year 
				order by volume_sum desc) as yearly_rank
		from prod_bycounty
	)
select 
	count(*) as years_ranked_first,
	fips_code
from ranked
where yearly_rank = 1
group by fips_code
-- Comments: This tells us which county, if anywhere, most frequently lead annual production.

-- Question 4: How have the top-producing counties changed over time?
WITH 
	prod_bycounty AS(
		select 
			sum(volume) as volume_sum, 
			fips_code, 
			extract (year from production_date) as by_year
		from geographical_analysis
		group by by_year, fips_code
		having sum(volume) > 0
	),
	ranked AS(
		select 
			by_year,
			volume_sum, 
			fips_code, 
			rank()over(
				partition by by_year 
				order by volume_sum desc) as yearly_rank
		from prod_bycounty
	),
	top_counties_per_year AS (
    SELECT
        by_year,
        fips_code
    FROM ranked
    WHERE yearly_rank <=5
	)
select 
	count(distinct by_year) as years_in_top5,
	fips_code
from top_counties_per_year
group by fips_code
order by years_in_top5 desc
-- Comments: This query analyzes the stability and concentration of production leadership. By looking at how many years each county spent in the top 5 producing group we can see the persistence of their dominance or whether there were just many one-offs.
