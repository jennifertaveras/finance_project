/* data exploratory 
improving customer satisfaction in a financial company 
*/


--1 whish companies receive the most complaints overall

SELECT
	COMPANY,
	COUNT(*) AS total_complaints 
FROM
	CONSUMER_COMPLAINTS
GROUP BY 
    COMPANY 
ORDER BY
    total_complaints DESC 
LIMIT 10 


-- 2 which products and issues generate the most complaints 
SELECT 
  product,
  issue,
  COUNT(*) AS total_complaints 
FROM 
  consumer_complaints 
group by 
    product, issue
order by 
    total_complaints desc 
limit 10	
	
-- 3  are they trends over time 
-- compare the top companies by year or month

WITH top_companies AS ( 
   SELECT company
   FROM consumer_complaints
   GROUP BY company
   ORDER BY COUNT(*) DESC
   LIMIT 10
)

SELECT 
   TO_CHAR(c.date_received, 'YYYY') AS year, 
   c.company, 
   COUNT(*) AS complaints
FROM 
    consumer_complaints c
JOIN top_companies t ON c.company = t.company
GROUP BY year, c.company
ORDER BY year, c.company

-- 4 how quickly do companies respond 

SELECT
     company, 
	 date_received,
	 date_sent_to_company,
	 (date_sent_to_company::date - date_received::date) AS response_time_days 
  FROM 
     consumer_complaints
GROUP BY 
     company, date_received, date_sent_to_company 
ORDER BY 
      response_time_days DESC 	 

-- 5 the AVG time that takes the company to respondens 

SELECT 
    company,
	AVG(date_sent_to_company - date_received) AS avg_responde_time
FROM 
   consumer_complaints
GROUP BY 
    company
ORDER BY 
    avg_responde_time  DESC

-- 6 whish complaint resolution methods are most common	

SELECT
   company_response_to_consumer, COUNT(*) AS total_count_of_resoluction_methods 
FROM 
   consumer_complaints 
GROUP BY 
  company_response_to_consumer
ORDER BY 
 total_count_of_resoluction_methods  DESC 


--- whish state generate the most consumer complaint 

SELECT 
    state, 
    COUNT(complaint_id) AS TotalComplaints
FROM 
    consumer_complaints
WHERE 
    state is not null 
GROUP BY 
    state 
ORDER BY 
    totalComplaints DESC 





	
	





