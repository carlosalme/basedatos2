--GENERAMOS LA PRIMER TABLA
CREATE TABLE almacen(
numero_almacen INTEGER,
ubicacion_almacen VARCHAR2(50),
constraint PK_NUM_ALM PRIMARY KEY (numero_almacen)
);

/*SE USAN PROCEDIMIENTOS ALMACENAS PARA:
ISERTAR
ACTUALIZAR 
ELIMINAR */

--PROCEDIMINEOT PARA INSERTAR EN ALMACEN
CREATE OR REPLACE PROCEDURE guardar_almacen(my_num_alm IN INTEGER, my_ubic_alm IN VARCHAR2)
AS
BEGIN
--cuerpo o logica del procedimiento
INSERT INTO almacen VALUES(my_num_alm, my_ubic_alm);
END;
/

/*USAREMOS UN BLOQUE PL SQL PARA PROBAR SI ESTA BIEN NUESTRO PROCEDIMINETO*/
BEGIN 
guardar_almacen(321,'ECATEPEC');
end;
/

SELECT * FROM almacen;

CREATE TABLE cliente(
numero_cliente integer,
numero_almacen integer,
nombre_cliente varchar2(60),
CONSTRAINT PK_clin PRIMARY KEY (numero_cliente),
CONSTRAINT FK_alma FOREIGN KEY (numero_almacen) REFERENCES almacen (numero_almacen)
);

CREATE TABLE vendedor(
numero_vendedor INTEGER,
nombre_vendedor VARCHAR2(80),
area_ventas VARCHAR2(80),
CONSTRAINT PK_vendedor PRIMARY KEY (numero_vendedor)
);

CREATE TABLE ventas(
id_ventas INTEGER,
numero_vendedor INTEGER,
numero_cliente INTEGER,
monto_venta FLOAT,
CONSTRAINT PK_ventas PRIMARY KEY (id_ventas),
CONSTRAINT FK1_venta_vendedor FOREIGN KEY (numero_vendedor) REFERENCES vendedor(numero_vendedor),
CONSTRAINT FK2_venta_cliente FOREIGN KEY (numero_cliente) REFERENCES cliente(numero_cliente)
);


--procedimiento para cliente

--procedimineto para vendedor


--ejemplo de una tabla y su procedimineto almacenado para guardar con 
--pk impuesto o artificial
CREATE TABLE calificaciones(
id_calificacion INTEGER,
materia VARCHAR2(80),
valor FLOAT,
CONSTRAINT PK_calificaciones PRIMARY KEY (id_calificacion)
);

--generamos una secuencia
CREATE SEQUENCE sec_calificaciones 
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

--AQUI YA VIENE EL PROCEDIMIENTO 
CREATE OR REPLACE PROCEDURE guardar_calificaciones(
my_id_calif OUT INTEGER, my_materia IN VARCHAR2, my_valor IN FLOAT)
AS
BEGIN
SELECT sec_calificaciones.NEXTVAL INTO my_id_calif FROM DUAL;
INSERT INTO calificaciones VALUES(my_id_calif, my_materia, my_valor);
END;
/