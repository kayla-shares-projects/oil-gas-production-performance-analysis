-- Question 1: How does total reported production change over time?
SELECT AVG(volume), production_date FROM production
GROUP BY production_date;
SELECT AVG(volume), EXTRACT(YEAR FROM production_date) as by_year FROM production
GROUP BY by_year;
-- Comments: Since all the production date information is stored uniformly and there are only ~125 unique dates on record, I decided to run this first query to explore what the differences in average production may be from day to day. Next I wanted to explore what the year to year averages would be like.

-- Question 2: How much of total production is driven by adjustments (negative volumes) over time?
SELECT sum(volume), EXTRACT(YEAR FROM production_date) as by_year FROM production
WHERE volume <= 0
GROUP BY by_year
--Comments: with this quesry we get a comparison of how much of our total production volume is contributed by negative adjustment year on year
