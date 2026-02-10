/**
 * =====================================================
 * CONFIGURACIÓN DE CONEXIÓN A BASE DE DATOS
 * Fundación Genesis Empresarial
 * =====================================================
 * 
 * Este archivo maneja la conexión a MySQL usando mysql2
 * con soporte para Promises para facilitar el uso de async/await
 */

const mysql = require('mysql2');
require('dotenv').config();

/**
 * Pool de conexiones a la base de datos
 * Usar pool es más eficiente que crear conexiones individuales
 * porque reutiliza las conexiones existentes
 */
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'genesis_bancario',
  port: process.env.DB_PORT || 3306,
  waitForConnections: true, // Esperar si no hay conexiones disponibles
  connectionLimit: 10,      // Máximo de conexiones simultáneas
  queueLimit: 0,            // Sin límite de cola de espera
  timezone: 'Z'             // Usar UTC para timestamps
});

/**
 * Convertir el pool a Promise-based para usar async/await
 * Esto nos permite escribir código más limpio y moderno
 */
const promisePool = pool.promise();

/**
 * Función para probar la conexión a la base de datos
 * Se ejecuta al iniciar el servidor para verificar que todo esté OK
 */
const testConnection = async () => {
  try {
    const connection = await promisePool.getConnection();
    console.log('✅ Conexión exitosa a MySQL - Base de datos: ' + process.env.DB_NAME);
    connection.release(); // Liberar la conexión de vuelta al pool
    return true;
  } catch (error) {
    console.error('❌ Error al conectar a MySQL:', error.message);
    return false;
  }
};

/**
 * Función helper para ejecutar queries con manejo de errores
 * Esto centraliza el manejo de errores de base de datos
 */
const executeQuery = async (query, params = []) => {
  try {
    const [rows] = await promisePool.execute(query, params);
    return { success: true, data: rows };
  } catch (error) {
    console.error('Error en query:', error.message);
    return { success: false, error: error.message };
  }
};

/**
 * Función para cerrar todas las conexiones del pool
 * Útil cuando se apaga el servidor
 */
const closePool = async () => {
  try {
    await pool.end();
    console.log('🔌 Pool de conexiones cerrado');
  } catch (error) {
    console.error('Error al cerrar pool:', error.message);
  }
};

// Exportar el pool y las funciones utilitarias
module.exports = {
  pool: promisePool,
  testConnection,
  executeQuery,
  closePool
};
