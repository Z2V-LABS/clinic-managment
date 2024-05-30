CREATE TABLE especialidades (
  especialidad_id INT AUTO_INCREMENT PRIMARY KEY,
  descripcion VARCHAR(255),
  fecha TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
);

CREATE TABLE tareas (
    tarea_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE,
    ultima_ejecucion DATE
);

CREATE TABLE categorias(
  categoria_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  descripcion VARCHAR(255)
);

CREATE TABLE password_resets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  token VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE productos (
  producto_id INT AUTO_INCREMENT PRIMARY KEY,
  categoria_id INT,
  nombre VARCHAR(255),
  descripcion VARCHAR(255),
  monto INT,
  fecha TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

-- Tabla para almacenar información de usuarios
CREATE TABLE usuarios (
  usuario_id VARCHAR(9) PRIMARY KEY,
  acerca_de VARCHAR(255),
  nombre VARCHAR(255),
  apellidos VARCHAR(255),
  telefono VARCHAR(100),
  fecha_nacimiento DATE,
  direccion VARCHAR(100),
  provincia VARCHAR(100),
  municipio VARCHAR(100),
  cp VARCHAR(7),
  email VARCHAR(100) UNIQUE,
  pass VARCHAR(255),
  rol ENUM('Administrador', 'Paciente', 'Fisioterapeuta'),
  genero ENUM('hombre', 'mujer', 'otro'),
  especialidad INT,
  sesiones_disponibles INT,
  FOREIGN KEY (especialidad) REFERENCES especialidades(especialidad_id)
);

-- Tabla para almacenar información de facturas
CREATE TABLE facturas (
  factura_id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id VARCHAR(9),
  fecha_emision DATE,
  producto INT,
  estado ENUM('Pendiente', 'Pagada'),
  FOREIGN KEY (paciente_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (producto) REFERENCES productos(producto_id)
);

-- Tabla para almacenar información de citas
CREATE TABLE citas (
  cita_id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id VARCHAR(9),
  fisioterapeuta_id VARCHAR(9),
  fecha_hora DATETIME,
  estado ENUM('Programada', 'Cancelada', 'Realizada'),
  especialidad_id INT,
  historial_id INT UNIQUE,
  horario_id INT,
  FOREIGN KEY (paciente_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (fisioterapeuta_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (especialidad_id) REFERENCES especialidades(especialidad_id)
);

CREATE TABLE historial_medico (
  historial_id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id VARCHAR(9),
  fisioterapeuta_id VARCHAR(9),
  cita_id INT UNIQUE,
  fecha DATETIME,
  descripcion TEXT,
  diagnostico TEXT,
  tratamiento TEXT,
  notas TEXT,
  FOREIGN KEY (paciente_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (fisioterapeuta_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (cita_id) REFERENCES citas(cita_id)
);

INSERT INTO tareas (nombre, ultima_ejecucion) VALUES ('enviarRecordatorios', NULL);

-- Insertar datos de prueba para la tabla especialidades
INSERT INTO especialidades (descripcion) VALUES
('Fisioterapia Deportiva'),
('Fisioterapia Neurológica'),
('Fisioterapia Respiratoria'),
('Fisioterapia Pediátrica'),
('Fisioterapia Geriátrica'),
('Fisioterapia Ortopédica'),
('Fisioterapia Cardiovascular'),
('Fisioterapia Oncológica'),
('Fisioterapia del Suelo Pélvico'),
('Fisioterapia Musculoesquelética'),
('Fisioterapia Acuática (Hidroterapia)'),
('Fisioterapia Manual'),
('Fisioterapia Deportiva Adaptada'),
('Fisioterapia del Dolor'),
('Fisioterapia Vestibular'),
('Fisioterapia en Salud Mental'),
('Fisioterapia Dermatofuncional'),
('Fisioterapia en Disfunciones Temporomandibulares'),
('Fisioterapia en Traumatología y Cirugía Ortopédica'),
('Fisioterapia en Salud de la Mujer (Maternidad y Postparto)');

-- Insertar datos de prueba para la tabla categorias
INSERT INTO categorias (nombre, descripcion) VALUES
('Terapia Física', 'Sesiones de terapia física individualizadas'),
('Bonos de Sesiones', 'Paquetes de sesiones de terapia física con descuento'),
('Tratamientos Especiales', 'Tratamientos específicos para ciertas condiciones o necesidades'),
('Rehabilitación', 'Programas de rehabilitación post-operatoria o lesiones'),
('Terapias Complementarias', 'Terapias complementarias como acupuntura o electroterapia');

-- Insertar datos de prueba para la tabla productos
INSERT INTO productos (nombre, categoria_id, descripcion, monto) VALUES
('Sesión individual', 1, '', 35),
('Bono de 10 sesiones', 2, '(30€/sesión)', 300),
('Bono de 15 sesiones', 2, '(26€/sesión)', 390),
('Bono de 20 sesiones', 2, '(24€/sesión)', 480),
('Bono de 30 sesiones', 2, '(20,5€/sesión)', 615),
('Bono especial de 10 sesiones', 3, '(37€/sesión)', 370);

-- Insertar datos de prueba para la tabla usuarios
INSERT INTO usuarios (usuario_id, acerca_de, nombre, apellidos, telefono, fecha_nacimiento, direccion, provincia, municipio, cp, email, pass, rol, genero, especialidad, sesiones_disponibles)
VALUES
('123456789', 'Juan Pérez es un paciente de 45 años que ha estado bajo nuestro cuidado desde 2015. Vive en Ciudad de México y trabaja como ingeniero. En su tiempo libre, disfruta de la lectura y el senderismo.', 'Juan', 'Perez', '123456789', '1990-01-01', 'Calle 123', 'Provincia 1', 'Ciudad 1', '12345', 'patient@example.com', '$2y$10$N7JA82u/XFyaeHM.4t44S.9KKcgpj5yikEYBZ8k/0cp4qmvA/MEb6', 'Paciente', 'hombre', NULL, 10),
('234567890', '', 'Maria', 'Lopez', '234567890', '1995-05-05', 'Avenida 456', 'Provincia 2', 'Ciudad 2', '23456', 'fisio@example.com', '$2y$10$N7JA82u/XFyaeHM.4t44S.9KKcgpj5yikEYBZ8k/0cp4qmvA/MEb6', 'Fisioterapeuta', 'mujer', 5, NULL),
('345678901', '', 'Pedro', 'Gomez', '345678901', '1985-10-10', 'Plaza 789', 'Provincia 3', 'Ciudad 3', '34567', 'admin@example.com', '$2y$10$N7JA82u/XFyaeHM.4t44S.9KKcgpj5yikEYBZ8k/0cp4qmvA/MEb6', 'Administrador', 'hombre', NULL, NULL);

-- Insertar datos de prueba para la tabla facturas
INSERT INTO facturas (paciente_id, fecha_emision, producto, estado)
VALUES
('123456789', '2024-04-01', 2, 'Pendiente'),
('234567890', '2024-04-02', 5, 'Pagada'),
('345678901', '2024-04-03', 1, 'Pendiente');

-- Insertar datos de prueba en la tabla citas
INSERT INTO citas (paciente_id, fisioterapeuta_id, fecha_hora, estado, especialidad_id, historial_id, horario_id)
VALUES
('123456789', '234567890', '2024-01-15 10:00:00', 'Realizada', 1, 1, 1),
('123456789', '234567890', '2024-02-20 11:00:00', 'Realizada', 1, 2, 2),
('123456789', '234567890', '2024-03-25 09:00:00', 'Realizada', 1, 3, 3),
('123456789', '234567890', '2024-04-20 10:00:00', 'Programada', 1, NULL, 4),
('234567890', '345678901', '2024-05-05 14:00:00', 'Cancelada', 2, NULL, 5);

-- Insertar datos de prueba en la tabla historial_medico
INSERT INTO historial_medico (paciente_id, fisioterapeuta_id, cita_id, fecha, descripcion, diagnostico, tratamiento, notas)
VALUES
('123456789', '234567890', 1, '2024-01-15 10:00:00', 'Dolor de espalda', 'Lumbalgia', 'Fisioterapia y ejercicios de fortalecimiento', 'Mejoría progresiva'),
('123456789', '234567890', 2, '2024-02-20 11:00:00', 'Revisión de dolor de espalda', 'Lumbalgia', 'Continuar con fisioterapia', 'Dolor disminuido en un 50%'),
('123456789', '234567890', 3, '2024-03-25 09:00:00', 'Rehabilitación post cirugía de rodilla', 'Post-cirugía', 'Ejercicios de movilidad y fortalecimiento', 'Buena evolución');
