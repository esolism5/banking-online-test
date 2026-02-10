/**
 * =====================================================
 * CONTROLADOR DE CUENTAS
 * =====================================================
 */

const { pool } = require('../config/database');

/**
 * Obtener todas las cuentas del usuario autenticado
 */
const obtenerCuentasUsuario = async (req, res) => {
  try {
    const id_usuario = req.usuario.id_usuario;
    
    const [cuentas] = await pool.execute(
      `SELECT c.*, tc.nombre as tipo_cuenta_nombre, tc.tasa_interes
       FROM cuentas c
       INNER JOIN tipos_cuenta tc ON c.id_tipo_cuenta = tc.id_tipo_cuenta
       WHERE c.id_usuario = ?
       ORDER BY c.fecha_creacion DESC`,
      [id_usuario]
    );
    
    res.json({
      success: true,
      cuentas
    });
    
  } catch (error) {
    console.error('Error al obtener cuentas:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener cuentas'
    });
  }
};

/**
 * Obtener detalle de una cuenta específica
 */
const obtenerCuentaPorId = async (req, res) => {
  try {
    const { id } = req.params;
    const id_usuario = req.usuario.id_usuario;
    
    const [cuentas] = await pool.execute(
      `SELECT c.*, tc.nombre as tipo_cuenta_nombre, tc.descripcion as tipo_descripcion,
              tc.tasa_interes, tc.comision_mantenimiento
       FROM cuentas c
       INNER JOIN tipos_cuenta tc ON c.id_tipo_cuenta = tc.id_tipo_cuenta
       WHERE c.id_cuenta = ? AND c.id_usuario = ?`,
      [id, id_usuario]
    );
    
    if (cuentas.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Cuenta no encontrada'
      });
    }
    
    res.json({
      success: true,
      cuenta: cuentas[0]
    });
    
  } catch (error) {
    console.error('Error al obtener cuenta:', error);
    res.status(500).json({
      success: false,
      message: 'Error al obtener cuenta'
    });
  }
};

/**
 * Crear una nueva cuenta
 */
const crearCuenta = async (req, res) => {
  try {
    const { id_tipo_cuenta, saldo_inicial = 0 } = req.body;
    const id_usuario = req.usuario.id_usuario;
    
    // Generar número de cuenta único
    const numero_cuenta = '100' + Date.now() + Math.floor(Math.random() * 1000);
    const fecha_apertura = new Date().toISOString().split('T')[0];
    
    const [result] = await pool.execute(
      `INSERT INTO cuentas (id_usuario, id_tipo_cuenta, numero_cuenta, saldo, fecha_apertura)
       VALUES (?, ?, ?, ?, ?)`,
      [id_usuario, id_tipo_cuenta, numero_cuenta, saldo_inicial, fecha_apertura]
    );
    
    // Si hay saldo inicial, crear transacción de depósito
    if (saldo_inicial > 0) {
      const referencia = 'DEP-' + Date.now();
      await pool.execute(
        `INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen)
         VALUES (3, ?, ?, 'Depósito inicial apertura de cuenta', ?, 0, ?)`,
        [result.insertId, saldo_inicial, referencia, saldo_inicial]
      );
    }
    
    res.status(201).json({
      success: true,
      message: 'Cuenta creada exitosamente',
      cuenta: {
        id_cuenta: result.insertId,
        numero_cuenta,
        saldo: saldo_inicial
      }
    });
    
  } catch (error) {
    console.error('Error al crear cuenta:', error);
    res.status(500).json({
      success: false,
      message: 'Error al crear cuenta'
    });
  }
};

module.exports = {
  obtenerCuentasUsuario,
  obtenerCuentaPorId,
  crearCuenta
};
