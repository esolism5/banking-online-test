const express = require('express');
const router = express.Router();
const cuentasController = require('../controllers/cuentas.controller');
const { verifyToken } = require('../middlewares/auth.middleware');
router.get('/', verifyToken, cuentasController.obtenerCuentasUsuario);
router.get('/:id', verifyToken, cuentasController.obtenerCuentaPorId);
router.post('/', verifyToken, cuentasController.crearCuenta);
module.exports = router;
