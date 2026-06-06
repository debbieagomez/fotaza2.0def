require('dotenv').config();
const {sequelize} = require('../models/index');

async function initDatabase() {
    try {
        await sequelize.authenticate();
        console.log('Conexion a MYSQL exitosa.');

        await sequelize.sync({force: false});
        console.log('tablas sincronizadas correctamente.');

        // Insertar roles iniciales
const { Role } = require('../models/index');
await Role.findOrCreate({ where: { id: 1 }, defaults: { name: 'user', description: 'Usuario registrado' }});
await Role.findOrCreate({ where: { id: 2 }, defaults: { name: 'validator', description: 'Validador de contenidos' }});
await Role.findOrCreate({ where: { id: 3 }, defaults: { name: 'admin', description: 'Administrador' }});
console.log('Roles insertados correctamente.');

    } catch (error) {
        console.error('error:', error.message);
    } finally {
        await sequelize.close();
} 
}

initDatabase();