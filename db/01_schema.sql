-- =====================================================
-- FUNDACIÓN GENESIS EMPRESARIAL - SISTEMA BANCARIO
-- Esquema de Base de Datos (DDL)
-- =====================================================

-- Eliminar base de datos si existe y crear una nueva
DROP DATABASE IF EXISTS genesis_bancario;
CREATE DATABASE genesis_bancario CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE genesis_bancario;

-- =====================================================
-- TABLA: usuarios
-- Almacena información de los clientes del banco
-- =====================================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    dpi VARCHAR(20) UNIQUE NOT NULL COMMENT 'Documento Personal de Identificación',
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    direccion TEXT,
    fecha_nacimiento DATE,
    password_hash VARCHAR(255) NOT NULL COMMENT 'Contraseña encriptada',
    estado ENUM('activo', 'inactivo', 'bloqueado') DEFAULT 'activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_dpi (dpi)
) ENGINE=InnoDB COMMENT='Tabla de usuarios/clientes del banco';

-- =====================================================
-- TABLA: tipos_cuenta
-- Catálogo de tipos de cuenta bancaria
-- =====================================================
CREATE TABLE tipos_cuenta (
    id_tipo_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE COMMENT 'Ej: Ahorro, Monetaria, Plazo Fijo',
    descripcion TEXT,
    tasa_interes DECIMAL(5,2) DEFAULT 0.00 COMMENT 'Tasa de interés anual (%)',
    comision_mantenimiento DECIMAL(10,2) DEFAULT 0.00 COMMENT 'Comisión mensual en Quetzales',
    saldo_minimo DECIMAL(15,2) DEFAULT 0.00 COMMENT 'Saldo mínimo requerido',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo'
) ENGINE=InnoDB COMMENT='Catálogo de tipos de cuentas bancarias';

-- =====================================================
-- TABLA: cuentas
-- Cuentas bancarias de los usuarios
-- =====================================================
CREATE TABLE cuentas (
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_tipo_cuenta INT NOT NULL,
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL COMMENT 'Número de cuenta único generado',
    saldo DECIMAL(15,2) DEFAULT 0.00 COMMENT 'Saldo actual en Quetzales',
    moneda VARCHAR(3) DEFAULT 'GTQ' COMMENT 'GTQ = Quetzales, USD = Dólares',
    fecha_apertura DATE NOT NULL,
    estado ENUM('activa', 'bloqueada', 'cerrada') DEFAULT 'activa',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_cuenta) REFERENCES tipos_cuenta(id_tipo_cuenta),
    INDEX idx_usuario (id_usuario),
    INDEX idx_numero_cuenta (numero_cuenta),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Cuentas bancarias de los usuarios';

-- =====================================================
-- TABLA: tarjetas
-- Tarjetas de débito/crédito asociadas a cuentas
-- =====================================================
CREATE TABLE tarjetas (
    id_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    numero_tarjeta VARCHAR(16) UNIQUE NOT NULL COMMENT 'Número de tarjeta (encriptado en producción)',
    tipo_tarjeta ENUM('debito', 'credito') NOT NULL,
    nombre_titular VARCHAR(100) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    cvv VARCHAR(4) NOT NULL COMMENT 'CVV (encriptado en producción)',
    limite_credito DECIMAL(15,2) DEFAULT NULL COMMENT 'Solo para tarjetas de crédito',
    saldo_usado DECIMAL(15,2) DEFAULT 0.00 COMMENT 'Saldo usado en crédito',
    estado ENUM('activa', 'bloqueada', 'expirada') DEFAULT 'activa',
    fecha_emision DATE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta) ON DELETE CASCADE,
    INDEX idx_numero_tarjeta (numero_tarjeta),
    INDEX idx_cuenta (id_cuenta)
) ENGINE=InnoDB COMMENT='Tarjetas de débito y crédito';

-- =====================================================
-- TABLA: tipos_transaccion
-- Catálogo de tipos de transacciones
-- =====================================================
CREATE TABLE tipos_transaccion (
    id_tipo_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE COMMENT 'Ej: Transferencia, Depósito, Retiro, Pago',
    descripcion TEXT,
    requiere_cuenta_destino BOOLEAN DEFAULT FALSE COMMENT 'TRUE si requiere cuenta destino',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo'
) ENGINE=InnoDB COMMENT='Catálogo de tipos de transacciones';

-- =====================================================
-- TABLA: transacciones
-- Registro de todas las transacciones bancarias
-- =====================================================
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_transaccion INT NOT NULL,
    id_cuenta_origen INT NOT NULL COMMENT 'Cuenta que realiza la transacción',
    id_cuenta_destino INT NULL COMMENT 'Cuenta destino (para transferencias)',
    monto DECIMAL(15,2) NOT NULL COMMENT 'Monto en Quetzales',
    moneda VARCHAR(3) DEFAULT 'GTQ',
    descripcion TEXT COMMENT 'Concepto o descripción de la transacción',
    referencia VARCHAR(50) UNIQUE COMMENT 'Número de referencia único',
    saldo_anterior_origen DECIMAL(15,2) COMMENT 'Saldo antes de la transacción',
    saldo_posterior_origen DECIMAL(15,2) COMMENT 'Saldo después de la transacción',
    estado ENUM('completada', 'pendiente', 'rechazada', 'cancelada') DEFAULT 'completada',
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tipo_transaccion) REFERENCES tipos_transaccion(id_tipo_transaccion),
    FOREIGN KEY (id_cuenta_origen) REFERENCES cuentas(id_cuenta),
    FOREIGN KEY (id_cuenta_destino) REFERENCES cuentas(id_cuenta),
    INDEX idx_cuenta_origen (id_cuenta_origen),
    INDEX idx_cuenta_destino (id_cuenta_destino),
    INDEX idx_fecha (fecha_transaccion),
    INDEX idx_referencia (referencia)
) ENGINE=InnoDB COMMENT='Registro de transacciones bancarias';

