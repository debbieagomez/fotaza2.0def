const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { isGuest } = require('../middleware/isAuth');

// Rutas de autenticación

// Ruta para mostrar el formulario de inicio de sesión
router.get('/login', isGuest, authController.getLogin);
//procesa el login del usuario
router.post('/login', isGuest, authController.postLogin);
// Ruta para mostrar el formulario de registro
router.get('/register', isGuest, authController.getRegister);
//procesa el registro del usuario
router.post('/register', isGuest, authController.postRegister);
// Ruta para cerrar sesión
router.post('/logout', authController.postLogout);

module.exports = router;