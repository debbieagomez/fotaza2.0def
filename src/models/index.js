const sequelize = require('../config/db');

const Role           = require('./Role');
const User           = require('./User');
const Post           = require('./Post');
const Image          = require('./Image');
const Tag            = require('./Tag');
const PostTag        = require('./PostTag');
const Comment        = require('./Comment');
const Rating         = require('./Rating');
const Follower       = require('./Follower');
const Notification   = require('./Notification');
const Message        = require('./Message');
const Interested     = require('./Interested');
const ReportReason   = require('./ReportReason');
const ImageReport    = require('./ImageReport');
const CommentReport  = require('./CommentReport');
const Collection     = require('./Collection');
const CollectionPost = require('./CollectionPost');
const ValidatorQueue = require('./ValidatorQueue');

// User - Role
Role.hasMany(User, { foreignKey: 'role_id' });
User.belongsTo(Role, { foreignKey: 'role_id' });

// Post - User
User.hasMany(Post, { foreignKey: 'user_id' });
Post.belongsTo(User, { foreignKey: 'user_id' });

// Image - Post
Post.hasMany(Image, { foreignKey: 'post_id' });
Image.belongsTo(Post, { foreignKey: 'post_id' });

// Post - Tag
Post.belongsToMany(Tag, { through: PostTag, foreignKey: 'post_id' });
Tag.belongsToMany(Post, { through: PostTag, foreignKey: 'tag_id' });

// Comment - Post - User
Post.hasMany(Comment, { foreignKey: 'post_id' });
Comment.belongsTo(Post, { foreignKey: 'post_id' });
User.hasMany(Comment, { foreignKey: 'user_id' });
Comment.belongsTo(User, { foreignKey: 'user_id' });

// Rating - Image - User
Image.hasMany(Rating, { foreignKey: 'image_id' });
Rating.belongsTo(Image, { foreignKey: 'image_id' });
User.hasMany(Rating, { foreignKey: 'user_id' });
Rating.belongsTo(User, { foreignKey: 'user_id' });

// Followers
User.belongsToMany(User, {
  through: Follower,
  foreignKey: 'follower_id',
  as: 'Following'
});
User.belongsToMany(User, {
  through: Follower,
  foreignKey: 'following_id',
  as: 'Followers'
});

// Notifications
User.hasMany(Notification, { foreignKey: 'user_id' });
Notification.belongsTo(User, { foreignKey: 'user_id' });

// Messages
User.hasMany(Message, { foreignKey: 'sender_id', as: 'SentMessages' });
User.hasMany(Message, { foreignKey: 'receiver_id', as: 'ReceivedMessages' });
Message.belongsTo(User, { foreignKey: 'sender_id', as: 'Sender' });
Message.belongsTo(User, { foreignKey: 'receiver_id', as: 'Receiver' });

// Interested
User.belongsToMany(Image, { through: Interested, foreignKey: 'user_id', as: 'InterestedImages' });
Image.belongsToMany(User, { through: Interested, foreignKey: 'image_id', as: 'InterestedUsers' });

// Reports
ImageReport.belongsTo(Image, { foreignKey: 'image_id' });
ImageReport.belongsTo(User, { foreignKey: 'user_id' });
ImageReport.belongsTo(ReportReason, { foreignKey: 'reason_id' });

CommentReport.belongsTo(Comment, { foreignKey: 'comment_id' });
CommentReport.belongsTo(User, { foreignKey: 'user_id' });
CommentReport.belongsTo(ReportReason, { foreignKey: 'reason_id' });

// ValidatorQueue
Post.hasOne(ValidatorQueue, { foreignKey: 'post_id' });
ValidatorQueue.belongsTo(Post, { foreignKey: 'post_id' });

// Collections
User.hasMany(Collection, { foreignKey: 'user_id' });
Collection.belongsTo(User, { foreignKey: 'user_id' });
Collection.belongsToMany(Post, { through: CollectionPost, foreignKey: 'collection_id', as: 'Posts' });
Post.belongsToMany(Collection, { through: CollectionPost, foreignKey: 'post_id', as: 'Collections' });

module.exports = {
  sequelize,
  Role, User, Post, Image, Tag, PostTag,
  Comment, Rating, Follower, Notification,
  Message, Interested, ReportReason, ImageReport,
  CommentReport, ValidatorQueue, Collection, CollectionPost
};