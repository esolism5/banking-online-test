#!/bin/bash

# Rutas
cat > backend/routes/auth.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const { verifyToken } = require('../middlewares/auth.middleware');
router.post('/login', authController.login);
router.post('/register', authController.register);
router.get('/verify', verifyToken, authController.verifyToken);
module.exports = router;
EOF

cat > backend/routes/cuentas.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const cuentasController = require('../controllers/cuentas.controller');
const { verifyToken } = require('../middlewares/auth.middleware');
router.get('/', verifyToken, cuentasController.obtenerCuentasUsuario);
router.get('/:id', verifyToken, cuentasController.obtenerCuentaPorId);
router.post('/', verifyToken, cuentasController.crearCuenta);
module.exports = router;
EOF

cat > backend/routes/usuarios.routes.js << 'EOF'
const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/auth.middleware');
router.get('/perfil', verifyToken, async (req, res) => {
  const { pool } = require('../config/database');
  const [usuarios] = await pool.execute('SELECT * FROM usuarios WHERE id_usuario = ?', [req.usuario.id_usuario]);
  res.json({ success: true, usuario: usuarios[0] });
});
module.exports = router;
EOF

echo "✅ Rutas creadas"
