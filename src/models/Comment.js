const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Comment = sequelize.define('Comment', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },  
    post_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    user_id: {
        type: DataTypes.INTEGER,    
        allowNull: false
    },
    body: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    is_deleted: {
        type: DataTypes.TINYINT,
        allowNull: false,
        defaultValue: 0
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
}, {tableName: 'comments', 
        timestamps: false}
);

module.exports = Comment;