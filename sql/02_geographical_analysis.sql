-- Question 1: How is total production distributed geographically by county over time?
select sum(volume) as volume_sum, fips_code, extract (year from production_date) as by_year
from geographical_analysis
group by by_year, fips_code
having sum(volume) > 0
order by by_year
--Comments: This query returns the total yearly production by county, making sure to separate inactive assets by filtering out where county production was zero in a year.

-- Question 2: 
	select sum(volume) as volume_sum, fips_code
	from geographical_analysis
	group by fips_code
	having sum(volume) > 0
	order by volume_sum desc
--Comments: This query breaks down which county produced the highest volume over the 10-year period that our dataset recorded.

--Question 3: Which counties consistently lead in yearly production?
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
--Comments: This tells us which county, if anywhere, most frequently lead annual production.
