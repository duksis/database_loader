CREATE OR REPLACE VIEW xx_cars_v AS
SELECT
  name,
  producer,
  designer,
  distributor,
  production_date
FROM xx_products_v
WHERE 1 = 1
AND type = 'CAR'
/
