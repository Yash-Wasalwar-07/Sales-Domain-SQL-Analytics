CREATE DEFINER=`root`@`localhost` PROCEDURE `forecast_accuracy_report`(
	in_fiscal_year INT
)
BEGIN
	WITH cte AS (SELECT customer_code,
			SUM(sold_quantity) AS total_sold_quantity,
			SUM(forecast_quantity) AS total_forecast_quantity,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) AS net_error,
			SUM(forecast_quantity - CAST(sold_quantity AS SIGNED)) / SUM(forecast_quantity) * 100 AS net_error_pct,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) AS abs_error,
			SUM(ABS((forecast_quantity - CAST(sold_quantity AS SIGNED)))) / SUM(forecast_quantity) * 100 AS abs_error_pct
	FROM fact_act_est
	WHERE fiscal_year = in_fiscal_year
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
END