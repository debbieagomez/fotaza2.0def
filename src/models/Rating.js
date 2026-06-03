const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Rating = sequelize.define('Rating', {
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
    score: {
        type: DataTypes.INTEGER,
        allowNull: false,
        validate: {
            min: 1,
            max: 5
        }
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'ratings', 
        timestamps: false,
        indexes: [
            {
                unique: true,
                fields: ['image_id', 'user_id']
            }
        ]
    }
);

module.exports = Rating;