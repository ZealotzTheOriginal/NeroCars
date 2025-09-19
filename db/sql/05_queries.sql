-- 05_queries.sql
-- 1) Listado básico de vehículos por marca (adaptado a tu esquema)
-- Resultado: marca, modelo, anio, precio

-- ===== VARIANTE A: SELECT directo (útil para psql / debug)
SELECT
  mk.name   AS marca,
  s.model   AS modelo,
  s.year    AS anio,
  s.price   AS precio
FROM coches.segunda_mano s
JOIN coches.make mk ON s.make_id = mk.make_id
WHERE lower(mk.name) = lower('Toyota')   -- <- sustituye 'Toyota' por la marca deseada
ORDER BY s.year DESC NULLS LAST, s.price DESC NULLS LAST
LIMIT 100;

-- ===== VARIANTE B: SELECT parametrizado (ideal para usar desde Node.js)
-- En Node: pool.query(text, [marca, limit, offset])
-- text below uses $1, $2, $3
-- Note: psql no sustituye $1; use esto desde tu código.
SELECT
  mk.name   AS marca,
  s.model   AS modelo,
  s.year    AS anio,
  s.price   AS precio
FROM coches.segunda_mano s
JOIN coches.make mk ON s.make_id = mk.make_id
WHERE lower(mk.name) = lower($1)
ORDER BY s.year DESC NULLS LAST, s.price DESC NULLS LAST
LIMIT $2 OFFSET $3;

-- ===== VARIANTE C: Función SQL reutilizable (llámala desde psql)
CREATE OR REPLACE FUNCTION coches.fn_list_vehiculos_por_marca(
  p_marca TEXT,
  p_limit INT DEFAULT 50,
  p_offset INT DEFAULT 0
)
RETURNS TABLE(marca TEXT, modelo TEXT, anio INT, precio INT) AS $$
BEGIN
  RETURN QUERY
  SELECT mk.name, s.model, s.year, s.price
  FROM coches.segunda_mano s
  JOIN coches.make mk ON s.make_id = mk.make_id
  WHERE lower(mk.name) = lower(p_marca)
  ORDER BY s.year DESC NULLS LAST, s.price DESC NULLS LAST
  LIMIT p_limit OFFSET p_offset;
END;
$$ LANGUAGE plpgsql STABLE;
