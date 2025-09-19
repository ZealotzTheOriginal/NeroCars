const pool = require('../db');

async function listVehiculosByMarca(marca, page = 1, limit = 20) {
  const offset = (Math.max(1, page) - 1) * limit;
  const text = `
    SELECT m.nombre AS marca, mo.nombre AS modelo, v.anio, v.precio
    FROM coches.vehiculos v
    JOIN coches.modelos mo ON v.modelo_id = mo.id
    JOIN coches.marcas m   ON mo.marca_id = m.id
    WHERE lower(m.nombre) = lower($1)
    ORDER BY v.anio DESC, v.precio DESC
    LIMIT $2 OFFSET $3;
  `;
  const { rows } = await pool.query(text, [marca, limit, offset]);
  return rows;
}

module.exports = { listVehiculosByMarca };
