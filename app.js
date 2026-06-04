require('dotenv').config();

const express = require('express');
const session = require('express-session');
const flash = require('connect-flash');
const path = require('path');


const app = express();

// MOTOR DE PLANTILLAS
app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'views'));


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

//VARIABLES DISPONIBLES EN TODAS LAS VISTAS
app.use((req, res, next) => {
    res.locals.user = req.session.user || null; 
    res.locals.success_msg = req.flash('success');
    res.locals.error_msg = req.flash('error');
    next();
});


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
const PORT = process.env.PORT || 3000;
app.listen (PORT , () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});