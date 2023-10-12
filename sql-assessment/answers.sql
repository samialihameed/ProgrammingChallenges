-- SQL Queries File

-- Query 1: Write a query to get the sum of impressions by day.
SELECT date, SUM(impressions) as total_impressions
FROM marketing_data
GROUP BY date;

-- Query 2: Write a query to get the top three revenue-generating states in order of best to worst. 
-- How much revenue did the third best state generate? 

--The third best state generated a revenue of 112731
SELECT state, SUM(revenue) as total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

-- Query 3: Write a query that shows total cost, impressions, clicks, and revenue of each campaign.
-- Make sure to include the campaign name in the output.
SELECT c.name as campaign_name,
       SUM(m.cost) as total_cost,
       SUM(m.impressions) as total_impressions,
       SUM(m.clicks) as total_clicks,
       SUM(w.revenue) as total_revenue
FROM marketing_data m
JOIN campaign_info c ON m.campaign_id = c.id
LEFT JOIN website_revenue w ON m.campaign_id = w.campaign_id
GROUP BY c.name;
ORDER BY campaign_name ASC;

-- Query 4: Write a query to get the number of conversions of Campaign5 by state.
-- Which state generated the most conversions for this campaign?

-- The state that generated the most conversions for this campaign was NY
SELECT w.state, SUM(m.conversions) as total_conversions
FROM marketing_data m
JOIN website_revenue w ON m.campaign_id = w.campaign_id AND m.date = w.date
WHERE m.campaign_id = '99058240'
GROUP BY w.state
ORDER BY total_conversions DESC;

-- Query 5: In your opinion, which campaign was the most efficient, and why?

--Campaign4 was the most efficient because it had the highest efficiency_ratio, at 3.161153713157511.
SELECT c.name as campaign_name,
       SUM(m.conversions) / SUM(m.cost) as efficiency_ratio
FROM marketing_data m
JOIN campaign_info c ON m.campaign_id = c.id
GROUP BY c.name
ORDER BY efficiency_ratio DESC
LIMIT 1;

-- Bonus Query: Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.

--The best day of the week to run ads is Saturday, with a cost_per_conversion of 0.3824708174174862
SELECT DAYNAME(date) as day_of_week,
       SUM(cost) / SUM(conversions) as cost_per_conversion
FROM marketing_data
GROUP BY day_of_week
ORDER BY cost_per_conversion ASC
LIMIT 1;