-- =====================================================
-- TABLA: prestamos
-- Préstamos/créditos otorgados a usuarios
-- =====================================================
CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_cuenta_desembolso INT NOT NULL COMMENT 'Cuenta donde se deposita el préstamo',
    monto_solicitado DECIMAL(15,2) NOT NULL COMMENT 'Monto del préstamo en Quetzales',
    monto_aprobado DECIMAL(15,2) NOT NULL,
    tasa_interes DECIMAL(5,2) NOT NULL COMMENT 'Tasa de interés anual (%)',
    plazo_meses INT NOT NULL COMMENT 'Plazo en meses',
    cuota_mensual DECIMAL(15,2) NOT NULL COMMENT 'Cuota mensual calculada',
    saldo_pendiente DECIMAL(15,2) NOT NULL COMMENT 'Saldo pendiente por pagar',
    fecha_aprobacion DATE,
    fecha_desembolso DATE,
    fecha_primer_pago DATE,
    estado ENUM('solicitado', 'aprobado', 'desembolsado', 'en_pago', 'pagado', 'rechazado', 'vencido') DEFAULT 'solicitado',
    proposito TEXT COMMENT 'Propósito del préstamo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_cuenta_desembolso) REFERENCES cuentas(id_cuenta),
    INDEX idx_usuario (id_usuario),
    INDEX idx_estado (estado)
) ENGINE=InnoDB COMMENT='Préstamos y créditos';

-- =====================================================
-- TABLA: pagos_prestamo
-- Registro de pagos realizados a préstamos
-- =====================================================
CREATE TABLE pagos_prestamo (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_prestamo INT NOT NULL,
    id_transaccion INT NOT NULL COMMENT 'Transacción asociada al pago',
    numero_cuota INT NOT NULL COMMENT 'Número de cuota pagada',
    monto_pagado DECIMAL(15,2) NOT NULL COMMENT 'Monto del pago',
    monto_capital DECIMAL(15,2) NOT NULL COMMENT 'Monto aplicado a capital',
    monto_interes DECIMAL(15,2) NOT NULL COMMENT 'Monto aplicado a intereses',
    saldo_restante DECIMAL(15,2) NOT NULL COMMENT 'Saldo pendiente después del pago',
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATE COMMENT 'Fecha de vencimiento de la cuota',
    estado ENUM('puntual', 'atrasado', 'adelantado') DEFAULT 'puntual',
    FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo) ON DELETE CASCADE,
    FOREIGN KEY (id_transaccion) REFERENCES transacciones(id_transaccion),
    INDEX idx_prestamo (id_prestamo),
    INDEX idx_fecha_pago (fecha_pago)
) ENGINE=InnoDB COMMENT='Registro de pagos de préstamos';

-- =====================================================
-- TABLA: beneficiarios
-- Beneficiarios para transferencias frecuentes
-- =====================================================
CREATE TABLE beneficiarios (
    id_beneficiario INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL COMMENT 'Usuario que registra el beneficiario',
    nombre_beneficiario VARCHAR(150) NOT NULL,
    numero_cuenta_beneficiario VARCHAR(20) NOT NULL,
    banco VARCHAR(100) COMMENT 'Nombre del banco (puede ser el mismo)',
    alias VARCHAR(50) COMMENT 'Alias amigable para el beneficiario',
    email VARCHAR(100),
    telefono VARCHAR(15),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario (id_usuario)
) ENGINE=InnoDB COMMENT='Beneficiarios para transferencias';

-- =====================================================
-- TABLA: notificaciones
-- Sistema de notificaciones para usuarios
-- =====================================================
CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo ENUM('info', 'alerta', 'exito', 'error', 'transaccion') DEFAULT 'info',
    leida BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario_leida (id_usuario, leida),
    INDEX idx_fecha (fecha_creacion)
) ENGINE=InnoDB COMMENT='Notificaciones de usuarios';

-- =====================================================
-- TABLA: auditoria
-- Registro de auditoría de acciones importantes
-- =====================================================
CREATE TABLE auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    accion VARCHAR(100) NOT NULL COMMENT 'Tipo de acción realizada',
    tabla_afectada VARCHAR(50) COMMENT 'Tabla de la BD afectada',
    id_registro INT COMMENT 'ID del registro afectado',
    valores_anteriores JSON COMMENT 'Valores antes del cambio',
    valores_nuevos JSON COMMENT 'Valores después del cambio',
    ip_address VARCHAR(45) COMMENT 'Dirección IP del usuario',
    user_agent TEXT COMMENT 'Navegador/dispositivo',
    fecha_accion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL,
    INDEX idx_usuario (id_usuario),
    INDEX idx_fecha (fecha_accion),
    INDEX idx_tabla (tabla_afectada)
) ENGINE=InnoDB COMMENT='Registro de auditoría del sistema';
