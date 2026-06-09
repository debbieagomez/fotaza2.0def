const { Rating, Image, Post } = require('../models/index');
const { post } = require('../routes/posts');

const ratingController = {

    postRating: async(req, res) => {
        const imageId = parseInt(req.params.imageId);
        const userId = req.session.user.id;
        const score = parseInt(req.body.score);

        try{
            //verificar que la imagen existe
            const image = await Image.findByPk(imageId, {
                include: [{ model: Post}]
            });
            
            if(!image){
                req.flash('error', 'imagen no encontrada');
                return res.redirect('/');
            }

            //verificar que el score sea valido
            if(!score || score < 1 || score > 5){
                req.flash('error', 'la valoracion debe ser entre 1 y 5');
                return res.redirect(`/posts/${image.Post.id}`);
            }

            //verificar si ya valoro esta imagen
            const existing = await Rating.findOne({
                where: { image_id: imageId, user_id: userId}
            });

            if(existing){
                req.flash('error', 'ya valoraste esta imagen');
                return res.redirect(`/posts/${image.Post.id}`);
            }

            await Rating.create({
                image_id: imageId,
                user_id: userId,
                score
            });

            req.flash('success', 'valoracion registrada');
            res.redirect(`/posts/${image.Post.id}`);

        } catch (error) {
            console.error(error);
            res.redirect('/');
        }
    
    }
};

module.exports = ratingController;