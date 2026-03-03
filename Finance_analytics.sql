-- Fincance Analytics

-- 1.
SELECT MONTHNAME(s.date), 
       d.product, 
       d.variant, 
       s.sold_quantity,
       gross_price AS gross_price_per_item,
       ROUND(gross_price * s.sold_quantity, 2) AS gross_price_total
FROM fact_sales_monthly s
JOIN dim_product d
ON s.product_code = d.product_code
JOIN fact_gross_price gp
ON gp.product_code = s.product_code AND gp.fiscal_year = 2021
WHERE get_fiscal_year(date) = 2021 AND customer_code = (SELECT customer_code FROM dim_customer WHERE customer = 'Croma')

-- 2. Gross Sales Report for Croma - Total Sales Amount
SELECT fiscal_year, 
	   MONTHNAME(fs.date),
       SUM(fp.gross_price) AS total_monthly_sales
FROM fact_sales_monthly fs
JOIN fact_gross_price fp
ON fs.product_code = fp.product_code AND
   fp.fiscal_year = get_fiscal_year(fs.date)
WHERE customer_code = (SELECT customer_code FROM dim_customer WHERE customer = 'Croma')
GROUP BY fiscal_year, MONTHNAME(fs.date)

-- 3. Gross Sales Report for Croma Yearly
SELECT fiscal_year, 
       ROUND(SUM(fp.gross_price * fs.sold_quantity), 2) AS yearly_sales
FROM fact_sales_monthly fs
JOIN fact_gross_price fp
ON fs.product_code = fp.product_code AND
   fp.fiscal_year = get_fiscal_year(fs.date)
WHERE customer_code = (SELECT customer_code FROM dim_customer WHERE customer = 'Croma')
GROUP BY fiscal_year

