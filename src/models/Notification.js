const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Notification = sequelize.define('Notification', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    actor_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    type: {
        type: DataTypes.ENUM('comment', 'rating', 'interesed', 'follow'),
        allowNull: false
    },
    entity_id: {
        type: DataTypes.INTEGER,
    },
    is_read: {
        type: DataTypes.TINYINT,
        allowNull: false,
        defaultValue: 0
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'notifications', 
        timestamps: false}
);
module.exports = Notification;