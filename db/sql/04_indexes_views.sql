-- 04_indexes_views.sql (fragmento útil para la consulta 1)
-- Índices en claves y búsquedas case-insensitive
CREATE INDEX IF NOT EXISTS idx_segunda_mano_make_id ON coches.segunda_mano (make_id);
CREATE INDEX IF NOT EXISTS idx_segunda_mano_year ON coches.segunda_mano (year);
CREATE INDEX IF NOT EXISTS idx_segunda_mano_price ON coches.segunda_mano (price);

-- índice funcional para búsqueda case-insensitive por make.name
CREATE INDEX IF NOT EXISTS idx_make_name_lower ON coches.make (lower(name));

-- índice sobre model (si más adelante filtras por modelo)
CREATE INDEX IF NOT EXISTS idx_segunda_mano_model_lower ON coches.segunda_mano (lower(model));
