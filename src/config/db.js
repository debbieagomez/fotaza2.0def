const{sequelize} = require('sequelize');

const sequelize = new sequelize(
    process.env.DB_NAME || 'fotaza',
    process.env.DB_USER || 'root',
    process.env.DB_PASSWORD || '',
    {
        host: process.env.DB_HOST || 'localhost',
        logging: false,
        dialect: 'mysql'
    }
);

module.exports = sequelize;
