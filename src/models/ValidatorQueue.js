const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const ValidatorQueue = sequelize.define('ValidatorQueue', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    post_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        unique: true
    },
    status: {
        type: DataTypes.ENUM('pending', 'resolved'),
        defaultValue: 'pending',
        allowNull: false
    },
    resolved_by: {
        type: DataTypes.INTEGER
    },
    resolution: {
        type: DataTypes.TEXT
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
    }, {
        timestamps: false,
        tableName: 'validator_queue'
    });




module.exports = ValidatorQueue;
