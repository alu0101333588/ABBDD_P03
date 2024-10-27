# ABBDD_P03
Práctica 03 - Administración de Bases de Datos
Realizada por Andrés Hernández Ortega y Luka Kravarusic Sljapic

Proyecto Draw.io: https://drive.google.com/file/d/17MgRfRyU7QS2GPIPZw6tTKoTyzIJD5LS/view?usp=sharing


## Modelo entidad-relación
![Modelo entidad-relación](/Viveros.drawio.png "ER Model")


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
- **(nombre_zona, tipo_zona, id_producto)**: PRIMARY KEY
- **nombre_zona**: FOREIGN KEY de `Zona(nombre)`  
- **tipo_zona**: FOREIGN KEY de `Zona(tipo)`  
- **id_producto**: FOREIGN KEY de `Producto(id)`  


## Restricciones

- En la tabla Zona, si eliminamos un vivero, también eliminamos las zonas asociadas al mismo
    - ``` FOREIGN KEY (id_vivero) REFERENCES Vivero(id) ON DELETE CASCADE ```

- En la tabla pedido, queremos guardar todo el historial de pedidos realizados, aunque se dé de baja algún cliente en el programa de fidelización o algún empleado que lo gestione se elimine
    - ```FOREIGN KEY (id_empleado) REFERENCES Empleado(id) ON DELETE SET NULL```
    - ```FOREIGN KEY (id_cliente_plus) REFERENCES ClienteTajinastePlus(id) ON DELETE SET NULL ```

- En la tabla EmpleadoZona, si se elimina un empleado o una zona, también eliminamos las entradas correspondientes en la relación entre Empleado y Zona
    - ```FOREIGN KEY (id_empleado) REFERENCES Empleado(id) ON DELETE CASCADE```
    - ```FOREIGN KEY (nombre_zona, tipo_zona) REFERENCES Zona(nombre, tipo) ON DELETE CASCADE```

- En la tabla ProductoPedido, en caso de que se quiera eliminar algún pedido, lo eliminamos también en la relación entre Producto y Pedido. Si se elimina un producto, no dejamos realizar la eliminación para querer mantener el historial de los pedidos de dicho producto
    - ```FOREIGN KEY (numero_pedido) REFERENCES Pedido(numero_pedido) ON DELETE CASCADE```
    - ```FOREIGN KEY (id_producto) REFERENCES Producto(id) ON DELETE RESTRICT```

- En la tabla ZonaProducto, si eliminamos una zona, también eliminamos los productos en la relación entre Zona y Producto. Si queremos eliminar un producto no lo permitimos, y en caso de querer eliminar un producto de una zona, la eliminamos directamente en la relación entre Zona y Producto, esto es en la tabla ZonaProducto
    - ```FOREIGN KEY (nombre_zona, tipo_zona) REFERENCES Zona(nombre, tipo) ON DELETE CASCADE```
    - ```FOREIGN KEY (id_producto) REFERENCES Producto(id) ON DELETE RESTRICT```
