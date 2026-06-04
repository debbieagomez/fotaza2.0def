const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const CollectionPost = sequelize.define('CollectionPost', {
    collection_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    post_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    added_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    timestamps: false,
    tableName: 'collection_posts'
});

module.exports = CollectionPost;
    