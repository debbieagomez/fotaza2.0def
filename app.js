import express from 'express';
import 'dotenv/config';
import session from 'express-session';
import flash from 'connect-flash';
import path from 'path';

const app = express();

//CONSTANTES
const PORT = process.env.PORT; 

// MILDAWARE
app.use(express.json());
app.use(express.urlencoded({extended: true})); // para leer html
app.use(express.static(path.join(__dirname, 'public')));

//SESIONES
app.use(session({
    secret: process.env.SESION_SECRET || 'secreto temporal',
    resave: false,
    saveUninitialized: false,
    cookie: {
        secure: process.env.NODE_ENV === 'production',
        maxAge: 1000 * 60 * 60 * 24
    }   
})); 

//FLASH MESSAGE
app.use(flash());

// MOTOR DE PLANTILLAS
app.set('view engine', 'pug');
app.set('views', './views');

// RUTAS
app.get('/', (req, res) => {
    res.render('index');
});

//manejo de errores
//404 - PAGINA NO ENCONTRADA
app.use((req, res) => {
    res.status(404).render('404', {title: 'pagina no encontrada'});
});
//500 - ERROR INTERNO DEL SERVIDOR
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).render('500', {title: 'error interno del servidor'});
});

//SERVIDOR 
app.listen (PORT , () => {
    console.log(`Servidor escuchando en el puerto ${PORT}`);
});