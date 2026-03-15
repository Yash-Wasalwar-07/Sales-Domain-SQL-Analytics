CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `net_sales_view` AS
    SELECT 
        `post_invoice_discount_view`.`date` AS `date`,
        `post_invoice_discount_view`.`fiscal_year` AS `fiscal_year`,
        `post_invoice_discount_view`.`customer_code` AS `customer_code`,
        `post_invoice_discount_view`.`market` AS `market`,
        `post_invoice_discount_view`.`product_code` AS `product_code`,
        `post_invoice_discount_view`.`product` AS `product`,
        `post_invoice_discount_view`.`variant` AS `variant`,
        `post_invoice_discount_view`.`sold_quantity` AS `sold_quantity`,
        `post_invoice_discount_view`.`gross_price_total` AS `gross_price_total`,
        `post_invoice_discount_view`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        `post_invoice_discount_view`.`net_inovice_sales` AS `net_inovice_sales`,
        `post_invoice_discount_view`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,
        ((1 - `post_invoice_discount_view`.`post_invoice_discount_pct`) * `post_invoice_discount_view`.`net_inovice_sales`) AS `net_sales`
    FROM
        `post_invoice_discount_view`