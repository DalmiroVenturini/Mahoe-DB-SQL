#####################################
###     Mahoe marketing team      ###
#####################################


-- Somos del departamento de marketing de la Cervecera Mahoe y nos han pedido realizar una campaña de publicidad
-- con los productos mas vendidos dependiendo la localidad seleccionada.

use mahoedb;

-- Revisamos la base de datos
show tables;

-- Cual es el producto mas caro? R= Mahou Barril 5L	10.00
SELECT nombre_producto, precio
FROM productos
ORDER BY precio DESC
LIMIT 1;

-- Cual es el producto mas barato? R= Mahou 200ml	1.00
SELECT nombre_producto, precio
FROM productos
ORDER BY precio 
LIMIT 1;

-- Cantidad de cada producto?
SELECT p.nombre_producto, SUM(i.cantidad) AS total_cantidad
FROM productos p
JOIN inventario i ON p.producto_id = i.producto_id
GROUP BY p.producto_id, p.nombre_producto;

-- Cantidad de pedidos del ultimo mes?
SELECT COUNT(*) AS cantidad_pedidos
FROM pedidos
WHERE fecha_pedido >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Cuantos empleados tengo? R=16
SELECT COUNT(EMPLEADO_ID)
FROM EMPLEADOS;

-- Número de pedidos por empleado R= Carlos	Sánchez	con 3 pedidos
SELECT e.nombre, e.apellido, COUNT(p.pedido_id) AS numero_pedidos
FROM empleados e
LEFT JOIN pedidos p ON e.empleado_id = p.empleado_id
GROUP BY e.empleado_id, e.nombre, e.apellido
ORDER BY numero_pedidos DESC;

-- Precio unitario de los productos vendidos R= Mahou 1000ml
SELECT p.nombre_producto,dp.cantidad,dp.precio_total, round((dp.precio_total /  dp.cantidad),2) AS precio_unitario
FROM detalle_pedidos as dp
join productos as p
on dp.producto_id = p.producto_id
group by p.nombre_producto,dp.cantidad,dp.precio_total
order by precio_unitario desc;

-- Pedido de mayor cantidad 
select *
from detalle_pedidos
order by cantidad 
limit 1;

-- -Pedido de mayor importe
select *
from detalle_pedidos
order by precio_total 
limit 1;

-- Empleado con MENOR sueldo  R= Maria	Perez	Vendedor	30000.00
select *
from empleados
order by salario 
limit 1;

-- Empleado con MAYOR sueldo R= Isabel	Gutiérrez	Gerente	52000.00	2015-09-15
select *
from empleados
order by salario desc 
limit 1;

-- Empleados con salario superior al promedio
SELECT nombre, 
       apellido, 
       salario
FROM empleados
WHERE salario > (
    SELECT AVG(salario) 
    FROM empleados
);
-- Cantidad total de productos vendidos por empleado:
SELECT concat(e.nombre,' ',e.apellido) as nombre, SUM(dp.cantidad) AS productos_vendidos
FROM empleados  as e
left JOIN pedidos as p 
ON e.empleado_id = p.empleado_id
left JOIN detalle_pedidos as dp 
ON p.pedido_id = dp.pedido_id
GROUP BY e.empleado_id
ORDER BY productos_vendidos DESC;

-- Suma total de ventas por cada cliente R= Vinos y Licores El Sol	5000.00
SELECT c.nombre_cliente, SUM(dp.precio_total) AS total_ventas
FROM clientes c
JOIN pedidos p ON c.cliente_id = p.cliente_id
JOIN detalle_pedidos dp ON p.pedido_id = dp.pedido_id
GROUP BY c.nombre_cliente
ORDER BY total_ventas DESC;


-- Clientes con un gasto total mayor a 1000:
SELECT c.nombre_cliente, SUM(dp.precio_total) AS gasto_total
FROM clientes c
JOIN pedidos p ON c.cliente_id = p.cliente_id
JOIN detalle_pedidos dp ON p.pedido_id = dp.pedido_id
GROUP BY c.nombre_cliente
HAVING gasto_total > 1000
ORDER BY gasto_total DESC;

-- En que localidad tenemos los clientes que mas compran R= Madrid
select c.ciudad, sum(precio_total) as importe_total
from clientes as c
join pedidos as p
on c.cliente_id = p.cliente_id
join detalle_pedidos as dp
on dp.pedido_id= p.pedido_id
group by c.ciudad
order by importe_total desc
limit 1;

-- Nombre de cliente y de producto donde el importe del pedido es mayor al promedio de los importes de los pedidos
SELECT c.nombre_cliente, p.nombre_producto
FROM clientes as c
JOIN pedidos as ped
ON c.cliente_id = ped.cliente_id
JOIN detalle_pedidos dp 
ON ped.pedido_id = dp.pedido_id
JOIN productos p 
ON dp.producto_id = p.producto_id
WHERE dp.precio_total > (
    SELECT AVG(dp.precio_total)
    FROM detalle_pedidos dp
)
ORDER BY c.nombre_cliente;

-- Clientes que realizaron pedidos gestionados por gerentes
SELECT nombre_cliente 
FROM clientes
WHERE cliente_id IN (
    SELECT p.cliente_id 
    FROM pedidos p
    WHERE p.empleado_id IN (
        SELECT empleado_id 
        FROM empleados 
        WHERE cargo = 'Gerente'
    )
);

-- Conclusion: Haremos la campaña de publicidad en Madrid con la cerveza Mahou 1000ml porque es la cerveza que mas se compra y 
-- y es nuestro producto mas caro con un precio de 12.50 euros. Tambien consideramos que podemos darle un regalo a nuestro cliente
--  Vinos y Licores El Sol que es el cliente que siempre gasta mas que el promedio en sus pedidos.