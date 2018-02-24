CREATE TABLE cliente(
id_cliente INTEGER,
nombre VARCHAR2(50),
apaterno VARCHAR2(50),
amaterno VARCHAR2(50),
sueldo FLOAT,
id_direccion INTEGER,
CONSTRAINT pk_cliente PRIMARY KEY(nombre,apaterno,amaterno),
CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
)

CREATE TABLE direccion(
id_direccion INTEGER,
municipio VARCHAR2(15),
cp INTEGER,
calle VARCHAR(30),
estado VARCHAR2(15),
colonia VARCHAR2(20),
CONSTRAINT pk_direccion PRIMARY KEY (id_direccion)
)

CREATE SEQUENCE sec_direccion
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE sec_cliente
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE OR REPLACE PROCEDURE guardar_direccion(
my_id_direccion OUT INTEGER, my_municipio IN VARCHAR2, my_cp IN INTEGER, my_calle IN VARCHAR2, my_estado IN VARCHAR2, my_colonia IN VARCHAR2)
AS 
BEGIN
SELECT sec_direccion.NEXTVAL INTO my_id_direccion FROM DUAL;
INSERT INTO direccion VALUES (my_id_direccion, my_municipio, my_cp, my_calle, my_estado, my_colonia);
END;

CREATE OR REPLACE PROCEDURE guardar_cliente(
my_id_cliente OUT INTEGER,my_nombre IN VARCHAR2,my_apaterno IN VARCHAR2,my_amaterno IN VARCHAR2,my_sueldo IN FLOAT,my_id_direccion IN INTEGER)
AS
BEGIN
SELECT sec_cliente.NEXTVAL INTO my_id_cliente FROM DUAL;
INSERT INTO cliente VALUES (my_id_cliente,my_nombre,my_apaterno,my_amaterno,my_sueldo,my_id_direccion);
END;

CREATE OR REPLACE PROCEDURE guardar_client_dir(
my_id_cliente OUT INTEGER,my_id_direccion OUT INTEGER,my_municipio IN VARCHAR,my_cp IN INTEGER,my_calle IN VARCHAR2,my_estado IN VARCHAR2,my_colonia IN VARCHAR2,
my_nombre IN VARCHAR2,my_apaterno IN VARCHAR2,my_amaterno IN VARCHAR2,my_sueldo IN FLOAT)
AS 
BEGIN
guardar_direccion(my_id_direccion,my_municipio,my_cp,my_calle,my_estado,my_colonia);
guardar_cliente(my_id_cliente,my_nombre,my_apaterno,my_amaterno,my_sueldo,my_id_direccion);
END;
/

DECLARE
valor1 INTEGER;
valor2 INTEGER;
BEGIN
guardar_client_dir(valor1,valor2,'bosques de guinea','nezahualcoyotl',57170,'bosques de aragon','mexico','bosques de aragon','carlos','almeida','salmeron',3000,valor2);
END;
/

SELECT cliente.nombre, direccion.calle
FROM cliente, direccion
WHERE
cliente.id_direccion=direccion.id_direccion;