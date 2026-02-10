-- =====================================================
-- FUNDACIÓN GENESIS EMPRESARIAL - SISTEMA BANCARIO
-- Datos de Prueba (DML)
-- =====================================================

USE genesis_bancario;

-- =====================================================
-- INSERTAR TIPOS DE CUENTA
-- =====================================================
INSERT INTO tipos_cuenta (nombre, descripcion, tasa_interes, comision_mantenimiento, saldo_minimo) VALUES
('Cuenta de Ahorro', 'Cuenta básica de ahorro con intereses mensuales', 3.50, 15.00, 500.00),
('Cuenta Monetaria', 'Cuenta para movimientos diarios sin límite de transacciones', 1.25, 25.00, 1000.00),
('Cuenta Nómina', 'Cuenta especial para recepción de salarios', 2.00, 0.00, 0.00),
('Cuenta Juvenil', 'Cuenta de ahorro para menores de 25 años', 4.00, 0.00, 100.00),
('Cuenta Premium', 'Cuenta con beneficios exclusivos y tasas preferenciales', 5.00, 50.00, 10000.00);

-- =====================================================
-- INSERTAR TIPOS DE TRANSACCIÓN
-- =====================================================
INSERT INTO tipos_transaccion (nombre, descripcion, requiere_cuenta_destino) VALUES
('Transferencia Interna', 'Transferencia entre cuentas del mismo banco', TRUE),
('Transferencia Externa', 'Transferencia a otros bancos', TRUE),
('Depósito', 'Depósito en efectivo o cheque', FALSE),
('Retiro', 'Retiro en efectivo de cajero o ventanilla', FALSE),
('Pago de Servicios', 'Pago de luz, agua, teléfono, etc.', FALSE),
('Pago de Préstamo', 'Abono o pago de cuota de préstamo', FALSE),
('Pago de Tarjeta', 'Pago de tarjeta de crédito', FALSE),
('Compra con Tarjeta', 'Compra realizada con tarjeta de débito/crédito', FALSE),
('Comisión Bancaria', 'Cobro de comisiones del banco', FALSE),
('Intereses Ganados', 'Intereses acreditados por ahorro', FALSE);

