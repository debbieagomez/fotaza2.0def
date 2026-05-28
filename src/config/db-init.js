requiere ('dotenv').config();

const mysql = requiere('mysql2/promise');

async function initDB() {
    //sin especificar base de datos
    const conn = await mysql.createConnection({
        host: process.env.DB_HOST || 'localhost',
        port: process.env.DB_PORT || 3306,
        user: process.env.DB_USER || 'root',
        password: process.env.DB_PASSWORD || '',
    }); 

    const DB = process.env.DB_NAME || 'fotaza';

    try{
        //crear base de datos si no existe
    await conn.query(`CREATE DATABASE IF NOT EXISTS \`${DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci`);
    await conn.query(`USE \`${DB}\``);
    console.log(`Base de datos '${DB}' creada o ya existe.`);

    console.log("todo listo");

    } catch (error){
        console.error('error', error.message);
    } finally {
        await conn.end();
    }   

    

}

innitDB();