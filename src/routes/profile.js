const express = require('express');
const router = express.Router();
const profileController = require('../controllers/profileController');

//Get/profile/username - ver perfil de un usuario
router.get('/:username', profileController.getProfile);

module.exports = router;