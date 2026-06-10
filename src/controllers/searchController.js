const { Post, Image, Tag, User } = require('../models/index');
const { Op } = require('sequelize');

const searchController = {

  search: async (req, res) => {
    const { q, tag } = req.query;

    try {
      const whereClause = { status: 'active' };
      
      if (q && q.trim() !== '') {
        whereClause.title = { [Op.iLike]: `%${q.trim()}%` };
      }

      const tagInclude = {
        model: Tag,
        required: false
      };

      if (tag && tag.trim() !== '') {
        tagInclude.where = { name: { [Op.iLike]: `%${tag.trim()}%` } };
        tagInclude.required = true;
      }

      const posts = await Post.findAll({
        where: whereClause,
        include: [
          { model: Image },
          tagInclude,
          { model: User, attributes: ['username', 'display_name'] }
        ],
        order: [['created_at', 'DESC']]
      });

      res.render('search/index', {
        title: 'Buscar',
        posts,
        q: q || '',
        tag: tag || ''
      });

    } catch (error) {
      console.error(error);
      res.redirect('/');
    }
  }

};

module.exports = searchController;