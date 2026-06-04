const sequelize = require('../config/db');

const Role = require('./role');
const User = require('./user');
const Post = require('./Post');
const Image = require('./image');
const Tag = require('./Tag');
const PostTag = require('./PostTag');
const Comment = require('./Comment');
const Rating = require('./Rating');
const Follower = require('./follower');
const Notification = require('./Notification');
const Message = require('./Message');
const Interested = require('./Interested');
const ReportReason = require('./ReportReason');
const ImageReport = require('./ImageReport');
const CommentReport = require('./CommentReport');
const Collection = require('./Collection');
const CollectionPost = require('./CollectionPost');
const ValidatorQueue = require('./ValidatorQueue');


//asociaciones
//user - role
Role.hasMany(User, {foreignKey: 'role_id'});
User.belongsTo(Role, {foreignKey: 'role_id'});

//post - user
User.hasMany(Post, {foreignKey: 'user_id'});
Post.belongsTo(User, {foreignKey: 'user_id'});

//image - post
Post.hasMany(Image, {foreignKey: 'post_id'});
Image.belongsTo(Post, {foreignKey: 'post_id'});

//post - tag (many-to-many)
Post.belongsToMany(Tag, {through: PostTag, foreignKey: 'post_id'});
Tag.belongsToMany(Post, {through: PostTag, foreignKey: 'tag_id'});

//comment - post - user
Post.hasMany(Comment, {foreignKey: 'post_id'});
Comment.belongsTo(Post, {foreignKey: 'post_id'});
User.hasMany(Comment, {foreignKey: 'user_id'});
Comment.belongsTo(User, {foreignKey: 'user_id'});

//rating - post - user
Post.hasMany(Rating, {foreignKey: 'post_id'});
Rating.belongsTo(Post, {foreignKey: 'post_id'});
User.hasMany(Rating, {foreignKey: 'user_id'});
Rating.belongsTo(User, {foreignKey: 'user_id'});

//followers (auto-referencia)
User.belongsToMany(User, {as: 'Followers', 
    through: Follower, 
    foreignKey: 'following_id',
    as: 'Following',
});

//notificationes
User.hasMany(Notification, {foreignKey: 'user_id'});
Notification.belongsTo(User, {foreignKey: 'user_id'});

//Mensajes
User.hasMany(Message, {foreignKey: 'sender_id', as: 'SentMessages'});
User.hasMany(Message, {foreignKey: 'receiver_id', as: 'ReceivedMessages'});
Message.belongsTo(User, {foreignKey: 'sender_id', as: 'Sender'});
Message.belongsTo(User, {foreignKey: 'receiver_id', as: 'Receiver'});

//Interested
User.belongsToMany(Post, {through: Interested, foreignKey: 'user_id', as: 'InterestedPosts'});
image.belongsToMany(User, {through: Interested, foreignKey: 'post_id', as: 'InterestedUsers'});

//reportes
ImageReport.belongsTo(User, {foreignKey: 'reporter_id'});
ImageReport.belongsTo(Image, {foreignKey: 'image_id'});
ImageReport.belongsTo(ReportReason, {foreignKey: 'reason_id'});

CommentReport.belongsTo(User, {foreignKey: 'reporter_id'});
CommentReport.belongsTo(Comment, {foreignKey: 'comment_id'});
CommentReport.belongsTo(ReportReason, {foreignKey: 'reason_id'});


//colecciones
User.hasMany(Collection, {foreignKey: 'user_id'});
Collection.belongsTo(User, {foreignKey: 'user_id'});
Collection.belongsToMany(Post, {through: CollectionPost, foreignKey: 'collection_id', as: 'Posts'});
Post.belongsToMany(Collection, {through: CollectionPost, foreignKey: 'post_id', as: 'Collections'});

//exportar todo
module.exports = {
    sequelize,
    Role,
    User,
    Post,
    Image,
    Tag,
    PostTag,
    Comment,
    Rating,
    Follower,
    Notification,
    Message,
    Interested,
    ReportReason,
    ImageReport,
    CommentReport,
    Collection,
    CollectionPost,
    ValidatorQueue
};