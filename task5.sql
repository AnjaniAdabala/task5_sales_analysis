SELECT * FROM orders;
SHOW VARIABLES LIKE 'sql_mode';
SHOW VARIABLES LIKE 'secure_file_priv';


SET SQL_SAFE_UPDATES = 0;

UPDATE orders
SET amount = REPLACE(amount, ',', '')
WHERE amount IS NOT NULL
  AND amount LIKE '%,%';

SET SQL_SAFE_UPDATES = 1;
ALTER TABLE orders ADD COLUMN amount_dec DECIMAL(12,2) NULL;
SET SQL_SAFE_UPDATES = 0;

UPDATE orders
SET amount_dec = CASE
  WHEN TRIM(amount) = '' THEN NULL
  ELSE CAST(amount AS DECIMAL(12,2))
END;

SET SQL_SAFE_UPDATES = 1;
SELECT order_id, amount FROM orders WHERE amount_dec IS NULL AND amount IS NOT NULL LIMIT 50;
ALTER TABLE orders DROP COLUMN amount;
ALTER TABLE orders CHANGE COLUMN amount_dec amount DECIMAL(12,2);
SELECT
  YEAR(dt) AS year,
  MONTH(dt) AS month,
  DATE_FORMAT(dt,'%Y-%m') AS yea_month,
  ROUND(SUM(amount),2) AS monthly_revenue,
  COUNT(DISTINCT order_id) AS order_volume
FROM (
  SELECT
    order_id,
    amount,
    CASE
      WHEN order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN CAST(order_date AS DATE)
      WHEN order_date REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}' THEN STR_TO_DATE(order_date, '%Y/%m/%d')
      WHEN order_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}' THEN STR_TO_DATE(order_date, '%d-%m-%Y')
      WHEN order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}' THEN STR_TO_DATE(order_date, '%d/%m/%Y')
      WHEN order_date REGEXP '^[0-9]{8}$' THEN STR_TO_DATE(order_date, '%Y%m%d')
      ELSE NULL
    END AS dt
  FROM orders
) AS t
WHERE dt IS NOT NULL
GROUP BY YEAR(dt), MONTH(dt), DATE_FORMAT(dt,'%Y-%m')
ORDER BY YEAR(dt), MONTH(dt);
SELECT DISTINCT order_date
FROM orders
LIMIT 20;



