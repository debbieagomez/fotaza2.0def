const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const CommentReport = sequelize.define('CommentReport', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    comment_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    user_id: {
        type: DataTypes.INTEGER,    
        allowNull: false
    },
    reason_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    description: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'comment_reports', 
    timestamps: false,
});

module.exports = CommentReport;