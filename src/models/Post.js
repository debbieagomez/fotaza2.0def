const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Post = sequelize.define('Post', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    title: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    description: {
        type: DataTypes.TEXT
    },
    status: {
        type: DataTypes.ENUM('active', 'pending', 'removed'),
        allowNull: false,
        defaultValue: 'active'
    },
    comments_open: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: true
    }, 
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    updated_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'posts', 
        timestamps: false}
);

module.exports = Post;