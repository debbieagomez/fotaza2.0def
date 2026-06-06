const isGuest = (req, res, next) => {
    if(!req.session.user) {
        return next();
    }
    res.redirect('/'); // Redirige a la página principal si el usuario ya está autenticado
};

const isAuth = (req, res, next) => {
    if(req.session.user) {
        return next();
    }
    req.flash('error', 'Debes iniciar sesión para acceder a esta página');
    res.redirect('/auth/login'); // Redirige a la página de inicio de sesión si el usuario no está autenticado
};

const isValidator = (req, res, next) => {
    if(req.session.user && (req.session.user.role_id === 2 || req.session.user.role_id === 3)) {
        return next();
    }
    req.flash('error', 'No tienes permisos para acceder a esta página');
    res.redirect('/'); // Redirige a la página principal si el usuario no tiene permisos
};

module.exports = {
    isGuest,
    isAuth,
    isValidator
};