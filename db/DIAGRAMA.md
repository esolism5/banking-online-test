# DIAGRAMA DE BASE DE DATOS - FUNDACIÓN GENESIS EMPRESARIAL

## Estructura de Tablas y Relaciones

```
┌──────────────────────────────────────────────────────────────────────┐
│                    SISTEMA BANCARIO GENESIS                          │
│                  Diagrama Entidad-Relación (ERD)                     │
└──────────────────────────────────────────────────────────────────────┘

┌─────────────────────────┐
│      USUARIOS           │
├─────────────────────────┤
│ PK id_usuario           │
│    nombre_completo      │
│ UK dpi                  │
│ UK email                │
│    telefono             │
│    direccion            │
│    fecha_nacimiento     │
│    password_hash        │
│    estado               │
│    fecha_registro       │
└─────────────────────────┘
          │
          │ 1:N
          ├──────────────────────────────────┐
          │                                  │
          ▼                                  ▼
┌─────────────────────────┐      ┌─────────────────────────┐
│      CUENTAS            │      │      PRÉSTAMOS          │
├─────────────────────────┤      ├─────────────────────────┤
│ PK id_cuenta            │      │ PK id_prestamo          │
│ FK id_usuario           │◄─┐   │ FK id_usuario           │
│ FK id_tipo_cuenta       │  │   │ FK id_cuenta_desembolso │
│ UK numero_cuenta        │  │   │    monto_solicitado     │
│    saldo                │  │   │    monto_aprobado       │
│    moneda               │  │   │    tasa_interes         │
│    fecha_apertura       │  │   │    plazo_meses          │
│    estado               │  │   │    cuota_mensual        │
└─────────────────────────┘  │   │    saldo_pendiente      │
          │                  │   │    fecha_aprobacion     │
          │ 1:N              │   │    estado               │
          ▼                  │   │    proposito            │
┌─────────────────────────┐  │   └─────────────────────────┘
│      TARJETAS           │  │             │
├─────────────────────────┤  │             │ 1:N
│ PK id_tarjeta           │  │             ▼
│ FK id_cuenta            │──┘   ┌─────────────────────────┐
│ UK numero_tarjeta       │      │   PAGOS_PRESTAMO        │
│    tipo_tarjeta         │      ├─────────────────────────┤
│    nombre_titular       │      │ PK id_pago              │
│    fecha_expiracion     │      │ FK id_prestamo          │
│    cvv                  │      │ FK id_transaccion       │
│    limite_credito       │      │    numero_cuota         │
│    saldo_usado          │      │    monto_pagado         │
│    estado               │      │    monto_capital        │
└─────────────────────────┘      │    monto_interes        │
                                 │    saldo_restante       │
                                 │    fecha_pago           │
┌─────────────────────────┐      └─────────────────────────┘
│   TIPOS_CUENTA          │
├─────────────────────────┤
│ PK id_tipo_cuenta       │
│ UK nombre               │      ┌─────────────────────────┐
│    descripcion          │      │   BENEFICIARIOS         │
│    tasa_interes         │      ├─────────────────────────┤
│    comision_mant.       │      │ PK id_beneficiario      │
│    saldo_minimo         │      │ FK id_usuario           │
│    estado               │      │    nombre_beneficiario  │
└─────────────────────────┘      │    numero_cuenta_benef  │
                                 │    banco                │
                                 │    alias                │
┌─────────────────────────┐      │    email                │
│  TIPOS_TRANSACCION      │      │    telefono             │
├─────────────────────────┤      └─────────────────────────┘
│ PK id_tipo_transaccion  │
│ UK nombre               │
│    descripcion          │      ┌─────────────────────────┐
│    requiere_cuenta_dest │      │   NOTIFICACIONES        │
│    estado               │      ├─────────────────────────┤
└─────────────────────────┘      │ PK id_notificacion      │
          │                      │ FK id_usuario           │
          │                      │    titulo               │
          │ 1:N                  │    mensaje              │
          ▼                      │    tipo                 │
┌─────────────────────────┐      │    leida                │
│    TRANSACCIONES        │      │    fecha_creacion       │
├─────────────────────────┤      └─────────────────────────┘
│ PK id_transaccion       │
│ FK id_tipo_transaccion  │
│ FK id_cuenta_origen     │◄───────┐
│ FK id_cuenta_destino    │        │  (Autorreferencia)
│    monto                │        │
│    moneda               │        │
│    descripcion          │        │
│ UK referencia           │        │
│    saldo_anterior_orig  │        │
│    saldo_posterior_orig │        │
│    estado               │        │
│    fecha_transaccion    │        │
└─────────────────────────┘        │
                                   │
                                   │
┌─────────────────────────┐        │
│      AUDITORÍA          │        │
├─────────────────────────┤        │
│ PK id_auditoria         │        │
│ FK id_usuario           │────────┘
│    accion               │
│    tabla_afectada       │
│    id_registro          │
│    valores_anteriores   │  (JSON)
│    valores_nuevos       │  (JSON)
│    ip_address           │
│    user_agent           │
│    fecha_accion         │
└─────────────────────────┘


═══════════════════════════════════════════════════════════════════

RELACIONES PRINCIPALES:

1. USUARIOS → CUENTAS (1:N)
   - Un usuario puede tener múltiples cuentas

2. USUARIOS → PRÉSTAMOS (1:N)
   - Un usuario puede tener múltiples préstamos

3. CUENTAS → TARJETAS (1:N)
   - Una cuenta puede tener múltiples tarjetas

4. CUENTAS → TRANSACCIONES (1:N)
   - Una cuenta puede tener múltiples transacciones (origen/destino)

5. PRÉSTAMOS → PAGOS_PRESTAMO (1:N)
   - Un préstamo tiene múltiples pagos

6. TIPOS_CUENTA → CUENTAS (1:N)
   - Un tipo de cuenta puede tener múltiples cuentas

7. TIPOS_TRANSACCION → TRANSACCIONES (1:N)
   - Un tipo de transacción puede aplicarse a múltiples transacciones

8. USUARIOS → BENEFICIARIOS (1:N)
   - Un usuario puede tener múltiples beneficiarios registrados

9. USUARIOS → NOTIFICACIONES (1:N)
   - Un usuario puede tener múltiples notificaciones

10. TRANSACCIONES → PAGOS_PRESTAMO (1:1)
    - Cada pago de préstamo está asociado a una transacción

═══════════════════════════════════════════════════════════════════

ÍNDICES IMPORTANTES:

- idx_email (usuarios.email)
- idx_dpi (usuarios.dpi)
- idx_usuario (varias tablas)
- idx_numero_cuenta (cuentas.numero_cuenta)
- idx_estado (cuentas.estado)
- idx_numero_tarjeta (tarjetas.numero_tarjeta)
- idx_cuenta_origen (transacciones.id_cuenta_origen)
- idx_cuenta_destino (transacciones.id_cuenta_destino)
- idx_fecha (transacciones.fecha_transaccion)
- idx_referencia (transacciones.referencia)
- idx_usuario_leida (notificaciones)

═══════════════════════════════════════════════════════════════════

CARACTERÍSTICAS DE SEGURIDAD:

✓ Contraseñas encriptadas (bcrypt)
✓ Claves foráneas con ON DELETE CASCADE/SET NULL
✓ Campos UNIQUE para evitar duplicados
✓ Auditoría completa de acciones
✓ Estados para control de registros
✓ Timestamps automáticos
✓ Validación de datos mediante ENUM

═══════════════════════════════════════════════════════════════════
```
