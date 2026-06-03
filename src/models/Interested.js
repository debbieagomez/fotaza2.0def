const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Interested = sequelize.define('Interested', {
    user_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    image_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'interested', 
        timestamps: false}
);  

module.exports = Interested;