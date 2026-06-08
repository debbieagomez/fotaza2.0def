const {Post, Image, Tag, PostTag, User, Comment } = require('../models/index');

const postController = {

    //muestra el formulario de creacion
   getCreate: (req, res) => {
  try {
    res.render('posts/create', { title: 'Nueva publicación' });
  } catch(err) {
    console.error('ERROR GETCREATE:', err.message);
    res.status(500).send(err.message);
  }
},

    //procesa la creacion de una publicacion 
    postCreate: async (req, res) => {
        const {title, description, tags, license, watermark_text} = req.body;
        const userId = req.session.user.id;

        try{
            //verificar que se subio al menos una imagen
            if(!req.files || req.files.length === 0 ){
                req.flash('error', 'debes subir al menos una imagen');
                return res.redirect('/posts/create');
            }

            //crear la publicacion

            const post = await Post.create({
                user_id: userId,
                title,
                description: description || null,
                status: 'active',
                comments_open: true
            });

            //guardar cada imagen 
            for(let i= 0; i < req.files.length; i++){
                await Image.create({
                    post_id: post.id,
                    file_path: '/uploads/' + req.files[i].filename,
                    license: license || 'free',
                    watermark_text: license === 'copyright' ? watermark_text: null,
                    order_index: i
                });
            
            }
            //procesar etiquetas
            if(tags){
                const tagNames = tags.split (',').map(t => t.trim().toLowerCase()).filter(t => t);
                for(const name of tagNames){
                    const [tag] = await Tag.findOrCreate({ where: { name}});
                await PostTag.create({post_id: post.id, tag_id: tag.id });
                }
                
            }
             req.flash('success', 'publicacion creada correctamente!');
             res.redirect(`/posts/${post.id}`);
        } catch(error){
            console.error(error);
            req.flash('error', 'error al crear la publicacion');
            res.redirect('/posts/create');
        }
       


    },
    // ver una publicacion
    getPost: async(req, res) => {
        try{
            const post = await Post.findByPk(req.params.id, {
                include: [
                    {model: User, attributes: ['username', 'display_name']},
                    {model: Image },
                    {model: Tag },
                    {
                        model: Comment,
                        include: [{ model: User, attributes:['username', 'display_name']}]
                    }
                ]
            });
            if(!post){
                req.flash('error', 'publicacion no encontrada');
                return res.redirect('/');
            }
            res.render('posts/show', { title: post.title, post});

        }catch(error){
            console.log(error);
            res.redirect('/');
        }
    }
};

module.exports = postController;