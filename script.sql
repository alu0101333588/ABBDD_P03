CREATE TABLE Vivero (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(25),
    latitud NUMERIC(9, 6) CHECK (latitud >= -90 AND latitud <= 90),
    longitud NUMERIC(9, 6) CHECK (longitud >= -180 AND longitud <= 180),
    municipio VARCHAR(50),
    provincia VARCHAR(50)
);


CREATE TABLE Zona (
    nombre VARCHAR(25),
    tipo VARCHAR(25) CHECK (tipo IN ('exterior', 'almacén', 'exposición', 'invernadero', 'producción', 'riego', 'compostaje')),
    latitud NUMERIC(9, 6) CHECK (latitud >= -90 AND latitud <= 90),
    longitud NUMERIC(9, 6) CHECK (longitud >= -180 AND longitud <= 180),
    productividad NUMERIC(5,2) CHECK (productividad <= 100.00),
    id_vivero INTEGER,
    PRIMARY KEY (nombre, tipo),
    FOREIGN KEY (id_vivero) REFERENCES Vivero(id) ON DELETE CASCADE
);


CREATE TABLE Producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(25),
    tipo VARCHAR(30) CHECK (tipo IN ('plantas', 'jardinería', 'decoración')),
    precio NUMERIC(10,2)
);


CREATE TABLE Empleado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    primer_apellido VARCHAR(30),
    segundo_apellido VARCHAR(30),
    productividad NUMERIC(5,2) CHECK (productividad <= 100.00)
);




CREATE TABLE ClienteTajinastePlus (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(25),
    primer_apellido VARCHAR(30),
    segundo_apellido VARCHAR(30),
    bonificaciones NUMERIC(4,2),
    fecha_ingreso DATE CHECK (fecha_ingreso <= CURRENT_DATE)
);


CREATE TABLE Pedido (
    numero_pedido SERIAL PRIMARY KEY,
    fecha DATE DEFAULT CURRENT_DATE,
    id_empleado INTEGER,
    id_cliente_plus INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id) ON DELETE SET NULL,
    FOREIGN KEY (id_cliente_plus) REFERENCES ClienteTajinastePlus(id) ON DELETE SET NULL
);


CREATE TABLE EmpleadoZona (
    id_empleado INTEGER,
    epoca_ano VARCHAR(15) CHECK (epoca_ano IN ('invierno', 'verano', 'primavera', 'otoño')),
    nombre_zona VARCHAR(25),
    tipo_zona VARCHAR(25) CHECK (tipo_zona IN ('exterior', 'almacén', 'exposición', 'invernadero', 'producción', 'riego', 'compostaje')),
    PRIMARY KEY (id_empleado, epoca_ano, nombre_zona, tipo_zona),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id) ON DELETE CASCADE,
    FOREIGN KEY (nombre_zona, tipo_zona) REFERENCES Zona(nombre, tipo) ON DELETE CASCADE
);


CREATE TABLE ProductoPedido (
    numero_pedido SERIAL,
    id_producto INTEGER,
    cantidad INTEGER CHECK (cantidad >= 1),
    PRIMARY KEY (numero_pedido, id_producto),
    FOREIGN KEY (numero_pedido) REFERENCES Pedido(numero_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id) ON DELETE RESTRICT
);



CREATE TABLE ZonaProducto (
	nombre_zona VARCHAR(25),
	tipo_zona VARCHAR(25),
	id_producto SERIAL,
	cantidad INTEGER CHECK (cantidad >= 1),
	PRIMARY KEY (nombre_zona, tipo_zona, id_producto),
	FOREIGN KEY (nombre_zona, tipo_zona) REFERENCES Zona(nombre, tipo) ON DELETE CASCADE,
	FOREIGN KEY (id_producto) REFERENCES Producto(id) ON DELETE RESTRICT
);



INSERT INTO Vivero (nombre, latitud, longitud, municipio, provincia) VALUES
('Vivero Primavera', 25.6841, -100.3161, 'Monterrey', 'Nuevo León'),
('Vivero Verde Vida', 19.4326, -99.1332, 'Ciudad de México', 'Ciudad de México'),
('Vivero El Bosque', -34.6037, -58.3816, 'Buenos Aires', 'Buenos Aires'),
('Vivero Las Flores', 40.7128, -74.0060, 'Nueva York', 'Nueva York'),
('Vivero Tropical', -22.9068, -43.1729, 'Río de Janeiro', 'Río de Janeiro');

INSERT INTO Zona (nombre, tipo, latitud, longitud, productividad, id_vivero) VALUES
('Zona Norte', 'exterior', 25.6845, -100.3170, 85.00, 1),
('Zona Sur', 'invernadero', 19.4321, -99.1320, 90.00, 2),
('Zona Central', 'producción', -34.6039, -58.3820, 75.00, 3),
('Zona Oeste', 'almacén', 40.7130, -74.0065, 80.00, 4),
('Zona Este', 'exposición', -22.9065, -43.1730, 70.00, 5);


INSERT INTO Producto (nombre, tipo, precio) VALUES
('Maceta de cerámica', 'decoración', 15.99),
('Rosa', 'plantas', 5.50),
('Sustrato universal', 'jardinería', 12.00),
('Orquídea', 'plantas', 20.00),
('Tierra abonada', 'jardinería', 8.50);

INSERT INTO Empleado (nombre, primer_apellido, segundo_apellido, productividad) VALUES
('Juan', 'Pérez', 'López', 95.00),
('Ana', 'Gómez', 'Martínez', 87.50),
('Carlos', 'Fernández', 'García', 92.00),
('Lucía', 'Díaz', 'Santos', 88.00),
('Miguel', 'Ruiz', 'Núñez', 90.50);

INSERT INTO ClienteTajinastePlus (nombre, primer_apellido, segundo_apellido, bonificaciones, fecha_ingreso) VALUES
('Laura', 'Torres', 'Vargas', 5.50, '2023-06-15'),
('Miguel', 'Ruiz', 'Sánchez', 3.00, '2024-01-12'),
('Elena', 'Martínez', 'Díaz', 2.50, '2024-05-20'),
('Pedro', 'González', 'Lopez', 4.00, '2022-09-30'),
('Ana', 'Morales', 'Fernández', 3.75, '2023-02-25');

INSERT INTO Pedido (id_empleado, id_cliente_plus) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO EmpleadoZona (id_empleado, epoca_ano, nombre_zona, tipo_zona) VALUES
(1, 'invierno', 'Zona Norte', 'exterior'),
(2, 'verano', 'Zona Sur', 'invernadero'),
(3, 'primavera', 'Zona Central', 'producción'),
(4, 'otoño', 'Zona Oeste', 'almacén'),
(5, 'invierno', 'Zona Este', 'exposición');

INSERT INTO ProductoPedido (numero_pedido, id_producto, cantidad) VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 20),
(4, 4, 7),
(5, 5, 15);

INSERT INTO ZonaProducto (nombre_zona, tipo_zona, id_producto, cantidad) VALUES
('Zona Norte', 'exterior', 1, 50),
('Zona Sur', 'invernadero', 2, 30),
('Zona Central', 'producción', 3, 70),
('Zona Oeste', 'almacén', 4, 40),
('Zona Este', 'exposición', 5, 25);