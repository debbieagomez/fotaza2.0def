const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Image = sequelize.define('Image', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    post_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    file_path:{
        type: DataTypes.STRING(255),
        allowNull: false
    },
    license: {
        type: DataTypes.ENUM('free','copyright'),
        allowNull: false,
    },
    watermark_text: {
        type: DataTypes.STRING(255)
    },
    order_index: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'images', 
        timestamps: false}
);

module.exports = Image;