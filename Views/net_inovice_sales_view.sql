CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `net_inovice_sales_view` AS
    SELECT 
        `f`.`date` AS `date`,
        `f`.`fiscal_year` AS `fiscal_year`,
        `f`.`product_code` AS `product_code`,
        `f`.`customer_code` AS `customer_code`,
        `f`.`sold_quantity` AS `sold_quantity`,
        `p`.`product` AS `product`,
        `p`.`division` AS `division`,
        `p`.`segment` AS `segment`,
        `p`.`category` AS `category`,
        `p`.`variant` AS `variant`,
        `g`.`gross_price` AS `gross_price`,
        `pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        ((1 - `pre`.`pre_invoice_discount_pct`) * `g`.`gross_price`) AS `net_invoice_sales`
    FROM
        (((`fact_sales_monthly` `f`
        JOIN `dim_product` `p` ON ((`f`.`product_code` = `p`.`product_code`)))
        JOIN `fact_gross_price` `g` ON (((`f`.`product_code` = `g`.`product_code`)
            AND (`f`.`fiscal_year` = `g`.`fiscal_year`))))
        JOIN `fact_pre_invoice_deductions` `pre` ON (((`pre`.`customer_code` = `f`.`customer_code`)
            AND (`pre`.`fiscal_year` = `f`.`fiscal_year`))))