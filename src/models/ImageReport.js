const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const ImageReport = sequelize.define('ImageReport', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    image_id: {
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
    },    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'image_reports', 
    timestamps: false,
    indexes: [
        {
            unique: true,
            fields: ['image_id', 'user_id']
        }
    ]
});

module.exports = ImageReport;