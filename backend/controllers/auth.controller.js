/**
 * =====================================================
 * CONTROLADOR DE AUTENTICACIÓN
 * =====================================================
 * 
 * Maneja el login, registro y autenticación de usuarios
 */

const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { pool } = require('../config/database');

/**
 * LOGIN - Iniciar sesión
 * POST /api/auth/login
 */
const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // Validar que vengan los datos
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: 'Email y contraseña son requeridos'
      });
    }
    
    // Buscar usuario por email
    const [usuarios] = await pool.execute(
      'SELECT * FROM usuarios WHERE email = ? AND estado = "activo"',
      [email]
    );
    
    if (usuarios.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas'
      });
    }
    
    const usuario = usuarios[0];
    
    // Verificar contraseña
    const passwordMatch = await bcrypt.compare(password, usuario.password_hash);
    
    if (!passwordMatch) {
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas'
      });
    }
    
    // Generar token JWT
    const token = jwt.sign(
      {
        id_usuario: usuario.id_usuario,
        email: usuario.email,
        nombre_completo: usuario.nombre_completo
      },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '24h' }
    );
    
    // Responder con token y datos del usuario
    res.json({
      success: true,
      message: 'Login exitoso',
      token,
      usuario: {
        id_usuario: usuario.id_usuario,
        nombre_completo: usuario.nombre_completo,
        email: usuario.email,
        telefono: usuario.telefono,
        dpi: usuario.dpi
      }
    });
    
  } catch (error) {
    console.error('Error en login:', error);
    res.status(500).json({
      success: false,
      message: 'Error al iniciar sesión'
    });
  }
};

/**
 * REGISTRO - Crear nuevo usuario
 * POST /api/auth/register
 */
const register = async (req, res) => {
  try {
    const {
      nombre_completo,
      dpi,
      email,
      telefono,
      direccion,
      fecha_nacimiento,
      password
    } = req.body;
    
    // Validar datos requeridos
    if (!nombre_completo || !dpi || !email || !password) {
      return res.status(400).json({
        success: false,
        message: 'Todos los campos son requeridos'
      });
    }
    
    // Verificar si el email ya existe
    const [emailExists] = await pool.execute(
      'SELECT id_usuario FROM usuarios WHERE email = ?',
      [email]
    );
    
    if (emailExists.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'El email ya está registrado'
      });
    }
    
    // Verificar si el DPI ya existe
    const [dpiExists] = await pool.execute(
      'SELECT id_usuario FROM usuarios WHERE dpi = ?',
      [dpi]
    );
    
    if (dpiExists.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'El DPI ya está registrado'
      });
    }
    
    // Encriptar contraseña
    const salt = await bcrypt.genSalt(10);
    const password_hash = await bcrypt.hash(password, salt);
    
    // Insertar nuevo usuario
    const [result] = await pool.execute(
      `INSERT INTO usuarios 
       (nombre_completo, dpi, email, telefono, direccion, fecha_nacimiento, password_hash) 
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [nombre_completo, dpi, email, telefono, direccion, fecha_nacimiento, password_hash]
    );
    
    // Generar token
    const token = jwt.sign(
      {
        id_usuario: result.insertId,
        email: email,
        nombre_completo: nombre_completo
      },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '24h' }
    );
    
    res.status(201).json({
      success: true,
      message: 'Usuario registrado exitosamente',
      token,
      usuario: {
        id_usuario: result.insertId,
        nombre_completo,
        email,
        telefono,
        dpi
      }
    });
    
  } catch (error) {
    console.error('Error en registro:', error);
    res.status(500).json({
      success: false,
      message: 'Error al registrar usuario'
    });
  }
};

/**
 * VERIFICAR TOKEN - Validar si el token es válido
 * GET /api/auth/verify
 */
const verifyToken = async (req, res) => {
  try {
    // Si llegamos aquí, el token ya fue verificado por el middleware
    // req.usuario contiene la información del token
    
    // Obtener datos actualizados del usuario
    const [usuarios] = await pool.execute(
      'SELECT id_usuario, nombre_completo, email, telefono, dpi, estado FROM usuarios WHERE id_usuario = ?',
      [req.usuario.id_usuario]
    );
    
    if (usuarios.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Usuario no encontrado'
      });
    }
    
    res.json({
      success: true,
      usuario: usuarios[0]
    });
    
  } catch (error) {
    console.error('Error en verify token:', error);
    res.status(500).json({
      success: false,
      message: 'Error al verificar token'
    });
  }
};

module.exports = {
  login,
  register,
  verifyToken
};
