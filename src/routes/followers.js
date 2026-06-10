const express = require('express');
const router = express.Router();
const followerController = require('../controllers/followerController');
const { isAuth } = require('../middleware/isAuth');

//post /followers/userId/follow - seguir usuario
router.post('/:userId/follow', isAuth, followerController.follow);

//post /followers/userId/unFollow - dejar de seguir
router.post('/:userId/unFollow', isAuth, followerController.unfollow);

module.exports = router;