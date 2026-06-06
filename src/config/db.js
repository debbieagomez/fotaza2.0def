const{Sequelize} = require('sequelize');

const sequelize = new Sequelize(
    process.env.DB_NAME || 'fotaza',
    process.env.DB_USER || 'root',
    process.env.DB_PASSWORD || '',
    {
        host: process.env.DB_HOST || 'localhost',
        logging: false,
        dialect: 'postgres'
    }
);

module.exports = sequelize;
