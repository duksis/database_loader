CREATE OR REPLACE VIEW xx_products_v AS
SELECT
  name,
  type,
  producer,
  designer,
  distributor,
  production_date
FROM xx_products_t
WHERE 1 = 1
AND nvl(production_date,SYSDATE) >= SYSDATE
/
