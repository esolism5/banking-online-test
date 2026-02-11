# 📖 GUÍA DE INSTALACIÓN COMPLETA
## Sistema Bancario - Fundación Genesis Empresarial

Esta guía te llevará paso a paso en la instalación y configuración del sistema bancario.

---

## 📋 REQUISITOS PREVIOS

Antes de comenzar, asegúrate de tener instalado:

### 1. Node.js (versión 16 o superior)
```bash
# Verificar instalación
node --version
npm --version
```

**Si no lo tienes instalado:**
- Descarga desde: https://nodejs.org/
- Instala la versión LTS (Long Term Support)

### 2. MySQL (versión 8.0 o superior)
```bash
# Verificar instalación
mysql --version
```

**Si no lo tienes instalado:**
- Windows: https://dev.mysql.com/downloads/installer/
- Mac: `brew install mysql`
- Linux: `sudo apt-get install mysql-server`

### 3. Angular CLI
```bash
# Instalar globalmente
npm install -g @angular/cli

# Verificar instalación
ng version
```

---

## 🗄️ PASO 1: CONFIGURAR LA BASE DE DATOS

### 1.1 Iniciar MySQL
```bash
# Windows
net start MySQL80

# Mac/Linux
sudo service mysql start
```

### 1.2 Conectar a MySQL
```bash
mysql -u root -p
# Ingresa tu contraseña cuando se solicite
```

### 1.3 Crear la base de datos
```bash
# Opción A: Desde la línea de comandos de MySQL
source /ruta/completa/al/proyecto/db/01_schema.sql
source /ruta/completa/al/proyecto/db/02_data.sql

# Opción B: Ejecutar manualmente
# Abre los archivos en un editor y copia-pega en MySQL Workbench o similar
```

### 1.4 Verificar que se creó correctamente
```sql
SHOW DATABASES;
USE genesis_bancario;
SHOW TABLES;
SELECT COUNT(*) FROM usuarios;
```

**Deberías ver:**
- Base de datos: `genesis_bancario`
- 13 tablas creadas
- 8 usuarios de prueba

---

## 🔧 PASO 2: CONFIGURAR EL BACKEND

### 2.1 Navegar a la carpeta del backend
```bash
cd backend
```

### 2.2 Instalar dependencias
```bash
npm install
```

**Esto instalará:**
- express
- mysql2
- cors
- dotenv
- bcryptjs
- jsonwebtoken
- y otras dependencias

### 2.3 Configurar variables de entorno
```bash
# Copiar el archivo de ejemplo
cp .env.example .env

# Abrir el archivo .env en un editor
# Windows: notepad .env
# Mac/Linux: nano .env
```

**Editar el archivo .env con tus datos:**
```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password_de_mysql_aqui
DB_NAME=genesis_bancario
DB_PORT=3306
JWT_SECRET=genesis_bancario_secret_key_2024_fundacion_empresarial_gt
JWT_EXPIRES_IN=24h
NODE_ENV=development
ALLOWED_ORIGINS=http://localhost:4200,http://localhost:3000
```

**⚠️ IMPORTANTE:** Cambia `DB_PASSWORD` por tu contraseña real de MySQL

### 2.4 Probar la conexión
```bash
# Iniciar el servidor en modo desarrollo
npm run dev
```

**Deberías ver:**
```
╔════════════════════════════════════════════════════════╗
║        🏦  FUNDACIÓN GENESIS EMPRESARIAL 🏦           ║
║              Sistema Bancario en Línea                 ║
╠════════════════════════════════════════════════════════╣
║  🚀 Servidor corriendo en: http://localhost:3000      ║
║  💾 Base de datos: genesis_bancario                    ║
╚════════════════════════════════════════════════════════╝
```

### 2.5 Probar el endpoint de salud
Abre tu navegador y ve a: http://localhost:3000/api/health

Deberías ver:
```json
{
  "status": "OK",
  "message": "Servidor Genesis Bancario funcionando correctamente",
  "timestamp": "2024-02-10T...",
  "environment": "development"
}
```

---

## 🎨 PASO 3: CONFIGURAR EL FRONTEND

### 3.1 Abrir una nueva terminal
**No cierres la terminal del backend**, abre una nueva terminal.

### 3.2 Navegar a la carpeta del frontend
```bash
cd frontend
```

### 3.3 Instalar dependencias
```bash
npm install
```

**Esto instalará:**
- Angular y sus dependencias
- TypeScript
- RxJS
- Chart.js para gráficas
- Y más dependencias necesarias

**⏱️ NOTA:** Este proceso puede tomar varios minutos

### 3.4 Iniciar la aplicación
```bash
npm start
# O alternativamente:
ng serve
```

**Deberías ver:**
```
** Angular Live Development Server is listening on localhost:4200 **
✔ Compiled successfully.
```

### 3.5 Abrir la aplicación
Abre tu navegador y ve a: http://localhost:4200

**¡Deberías ver el sistema bancario funcionando!**

---

## 👤 PASO 4: INICIAR SESIÓN

### Usuarios de prueba disponibles:

| Usuario | Email | Contraseña |
|---------|-------|-----------|
| María García | maria.garcia@gmail.com | Genesis2024! |
| Carlos Pérez | carlos.perez@gmail.com | Genesis2024! |
| Ana Rodríguez | ana.rodriguez@gmail.com | Genesis2024! |

**Inicia sesión con cualquiera de estos usuarios para explorar el sistema.**

---

## 🧪 PASO 5: PROBAR LA API CON POSTMAN (OPCIONAL)

### 5.1 Importar la colección
1. Abre Postman
2. File → Import
3. Selecciona el archivo: `collection/Genesis-Bancario.postman_collection.json`

### 5.2 Realizar un login
1. En Postman, abre la carpeta "Auth"
2. Selecciona "Login"
3. Click en "Send"
4. Copia el token que recibes en la respuesta

### 5.3 Usar el token
1. Ve a la pestaña "Variables" de la colección
2. En la variable `token`, pega el token copiado
3. Ahora puedes usar los demás endpoints

---

## ✅ VERIFICACIÓN FINAL

### El sistema está funcionando correctamente si:

✅ Backend corriendo en http://localhost:3000
✅ Frontend corriendo en http://localhost:4200
✅ Puedes iniciar sesión con los usuarios de prueba
✅ Ves el dashboard con tus cuentas y transacciones
✅ La base de datos tiene todos los datos de prueba

---

## 🚨 SOLUCIÓN DE PROBLEMAS COMUNES

### Problema: "Cannot connect to MySQL"
**Solución:**
- Verifica que MySQL esté corriendo
- Verifica usuario y contraseña en .env
- Verifica que el puerto sea 3306

### Problema: "Port 3000 already in use"
**Solución:**
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <número_de_proceso> /F

# Mac/Linux
lsof -ti:3000 | xargs kill
```

### Problema: "Module not found" en frontend
**Solución:**
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### Problema: "Cannot find table 'cuentas'"
**Solución:**
- Vuelve a ejecutar los scripts de base de datos
- Verifica que estás usando la base de datos correcta

---


**Desarrollado con ❤️ para Fundación Genesis Empresarial**
