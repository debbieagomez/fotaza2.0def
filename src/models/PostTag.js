const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const PostTag = sequelize.define('PostTag', {
    post_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    tag_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    }
}, {tableName: 'post_tags', 
        timestamps: false}
);

module.exports = PostTag;