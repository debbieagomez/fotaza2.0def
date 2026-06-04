require('dotenv').config();
const {sequelize} = require('../models/index');

async function initDatabase() {
    try {
        await sequelize.authenticate();
        console.log('Conexion a MYSQL exitosa.');

        await sequelize.sync({force: false});
        console.log('tablas sincronizadas correctamente.');
    } catch (error) {
        console.error('error:', error.message);
    } finally {
        await sequelize.close();
} 
}

initDatabase();