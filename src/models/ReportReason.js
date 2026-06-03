const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const ReportReason = sequelize.define('ReportReason', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    label: {
        type: DataTypes.STRING(255),
        allowNull: false,
    }
}, {tableName: 'report_reasons', timestamps: false});

module.exports = ReportReason;