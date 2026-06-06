const bcrypt = require('bcryptjs');
const { User } = require('../models/index');

const authController = {

  getLogin: (req, res) => {
    res.render('auth/login', { title: 'Iniciar sesión' });
  },

  postLogin: async (req, res) => {
    const { email, password } = req.body;
    try {
      const user = await User.findOne({ where: { email } });

      if (!user) {
        req.flash('error', 'Email o contraseña incorrectos');
        return res.redirect('/auth/login');
      }

      const match = await bcrypt.compare(password, user.password_hash);
      if (!match) {
        req.flash('error', 'Email o contraseña incorrectos');
        return res.redirect('/auth/login');
      }

      if (!user.is_active) {
        req.flash('error', 'Tu cuenta está inactiva');
        return res.redirect('/auth/login');
      }

      req.session.user = {
        id: user.id,
        username: user.username,
        email: user.email,
        display_name: user.display_name,
        role_id: user.role_id
      };

      req.flash('success', `Bienvenido ${user.display_name || user.username}!`);
      res.redirect('/');

    } catch (error) {
      console.error(error);
      res.redirect('/auth/login');
    }
  },

  getRegister: (req, res) => {
    res.render('auth/register', { title: 'Registrarse' });
  },

  postRegister: async (req, res) => {
    const { username, email, password, display_name } = req.body;
    try {
      const existingEmail = await User.findOne({ where: { email } });
      if (existingEmail) {
        req.flash('error', 'Ese email ya está registrado');
        return res.redirect('/auth/register');
      }

      const existingUsername = await User.findOne({ where: { username } });
      if (existingUsername) {
        req.flash('error', 'Ese nombre de usuario ya está en uso');
        return res.redirect('/auth/register');
      }

      const password_hash = await bcrypt.hash(password, 10);

      await User.create({
        username,
        email,
        password_hash,
        display_name: display_name || username,
        role_id: 1
      });

      req.flash('success', 'Cuenta creada correctamente. Ya podés iniciar sesión');
      res.redirect('/auth/login');

    } catch (error) {
      console.error(error);
      req.flash('error', 'Error al crear la cuenta');
      res.redirect('/auth/register');
    }
  },

  postLogout: (req, res) => {
    req.session.destroy();
    res.redirect('/auth/login');
  }

};

module.exports = authController;


