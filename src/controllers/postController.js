const {Post, Image, Tag, PostTag, User, Comment, Rating } = require('../models/index');

const postController = {

  getCreate: (req, res) => {
    try {
      res.render('posts/create', { title: 'Nueva publicación' });
    } catch(err) {
      console.error('ERROR GETCREATE:', err.message);
      res.status(500).send(err.message);
    }
  },

  postCreate: async (req, res) => {
    const {title, description, tags, license, watermark_text} = req.body;
    const userId = req.session.user.id;

    try {
      if(!req.files || req.files.length === 0) {
        req.flash('error', 'Debés subir al menos una imagen');
        return res.redirect('/posts/create');
      }

      const post = await Post.create({
        user_id: userId,
        title,
        description: description || null,
        status: 'active',
        comments_open: true
      });

      for(let i = 0; i < req.files.length; i++) {
        await Image.create({
          post_id: post.id,
          file_path: req.files[i].path,
          license: license || 'free',
          watermark_text: license === 'copyright' ? watermark_text : null,
          order_index: i
        });
      }

      if(tags) {
        const tagNames = tags.split(',').map(t => t.trim().toLowerCase()).filter(t => t);
        for(const name of tagNames) {
          const [tag] = await Tag.findOrCreate({ where: { name }});
          await PostTag.create({ post_id: post.id, tag_id: tag.id });
        }
      }

      req.flash('success', '¡Publicación creada correctamente!');
      res.redirect(`/posts/${post.id}`);

    } catch(error) {
      console.error(error);
      req.flash('error', 'Error al crear la publicación');
      res.redirect('/posts/create');
    }
  },

  getPost: async(req, res) => {
    try {
      const post = await Post.findByPk(req.params.id, {
        include: [
          { model: User, attributes: ['username', 'display_name'] },
          { model: Image, include: [{ model: Rating }] },
          { model: Tag },
          { model: Comment, include: [{ model: User, attributes: ['username', 'display_name'] }] }
        ]
      });

      if(!post) {
        req.flash('error', 'Publicación no encontrada');
        return res.redirect('/');
      }

      res.render('posts/show', { title: post.title, post });

    } catch(error) {
      console.log(error);
      res.redirect('/');
    }
  },

  toggleComments: async (req, res) => {
    const postId = parseInt(req.params.id);
    const userId = req.session.user.id;

    try {
      const post = await Post.findByPk(postId);

      if (!post) {
        req.flash('error', 'Publicación no encontrada');
        return res.redirect('/');
      }

      if (post.user_id !== userId) {
        req.flash('error', 'No tenés permisos para hacer esto');
        return res.redirect(`/posts/${postId}`);
      }

      await post.update({ comments_open: !post.comments_open });

      req.flash('success', post.comments_open ? 'Comentarios cerrados' : 'Comentarios abiertos');
      res.redirect(`/posts/${postId}`);

    } catch (error) {
      console.error(error);
      res.redirect('/');
    }
  }

};

module.exports = postController;