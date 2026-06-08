const express = require('express');
const router = express.Router();
const commentController = require('../controllers/commentController');
const { isAuth } = require('../middleware/isAuth');

// POST /comments/:postId — agregar un comentario
router.post('/:postId', isAuth, commentController.postComment);

// POST /comments/:id/delete — borrar un comentario
router.post('/:id/delete', isAuth, commentController.deleteComment);

module.exports = router;