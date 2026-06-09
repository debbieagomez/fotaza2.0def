const express = require('express');
const router = express.Router();
const postController = require('../controllers/postController');
const { isAuth } = require('../middleware/isAuth');
const multer = require('multer');
const path = require('path');

// Configuración de multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'public/uploads');
  },
  filename: (req, file, cb) => {
    const unique = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, unique + path.extname(file.originalname));
  }
});

const upload = multer({
  storage,
  limits: { fileSize: 20 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    const allowed = /jpeg|jpg|png|webp/;
    const valid = allowed.test(path.extname(file.originalname).toLowerCase());
    valid ? cb(null, true) : cb(new Error('Solo se permiten imágenes'));
  }
});

// GET /posts/create — muestra el formulario
router.get('/create', isAuth, postController.getCreate);

// POST /posts/create — procesa la creación
router.post('/create', isAuth, upload.array('images', 10), postController.postCreate);

// GET /posts/:id — ver una publicación
router.get('/:id', postController.getPost);


module.exports = router;