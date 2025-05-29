CREATE DATABASE IF NOT EXISTS clinica_medica;
USE clinica_medica;

CREATE TABLE EMPLEADOS (
  id_empleado INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  cargo VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  email VARCHAR(100) UNIQUE,
  direccion VARCHAR(100)
);

CREATE TABLE SERVICIOS (
  id_servicio INT PRIMARY KEY,
  nombre_servicio VARCHAR(100) NOT NULL,
  descripcion VARCHAR(100),
  precio DECIMAL(5,2) CHECK( precio >=0),
  id_empleado INT,
  FOREIGN KEY (id_empleado) REFERENCES EMPLEADOS(id_empleado)
);

CREATE TABLE MEDICO (
  id_medico INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especialidad VARCHAR(100),
  telefono VARCHAR(20),
  email VARCHAR(100) UNIQUE
);

CREATE TABLE ASEGURADORA (
  id_aseguradora INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  contacto VARCHAR(100),
  telefono VARCHAR(20)
);

CREATE TABLE PACIENTES (
  id_paciente INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  email VARCHAR(100) UNIQUE,
  direccion VARCHAR(100),
  id_aseguradora INT,
  FOREIGN KEY (id_aseguradora) REFERENCES ASEGURADORA(id_aseguradora)
);


CREATE TABLE HISTORIAL_MEDICO (
  id_historial INT PRIMARY KEY,
  fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
  diagnostico VARCHAR(100),
  id_medico INT,
  id_paciente INT,
  FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
  FOREIGN KEY (id_paciente) REFERENCES PACIENTES(id_paciente)
);

CREATE TABLE CITAS (
  id_cita INT PRIMARY KEY,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  estado VARCHAR(100),
  id_paciente INT,
  id_medico INT,
  id_servicio INT,
  FOREIGN KEY (id_paciente) REFERENCES PACIENTES(id_paciente),
  FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
  FOREIGN KEY (id_servicio) REFERENCES SERVICIOS(id_servicio)
);

CREATE TABLE FACTURAS (
  id_factura INT PRIMARY KEY,
  monto DECIMAL(5,2) CHECK (monto>=0),
  fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,
  estado_pago VARCHAR(100),
  id_cita INT,
  FOREIGN KEY (id_cita) REFERENCES CITAS(id_cita)
);

CREATE TABLE PAGOS (
  id_pago INT PRIMARY KEY,
  metodo_pago VARCHAR(100) NOT NULL,
  fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
  id_factura INT,
  FOREIGN KEY (id_factura) REFERENCES FACTURAS(id_factura)
);

CREATE TABLE CONSULTORIOS (
  id_consultorio INT PRIMARY KEY,
  ubicacion VARCHAR(100) NOT NULL,
  capacidad INT CHECK (capacidad > 0)
);

CREATE TABLE MEDICO_CONSULTORIO (
  id_medico INT,
  id_consultorio INT,
  PRIMARY KEY (id_medico, id_consultorio),
  FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
  FOREIGN KEY (id_consultorio) REFERENCES CONSULTORIOS(id_consultorio)
);

INSERT INTO EMPLEADOS (id_empleado, nombre, cargo, telefono, email, direccion) VALUES
(1, 'Carlos Mendoza', 'Administrador', '3101234567', 'carlos.mendoza@clinicamedica.com', 'Calle 10 #23-45'),
(2, 'Laura Pérez', 'Recepcionista', '3112345678', 'laura.perez@clinicamedica.com', 'Avenida 15 #45-67'),
(3, 'Javier Torres', 'Técnico', '3123456789', 'javier.torres@clinicamedica.com', 'Carrera 8 #12-34'),
(4, 'Sofía Ramírez', 'Asistente Médico', '3134567890', 'sofia.ramirez@clinicamedica.com', 'Diagonal 5 #78-90'),
(5, 'Andrés López', 'Contador', '3145678901', 'andres.lopez@clinicamedica.com', 'Transversal 3 #56-78'),
(6, 'Patricia Gómez', 'Secretaria', '3156789012', 'patricia.gomez@clinicamedica.com', 'Calle 12 #89-01'),
(7, 'Diego Martínez', 'Mantenimiento', '3167890123', 'diego.martinez@clinicamedica.com', 'Carrera 14 #34-56'),
(8, 'Valentina Díaz', 'Soporte Técnico', '3178901234', 'valentina.diaz@clinicamedica.com', 'Avenida 7 #65-43'),
(9, 'Fernando Cruz', 'Gerente', '3189012345', 'fernando.cruz@clinicamedica.com', 'Calle 5 #21-87'),
(10, 'Camila Rojas', 'Coordinadora', '3190123456', 'camila.rojas@clinicamedica.com', 'Carrera 2 #98-76');

