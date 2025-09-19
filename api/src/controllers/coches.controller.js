const { listVehiculosByMarca } = require('../services/coches.service');

async function getVehiculos(req, res, next) {
  try {
    const { marca, page = 1, limit = 20 } = req.query;
    if (!marca) return res.status(400).json({ error: 'param marca requerido' });
    const rows = await listVehiculosByMarca(marca, Number(page), Number(limit));
    res.json(rows);
  } catch (err) {
    next(err);
  }
}

module.exports = { getVehiculos };
