const express = require('express');
const router = express.Router();
const ratingController = require('../controllers/ratingController');
const { isAuth } = require('../middleware/isAuth');

//post/ratings/imageId - valorar imagen
router.post('/:imageId', isAuth, ratingController.postRating);

module.exports = router;