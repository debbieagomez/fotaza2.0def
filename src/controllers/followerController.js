const { Follower, User } = require('../models/index');

const followerController = {

  follow: async (req, res) => {
    const followingId = parseInt(req.params.userId);
    const followerId = req.session.user.id;

    try {
      // No puede seguirse a sí mismo
      if (followerId === followingId) {
        req.flash('error', 'No podés seguirte a vos mismo');
        return res.redirect(`/profile/${req.params.userId}`);
      }

      const userToFollow = await User.findByPk(followingId);
      if (!userToFollow) {
        req.flash('error', 'Usuario no encontrado');
        return res.redirect('/');
      }

      // Verificar si ya lo sigue
      const existing = await Follower.findOne({
        where: { follower_id: followerId, following_id: followingId }
      });

      if (existing) {
        req.flash('error', 'Ya seguís a este usuario');
        return res.redirect(`/profile/${userToFollow.username}`);
      }

      await Follower.create({
        follower_id: followerId,
        following_id: followingId
      });

      req.flash('success', `Ahora seguís a ${userToFollow.display_name || userToFollow.username}`);
      res.redirect(`/profile/${userToFollow.username}`);

    } catch (error) {
      console.error(error);
      res.redirect('/');
    }
  },

  unfollow: async (req, res) => {
    const followingId = parseInt(req.params.userId);
    const followerId = req.session.user.id;

    try {
      const userToUnfollow = await User.findByPk(followingId);
      if (!userToUnfollow) {
        req.flash('error', 'Usuario no encontrado');
        return res.redirect('/');
      }

      await Follower.destroy({
        where: { follower_id: followerId, following_id: followingId }
      });

      req.flash('success', `Dejaste de seguir a ${userToUnfollow.display_name || userToUnfollow.username}`);
      res.redirect(`/profile/${userToUnfollow.username}`);

    } catch (error) {
      console.error(error);
      res.redirect('/');
    }
  }

};

module.exports = followerController;