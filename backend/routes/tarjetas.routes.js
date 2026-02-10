const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/auth.middleware');
module.exports = router;
