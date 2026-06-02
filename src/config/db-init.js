requiere ('dotenv').config();
const sequelize = requiere('./db');

async function initDatabase
() {   try {
        await sequelize.authenticate();
        console.log('Conexión a la base de datos establecida con éxito.');

        await sequelize.sync({force: false});
        console.log('tablas sincronizadas correctamente.');
    } catch (error) {
        console.error('error:', error.message);
    }finally {
        await sequelize.close();
}
}

initDatabase();