CREATE DATABASE Mahoedb;

USE Mahoedb;

-- Crear tablas principales

CREATE TABLE empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    fecha_contratacion DATE
);

CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    tipo_producto VARCHAR(50),
    precio DECIMAL(10,2)
);

CREATE TABLE inventario (
    inventario_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    cantidad INT,
    almacen VARCHAR(100),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    ciudad VARCHAR(100),
    pais VARCHAR(50)
);

CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    empleado_id INT,
    fecha_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);

CREATE TABLE detalle_pedidos (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    precio_total DECIMAL(10,2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- Insertar datos en empleados
INSERT INTO empleados (nombre, apellido, cargo, salario, fecha_contratacion)
VALUES
('Carlos', 'Sánchez', 'Vendedor', 32000, '2021-01-12'),
('Maria', 'Perez', 'Vendedor', 30000, '2019-09-10'),
('Fernando', 'Torres', 'Vendedor', 31000, '2020-06-22'),
('Paula', 'González', 'Vendedor', 33000, '2022-03-01'),
('Antonio', 'Jiménez', 'Vendedor', 34000, '2021-07-18'),
('Eva', 'Ruiz', 'Vendedor', 31000, '2020-02-02'),
('Miguel', 'Martínez', 'Vendedor', 32000, '2021-12-15'),
('Javier', 'Hernández', 'Gerente', 46000, '2018-01-20'),
('Cristina', 'Sánchez', 'Gerente', 49000, '2017-08-30'),
('Raúl', 'Lopez', 'Gerente', 51000, '2016-11-05'),
('Marta', 'Diaz', 'Supervisor', 42000, '2019-04-28'),
('Sergio', 'Fernández', 'Supervisor', 43000, '2020-05-17'),
('Esther', 'Alonso', 'Supervisor', 44000, '2021-06-08'),
('Isabel', 'Gutiérrez', 'Gerente', 52000, '2015-09-15'),
('Rafael', 'García', 'Supervisor', 45000, '2021-02-11'),
('Andrea', 'López', 'Supervisor', 47000, '2020-10-19');


-- Insertar datos en productos
INSERT INTO productos (nombre_producto, tipo_producto, precio)
VALUES
('Mahou 1000ml', 'Cerveza', 3.50),
('Mahou 200ml', 'Cerveza', 1.00),
('Mahou Light', 'Cerveza', 1.80),
('Mahou 0.0', 'Cerveza', 1.70),
('Mahou 750ml', 'Cerveza', 2.90),
('Mahou 1500ml', 'Cerveza', 4.20),
('Mahou Negra 500ml', 'Cerveza', 2.80),
('Mahou Radler 500ml', 'Cerveza', 2.50),
('Mahou Roja 500ml', 'Cerveza', 2.30),
('Mahou 1000ml', 'Cerveza', 3.00),
('Mahou Clásica 1906 500ml', 'Cerveza', 2.60),
('Mahou Barril 5L', 'Cerveza', 10.00);



-- Insertar datos en inventario
INSERT INTO inventario (producto_id, cantidad, almacen)
VALUES
(1, 1000, 'Almacen Norte'),
(2, 500, 'Almacen Norte'),
(3, 300, 'Almacen Centro'),
(4, 700, 'Almacen Sur'),
(5, 800, 'Almacen Centro'),
(6, 800, 'Almacen Centro'),
(7, 800, 'Almacen Norte'),
(8, 800, 'Almacen Norte'),
(9, 800, 'Almacen Norte'),
(10, 800, 'Almacen Sur'),
(11, 800, 'Almacen Sur'),
(12, 800, 'Almacen Centro');


-- Insertar datos en clientes
INSERT INTO clientes (nombre_cliente, ciudad, pais)
VALUES
('Bebidas S.A.', 'Madrid', 'España'),
('Distribuidora Norte', 'Bilbao', 'España'),
('Cervezas del Sur', 'Sevilla', 'España'),
('Horeca Distribuciones', 'Barcelona', 'España'),
('Tiendas Consum', 'Valencia', 'España'),
('Vinos y Licores El Sol', 'Madrid', 'España'),
('Comercial Ríos', 'Alicante', 'España'),
('Distribuciones del Mediterráneo', 'Murcia', 'España'),
('Alimentación Global', 'Zaragoza', 'España'),
('Alimentación Amigos', 'Bilbao', 'España');

-- Insertar datos en pedidos
INSERT INTO pedidos (cliente_id, empleado_id, fecha_pedido)
VALUES
(1, 1, '2023-01-10'),
(2, 2, '2023-02-15'),
(3, 3, '2023-03-05'),
(4, 1, '2023-04-20'),
(5, 5, '2023-05-10'),
(6, 6, '2023-06-10'),
(7, 8, '2023-06-11'),
(8, 9, '2023-07-23'),
(9, 10, '2023-07-22'),
(10, 1, '2023-07-10');

-- Insertar datos en detalle_pedidos
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_total)
VALUES
(1, 1, 200, 240.00),
(1, 3, 100, 250.00),
(2, 2, 150, 270.00),
(2, 4, 50, 45.00),
(3, 5, 300, 330.00),
(4, 1, 400, 480.00),
(4, 2, 250, 450.00),
(5, 3, 200, 500.00),
(6, 10, 400, 5000.00),
(7, 8, 100, 150.00),
(8, 10, 400, 1000.00),
(9, 9, 30, 50.00),
(10, 1, 200, 500.00);
