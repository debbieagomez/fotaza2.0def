  require('dotenv').config();
const bcrypt = require('bcryptjs');
const { sequelize, Role, User, Post, Image, Tag, PostTag, Comment, Rating, Follower, Collection, CollectionPost, ReportReason } = require('../models/index');

async function seed() {
  try {
    console.log('Iniciando seeder...');

    //ROLES: 
    await Role.findOrCreate({ where: { id: 1 }, defaults: { name: 'user', description: 'Usuario registrado' }});
    await Role.findOrCreate({ where: { id: 2 }, defaults: { name: 'validator', description: 'Validador de contenidos' }});
    await Role.findOrCreate({ where: { id: 3 }, defaults: { name: 'admin', description: 'Administrador' }});
    console.log('Roles');

    // USUARIOS:
    const pass = await bcrypt.hash('Test1234!', 10);

    const [admin] = await User.findOrCreate({ where: { email: 'admin@fotaza.com' }, defaults: {
      username: 'admin', password_hash: pass, display_name: 'Administrador', role_id: 3, is_active: true
    }});
    const [validator] = await User.findOrCreate({ where: { email: 'validator@fotaza.com' }, defaults: {
      username: 'validador', password_hash: pass, display_name: 'Juan Validador', role_id: 2, is_active: true
    }});
    const [user1] = await User.findOrCreate({ where: { email: 'maria@fotaza.com' }, defaults: {
      username: 'maria', password_hash: pass, display_name: 'María García', role_id: 1, is_active: true
    }});
    const [user2] = await User.findOrCreate({ where: { email: 'pedro@fotaza.com' }, defaults: {
      username: 'pedro', password_hash: pass, display_name: 'Pedro López', role_id: 1, is_active: true
    }});
    const [user3] = await User.findOrCreate({ where: { email: 'ana@fotaza.com' }, defaults: {
      username: 'ana', password_hash: pass, display_name: 'Ana Martínez', role_id: 1, is_active: true
    }});
    console.log(' Usuarios');

    // TAGS
    const tagNames = ['paisaje', 'retrato', 'naturaleza', 'ciudad', 'blanco y negro', 'macro', 'arquitectura', 'viaje', 'abstracto', 'animales'];
    const tags = [];
    for (const name of tagNames) {
      const [tag] = await Tag.findOrCreate({ where: { name } });
      tags.push(tag);
    }
    console.log('Tags');

    // MOTIVOS DE DENUNCIA
    const reasons = ['Contenido inapropiado', 'Violación de derechos de autor', 'Spam', 'Acoso', 'Información falsa', 'Otro'];
    for (let i = 0; i < reasons.length; i++) {
      await ReportReason.findOrCreate({ where: { id: i + 1 }, defaults: { label: reasons[i] } });
    }
    console.log('Motivos de denuncia');

    // PUBLICACIONES:
    const [post1] = await Post.findOrCreate({ where: { title: 'Atardecer en la montaña' }, defaults: {
      user_id: user1.id, description: 'Hermoso atardecer capturado en la cordillera', status: 'active', comments_open: true
    }});
    const [post2] = await Post.findOrCreate({ where: { title: 'Retrato urbano' }, defaults: {
      user_id: user2.id, description: 'Fotografía callejera en el centro de la ciudad', status: 'active', comments_open: true
    }});
    const [post3] = await Post.findOrCreate({ where: { title: 'Naturaleza salvaje' }, defaults: {
      user_id: user3.id, description: 'Flora y fauna en su estado natural', status: 'active', comments_open: true
    }});
    console.log(' Posts');

    // IMAGENES:
    await Image.findOrCreate({ where: { post_id: post1.id, order_index: 0 }, defaults: {
      file_path: '/uploads/sample1.jpg', license: 'free', order_index: 0
    }});
    await Image.findOrCreate({ where: { post_id: post2.id, order_index: 0 }, defaults: {
      file_path: '/uploads/sample2.jpg', license: 'copyright', watermark_text: '© Pedro López', order_index: 0
    }});
    await Image.findOrCreate({ where: { post_id: post3.id, order_index: 0 }, defaults: {
      file_path: '/uploads/sample3.jpg', license: 'free', order_index: 0
    }});
    console.log(' Imágenes');

    // POST TAG
    await PostTag.findOrCreate({ where: { post_id: post1.id, tag_id: tags[0].id }});
    await PostTag.findOrCreate({ where: { post_id: post1.id, tag_id: tags[2].id }});
    await PostTag.findOrCreate({ where: { post_id: post2.id, tag_id: tags[1].id }});
    await PostTag.findOrCreate({ where: { post_id: post2.id, tag_id: tags[3].id }});
    await PostTag.findOrCreate({ where: { post_id: post3.id, tag_id: tags[2].id }});
    await PostTag.findOrCreate({ where: { post_id: post3.id, tag_id: tags[9].id }});
    console.log('PostTags');

    // COMENTARIOS:
    await Comment.findOrCreate({ where: { post_id: post1.id, user_id: user2.id }, defaults: {
      body: '¡Qué foto tan hermosa!', is_deleted: false
    }});
    await Comment.findOrCreate({ where: { post_id: post1.id, user_id: user3.id }, defaults: {
      body: 'Me encanta el juego de luces', is_deleted: false
    }});
    await Comment.findOrCreate({ where: { post_id: post2.id, user_id: user1.id }, defaults: {
      body: 'Excelente composición', is_deleted: false
    }});
    console.log(' Comentarios');

    // FOLLOWERS:
    await Follower.findOrCreate({ where: { follower_id: user1.id, following_id: user2.id }});
    await Follower.findOrCreate({ where: { follower_id: user2.id, following_id: user1.id }});
    await Follower.findOrCreate({ where: { follower_id: user3.id, following_id: user1.id }});
    console.log(' Followers');

    // COLECCIONES:
    const [col1] = await Collection.findOrCreate({ where: { user_id: user1.id, name: 'Paisajes' }});
    const [col2] = await Collection.findOrCreate({ where: { user_id: user1.id, name: 'Inspiración' }});
    await CollectionPost.findOrCreate({ where: { collection_id: col1.id, post_id: post1.id }});
    await CollectionPost.findOrCreate({ where: { collection_id: col2.id, post_id: post2.id }});
    console.log('Colecciones');

    console.log(`
╔══════════════════════════════════════════════════════╗
║  ✅  Seeder ejecutado correctamente                  ║
╠══════════════════════════════════════════════════════╣
║  USUARIOS DE PRUEBA (contraseña: Test1234!)          ║
║  admin@fotaza.com      → admin                       ║
║  validator@fotaza.com  → validador                   ║
║  maria@fotaza.com      → usuario                     ║
║  pedro@fotaza.com      → usuario                     ║
║  ana@fotaza.com        → usuario                     ║
╚══════════════════════════════════════════════════════╝
    `);

  } catch (error) {
    console.error('❌ Error en seeder:', error.message);
  } finally {
    await sequelize.close();
  }
}

seed();