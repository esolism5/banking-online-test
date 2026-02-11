# 🏦 SISTEMA BANCARIO EN LÍNEA
## Fundación Genesis Empresarial

---

## 📌 RESUMEN EJECUTIVO

Sistema web completo de banca en línea desarrollado con tecnologías modernas y mejores prácticas de la industria. Permite a los usuarios gestionar sus finanzas personales, realizar transacciones, solicitar préstamos y visualizar estadísticas en tiempo real.

### Tecnologías Principales
- **Frontend:** Angular 17 con TypeScript
- **Backend:** Node.js + Express
- **Base de Datos:** MySQL
- **Autenticación:** JWT (JSON Web Tokens)
- **Seguridad:** Bcrypt, Helmet, CORS

---

## ✨ CARACTERÍSTICAS DESTACADAS

### 🎯 Dashboard Interactivo
- Visualización de saldo total en todas las cuentas
- Gráficas de movimientos mensuales
- Transacciones recientes con filtros
- Préstamos activos con estado de pagos
- Accesos rápidos a funciones principales

### 💳 Gestión de Cuentas
- Múltiples tipos de cuenta (Ahorro, Monetaria, Nómina, Premium)
- Apertura de nuevas cuentas
- Visualización de detalle completo
- Historial de movimientos por cuenta
- Tasas de interés diferenciadas

### 💸 Transacciones
- **Transferencias Internas:** Entre cuentas del mismo banco
- **Transferencias Externas:** A otros bancos
- **Depósitos:** En efectivo o cheque
- **Retiros:** En cajeros automáticos
- **Pagos de Servicios:** Luz, agua, teléfono, internet
- **Pagos de Préstamos:** Abonos y cuotas mensuales

### 🏦 Tarjetas Bancarias
- Tarjetas de débito vinculadas a cuentas
- Tarjetas de crédito con límite configurable
- Visualización de CVV y datos (en ambiente seguro)
- Bloqueo y desbloqueo de tarjetas
- Historial de compras

### 💰 Préstamos y Créditos
- Solicitud de préstamos en línea
- Calculadora de cuotas
- Diferentes tasas según tipo de préstamo
- Pagos automáticos programables
- Historial de pagos detallado
- Estado de cada préstamo

### 📊 Reportes y Estadísticas
- Gráficas de ingresos vs egresos
- Estadísticas mensuales y anuales
- Categorización de gastos
- Exportación de reportes (próximamente)

### 🔔 Notificaciones
- Alertas de transacciones
- Recordatorios de pagos
- Notificaciones de vencimientos
- Alertas de seguridad

---

## 🎨 DISEÑO Y EXPERIENCIA DE USUARIO

### Principios de Diseño
- **Moderno y Limpio:** Interfaz minimalista y profesional
- **Intuitivo:** Navegación clara y sencilla
- **Responsive:** Funciona en desktop, tablet y móvil
- **Accesible:** Colores con buen contraste
- **Animado:** Transiciones suaves y agradables

### Paleta de Colores
```
Primario:   Gradiente azul-púrpura (#667eea - #764ba2)
Éxito:      Verde brillante (#2ed573)
Advertencia: Naranja (#ffa502)
Error:      Rojo (#ff4757)
Fondo:      Oscuro con glassmorphism
```

### Animaciones
- Fade in al cargar componentes
- Slide up para tarjetas
- Hover effects en botones
- Loading spinners elegantes
- Transiciones de página fluidas

---

## 🔐 SEGURIDAD

### Medidas Implementadas

**Autenticación:**
- Login con email y contraseña
- Contraseñas encriptadas con bcrypt (salt: 10 rounds)
- Tokens JWT con expiración de 24 horas
- Refresh tokens (para implementar)

**Protección de Datos:**
- SQL injection prevención con prepared statements
- XSS protection
- CORS configurado específicamente
- Headers de seguridad con Helmet
- Validación de datos en backend y frontend

**Auditoría:**
- Tabla de auditoría para todas las acciones críticas
- Registro de IPs y user agents
- Timestamps en todas las transacciones
- Historial completo de cambios

**Moneda:**
- Todas las transacciones en Quetzales (GTQ)
- Formato numérico guatemalteco
- Precisión decimal de 2 dígitos

---

## 📁 ESTRUCTURA DEL PROYECTO

```
fundacion-genesis-bancario/
│
├── 📂 frontend/               → Aplicación Angular
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/    → Componentes de UI
│   │   │   ├── services/      → Servicios de API
│   │   │   ├── guards/        → Guards de rutas
│   │   │   └── models/        → Interfaces TypeScript
│   │   ├── assets/            → Imágenes, fuentes
│   │   └── environments/      → Configuraciones
│   └── package.json
│
├── 📂 backend/                → API REST Node.js
│   ├── config/                → Configuraciones
│   ├── controllers/           → Lógica de negocio
│   ├── routes/                → Rutas de la API
│   ├── middlewares/           → Auth, validación
│   ├── models/                → Modelos de datos
│   ├── utils/                 → Utilidades
│   ├── server.js              → Servidor principal
│   └── package.json
│
├── 📂 db/                     → Base de Datos
│   ├── 01_schema.sql          → DDL - Tablas
│   ├── 02_data.sql            → DML - Datos de prueba
│   └── DIAGRAMA.md            → Diagrama ERD
│
├── 📂 collection/             → Postman
│   └── Genesis-Bancario.postman_collection.json
│
├── 📄 README.md               → Documentación principal
├── 📄 INSTALACION.md          → Guía de instalación
└── 📄 NOTAS_TECNICAS.md       → Notas técnicas
```

