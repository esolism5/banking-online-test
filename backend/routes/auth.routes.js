const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const { verifyToken } = require('../middlewares/auth.middleware');

router.post('/login', authController.login);
router.post('/register', authController.register);
router.get('/verify', verifyToken, authController.verifyToken);

module.exports = router;
