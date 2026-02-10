/**
 * =====================================================
 * SERVIDOR PRINCIPAL - API REST
 * Fundación Genesis Empresarial
 * Sistema Bancario en Línea
 * =====================================================
 * 
 * Este es el punto de entrada de la aplicación backend.
 * Configura Express, middlewares, rutas y conexión a BD.
 */

const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const compression = require('compression');
require('dotenv').config();

// Importar configuración de base de datos
const { testConnection } = require('./config/database');

// Importar rutas
const authRoutes = require('./routes/auth.routes');
const usuariosRoutes = require('./routes/usuarios.routes');
const cuentasRoutes = require('./routes/cuentas.routes');
const transaccionesRoutes = require('./routes/transacciones.routes');
const tarjetasRoutes = require('./routes/tarjetas.routes');
const prestamosRoutes = require('./routes/prestamos.routes');
const beneficiariosRoutes = require('./routes/beneficiarios.routes');
const notificacionesRoutes = require('./routes/notificaciones.routes');
const dashboardRoutes = require('./routes/dashboard.routes');

/**
 * Inicializar aplicación Express
 */
const app = express();
const PORT = process.env.PORT || 3000;

/**
 * =====================================================
 * MIDDLEWARES GLOBALES
 * =====================================================
 */

// Helmet - Seguridad HTTP headers
app.use(helmet());

// CORS - Permitir peticiones desde el frontend Angular
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || 'http://localhost:4200',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

// Compression - Comprimir respuestas HTTP
app.use(compression());

// Morgan - Logger de peticiones HTTP
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev')); // Formato detallado para desarrollo
} else {
  app.use(morgan('combined')); // Formato estándar para producción
}

// Body parser - Parsear JSON y URL-encoded
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

/**
 * =====================================================
 * RUTAS DE LA API
 * =====================================================
 */

// Ruta de health check (verificar que el servidor esté corriendo)
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'Servidor Genesis Bancario funcionando correctamente',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Rutas principales de la API
app.use('/api/auth', authRoutes);                       // Autenticación y login
app.use('/api/usuarios', usuariosRoutes);               // Gestión de usuarios
app.use('/api/cuentas', cuentasRoutes);                 // Gestión de cuentas
app.use('/api/transacciones', transaccionesRoutes);     // Transacciones bancarias
app.use('/api/tarjetas', tarjetasRoutes);               // Tarjetas de débito/crédito
app.use('/api/prestamos', prestamosRoutes);             // Préstamos y créditos
app.use('/api/beneficiarios', beneficiariosRoutes);     // Beneficiarios
app.use('/api/notificaciones', notificacionesRoutes);   // Notificaciones
app.use('/api/dashboard', dashboardRoutes);             // Dashboard y estadísticas

/**
 * Ruta 404 - No encontrada
 */
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    message: 'Ruta no encontrada',
    path: req.originalUrl
  });
});

/**
 * =====================================================
 * MIDDLEWARE DE MANEJO DE ERRORES GLOBAL
 * =====================================================
 * Este middleware captura todos los errores que ocurran
 * en las rutas y los maneja de forma centralizada
 */
app.use((error, req, res, next) => {
  console.error('❌ Error capturado:', error);
  
  // Error de validación
  if (error.name === 'ValidationError') {
    return res.status(400).json({
      success: false,
      message: 'Error de validación',
      errors: error.errors
    });
  }
  
  // Error de JWT
  if (error.name === 'JsonWebTokenError') {
    return res.status(401).json({
      success: false,
      message: 'Token inválido'
    });
  }
  
  // Error genérico del servidor
  res.status(error.status || 500).json({
    success: false,
    message: error.message || 'Error interno del servidor',
    ...(process.env.NODE_ENV === 'development' && { stack: error.stack })
  });
});

/**
 * =====================================================
 * INICIAR SERVIDOR
 * =====================================================
 */
const startServer = async () => {
  try {
    // Probar conexión a la base de datos
    const dbConnected = await testConnection();
    
    if (!dbConnected) {
      console.error('❌ No se pudo conectar a la base de datos');
      console.error('Verifica tu configuración en el archivo .env');
      process.exit(1);
    }
    
    // Iniciar servidor HTTP
    app.listen(PORT, () => {
      console.log('');
      console.log('╔════════════════════════════════════════════════════════╗');
      console.log('║                                                        ║');
      console.log('║        🏦  FUNDACIÓN GENESIS EMPRESARIAL 🏦           ║');
      console.log('║              Sistema Bancario en Línea                 ║');
      console.log('║                                                        ║');
      console.log('╠════════════════════════════════════════════════════════╣');
      console.log(`║  🚀 Servidor corriendo en: http://localhost:${PORT}     ║`);
      console.log(`║  🌍 Entorno: ${process.env.NODE_ENV || 'development'}                          ║`);
      console.log(`║  💾 Base de datos: ${process.env.DB_NAME || 'genesis_bancario'}              ║`);
      console.log('║  📊 API Docs: http://localhost:' + PORT + '/api/health      ║');
      console.log('║                                                        ║');
      console.log('╚════════════════════════════════════════════════════════╝');
      console.log('');
    });
    
  } catch (error) {
    console.error('❌ Error al iniciar el servidor:', error);
    process.exit(1);
  }
};

// Manejar cierre gracioso del servidor
process.on('SIGTERM', () => {
  console.log('🛑 SIGTERM recibido. Cerrando servidor...');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('🛑 SIGINT recibido. Cerrando servidor...');
  process.exit(0);
});

// Iniciar el servidor
startServer();

// Exportar app para testing
module.exports = app;
