# 🏦 Sistema Bancario en Línea - Fundación Genesis Empresarial

Sistema bancario completo desarrollado con Angular, Node.js/Express y MySQL.

## 📋 Descripción

Sistema web de banca en línea que permite a los usuarios gestionar sus cuentas bancarias, realizar transacciones, solicitar préstamos y ver estadísticas financieras en tiempo real.

## ✨ Características Principales

- ✅ Dashboard interactivo con gráficas y estadísticas
- ✅ Gestión de múltiples cuentas bancarias
- ✅ Transferencias entre cuentas (internas y externas)
- ✅ Pagos de servicios y préstamos
- ✅ Visualización de tarjetas de débito y crédito
- ✅ Sistema de préstamos y créditos
- ✅ Historial completo de transacciones
- ✅ Notificaciones en tiempo real
- ✅ Diseño responsive y moderno
- ✅ Animaciones suaves y profesionales

## 🛠️ Tecnologías Utilizadas

### Frontend
- **Angular 17** - Framework principal
- **TypeScript** - Lenguaje de programación
- **CSS3** - Estilos y animaciones
- **Chart.js** - Gráficas y visualizaciones

### Backend
- **Node.js** - Entorno de ejecución
- **Express** - Framework web
- **MySQL2** - Driver de base de datos
- **JWT** - Autenticación
- **Bcrypt** - Encriptación de contraseñas

### Base de Datos
- **MySQL** - Sistema de gestión de base de datos

## 📁 Estructura del Proyecto

```
fundacion-genesis-bancario/
├── frontend/               # Aplicación Angular
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/    # Componentes de la UI
│   │   │   ├── services/      # Servicios de API
│   │   │   ├── guards/        # Guardias de rutas
│   │   │   └── models/        # Interfaces y modelos
│   │   ├── assets/            # Recursos estáticos
│   │   └── environments/      # Configuraciones de entorno
│   ├── package.json
│   └── angular.json
│
├── backend/                # API REST Node.js
│   ├── config/             # Configuraciones
│   │   └── database.js     # Conexión a MySQL
│   ├── controllers/        # Controladores
│   ├── routes/             # Rutas de la API
│   ├── middlewares/        # Middlewares (auth, validación)
│   ├── models/             # Modelos de datos
│   ├── utils/              # Utilidades
│   ├── server.js           # Servidor principal
│   ├── package.json
│   └── .env.example        # Variables de entorno ejemplo
│
├── db/                     # Base de Datos
│   ├── 01_schema.sql       # DDL - Estructura de tablas
│   ├── 02_data.sql         # DML - Datos de prueba
│   └── DIAGRAMA.md         # Diagrama de BD
│
├── collection/             # Colección de Postman
│   └── Genesis-Bancario.postman_collection.json
│
└── README.md              # Este archivo
```

## 🚀 Instalación y Configuración

### Prerrequisitos

- Node.js 16 o superior
- MySQL 8.0 o superior
- Angular CLI 17

### 1. Configurar la Base de Datos

```bash
# Conectar a MySQL
mysql -u root -p

# Ejecutar scripts de creación
source db/01_schema.sql
source db/02_data.sql
```

### 2. Configurar el Backend

```bash
cd backend

# Instalar dependencias
npm install

# Copiar archivo de configuración
cp .env.example .env

# Editar .env con tus credenciales de MySQL
nano .env

# Iniciar servidor
npm run dev
```

El servidor estará corriendo en `http://localhost:3000`

### 3. Configurar el Frontend

```bash
cd frontend

# Instalar dependencias
npm install

# Iniciar aplicación
npm start
```

La aplicación estará disponible en `http://localhost:4200`

## 👤 Usuarios de Prueba

| Email | Contraseña | Descripción |
|-------|-----------|-------------|
| maria.garcia@gmail.com | Genesis2024! | Usuario de prueba 1 |
| carlos.perez@gmail.com | Genesis2024! | Usuario de prueba 2 |
| ana.rodriguez@gmail.com | Genesis2024! | Usuario de prueba 3 |

## 📊 Base de Datos

### Tablas Principales

- `usuarios` - Información de clientes
- `cuentas` - Cuentas bancarias
- `tarjetas` - Tarjetas de débito/crédito
- `transacciones` - Registro de transacciones
- `prestamos` - Préstamos y créditos
- `beneficiarios` - Beneficiarios de transferencias
- `notificaciones` - Sistema de notificaciones

## 🔐 Seguridad

- ✅ Contraseñas encriptadas con bcrypt (salt rounds: 10)
- ✅ Autenticación mediante JWT
- ✅ Validación de datos en backend
- ✅ Protección contra SQL Injection
- ✅ CORS configurado
- ✅ Headers de seguridad con Helmet
- ✅ Auditoría de acciones

## 📱 Funcionalidades

### Dashboard
- Resumen de saldos totales
- Gráfica de movimientos mensuales
- Transacciones recientes
- Préstamos activos
- Accesos rápidos

### Transacciones
- Transferencias entre cuentas
- Pagos de servicios
- Pagos de préstamos
- Depósitos y retiros
- Historial completo con filtros

### Cuentas
- Listado de cuentas
- Detalle de cuenta
- Crear nueva cuenta
- Tipos de cuenta: Ahorro, Monetaria, Nómina, etc.

### Préstamos
- Solicitar préstamo
- Ver préstamos activos
- Calcular cuotas
- Realizar pagos
- Historial de pagos

## 🎨 Diseño

El sistema cuenta con:
- Diseño moderno y profesional
- Animaciones suaves y fluidas
- Efectos de blur y glassmorphism
- Gradientes dinámicos
- Responsive design para móviles y tablets
- Paleta de colores corporativa
- Iconografía SVG personalizada

## 📈 API Endpoints

### Autenticación
- `POST /api/auth/login` - Iniciar sesión
- `POST /api/auth/register` - Registrar usuario
- `GET /api/auth/verify` - Verificar token

### Cuentas
- `GET /api/cuentas` - Obtener cuentas del usuario
- `GET /api/cuentas/:id` - Detalle de cuenta
- `POST /api/cuentas` - Crear cuenta

### Transacciones
- `GET /api/transacciones` - Historial
- `POST /api/transacciones/transferir` - Nueva transferencia
- `POST /api/transacciones/pagar-servicio` - Pagar servicio

### Dashboard
- `GET /api/dashboard/estadisticas` - Estadísticas generales

