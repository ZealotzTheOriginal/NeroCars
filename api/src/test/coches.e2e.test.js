const request = require('supertest');
const app = require('../app'); // tu app Express exportada

describe('GET /api/coches/vehiculos', () => {
  test('lista vehículos para marca existente', async () => {
    const res = await request(app)
      .get('/api/coches/vehiculos')
      .query({ marca: 'Toyota', page: 1, limit: 10 });

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    // si tienes datos de ejemplo puedes hacer más asserts
  });

  test('400 si falta marca', async () => {
    const res = await request(app).get('/api/coches/vehiculos');
    expect(res.statusCode).toBe(400);
  });
});