INSERT INTO SERVICIOS (id_servicio, nombre_servicio, descripcion, precio, id_empleado) VALUES
(1, 'Consulta General', 'Primera consulta médica general', 50.00, 1),
(2, 'Urgencias', 'Atención de emergencia las 24 horas', 100.00, 2),
(3, 'Laboratorio Clínico', 'Análisis sanguíneos y pruebas clínicas', 40.00, 3),
(4, 'Rayos X', 'Estudios radiográficos generales', 60.00, 4),
(5, 'Ecografía', 'Exploración por ultrasonido abdominal', 80.00, 5),
(6, 'Vacunación', 'Programa de inmunización básica', 30.00, 6),
(7, 'Control Prenatal', 'Seguimiento médico durante el embarazo', 70.00, 7),
(8, 'Fisioterapia', 'Tratamiento físico post-operatorio o lesiones', 90.00, 8),
(9, 'Nutrición', 'Evaluación nutricional y plan alimenticio', 45.00, 9),
(10, 'Psicología Clínica', 'Consulta psicológica individual', 55.00, 10);

INSERT INTO MEDICO (id_medico, nombre, especialidad, telefono, email) VALUES
(1, 'Dr. Juan Morales', 'Cardiología', '3102345678', 'juan.morales@medicoscl.com'),
(2, 'Dra. Ana Fernández', 'Pediatría', '3113456789', 'ana.fernandez@medicoscl.com'),
(3, 'Dr. Luis Castillo', 'Dermatología', '3124567890', 'luis.castillo@medicoscl.com'),
(4, 'Dra. Elena Vargas', 'Neurología', '3135678901', 'elena.vargas@medicoscl.com'),
(5, 'Dr. Pablo Ríos', 'Traumatología', '3146789012', 'pablo.rios@medicoscl.com'),
(6, 'Dra. María Soto', 'Ginecología', '3157890123', 'maria.soto@medicoscl.com'),
(7, 'Dr. Andrés Cárdenas', 'Oftalmología', '3168901234', 'andres.cardenas@medicoscl.com'),
(8, 'Dra. Laura Ortega', 'Endocrinología', '3179012345', 'laura.ortega@medicoscl.com'),
(9, 'Dr. Miguel Torres', 'Urología', '3180123456', 'miguel.torres@medicoscl.com'),
(10, 'Dra. Patricia Rojas', 'Psiquiatría', '3191234567', 'patricia.rojas@medicoscl.com');

INSERT INTO ASEGURADORA (id_aseguradora, nombre, contacto, telefono) VALUES
(1, 'SaludTotal S.A.', 'Juan Camargo', '3201234567'),
(2, 'VidaPlus Seguros', 'María León', '3212345678'),
(3, 'Protección Salud', 'Carlos Duarte', '3223456789'),
(4, 'Medicare Plus', 'Luisa Rueda', '3234567890'),
(5, 'Seguros del Hogar', 'Daniela Mejía', '3245678901'),
(6, 'Allianz Colombia', 'Fernando Ocampo', '3256789012'),
(7, 'Bolívar Salud', 'Jorge Medina', '3267890123'),
(8, 'AXA Salud S.A.', 'Carolina Roa', '3278901234'),
(9, 'Mapfre Salud', 'Rafael Niño', '3289012345'),
(10, 'Assist Card Salud', 'Paola Vega', '3290123456');

INSERT INTO PACIENTES (id_paciente, nombre, telefono, email, direccion, id_aseguradora) VALUES
(1, 'Luis Jiménez', '3109876543', 'luis.jimenez@gmail.com', 'Calle 10 #23-45', 1),
(2, 'María Fernández', '3118765432', 'maria.fernandez@hotmail.com', 'Avenida 15 #45-67', 2),
(3, 'Carlos Rojas', '3127654321', 'carlos.rojas@yahoo.com', 'Carrera 8 #12-34', 3),
(4, 'Ana Lucía Torres', '3136543210', 'anatorres@outlook.com', 'Diagonal 5 #78-90', 4),
(5, 'Javier Mendoza', '3145432109', 'javier.mendoza@gmail.com', 'Transversal 3 #56-78', 5),
(6, 'Sofía Pérez', '3154321098', 'sofia.perez@hotmail.com', 'Calle 12 #89-01', 6),
(7, 'David Gómez', '3163210987', 'david.gomez@yahoo.com', 'Av. 7 #45-23', 7),
(8, 'Lucía Ramírez', '3172109876', 'lucia.ramirez@outlook.com', 'Carrera 8 #12-34', 8),
(9, 'Alejandro Castro', '3181098765', 'alejandro.castro@gmail.com', 'Calle 9 #34-56', 9),
(10, 'Daniela Navarro', '3190987654', 'daniela.navarro@hotmail.com', 'Av. 10 #12-34', 10);

