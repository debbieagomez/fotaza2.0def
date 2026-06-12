#FOTAZA2
PROGRAMACION WEB II - DESARROLLO DE SOFTWARE 
ULP
Alumna: Deborah Ailen Gomez

plataforma web para comparti, valorizar y gestionar fotografias en linea. 

---
##instalacion local

```bash
#1. clonar repositorio
git clone https://github.com/debbieagomez/fotaza2.0def.git
cd fotaza2.0def

#2. instalar dependencias
npm intall

#3. Configurar variables de entorno
cp .env.example .env
#edita el .env con tus datos de PostgreSQL y Cloudinary

#4. Inicializar la base de datos
npm run db:init

#5. Cargar datos de prueba
npm run db:seed

#6. Inicial el servidor
npm start

la app estara disponible en: **http://localhost:3000**

---

## Variables de entorno 

 Variable | Descripción |
|----------|-------------|
| `PORT` | Puerto del servidor (default: 3000) |
| `DB_HOST` | Host de PostgreSQL |
| `DB_PORT` | Puerto de PostgreSQL (default: 5432)
`DB_USER` | Usuario de PostgreSQL |
| `DB_PASSWORD` | Contraseña de PostgreSQL |
| `DB_NAME` | Nombre de la base de datos |
| `SESSION_SECRET` | Clave secreta para sesiones |
| `CLOUDINARY_CLOUD_NAME` | Cloud name de Cloudinary|
| `CLOUDINARY_API_KEY` | API Key de Cloudinary |
| `CLOUDINARY_API_SECRET` | API Secret de   Cloudinary |

Usuarios de prueba

Contraseña para todos: **Test1234!**

| Email | Username | Rol |
|-------|----------|-----|
| admin@fotaza.com | admin | Administrador |
| validator@fotaza.com | validador | Validador de contenidos |
| maria@fotaza.com | maria | Usuario |
| pedro@fotaza.com | pedro | Usuario |
| ana@fotaza.com | ana | Usuario |


## Stack tecnologico:
- RunTime: Node.js
- Frameworck: Express.js
- Vistas:PUG
- Base de Datos: PostgresSQL + Sequelize
- Autenticacion: express-session + bcryptjs
- Imagenes: Cloudinary + Multer
- CSS: Booststrap 5 

##Funcionalidades que se implementaron:
- Registro y login de usuarios con contraseñas cifradas (bcrypt)
- Crear publicaciones con múltiples imágenes y etiquetas
- Licencias de imágenes (libre o copyright)
- Comentarios en publicaciones
- Valoración de imágenes (1 a 5 estrellas)
- Seguimiento de usuarios (followers)
- Buscador por título y etiqueta
- Perfil de usuario con contadores de seguidores


## 🔧 Problemas encontrados y soluciones

### 1. ES Modules vs CommonJS
Al iniciar el proyecto tenía `"type": "module"` en el `package.json` lo que causaba errores con `__dirname` y con Sequelize. Se resolvió eliminando esa línea y usando CommonJS con `require()`.

### 2. Almacenamiento de imágenes
Inicialmente las imágenes se guardaban en `public/uploads/` en el servidor local. Esto genera problemas en producción porque los archivos no persisten. Se migró a **Cloudinary** para almacenamiento en la nube.

### 3. Tipos de datos MySQL vs PostgreSQL
El proyecto originalmente estaba pensado para MySQL. Al usar PostgreSQL se encontraron incompatibilidades con el tipo `TINYINT` y con valores `0/1` para campos booleanos. Se resolvió usando `DataTypes.BOOLEAN` con valores `true/false`.

### 4. Variables de entorno con dotenv
Se configuraron todas las variables sensibles (credenciales de base de datos, Cloudinary, sesiones) en el archivo `.env` para no exponer datos en el repositorio.