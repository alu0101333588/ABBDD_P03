# ABBDD_P03
Práctica 03 - Administración de Bases de Datos
Realizada por Andrés Hernández Ortega y Luka Kravarusic Sljapic


## Tablas del Modelo Relacional


**Vivero**(id, nombre, latitud, longitud, municipio, provincia)  
- **id**: PRIMARY KEY  

**Zona**(nombre, tipo, latitud, longitud, productividad, id_vivero)  
- **id_vivero**: FOREIGN KEY de `Vivero(id)`  
- **(nombre, tipo)**: PRIMARY KEY

**Producto**(id, nombre, tipo, precio, cantidad_stock)  
- **id**: PRIMARY KEY  

**Empleado**(id, nombre, primer_apellido, segundo_apellido, productividad)  
- **id**: PRIMARY KEY  
- Se añadirá un **disparador** para calcular el valor de `productividad` en función de datos de otras tablas, impidiendo también que el usuario le asigne valores.

**Cliente_Tajinaste_Plus**(id, nombre, primer_apellido, segundo_apellido, bonificaciones, fecha_ingreso)  
- **id**: PRIMARY KEY  
- Se incluirá un **disparador** antes de la inserción para evitar que `fecha_ingreso` sea anterior a la fecha actual.

**Pedido**(numero_pedido, fecha, id_empleado, id_cliente_plus)  
- **(numero_pedido, fecha, id_empleado, id_cliente_plus)**: PRIMARY KEY  
- **id_empleado**: FOREIGN KEY de `Empleado(id)`  
- **id_cliente_plus**: FOREIGN KEY de `Cliente_Tajinaste_Plus(id)` (puede ser `NULL`)  

**Empleado_Zona**(id_empleado, epoca_ano, nombre_zona, tipo_zona)  
- **(id_empleado, epoca_ano, nombre_zona, tipo_zona)**: PRIMARY KEY  
- **id_empleado**: FOREIGN KEY de `Empleado(id)`  
- **nombre_zona**: FOREIGN KEY de `Zona(nombre)`  
- **tipo_zona**: FOREIGN KEY de `Zona(tipo)`  
- Se incluirá un **disparador** para evitar que un empleado trabaje en más de una zona durante una época del año.

**Producto_Pedido**(numero_pedido, id_producto, cantidad)  
- **(numero_pedido, id_producto)**: PRIMARY KEY  
- **numero_pedido**: FOREIGN KEY de `Pedido(numero_pedido)`  
- **id_producto**: FOREIGN KEY de `Producto(id)`  
- Se incluirá un **disparador** para evitar que se adquiera una cantidad de producto que exceda el stock disponible.

**Zona_Producto**(nombre_zona, tipo_zona, id_producto, cantidad)  
- **nombre_zona**: FOREIGN KEY de `Zona(nombre)`  
- **tipo_zona**: FOREIGN KEY de `Zona(tipo)`  
- **id_producto**: FOREIGN KEY de `Producto(id)`  
