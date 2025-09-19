const express = require('express');
const router = express.Router();
const { getVehiculos } = require('../controllers/coches.controller');

router.get('/vehiculos', getVehiculos);

module.exports = router;