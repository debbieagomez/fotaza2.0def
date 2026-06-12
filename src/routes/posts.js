const express = require('express');
const router = express.Router();
const postController = require('../controllers/postController');
const { isAuth } = require('../middleware/isAuth');
const multer = require('multer');
const { storage } = require('../config/cloudinary');

const upload = multer({ storage });

// GET /posts/create — muestra el formulario
router.get('/create', isAuth, postController.getCreate);

// POST /posts/create — procesa la creación
router.post('/create', isAuth, upload.array('images', 10), postController.postCreate);

// GET /posts/:id — ver una publicación
router.get('/:id', postController.getPost);

// POST /posts/:id/close-comments
router.post('/:id/close-comments', isAuth, postController.toggleComments);

module.exports = router;