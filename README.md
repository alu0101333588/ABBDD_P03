# ABBDD_P03
Práctica 03 - Administración de Bases de Datos
Realizada por Andrés Hernández Ortega y Luka Kravarusic Sljapic



ZONA(<u>nombre</u>, <u>tipo</u>, latitud, longitud, productividad, id_vivero)
id_vivero: FOREIGN KEY de VIVERO(id)

VIVERO(<u>id</u>, nombre, latitud, longitud, municipio, provincia)



PRODUCTO(<u>id</u>, nombre, tipo, precio)



EMPLEADO(<u>id</u>, nombre, primer_apellido, segundo_apellido, productividad)



CLIENTE_TAJINASTE_PLUS(<u>id</u>, nombre, primer_apellido,segundo_apellido, bonificaciones, fecha_ingreso)


PEDIDO(<u>numero_pedido</u>, fecha, id_empleado, id_cliente_plus)
id_empleado: FOREIGN KEY de EMPLEADO(id)
id_cliente_plus: FOREIGN KEY de CLIENTE_TAJINASTE_PLUS(id)
id_cliente_plus puede ser NULL



EMPLEADO_ZONA(<u>id_empleado</u>, <u>epoca_ano</u>, <u>nombre_zona</u>, <u>tipo_zona</u>)
id_empleado: FOREIGN KEY de EMPLEADO(id)
nombre_zona: FOREIGN KEY de ZONA(nombre)
tipo_zona: FOREIGN KEY de ZONA(tipo)
Se tendría que incluir un disparador para evitar que un empleado durante una época del año pueda trabajar en más de una zona de trabajo



PRODUCTO_PEDIDO(<u>numero_pedido</u>, <u>id_producto</u>, cantidad)
numero_pedido: FOREIGN KEY de PEDIDO(numero_pedido)
id_producto: FOREIGN KEY de PRODUCTO(id)


ZONA_PRODUCTO(<u>nombre_zona</u>, <u>tipo_zona</u>, <u>id_producto</u>, cantidad)
nombre_zona: FOREIGN KEY de ZONA(nombre)
tipo_zona: FOREIGN KEY de ZONA(tipo)
id_producto: FOREIGN KEY de PRODUCTO(id)
