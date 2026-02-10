const { pool } = require('../config/database');

const obtenerEstadisticas = async (req, res) => {
  try {
    const id_usuario = req.usuario.id_usuario;
    
    const [saldoTotal] = await pool.execute(
      'SELECT COALESCE(SUM(saldo), 0) as total FROM cuentas WHERE id_usuario = ? AND estado = "activa"',
      [id_usuario]
    );
    
    const [transaccionesRecientes] = await pool.execute(
      `SELECT t.*, tt.nombre as tipo_nombre, c.numero_cuenta 
       FROM transacciones t
       JOIN tipos_transaccion tt ON t.id_tipo_transaccion = tt.id_tipo_transaccion
       JOIN cuentas c ON t.id_cuenta_origen = c.id_cuenta
       WHERE c.id_usuario = ?
       ORDER BY t.fecha_transaccion DESC
       LIMIT 10`,
      [id_usuario]
    );
    
    const [prestamos] = await pool.execute(
      'SELECT * FROM prestamos WHERE id_usuario = ? ORDER BY fecha_creacion DESC',
      [id_usuario]
    );
    
    res.json({
      success: true,
      dashboard: {
        saldo_total: saldoTotal[0].total,
        transacciones_recientes: transaccionesRecientes,
        prestamos: prestamos
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener estadísticas' });
  }
};

module.exports = { obtenerEstadisticas };
