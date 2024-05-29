CREATE TABLE especialidades (
  especialidad_id INT AUTO_INCREMENT PRIMARY KEY,
  descripcion VARCHAR(255),
  fecha TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
);

CREATE TABLE clinicas (
  clinica_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  direccion VARCHAR(255),
  telefono VARCHAR(20),
  email VARCHAR(100),
  fecha_creacion TIMESTAMP NOT NULL DEFAULT current_timestamp()
);

CREATE TABLE horarios (
  horario_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  estado ENUM('Activo', 'Pendiente', 'Cancelado'),
  ult_modificacion TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
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

CREATE TABLE documentos_sanitarios (
  documento_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255),
  descripcion TEXT,
  ruta_documento VARCHAR(255),
  fecha_subida TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  estado ENUM('Pendiente', 'Firmado', 'Rechazado') DEFAULT 'Pendiente',
  paciente_id VARCHAR(9),
  fisioterapeuta_id VARCHAR(9),
  FOREIGN KEY (paciente_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (fisioterapeuta_id) REFERENCES usuarios(usuario_id)
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

CREATE TABLE historial_medico (
  historial_id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id VARCHAR(9),
  fisioterapeuta_id VARCHAR(9),
  fecha DATETIME,
  descripcion TEXT,
  diagnostico TEXT,
  tratamiento TEXT,
  notas TEXT,
  FOREIGN KEY (paciente_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (fisioterapeuta_id) REFERENCES usuarios(usuario_id)
);

-- Tabla para almacenar información de citas
CREATE TABLE citas (
  cita_id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id VARCHAR(9),
  fisioterapeuta_id VARCHAR(9),
  fecha_hora DATETIME,
  duracion_minutos INT,
  estado ENUM('Programada', 'Cancelada', 'Realizada'),
  especialidad_id INT,
  historial_id INT UNIQUE,
  horario_id INT,
  FOREIGN KEY (paciente_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (fisioterapeuta_id) REFERENCES usuarios(usuario_id),
  FOREIGN KEY (especialidad_id) REFERENCES especialidades(especialidad_id),
  FOREIGN KEY (horario_id) REFERENCES horarios(horario_id),
  FOREIGN KEY (historial_id) REFERENCES historial_medico(historial_id)
);


-- Insertar datos de prueba para la tabla usuarios
-- La contraseña está cifrada. Deberás escribir 12345678 en el formulario de inicio de sesión
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

INSERT INTO horarios (nombre, estado) VALUES
('Lunes Mañana', 'Activo'),
('Lunes Tarde', 'Activo'),
('Martes Mañana', 'Activo'),
('Martes Tarde', 'Activo'),
('Miércoles Mañana', 'Activo'),
('Miércoles Tarde', 'Activo'),
('Jueves Mañana', 'Activo'),
('Jueves Tarde', 'Activo'),
('Viernes Mañana', 'Activo'),
('Viernes Tarde', 'Activo'),
('Sábado Mañana', 'Activo'),
('Sábado Tarde', 'Activo'),
('Domingo Mañana', 'Activo'),
('Domingo Tarde', 'Activo');

INSERT INTO categorias (nombre, descripcion) VALUES
('Terapia Física', 'Sesiones de terapia física individualizadas'),
('Bonos de Sesiones', 'Paquetes de sesiones de terapia física con descuento'),
('Tratamientos Especiales', 'Tratamientos específicos para ciertas condiciones o necesidades'),
('Rehabilitación', 'Programas de rehabilitación post-operatoria o lesiones'),
('Terapias Complementarias', 'Terapias complementarias como acupuntura o electroterapia');

INSERT INTO productos (nombre, categoria_id, descripcion, monto) VALUES
('Sesión individual', 1, '', 35),
('Bono de 10 sesiones', 2, '(30€/sesión)', 300),
('Bono de 15 sesiones', 2, '(26€/sesión)', 390),
('Bono de 20 sesiones', 2, '(24€/sesión)', 480),
('Bono de 30 sesiones', 2, '(20,5€/sesión)', 615),
('Bono especial de 10 sesiones', 3, '(37€/sesión)', 370);

INSERT INTO usuarios (usuario_id, acerca_de, nombre, apellidos, telefono, fecha_nacimiento, direccion, provincia, municipio, cp, email, pass, rol, genero, especialidad, sesiones_disponibles)
VALUES
('123456789', 'Juan Pérez es un paciente de 45 años que ha estado bajo nuestro cuidado desde 2015. Vive en Ciudad de México y trabaja como ingeniero. En su tiempo libre, disfruta de la lectura y el senderismo.', 'Juan', 'Perez', '123456789', '1990-01-01', 'Calle 123', 'Provincia 1', 'Ciudad 1', '12345', 'patient@example.com', '$2y$10$N7JA82u/XFyaeHM.4t44S.9KKcgpj5yikEYBZ8k/0cp4qmvA/MEb6', 'paciente', 'hombre', NULL, 10),
('234567890', '', 'Maria', 'Lopez', '234567890', '1995-05-05', 'Avenida 456', 'Provincia 2', 'Ciudad 2', '23456', 'fisio@example.com', '$2y$10$N7JA82u/XFyaeHM.4t44S.9KKcgpj5yikEYBZ8k/0cp4qmvA/MEb6', 'fisioterapeuta', 'mujer', 5, NULL),
('345678901', '', 'Pedro', 'Gomez', '345678901', '1985-10-10', 'Plaza 789', 'Provincia 3', 'Ciudad 3', '34567', 'admin@example.com', '$2y$10$N7JA82u/XFyaeHM.4t44S.9KKcgpj5yikEYBZ8k/0cp4qmvA/MEb6', 'administrador', 'hombre', NULL, NULL);

-- Insertar datos de prueba para la tabla facturas
INSERT INTO facturas (paciente_id, fecha_emision, producto, estado)
VALUES
('123456789', '2024-04-01', 2, 'pendiente'),
('234567890', '2024-04-02', 5, 'pagada'),
('345678901', '2024-04-03', 1, 'pendiente');

-- Insertar datos de prueba en la tabla historial_medico
INSERT INTO historial_medico (paciente_id, fisioterapeuta_id, fecha, descripcion, diagnostico, tratamiento, notas)
VALUES
('123456789', '234567890', '2024-01-15 10:00:00', 'Dolor de espalda', 'Lumbalgia', 'Fisioterapia y ejercicios de fortalecimiento', 'Mejoría progresiva'),
('123456789', '234567890', '2024-02-20 11:00:00', 'Revisión de dolor de espalda', 'Lumbalgia', 'Continuar con fisioterapia', 'Dolor disminuido en un 50%'),
('123456789', '234567890', '2024-03-25 09:00:00', 'Rehabilitación post cirugía de rodilla', 'Post-cirugía', 'Ejercicios de movilidad y fortalecimiento', 'Buena evolución');

-- Insertar datos de prueba en la tabla citas
INSERT INTO citas (paciente_id, fisioterapeuta_id, fecha_hora, duracion_minutos, estado, especialidad_id, historial_id, horario_id)
VALUES
('123456789', '234567890', '2024-01-15 10:00:00', 60, 'Realizada', 1, 1, 1),
('123456789', '234567890', '2024-02-20 11:00:00', 60, 'Realizada', 1, 2, 2),
('123456789', '234567890', '2024-03-25 09:00:00', 60, 'Realizada', 1, 3, 3),
('123456789', '234567890', '2024-04-20 10:00:00', 60, 'Programada', 1, NULL, 4),
('234567890', '345678901', '2024-05-05 14:00:00', 60, 'Cancelada', 2, NULL, 5);
