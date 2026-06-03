const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const User = sequelize.define('User', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    }, 
    username: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true
    },
    email: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true
    },
    password_hash: {
        type: DataTypes.STRING(255),
        allowNull: false
    },
    display_name: {
        type: DataTypes.STRING(100)
    },
    bio:{
        type: DataTypes.TEXT
    },
    role_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 1
    },
    strikes:{
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
}, {tableName: 'users', 
        timestamps: false}
);

module.exports = User;