-- =====================================================
-- INSERTAR USUARIOS DE PRUEBA
-- Password para todos: Genesis2024! (hash bcrypt)
-- =====================================================
INSERT INTO usuarios (nombre_completo, dpi, email, telefono, direccion, fecha_nacimiento, password_hash, estado) VALUES
('María Elena García López', '2547896541234', 'maria.garcia@gmail.com', '55123456', 'Zona 10, Ciudad de Guatemala', '1990-05-15', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('Carlos Alberto Pérez Morales', '2987654321098', 'carlos.perez@gmail.com', '44567890', 'Zona 14, Guatemala', '1985-08-22', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('Ana Lucía Rodríguez Méndez', '3124567890123', 'ana.rodriguez@gmail.com', '33456789', 'Mixco, Guatemala', '1992-11-30', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('José Roberto Hernández Castro', '2765432109876', 'jose.hernandez@gmail.com', '22345678', 'Villa Nueva, Guatemala', '1988-03-12', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('Sofía Isabel Flores Ramírez', '3456789012345', 'sofia.flores@gmail.com', '11234567', 'Zona 15, Guatemala', '1995-07-18', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('Luis Fernando Ortiz Vásquez', '2654321098765', 'luis.ortiz@gmail.com', '99887766', 'Antigua Guatemala', '1987-12-05', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('Patricia del Carmen Gómez Díaz', '3789012345678', 'patricia.gomez@gmail.com', '88776655', 'Zona 11, Guatemala', '1993-09-25', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo'),
('Diego Alejandro Ruiz Santos', '2876543210987', 'diego.ruiz@gmail.com', '77665544', 'Escuintla, Guatemala', '1991-04-08', '$2a$10$rZ8YvL4xKjH9nB3fQ2wL1OeM7xJ5kP8qN6tR9sV4wX2yZ1aC3bD4e', 'activo');

-- =====================================================
-- INSERTAR CUENTAS BANCARIAS
-- =====================================================
INSERT INTO cuentas (id_usuario, id_tipo_cuenta, numero_cuenta, saldo, moneda, fecha_apertura, estado) VALUES
-- Cuentas de María Elena García
(1, 1, '1001234567890001', 15750.50, 'GTQ', '2023-01-15', 'activa'),
(1, 2, '1001234567890002', 8200.00, 'GTQ', '2023-02-20', 'activa'),

-- Cuentas de Carlos Alberto Pérez
(2, 3, '1002345678900001', 22500.75, 'GTQ', '2022-06-10', 'activa'),
(2, 1, '1002345678900002', 45300.00, 'GTQ', '2022-07-15', 'activa'),

-- Cuentas de Ana Lucía Rodríguez
(3, 1, '1003456789010001', 9850.25, 'GTQ', '2023-03-05', 'activa'),
(3, 5, '1003456789010002', 125000.00, 'GTQ', '2023-04-12', 'activa'),

-- Cuentas de José Roberto Hernández
(4, 2, '1004567890120001', 6750.00, 'GTQ', '2022-09-22', 'activa'),
(4, 1, '1004567890120002', 18400.50, 'GTQ', '2022-10-08', 'activa'),

-- Cuentas de Sofía Isabel Flores
(5, 4, '1005678901230001', 3250.00, 'GTQ', '2023-05-18', 'activa'),
(5, 1, '1005678901230002', 12800.75, 'GTQ', '2023-06-25', 'activa'),

-- Cuentas de Luis Fernando Ortiz
(6, 1, '1006789012340001', 28900.00, 'GTQ', '2022-11-30', 'activa'),
(6, 2, '1006789012340002', 15600.50, 'GTQ', '2022-12-15', 'activa'),

-- Cuentas de Patricia del Carmen Gómez
(7, 3, '1007890123450001', 19200.00, 'GTQ', '2023-07-08', 'activa'),
(7, 1, '1007890123450002', 34500.25, 'GTQ', '2023-08-14', 'activa'),

-- Cuentas de Diego Alejandro Ruiz
(8, 1, '1008901234560001', 11450.00, 'GTQ', '2023-09-20', 'activa'),
(8, 2, '1008901234560002', 7800.75, 'GTQ', '2023-10-05', 'activa');

-- =====================================================
-- INSERTAR TARJETAS
-- =====================================================
INSERT INTO tarjetas (id_cuenta, numero_tarjeta, tipo_tarjeta, nombre_titular, fecha_expiracion, cvv, limite_credito, saldo_usado, estado, fecha_emision) VALUES
-- Tarjetas de débito
(1, '4532123456789001', 'debito', 'MARIA GARCIA', '2027-01-31', '123', NULL, 0.00, 'activa', '2023-01-15'),
(3, '4532234567890001', 'debito', 'CARLOS PEREZ', '2026-06-30', '456', NULL, 0.00, 'activa', '2022-06-10'),
(5, '4532345678900001', 'debito', 'ANA RODRIGUEZ', '2027-03-31', '789', NULL, 0.00, 'activa', '2023-03-05'),
(7, '4532456789010001', 'debito', 'JOSE HERNANDEZ', '2026-09-30', '234', NULL, 0.00, 'activa', '2022-09-22'),
(9, '4532567890120001', 'debito', 'SOFIA FLORES', '2027-05-31', '567', NULL, 0.00, 'activa', '2023-05-18'),
(11, '4532678901230001', 'debito', 'LUIS ORTIZ', '2026-11-30', '890', NULL, 0.00, 'activa', '2022-11-30'),
(13, '4532789012340001', 'debito', 'PATRICIA GOMEZ', '2027-07-31', '345', NULL, 0.00, 'activa', '2023-07-08'),
(15, '4532890123450001', 'debito', 'DIEGO RUIZ', '2027-09-30', '678', NULL, 0.00, 'activa', '2023-09-20'),

-- Tarjetas de crédito
(2, '5412123456789001', 'credito', 'MARIA GARCIA', '2027-01-31', '321', 25000.00, 5200.00, 'activa', '2023-02-20'),
(4, '5412234567890001', 'credito', 'CARLOS PEREZ', '2026-07-31', '654', 50000.00, 12500.00, 'activa', '2022-07-15'),
(6, '5412345678900001', 'credito', 'ANA RODRIGUEZ', '2027-04-30', '987', 75000.00, 18000.00, 'activa', '2023-04-12'),
(8, '5412456789010001', 'credito', 'JOSE HERNANDEZ', '2026-10-31', '432', 30000.00, 8400.00, 'activa', '2022-10-08'),
(10, '5412567890120001', 'credito', 'SOFIA FLORES', '2027-06-30', '765', 20000.00, 3250.00, 'activa', '2023-06-25'),
(12, '5412678901230001', 'credito', 'LUIS ORTIZ', '2026-12-31', '098', 40000.00, 9800.00, 'activa', '2022-12-15');

-- =====================================================
-- INSERTAR PRÉSTAMOS
-- =====================================================
INSERT INTO prestamos (id_usuario, id_cuenta_desembolso, monto_solicitado, monto_aprobado, tasa_interes, plazo_meses, cuota_mensual, saldo_pendiente, fecha_aprobacion, fecha_desembolso, fecha_primer_pago, estado, proposito) VALUES
(1, 1, 50000.00, 50000.00, 12.50, 24, 2365.72, 42500.00, '2023-03-01', '2023-03-05', '2023-04-05', 'en_pago', 'Remodelación de vivienda'),
(2, 3, 100000.00, 100000.00, 11.00, 36, 3273.74, 85000.00, '2022-08-15', '2022-08-20', '2022-09-20', 'en_pago', 'Compra de vehículo'),
(3, 5, 200000.00, 180000.00, 10.50, 60, 3852.93, 165000.00, '2023-05-10', '2023-05-15', '2023-06-15', 'en_pago', 'Inversión en negocio'),
(4, 7, 75000.00, 75000.00, 13.00, 48, 1998.54, 68000.00, '2022-11-01', '2022-11-05', '2022-12-05', 'en_pago', 'Estudios universitarios'),
(6, 11, 30000.00, 30000.00, 14.00, 12, 2698.78, 15000.00, '2023-02-20', '2023-02-25', '2023-03-25', 'en_pago', 'Equipo de trabajo');

-- =====================================================
-- INSERTAR TRANSACCIONES (Últimos 3 meses)
-- =====================================================

-- Depósitos iniciales (cuando se abrieron las cuentas)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(3, 1, NULL, 10000.00, 'Depósito inicial apertura de cuenta', 'DEP-2023-001-0001', 0.00, 10000.00, 'completada', '2023-01-15 09:30:00'),
(3, 3, NULL, 20000.00, 'Depósito inicial apertura de cuenta', 'DEP-2022-001-0002', 0.00, 20000.00, 'completada', '2022-06-10 10:15:00'),
(3, 5, NULL, 8000.00, 'Depósito inicial apertura de cuenta', 'DEP-2023-001-0003', 0.00, 8000.00, 'completada', '2023-03-05 11:00:00');

-- Transferencias entre cuentas (Noviembre 2024)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(1, 1, 3, 1500.00, 'Transferencia por pago de servicios profesionales', 'TRF-2024-11-0001', 10000.00, 8500.00, 'completada', '2024-11-05 14:25:00'),
(1, 4, 1, 2000.00, 'Transferencia - Préstamo personal', 'TRF-2024-11-0002', 45000.00, 43000.00, 'completada', '2024-11-08 09:15:00'),
(1, 6, 5, 5000.00, 'Transferencia - Inversión conjunta', 'TRF-2024-11-0003', 125000.00, 120000.00, 'completada', '2024-11-12 16:40:00'),
(1, 3, 7, 3200.00, 'Transferencia - Pago de servicios', 'TRF-2024-11-0004', 21500.00, 18300.00, 'completada', '2024-11-15 11:20:00');

-- Retiros en efectivo (Noviembre 2024)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(4, 1, NULL, 500.00, 'Retiro cajero automático - ATM Zona 10', 'RET-2024-11-0001', 8500.00, 8000.00, 'completada', '2024-11-10 18:30:00'),
(4, 3, NULL, 1000.00, 'Retiro cajero automático - ATM Oakland Mall', 'RET-2024-11-0002', 18300.00, 17300.00, 'completada', '2024-11-14 20:15:00'),
(4, 5, NULL, 750.00, 'Retiro cajero automático - ATM Pradera', 'RET-2024-11-0003', 13850.00, 13100.00, 'completada', '2024-11-18 19:45:00');

-- Depósitos (Diciembre 2024)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(3, 1, NULL, 5000.00, 'Depósito en efectivo - Agencia Zona 10', 'DEP-2024-12-0001', 8000.00, 13000.00, 'completada', '2024-12-02 10:30:00'),
(3, 3, NULL, 7500.00, 'Depósito salario mensual', 'DEP-2024-12-0002', 17300.00, 24800.00, 'completada', '2024-12-05 08:00:00'),
(3, 5, NULL, 3500.00, 'Depósito transferencia externa', 'DEP-2024-12-0003', 13100.00, 16600.00, 'completada', '2024-12-08 14:20:00');

-- Transferencias (Diciembre 2024)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(1, 3, 5, 2000.00, 'Transferencia - Regalo navideño', 'TRF-2024-12-0005', 24800.00, 22800.00, 'completada', '2024-12-10 15:30:00'),
(1, 1, 7, 1800.00, 'Transferencia - Pago de servicios', 'TRF-2024-12-0006', 13000.00, 11200.00, 'completada', '2024-12-12 09:45:00'),
(1, 4, 8, 2500.00, 'Transferencia - Ayuda familiar', 'TRF-2024-12-0007', 43000.00, 40500.00, 'completada', '2024-12-15 11:10:00');

-- Pagos de servicios (Diciembre 2024)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(5, 1, NULL, 450.00, 'Pago de energía eléctrica - EEGSA', 'PAG-2024-12-0001', 11200.00, 10750.00, 'completada', '2024-12-18 16:25:00'),
(5, 3, NULL, 320.00, 'Pago de agua potable - EMPAGUA', 'PAG-2024-12-0002', 22800.00, 22480.00, 'completada', '2024-12-19 10:15:00'),
(5, 5, NULL, 580.00, 'Pago de internet - Claro', 'PAG-2024-12-0003', 18600.00, 18020.00, 'completada', '2024-12-20 14:50:00'),
(5, 7, NULL, 250.00, 'Pago de teléfono - Tigo', 'PAG-2024-12-0004', 22200.00, 21950.00, 'completada', '2024-12-21 12:30:00');

-- Compras con tarjeta (Diciembre 2024)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
(8, 2, NULL, 1250.00, 'Compra - Walmart Zona 10', 'COM-2024-12-0001', 8200.00, 6950.00, 'completada', '2024-12-22 18:40:00'),
(8, 4, NULL, 890.00, 'Compra - Farmacia Cruz Verde', 'COM-2024-12-0002', 40500.00, 39610.00, 'completada', '2024-12-23 15:20:00'),
(8, 6, NULL, 3200.00, 'Compra - Elektra Zona 12', 'COM-2024-12-0003', 120000.00, 116800.00, 'completada', '2024-12-24 11:35:00');

-- Transacciones de Enero 2025 (mes actual)
INSERT INTO transacciones (id_tipo_transaccion, id_cuenta_origen, id_cuenta_destino, monto, descripcion, referencia, saldo_anterior_origen, saldo_posterior_origen, estado, fecha_transaccion) VALUES
-- Depósitos de salario (Enero)
(3, 3, NULL, 8500.00, 'Depósito salario mensual - Enero 2025', 'DEP-2025-01-0001', 22480.00, 30980.00, 'completada', '2025-01-05 08:00:00'),
(3, 7, NULL, 9200.00, 'Depósito salario mensual - Enero 2025', 'DEP-2025-01-0002', 21950.00, 31150.00, 'completada', '2025-01-05 08:15:00'),
(3, 13, NULL, 7800.00, 'Depósito salario mensual - Enero 2025', 'DEP-2025-01-0003', 19200.00, 27000.00, 'completada', '2025-01-05 08:30:00'),

-- Transferencias (Enero)
(1, 3, 1, 3000.00, 'Transferencia - Pago de renta', 'TRF-2025-01-0001', 30980.00, 27980.00, 'completada', '2025-01-08 09:20:00'),
(1, 1, 5, 2500.00, 'Transferencia - Inversión', 'TRF-2025-01-0002', 13750.50, 11250.50, 'completada', '2025-01-10 14:15:00'),
(1, 4, 7, 1800.00, 'Transferencia - Pago de servicios', 'TRF-2025-01-0003', 39610.00, 37810.00, 'completada', '2025-01-12 16:30:00'),

-- Retiros (Enero)
(4, 1, NULL, 1000.00, 'Retiro cajero automático - ATM Zona 10', 'RET-2025-01-0001', 11250.50, 10250.50, 'completada', '2025-01-15 19:45:00'),
(4, 3, NULL, 1500.00, 'Retiro cajero automático - ATM Oakland', 'RET-2025-01-0002', 27980.00, 26480.00, 'completada', '2025-01-17 20:15:00'),

-- Pagos de préstamos (Enero)
(6, 1, NULL, 2365.72, 'Pago cuota préstamo #1 - Enero 2025', 'PAG-PRE-2025-01-0001', 10250.50, 7884.78, 'completada', '2025-01-20 10:00:00'),
(6, 3, NULL, 3273.74, 'Pago cuota préstamo #2 - Enero 2025', 'PAG-PRE-2025-01-0002', 26480.00, 23206.26, 'completada', '2025-01-20 10:15:00'),
(6, 5, NULL, 3852.93, 'Pago cuota préstamo #3 - Enero 2025', 'PAG-PRE-2025-01-0003', 125000.00, 121147.07, 'completada', '2025-01-20 10:30:00'),

-- Pagos de servicios (Enero)
(5, 1, NULL, 480.00, 'Pago de energía eléctrica - EEGSA', 'PAG-2025-01-0005', 7884.78, 7404.78, 'completada', '2025-01-22 15:20:00'),
(5, 3, NULL, 340.00, 'Pago de agua potable - EMPAGUA', 'PAG-2025-01-0006', 23206.26, 22866.26, 'completada', '2025-01-23 11:40:00'),
(5, 5, NULL, 600.00, 'Pago de internet - Claro', 'PAG-2025-01-0007', 121147.07, 120547.07, 'completada', '2025-01-24 14:10:00'),

-- Compras con tarjeta (Enero)
(8, 2, NULL, 2100.00, 'Compra - Super 24 Zona 14', 'COM-2025-01-0001', 6950.00, 4850.00, 'completada', '2025-01-25 17:30:00'),
(8, 4, NULL, 1560.00, 'Compra - Restaurante Tamarindos', 'COM-2025-01-0002', 37810.00, 36250.00, 'completada', '2025-01-26 20:15:00'),
(8, 6, NULL, 4200.00, 'Compra - La Curacao Zona 1', 'COM-2025-01-0003', 116800.00, 112600.00, 'completada', '2025-01-27 13:45:00'),

-- Depósitos adicionales (Enero)
(3, 1, NULL, 8500.00, 'Depósito - Pago cliente', 'DEP-2025-01-0004', 7404.78, 15904.78, 'completada', '2025-01-28 09:30:00'),
(3, 5, NULL, 12000.00, 'Depósito - Venta de activo', 'DEP-2025-01-0005', 120547.07, 132547.07, 'completada', '2025-01-29 11:20:00'),

-- Intereses ganados (Enero)
(10, 1, NULL, 45.72, 'Intereses generados - Enero 2025', 'INT-2025-01-0001', 15904.78, 15950.50, 'completada', '2025-01-31 23:59:00'),
(10, 4, NULL, 200.75, 'Intereses generados - Enero 2025', 'INT-2025-01-0002', 36250.00, 36450.75, 'completada', '2025-01-31 23:59:00'),
(10, 6, NULL, 452.93, 'Intereses generados - Enero 2025', 'INT-2025-01-0003', 132547.07, 133000.00, 'completada', '2025-01-31 23:59:00');

-- Actualizar saldos finales de cuentas (Febrero 2025 - datos actuales)
UPDATE cuentas SET saldo = 15750.50 WHERE id_cuenta = 1;
UPDATE cuentas SET saldo = 8200.00 WHERE id_cuenta = 2;
UPDATE cuentas SET saldo = 22500.75 WHERE id_cuenta = 3;
UPDATE cuentas SET saldo = 45300.00 WHERE id_cuenta = 4;
UPDATE cuentas SET saldo = 9850.25 WHERE id_cuenta = 5;
UPDATE cuentas SET saldo = 125000.00 WHERE id_cuenta = 6;
UPDATE cuentas SET saldo = 6750.00 WHERE id_cuenta = 7;
UPDATE cuentas SET saldo = 18400.50 WHERE id_cuenta = 8;
UPDATE cuentas SET saldo = 3250.00 WHERE id_cuenta = 9;
UPDATE cuentas SET saldo = 12800.75 WHERE id_cuenta = 10;
UPDATE cuentas SET saldo = 28900.00 WHERE id_cuenta = 11;
UPDATE cuentas SET saldo = 15600.50 WHERE id_cuenta = 12;
UPDATE cuentas SET saldo = 19200.00 WHERE id_cuenta = 13;
UPDATE cuentas SET saldo = 34500.25 WHERE id_cuenta = 14;
UPDATE cuentas SET saldo = 11450.00 WHERE id_cuenta = 15;
UPDATE cuentas SET saldo = 7800.75 WHERE id_cuenta = 16;

-- =====================================================
-- INSERTAR PAGOS DE PRÉSTAMOS
-- =====================================================
INSERT INTO pagos_prestamo (id_prestamo, id_transaccion, numero_cuota, monto_pagado, monto_capital, monto_interes, saldo_restante, fecha_vencimiento, estado) VALUES
-- Pagos del préstamo 1 (María Elena García)
(1, 40, 1, 2365.72, 1844.89, 520.83, 48155.11, '2023-04-05', 'puntual'),
(1, 40, 2, 2365.72, 1864.10, 501.62, 46291.01, '2023-05-05', 'puntual'),
(1, 40, 3, 2365.72, 1883.54, 482.18, 44407.47, '2023-06-05', 'puntual'),

-- Pagos del préstamo 2 (Carlos Alberto Pérez)
(2, 41, 1, 3273.74, 2357.07, 916.67, 97642.93, '2022-09-20', 'puntual'),
(2, 41, 2, 3273.74, 2378.59, 895.15, 95264.34, '2022-10-20', 'puntual'),

-- Pagos del préstamo 3 (Ana Lucía Rodríguez)
(3, 42, 1, 3852.93, 2277.93, 1575.00, 177722.07, '2023-06-15', 'puntual'),
(3, 42, 2, 3852.93, 2297.89, 1555.04, 175424.18, '2023-07-15', 'puntual');

-- =====================================================
-- INSERTAR BENEFICIARIOS
-- =====================================================
INSERT INTO beneficiarios (id_usuario, nombre_beneficiario, numero_cuenta_beneficiario, banco, alias, email, telefono) VALUES
(1, 'Rosa María García Vásquez', '1009876543210001', 'Fundación Genesis Empresarial', 'Mamá Rosa', 'rosa.garcia@gmail.com', '55998877'),
(1, 'Pedro García López', '1009876543210002', 'Fundación Genesis Empresarial', 'Hermano Pedro', 'pedro.garcia@gmail.com', '44887766'),
(2, 'Laura Pérez Ramos', '1009988776655001', 'Fundación Genesis Empresarial', 'Esposa Laura', 'laura.perez@gmail.com', '33776655'),
(3, 'Roberto Méndez Castro', '1008877665544001', 'Fundación Genesis Empresarial', 'Socio Roberto', 'roberto.mendez@gmail.com', '22665544'),
(4, 'Claudia Hernández Flores', '1007766554433001', 'Fundación Genesis Empresarial', 'Hermana Claudia', 'claudia.hernandez@gmail.com', '11554433');

-- =====================================================
-- INSERTAR NOTIFICACIONES
-- =====================================================
INSERT INTO notificaciones (id_usuario, titulo, mensaje, tipo, leida) VALUES
(1, 'Bienvenida a Genesis Bancario', 'Gracias por confiar en nosotros. Tu cuenta ha sido activada exitosamente.', 'exito', TRUE),
(1, 'Depósito recibido', 'Se ha acreditado Q3,000.00 en tu cuenta ***0001', 'transaccion', TRUE),
(1, 'Pago de préstamo realizado', 'Tu pago de cuota de préstamo por Q2,365.72 ha sido procesado exitosamente.', 'exito', FALSE),
(2, 'Transferencia exitosa', 'Transferencia de Q2,500.00 realizada a cuenta ***0001', 'transaccion', TRUE),
(2, 'Próximo vencimiento', 'Recuerda que tu cuota de préstamo vence el 20 de febrero.', 'alerta', FALSE),
(3, 'Nueva tarjeta disponible', 'Tu tarjeta de crédito ha sido aprobada. Límite: Q75,000.00', 'exito', TRUE),
(3, 'Compra con tarjeta', 'Compra por Q4,200.00 en La Curacao. Saldo disponible: Q56,800.00', 'transaccion', FALSE),
(4, 'Depósito de salario', 'Se ha depositado tu salario de Q8,500.00', 'transaccion', TRUE),
(5, 'Recordatorio de pago', 'Tienes un pago de servicios pendiente por Q580.00', 'alerta', FALSE),
(6, 'Intereses acreditados', 'Se han acreditado Q452.93 por concepto de intereses.', 'exito', TRUE);

-- =====================================================
-- CONFIRMAR INSERCIÓN DE DATOS
-- =====================================================
SELECT 'Base de datos poblada exitosamente' AS mensaje;
SELECT COUNT(*) AS total_usuarios FROM usuarios;
SELECT COUNT(*) AS total_cuentas FROM cuentas;
SELECT COUNT(*) AS total_tarjetas FROM tarjetas;
SELECT COUNT(*) AS total_transacciones FROM transacciones;
SELECT COUNT(*) AS total_prestamos FROM prestamos;
SELECT COUNT(*) AS total_beneficiarios FROM beneficiarios;
SELECT COUNT(*) AS total_notificaciones FROM notificaciones;
