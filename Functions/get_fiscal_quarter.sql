CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_quarter`( calendar_date DATE ) RETURNS char(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE m TINYINT;
    DECLARE qrt CHAR(2);
    SET m = MONTH(calendar_date);
    
    CASE
		WHEN m IN (9,10,11) THEN
			SET qrt = 'Q1';
		WHEN m IN (12, 1, 2) THEN
			SET qrt = 'Q2';
		WHEN m IN (3, 4, 5) THEN
			SET qrt = 'Q3';
		ELSE
			SET qrt = 'Q4';
	END CASE;
    
    RETURN qrt;
END