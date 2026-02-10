# 📝 NOTAS TÉCNICAS DEL PROYECTO
## Sistema Bancario Genesis Empresarial

---

## 🏗️ ARQUITECTURA

### Frontend (Angular)
- **Versión:** Angular 17 (Standalone Components)
- **Patrón:** Component-based Architecture
- **Estado:** Services con RxJS
- **Routing:** Angular Router con lazy loading
- **HTTP:** HttpClient con interceptors

### Backend (Node.js)
- **Framework:** Express.js
- **Arquitectura:** MVC (Model-View-Controller)
- **Autenticación:** JWT (JSON Web Tokens)
- **Validación:** express-validator
- **Seguridad:** helmet, cors, bcryptjs

### Base de Datos (MySQL)
- **Motor:** InnoDB
- **Encoding:** UTF-8 (utf8mb4_unicode_ci)
- **Integridad:** Foreign Keys con CASCADE
- **Índices:** Optimizados para consultas frecuentes

---

## 🔐 SEGURIDAD IMPLEMENTADA

### Backend
1. **Contraseñas:**
   - Encriptación con bcrypt (salt rounds: 10)
   - Nunca se almacenan en texto plano
   - Hash irreversible

2. **JWT:**
   - Tokens con expiración de 24 horas
   - Secret key segura (cambiar en producción)
   - Validación en cada request protegido

3. **SQL Injection:**
   - Prepared statements en todas las queries
   - Uso de placeholders (?)
   - Pool de conexiones seguro

4. **Headers HTTP:**
   - helmet.js para headers de seguridad
   - CORS configurado específicamente
   - Rate limiting recomendado para producción

### Frontend
1. **Sanitización:**
   - Angular sanitiza automáticamente el HTML
   - Validación de formularios
   - Guards para rutas protegidas

---

## 📊 BASE DE DATOS

### Estructura de Tablas

**Usuarios y Cuentas:**
```
usuarios (1) ─────→ (N) cuentas
                     │
                     ├─→ (N) tarjetas
                     └─→ (N) transacciones
```

**Préstamos:**
```
usuarios (1) ─────→ (N) prestamos ─────→ (N) pagos_prestamo
```

**Características:**
- Timestamps automáticos (created_at, updated_at)
- Soft deletes con campo estado
- Auditoría completa en tabla auditoria
- Índices en columnas frecuentemente consultadas

---

## 🔄 FLUJO DE DATOS

### Login
```
1. Usuario ingresa email y password
2. Frontend envía POST /api/auth/login
3. Backend valida credenciales
4. Backend genera JWT
5. Frontend almacena token
6. Frontend incluye token en headers
```

### Transferencia
```
1. Usuario completa formulario
2. Frontend valida datos
3. POST /api/transacciones/transferir
4. Backend inicia transacción SQL
5. Actualiza saldo origen
6. Actualiza saldo destino
7. Registra en tabla transacciones
8. Commit o rollback
9. Responde al frontend
```

---

## 🎨 DISEÑO Y UX

### Principios Aplicados
1. **Atomic Design:**
   - Componentes reutilizables
   - Jerarquía clara
   - Separación de responsabilidades

2. **Responsive:**
   - Mobile-first approach
   - Breakpoints: 768px, 1024px, 1280px
   - Grid system flexible

3. **Accesibilidad:**
   - Contraste de colores adecuado
   - Labels en inputs
   - Navegación por teclado

### Paleta de Colores
```css
Primary: #667eea - #764ba2 (Gradient)
Success: #2ed573
Warning: #ffa502
Error: #ff4757
Text: #ffffff (on dark backgrounds)
```

---

## 📈 OPTIMIZACIONES

### Frontend
- Lazy loading de componentes
- OnPush change detection strategy
- Trackby en ngFor
- Unsubscribe de observables
- Imágenes optimizadas

### Backend
- Pool de conexiones MySQL (max: 10)
- Compresión de respuestas HTTP
- Caching de consultas frecuentes (recomendado)
- Queries optimizadas con JOINS

### Base de Datos
- Índices en columnas de búsqueda
- Foreign keys para integridad
- Normalización hasta 3NF
- Evitar N+1 queries

---

## 🧪 TESTING (Para Implementar)

### Recomendaciones de Testing

**Frontend:**
```bash
# Unit tests
npm test

# E2E tests
ng e2e
```

**Backend:**
```bash
# Unit tests con Jest
npm test

# Tests de integración
npm run test:integration
```

**Base de Datos:**
- Backup antes de cambios importantes
- Restore procedures documentados
- Seeds para datos de prueba

---

## 🚀 DEPLOYMENT

### Preparación para Producción

**Frontend:**
```bash
ng build --configuration production
# Output: dist/genesis-bancario
# Servir con Nginx o Apache
```

**Backend:**
```bash
# Usar PM2 para process management
npm install -g pm2
pm2 start server.js --name genesis-api
pm2 save
```

**Base de Datos:**
- Cambiar credenciales
- Habilitar SSL/TLS
- Configurar backups automáticos
- Monitoreo de performance

### Variables de Entorno Críticas
```env
NODE_ENV=production
JWT_SECRET=<generar_clave_segura_aleatoria>
DB_PASSWORD=<password_fuerte>
ALLOWED_ORIGINS=https://tu-dominio.com
```

---

## 📚 RECURSOS ADICIONALES

### Documentación
- Angular: https://angular.io/docs
- Express: https://expressjs.com/
- MySQL: https://dev.mysql.com/doc/

### Herramientas Útiles
- Postman: Testing de API
- MySQL Workbench: Admin de BD
- VS Code: Editor recomendado
- Git: Control de versiones

---

## 🔮 MEJORAS FUTURAS

### Features Sugeridos
1. **Notificaciones Push:** Usar Firebase Cloud Messaging
2. **Gráficas Avanzadas:** Integrar Chart.js más profundamente
3. **Exportar a PDF:** Reportes de transacciones
4. **Biometría:** Login con huella digital
5. **Chat de Soporte:** Sistema de tickets
6. **Multi-idioma:** Internacionalización (i18n)
7. **Dark Mode:** Tema oscuro

### Optimizaciones Técnicas
1. **Redis:** Cache de sesiones y queries
2. **WebSockets:** Actualizaciones en tiempo real
3. **Microservicios:** Separar módulos grandes
4. **GraphQL:** API más flexible
5. **Docker:** Containerización

---

## 📄 CONVENCIONES DE CÓDIGO

### Nombres de Variables
```typescript
// camelCase para variables y funciones
let saldoTotal = 0;
function calcularIntereses() {}

// PascalCase para clases y componentes
class Usuario {}
class DashboardComponent {}

// UPPERCASE para constantes
const MAX_INTENTOS_LOGIN = 5;
```

### Nombres de Archivos
```
dashboard.component.ts
dashboard.component.html
dashboard.component.css
auth.service.ts
usuario.model.ts
```

---

## 💡 TIPS DE DESARROLLO

1. **Comentar el código:** Especialmente lógica compleja
2. **Commits descriptivos:** "feat: agregar dashboard" no "update"
3. **Branch strategy:** main, develop, feature/nombre
4. **Code reviews:** Revisar código antes de merge
5. **Documentar cambios:** Actualizar README

---

**Última actualización:** Febrero 2025
**Desarrollado por:** Fundación Genesis Empresarial
