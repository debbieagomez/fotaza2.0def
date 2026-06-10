const express = require('express');
const router = express.Router();
const searchController = require('../controllers/searchController');

//Get - search/buscador:
router.get('/', searchController.search);

module.exports = router;