INSERT INTO HISTORIAL_MEDICO (id_historial, fecha_inicio, diagnostico, id_medico, id_paciente) VALUES
(1, '2024-01-10 09:30:00', 'Hipertensión arterial esencial', 1, 1),
(2, '2024-02-15 10:15:00', 'Resfriado común leve', 2, 2),
(3, '2024-03-01 11:00:00', 'Dermatitis alérgica', 3, 3),
(4, '2024-04-05 14:20:00', 'Trastorno de ansiedad generalizada', 4, 4),
(5, '2024-05-12 08:45:00', 'Fractura distal de radio derecho', 5, 5),
(6, '2024-06-20 12:10:00', 'Embarazo en semana 12', 6, 6),
(7, '2024-07-22 15:55:00', 'Miopía moderada bilateral', 7, 7),
(8, '2024-08-30 16:40:00', 'Diabetes tipo 2 controlada', 8, 8),
(9, '2024-09-10 09:15:00', 'Infección urinaria recurrente', 9, 9),
(10, '2024-10-15 10:00:00', 'Depresión leve episódica', 10, 10);

INSERT INTO CITAS (id_cita, fecha, hora, estado, id_paciente, id_medico, id_servicio) VALUES
(1, '2025-04-01', '09:00:00', 'Confirmada', 1, 1, 1),
(2, '2025-04-01', '10:00:00', 'Pendiente', 2, 2, 2),
(3, '2025-04-02', '11:00:00', 'Cancelada', 3, 3, 3),
(4, '2025-04-02', '12:00:00', 'Confirmada', 4, 4, 4),
(5, '2025-04-03', '13:00:00', 'Pendiente', 5, 5, 5),
(6, '2025-04-03', '14:00:00', 'Confirmada', 6, 6, 6),
(7, '2025-04-04', '15:00:00', 'Pendiente', 7, 7, 7),
(8, '2025-04-04', '16:00:00', 'Confirmada', 8, 8, 8),
(9, '2025-04-05', '17:00:00', 'Pendiente', 9, 9, 9),
(10, '2025-04-05', '18:00:00', 'Cancelada', 10, 10, 10);

INSERT INTO FACTURAS (id_factura, monto, fecha_emision, estado_pago, id_cita) VALUES
(1, 50.00, '2025-04-01 09:15:00', 'Pagado', 1),
(2, 100.00, '2025-04-01 10:10:00', 'Pendiente', 2),
(3, 40.00, '2025-04-02 11:15:00', 'Pagado', 3),
(4, 60.00, '2025-04-02 12:20:00', 'Pendiente', 4),
(5, 80.00, '2025-04-03 13:25:00', 'Pagado', 5),
(6, 30.00, '2025-04-03 14:30:00', 'Pendiente', 6),
(7, 70.00, '2025-04-04 15:35:00', 'Pagado', 7),
(8, 90.00, '2025-04-04 16:40:00', 'Pendiente', 8),
(9, 45.00, '2025-04-05 17:45:00', 'Pagado', 9),
(10, 55.00, '2025-04-05 18:50:00', 'Pendiente', 10);

INSERT INTO PAGOS (id_pago, metodo_pago, fecha_pago, id_factura) VALUES
(1, 'Tarjeta de Crédito', '2025-04-01 09:20:00', 1),
(2, 'Efectivo', '2025-04-02 11:20:00', 3),
(3, 'Transferencia Bancaria', '2025-04-03 13:30:00', 5),
(4, 'PayPal', '2025-04-04 15:40:00', 7),
(5, 'Tarjeta Débito', '2025-04-05 17:50:00', 9),
(6, 'Tarjeta de Crédito', '2025-04-01 10:15:00', 2),
(7, 'Efectivo', '2025-04-02 12:25:00', 4),
(8, 'Transferencia Bancaria', '2025-04-03 14:35:00', 6),
(9, 'PayPal', '2025-04-04 16:45:00', 8),
(10, 'Tarjeta Débito', '2025-04-05 18:55:00', 10);

INSERT INTO CONSULTORIOS (id_consultorio, ubicacion, capacidad) VALUES
(1, 'Planta Baja - Consultorio 1', 2),
(2, 'Primer Piso - Consultorio 2', 3),
(3, 'Segundo Piso - Consultorio 3', 4),
(4, 'Ala Norte - Consultorio 4', 2),
(5, 'Ala Sur - Consultorio 5', 3),
(6, 'Consultorio Externo 1 - Urgencias', 1),
(7, 'Consultorio Externo 2 - Psicología', 1),
(8, 'Área de Urgencias', 5),
(9, 'Laboratorio Clínico', 4),
(10, 'Sala de Rayos X', 2);

INSERT INTO MEDICO_CONSULTORIO (id_medico, id_consultorio) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

