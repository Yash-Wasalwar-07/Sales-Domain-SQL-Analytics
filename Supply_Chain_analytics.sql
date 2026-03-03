-- Creating the table to capture both sales and forecasted quantity.

CREATE TABLE fact_act_est
(
SELECT 	s.date,
		   s.product_code,
        s.customer_code, 
        s.sold_quantity,
		f.forecast_quantity
FROM fact_sales_monthly s
LEFT JOIN fact_forecast_monthly f
using (date, product_code, customer_code)
UNION
SELECT 	f.date,
		f.product_code,
        f.customer_code, 
        s.sold_quantity,
		f.forecast_quantity
FROM fact_forecast_monthly f
LEFT JOIN fact_sales_monthly s
using (date, product_code, customer_code)
)

-- Calculating the Forecast Accuracy of the quantity sold using two approaches.
-- 1. Using CTE Approach
WITH cte AS
(SELECT customer_code,
		SUM(sold_quantity) AS total_sold_quantity,
        SUM(forecast_quantity) AS total_forecast_quantity,
		SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) AS net_error,
        SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) / SUM(forecast_quantity) * 100 AS net_error_pct,
        SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) AS abs_error,
        SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) / SUM(forecast_quantity) * 100 AS abs_error_pct
FROM fact_act_est
WHERE fiscal_year = 2021
GROUP BY customer_code) 
SELECT c.customer_code,
	   cu.customer,
       cu.market,
       c.total_sold_quantity,
       c.total_forecast_quantity,
       c.net_error,
       c.net_error_pct,
       c.abs_error,
       c.abs_error_pct,
       if(abs_error_pct > 100, 0, (100 - abs_error_pct)) AS forecast_acc_pct
FROM cte c
JOIN dim_customer cu
USING (customer_code)
ORDER BY forecast_acc_pct DESC;


-- 2. Using Temporary Table Approach
CREATE TEMPORARY TABLE forecast_accuracy_table
	SELECT customer_code,
			SUM(sold_quantity) AS total_sold_quantity,
			SUM(forecast_quantity) AS total_forecast_quantity,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) AS net_error,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) / SUM(forecast_quantity) * 100 AS net_error_pct,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) AS abs_error,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) / SUM(forecast_quantity) * 100 AS abs_error_pct
	FROM fact_act_est
	WHERE fiscal_year = 2021
	GROUP BY customer_code;

SELECT 
	e.*,
    c.customer,
    c.market,
    if(abs_error_pct > 100, 0, 100 - abs_error_pct) AS forecast_accuracy
FROM forecast_accuracy_table e
JOIN dim_customer c
USING (customer_code)
ORDER BY forecast_accuracy DESC;



-- Checking which customers forecast has dropped from FY 2020 to 2021 using temporary tables.
DROP TABLE forecast_accuracy_table_2020
CREATE TEMPORARY TABLE forecast_accuracy_table_2020
	SELECT 	customer_code,
			SUM(sold_quantity) AS total_sold_quantity,
			SUM(forecast_quantity) AS total_forecast_quantity,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) AS net_error,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) / SUM(forecast_quantity) * 100 AS net_error_pct,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) AS abs_error,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) / SUM(forecast_quantity) * 100 AS abs_error_pct
	FROM fact_act_est
	WHERE fiscal_year = 2020
	GROUP BY customer_code;


CREATE TEMPORARY TABLE forecast_accuracy_table_2021
	SELECT 	customer_code,
		    customer_name,
			SUM(sold_quantity) AS total_sold_quantity,
			SUM(forecast_quantity) AS total_forecast_quantity,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) AS net_error,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) / SUM(forecast_quantity) * 100 AS net_error_pct,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) AS abs_error,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) / SUM(forecast_quantity) * 100 AS abs_error_pct
	FROM fact_act_est
	WHERE fiscal_year = 2021
	GROUP BY customer_code;
    

SELECT f21.customer_code,
	   c.customer,
       c.market,
       f21.fcast_acc_2021,
       f20.fcast_acc_2020
FROM
(SELECT customer_code,
	   if(abs_error_pct > 100, 0, 100 - abs_error_pct) AS fcast_acc_2021
FROM forecast_accuracy_table_2021) f21
JOIN (SELECT customer_code,
	   if(abs_error_pct > 100, 0, 100 - abs_error_pct) AS fcast_acc_2020
FROM forecast_accuracy_table_2020) f20
USING (customer_code)
JOIN dim_customer c
USING (customer_code)
WHERE f21.fcast_acc_2021 < f20.fcast_acc_2020









