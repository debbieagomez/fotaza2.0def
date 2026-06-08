const { Comment, Post } = require('../models/index');

const commentController = {

  postComment: async (req, res) => {
    const { body } = req.body;
    const postId = parseInt(req.params.postId);
    const userId = req.session.user.id;

    try {
      const post = await Post.findByPk(postId);
      if (!post) {
        req.flash('error', 'Publicación no encontrada');
        return res.redirect('/');
      }

      if (!post.comments_open) {
        req.flash('error', 'Los comentarios están cerrados');
        return res.redirect(`/posts/${postId}`);
      }

      if (!body || body.trim() === '') {
        req.flash('error', 'El comentario no puede estar vacío');
        return res.redirect(`/posts/${postId}`);
      }

      await Comment.create({
        post_id: postId,
        user_id: userId,
        body: body.trim()
      });

      req.flash('success', 'Comentario agregado');
      res.redirect(`/posts/${postId}`);

    } catch (error) {
      console.error(error);
      req.flash('error', 'Error al agregar el comentario');
      res.redirect(`/posts/${postId}`);
    }
  },

  deleteComment: async (req, res) => {
    const commentId = req.params.id;
    const userId = req.session.user.id;

    try {
      const comment = await Comment.findByPk(commentId, {
        include: [{ model: Post }]
      });

      if (!comment) {
        req.flash('error', 'Comentario no encontrado');
        return res.redirect('/');
      }

      if (comment.Post.user_id !== userId) {
        req.flash('error', 'No tenés permisos para borrar este comentario');
        return res.redirect(`/posts/${comment.post_id}`);
      }

      await comment.update({ is_deleted: true });

      req.flash('success', 'Comentario eliminado');
      res.redirect(`/posts/${comment.post_id}`);

    } catch (error) {
      console.error(error);
      res.redirect('/');
    }
  }
};

module.exports = commentController;