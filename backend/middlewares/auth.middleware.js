/**
 * =====================================================
 * MIDDLEWARE DE AUTENTICACIÓN JWT
 * =====================================================
 * 
 * Este middleware verifica que el usuario esté autenticado
 * mediante un token JWT válido antes de permitir el acceso
 * a las rutas protegidas.
 */

const jwt = require('jsonwebtoken');

/**
 * Middleware para verificar el token JWT
 * Se usa en todas las rutas que requieren autenticación
 * 
 * @param {Object} req - Request de Express
 * @param {Object} res - Response de Express
 * @param {Function} next - Función para continuar al siguiente middleware
 */
const verifyToken = (req, res, next) => {
  try {
    // Obtener el token del header Authorization
    // Formato esperado: "Bearer <token>"
    const authHeader = req.headers['authorization'];
    
    if (!authHeader) {
      return res.status(401).json({
        success: false,
        message: 'No se proporcionó token de autenticación'
      });
    }
    
    // Extraer el token (quitar "Bearer ")
    const token = authHeader.split(' ')[1];
    
    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'Token malformado'
      });
    }
    
    // Verificar el token
    jwt.verify(token, process.env.JWT_SECRET, (error, decoded) => {
      if (error) {
        // Token inválido o expirado
        return res.status(401).json({
          success: false,
          message: 'Token inválido o expirado',
          error: error.message
        });
      }
      
      // Token válido - agregar información del usuario al request
      // Esto permite que las siguientes funciones accedan a req.usuario
      req.usuario = {
        id_usuario: decoded.id_usuario,
        email: decoded.email,
        nombre_completo: decoded.nombre_completo
      };
      
      // Continuar al siguiente middleware o ruta
      next();
    });
    
  } catch (error) {
    console.error('Error en middleware de autenticación:', error);
    return res.status(500).json({
      success: false,
      message: 'Error al verificar autenticación'
    });
  }
};

/**
 * Middleware opcional de autenticación
 * Verifica el token si existe, pero no lo requiere
 * Útil para rutas que funcionan diferente si el usuario está logueado
 */
const optionalAuth = (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];
    
    if (!authHeader) {
      // No hay token, continuar sin usuario autenticado
      req.usuario = null;
      return next();
    }
    
    const token = authHeader.split(' ')[1];
    
    if (!token) {
      req.usuario = null;
      return next();
    }
    
    // Intentar verificar el token
    jwt.verify(token, process.env.JWT_SECRET, (error, decoded) => {
      if (error) {
        // Token inválido, continuar sin usuario
        req.usuario = null;
      } else {
        // Token válido, agregar usuario
        req.usuario = {
          id_usuario: decoded.id_usuario,
          email: decoded.email,
          nombre_completo: decoded.nombre_completo
        };
      }
      next();
    });
    
  } catch (error) {
    console.error('Error en optional auth:', error);
    req.usuario = null;
    next();
  }
};

module.exports = {
  verifyToken,
  optionalAuth
};