---

## 💾 BASE DE DATOS

### Tablas Principales (13 tablas)

1. **usuarios** - Información de clientes
2. **tipos_cuenta** - Catálogo de tipos de cuenta
3. **cuentas** - Cuentas bancarias
4. **tarjetas** - Tarjetas de débito/crédito
5. **tipos_transaccion** - Catálogo de transacciones
6. **transacciones** - Registro de movimientos
7. **prestamos** - Préstamos otorgados
8. **pagos_prestamo** - Historial de pagos
9. **beneficiarios** - Beneficiarios frecuentes
10. **notificaciones** - Sistema de alertas
11. **auditoria** - Log de acciones

### Datos de Prueba Incluidos
- 8 usuarios de prueba
- 16 cuentas bancarias
- 16 tarjetas (débito y crédito)
- 5 préstamos activos
- 50+ transacciones históricas
- 10 notificaciones
- 5 beneficiarios

---

## 🚀 INSTALACIÓN RÁPIDA

### Requisitos
- Node.js 16+
- MySQL 8.0+
- Angular CLI

### Pasos Básicos

1. **Base de Datos:**
```bash
mysql -u root -p < db/01_schema.sql
mysql -u root -p < db/02_data.sql
```

2. **Backend:**
```bash
cd backend
npm install
cp .env.example .env
# Editar .env con tus credenciales
npm run dev
```

3. **Frontend:**
```bash
cd frontend
npm install
npm start
```

4. **Acceder:**
- Frontend: http://localhost:4200
- Backend: http://localhost:3000

### Usuarios de Prueba
- maria.garcia@gmail.com / Genesis2024!
- carlos.perez@gmail.com / Genesis2024!
- ana.rodriguez@gmail.com / Genesis2024!

---

## 📊 ESTADÍSTICAS DEL PROYECTO

### Líneas de Código (aproximado)
- Frontend: ~3,500 líneas (TS + HTML + CSS)
- Backend: ~2,000 líneas (JavaScript)
- Base de Datos: ~800 líneas (SQL)
- **Total: ~6,300 líneas**

### Archivos Creados
- Componentes Angular: 8+
- Servicios: 6+
- Controllers: 8+
- Rutas API: 9+
- Tablas BD: 13

### Tiempo de Desarrollo
- Diseño de BD: 3 horas
- Backend API: 5 horas
- Frontend UI/UX: 8 horas
- Testing: 2 horas
- Documentación: 2 horas
- **Total: ~20 horas**

---

## 🎓 CONCEPTOS APLICADOS

### Arquitectura
- ✅ MVC (Model-View-Controller)
- ✅ RESTful API
- ✅ Component-based Architecture
- ✅ Separation of Concerns
- ✅ DRY (Don't Repeat Yourself)

### Patrones de Diseño
- ✅ Singleton (Database connection)
- ✅ Factory (Token generation)
- ✅ Observer (RxJS Observables)
- ✅ Dependency Injection (Angular)
- ✅ Middleware Pattern (Express)

### Buenas Prácticas
- ✅ Código comentado
- ✅ Nombres descriptivos
- ✅ Manejo de errores
- ✅ Validación de datos
- ✅ Control de versiones (Git)
- ✅ Documentación completa

---

## 🌟 CARACTERÍSTICAS TÉCNICAS DESTACADAS

### Frontend Angular
- Standalone Components (Angular 17)
- Lazy Loading
- Route Guards
- HTTP Interceptors
- Reactive Forms
- RxJS Observables
- TypeScript strict mode

### Backend Node.js
- Express.js framework
- JWT authentication
- Bcrypt encryption
- MySQL connection pooling
- Error handling middleware
- Request validation
- Compression
- Security headers (Helmet)

### Base de Datos MySQL
- Foreign Keys con CASCADE
- Índices optimizados
- Triggers (próximamente)
- Stored Procedures (próximamente)
- Normalización 3NF
- Timestamps automáticos

---

## 📈 POSIBLES MEJORAS FUTURAS

### Funcionalidades
1. Sistema de inversiones
2. Conversión de divisas
3. Pagos con QR
4. Biometría para login
5. Chatbot de soporte
6. Notificaciones push
7. Exportar a PDF/Excel
8. App móvil nativa
9. Dark mode
10. Multi-idioma

### Técnicas
1. Redis para caching
2. WebSockets para real-time
3. Docker containerization
4. CI/CD pipeline
5. Unit & E2E tests
6. Microservicios
7. GraphQL API
8. Server-side rendering

Gracias por ver mi proyecto
