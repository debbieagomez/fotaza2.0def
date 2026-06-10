const { User, Post, Image, Follower } = require('../models/index');

const profileController = {

  getProfile: async (req, res) => {
     console.log('---PERFIL---', req.params.username);
    try {
      const profileUser = await User.findOne({
        where: { username: req.params.username }
      });
      console.log('---USUARIO ENCONTRADO---', profileUser ? profileUser.username : 'NO ENCONTRADO');

      if (!profileUser) {
        req.flash('error', 'Usuario no encontrado');
        return res.redirect('/');
      }

      const followersCount = await Follower.count({
        where: { following_id: profileUser.id }
      });
      console.log('---FOLLOWERS---', followersCount);

      const followingCount = await Follower.count({
        where: { follower_id: profileUser.id }
      });

      let isFollowing = false;
      if (req.session.user) {
        const follow = await Follower.findOne({
          where: {
            follower_id: req.session.user.id,
            following_id: profileUser.id
          }
        });
        isFollowing = !!follow;
      }

      const posts = await Post.findAll({
        where: { user_id: profileUser.id, status: 'active' },
        include: [{ model: Image }],
        order: [['created_at', 'DESC']]
      });
      console.log('---POSTS---', posts.length);

      res.render('profile/show', {
        title: profileUser.display_name || profileUser.username,
        profileUser,
        followersCount,
        followingCount,
        isFollowing,
        posts
      });

    } catch (error) {
      console.error('---ERROR PERFIL---', error.message);
      res.redirect('/');
    }
  }

};

module.exports = profileController;