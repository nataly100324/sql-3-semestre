--yuberli miranda
--lucia puma

-----------------------------

CREATE TABLE generos (
id_genero NUMBER PRIMARY KEY,
nombre_genero varchar2(15) UNIQUE NOT NULL,
sigla VARCHAR2 (2) UNIQUE,
orden NUMBER,
estado char(1)
);

CREATE SEQUENCE seq_generos
START WITH 1
INCREMENT BY 1
NOCACHE;

----------------------------------------
--TIPO DOCUMEDROP TABLENTO
CREATE TABLE tipo_documento (
id_tipo_documento NUMBER PRIMARY KEY,
nombre  varchar2(150) UNIQUE NOT NULL,
sigla VARCHAR2 (5) UNIQUE,
pais VARCHAR2 (50),
cantidad_digitos NUMBER,
orden NUMBER,
estado char(1)
);
CREATE SEQUENCE seq_tipo_documento
START WITH 1
INCREMENT BY 1
NOCACHE;

----------------------------------------
--TABLA PERSONA
CREATE TABLE personas(
id_persona NUMBER PRIMARY KEY,
id_tipo_documento NUMBER,
id_genero NUMBER,
nombres varchar2(100) NOT NULL,
apellido_paterno VARCHAR2 (50) NOT NULL,
apellido_materno VARCHAR2 (50) NOT NULL,
fecha_nacimiento DATE,
celular NUMBER NOT NULL,
numero_documento NUMBER UNIQUE NOT NULL,
correo VARCHAR2 (150) UNIQUE,
estado char (1),

CONSTRAINT fk_tipo_documentos_personas 
FOREIGN KEY (id_tipo_documento) 
REFERENCES tipo_documento (id_tipo_documento),

CONSTRAINT fk_generos_personas
FOREIGN KEY (id_genero)
REFERENCES generos (id_genero)

);
CREATE SEQUENCE seq_personas
START WITH 1
INCREMENT BY 1
NOCACHE;

---------------------------------------
CREATE TABLE cliente (
id_cliente NUMBER PRIMARY KEY,
id_persona NUMBER UNIQUE,
direccion VARCHAR2(50),
fecha_registro DATE,

CONSTRAINT fk_personas_clientes
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona)
);

CREATE SEQUENCE seq_cliente
START WITH 1
INCREMENT BY 1
NOCACHE;

--------------------------

CREATE TABLE personal(
id_personal NUMBER PRIMARY KEY,
id_persona NUMBER UNIQUE,
id_venta NUMBER ,
direccion VARCHAR2(50),
cargo varchar2 (100) NOT NULL,
sueldo NUMBER (10,2) NOT NULL,
estado char(1),
fecha_inicio_contrato date,
fecha_fin_contrato DATE,

CONSTRAINT fk_personas_personal
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona)

);
CREATE SEQUENCE seq_personal
START WITH 1
INCREMENT BY 1
NOCACHE;

--------------------------------
CREATE TABLE tipo_pago(
id_tipo_pago NUMBER PRIMARY KEY,
nombre VARCHAR2 (20),
estado char(1),
orden NUMBER
);
--------------------------
CREATE TABLE dato_envio_cliente (
id_dato_envio_cliente NUMBER PRIMARY KEY,
estado char(1),
fecha_envio DATE,
fecha_entrega DATE,
tipo_envio VARCHAR2 (20),
costo_envio NUMBER (5,2),
direccion VARCHAR2(50),
ubicacion VARCHAR2 (30)
);
CREATE SEQUENCE seq_dato_envio_cliente
START WITH 1
INCREMENT BY 1
NOCACHE;


-------------------------

CREATE TABLE tienda(
id_tienda NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
ubicacion VARCHAR2 (30),
telefono NUMBER (9),
estado char(1)

);
CREATE SEQUENCE seq_tienda
START WITH 1
INCREMENT BY 1
NOCACHE;

----------------------------------
CREATE TABLE tipo_comprobante(
id_tipo_comprobante NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
descripcion VARCHAR2 (100),
fecha_emision DATE,
monto NUMBER (10,2),
comision NUMBER (5)

);
CREATE SEQUENCE seq_tipo_comprobante
START WITH 1
INCREMENT BY 1
NOCACHE;

------------------------------
CREATE TABLE carrito_detalle(
id_carrito_detalle NUMBER PRIMARY KEY,
id_producto NUMBER (5),
id_venta NUMBER (5),
cantidad NUMBER (5),

CONSTRAINT fk_venta_carrito_detalle
FOREIGN KEY (id_venta)
REFERENCES venta (id_venta),

CONSTRAINT fk_producto_carrito_detalle
FOREIGN KEY (id_producto)
REFERENCES producto (id_producto)
);
CREATE SEQUENCE seq_carrito_detalle
START WITH 1
INCREMENT BY 1
NOCACHE;

------------------------------------------
CREATE TABLE producto(
id_producto NUMBER PRIMARY KEY,
id_proveedor NUMBER,
id_promocion NUMBER,
nombre VARCHAR2 (20),
descripcion VARCHAR2(100),
precio NUMBER (10),
cantidad NUMBER (5),
echa_creacion DATE,
marca VARCHAR2 (20),


CONSTRAINT fk_proveedor_producto
FOREIGN KEY (id_proveedor)
REFERENCES proveedor (id_proveedor),

CONSTRAINT fk_promocion_producto
FOREIGN KEY (id_promocion)
REFERENCES promocion (id_promocion)
);
CREATE SEQUENCE seq_producto
START WITH 1
INCREMENT BY 1
NOCACHE;

------------------------------------------
CREATE TABLE marca(
id_marca NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
estado char(1)

);
CREATE SEQUENCE seq_marca
START WITH 1
INCREMENT BY 1
NOCACHE;


------------------------------------------
CREATE TABLE proveedor(
id_proveedor NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
telefono NUMBER (9),
correo VARCHAR2 (20),
direccion VARCHAR2(50),
estado char(1)
);
CREATE SEQUENCE seq_proveedor
START WITH 1
INCREMENT BY 1
NOCACHE;

-------------------------------------------
CREATE TABLE promocion(
id_promocion NUMBER PRIMARY KEY,
descripcion VARCHAR2 (100),
descuernto NUMBER (20),
fecha_inicio DATE,
fecha_fin DATE
);
CREATE SEQUENCE seq_promocion
START WITH 1
INCREMENT BY 1
NOCACHE;
--------------------------------------------
CREATE TABLE reembolso_detalle(
id_reembolso_detalle NUMBER PRIMARY KEY,
id_reembolso NUMBER,
id_carrito_detalle NUMBER,

CONSTRAINT fk_reembolso_reembolso_detalle
FOREIGN KEY (id_reembolso)
REFERENCES reembolso (id_reembolso),

CONSTRAINT fk_carrito_detalle_reembolso_detalle
FOREIGN KEY (id_carrito_detalle)
REFERENCES carrito_detalle (id_carrito_detalle)

);
------------------------------------
CREATE TABLE reembolso(
id_reembolso NUMBER PRIMARY KEY,
id_ticket_soporte NUMBER UNIQUE,
id_venta NUMBER UNIQUE,
precio NUMBER,
fecha_reembolso DATE,

CONSTRAINT fk_ticket_soporte_reembolso
FOREIGN KEY (id_ticket_soporte)
REFERENCES ticket_soporte (id_ticket_soporte),

CONSTRAINT fk_venta_reembolso
FOREIGN KEY (id_venta)
REFERENCES venta (id_venta)

);
--------------------------
CREATE TABLE ticket_soporte(
id_ticket_soporte NUMBER PRIMARY KEY,
id_requisitos NUMBER,
fecha_creacion DATE,
descripcion VARCHAR2 (100),
estado char(1),

CONSTRAINT fk_requisitos_ticket_soporte
FOREIGN KEY (id_requisitos)
REFERENCES requisitos (id_requisitos)

);
------------------
CREATE TABLE requisitos(
id_requisitos NUMBER PRIMARY KEY,
descripcion VARCHAR2 (100),
estado char(1)
);

-------------------------------

CREATE TABLE venta(
id_venta NUMBER PRIMARY KEY,
id_cliente NUMBER,
id_tienda NUMBER ,
id_tipo_pago NUMBER,
id_tipo_comprobante NUMBER,
id_personal NUMBER UNIQUE,
id_dato_envio_cliente NUMBER,
fecha_venta DATE,
estado char(1),

CONSTRAINT fk_cliente_venta
FOREIGN KEY (id_cliente)
REFERENCES cliente (id_cliente),

CONSTRAINT fk_tienda_venta
FOREIGN KEY (id_tienda)
REFERENCES tienda (id_tienda),

CONSTRAINT fk_tipo_pago_venta
FOREIGN KEY (id_tipo_pago)
REFERENCES tipo_pago (id_tipo_pago),

CONSTRAINT fk_tipo_comprobante_venta
FOREIGN KEY (id_tipo_comprobante)
REFERENCES tipo_comprobante (id_tipo_comprobante),

CONSTRAINT fk_personal_venta
FOREIGN KEY (id_personal)
REFERENCES personal (id_personal),

CONSTRAINT fk_dato_envio_cliente_venta
FOREIGN KEY (id_dato_envio_cliente)
REFERENCES dato_envio_cliente (id_dato_envio_cliente)
);

ALTER TABLE VENTA 
DROP CONSTRAINT SYS_C008512;

ALTER TABLE venta ADD igv NUMBER(10,2);
ALTER TABLE venta ADD total NUMBER(10,2);

ALTER TABLE producto ADD id_marca NUMBER;
ALTER TABLE producto ADD CONSTRAINT fk_marca_producto
FOREIGN KEY (id_marca)
REFERENCES marca (id_marca);

ALTER TABLE PRODUCTO DROP COLUMN  marca;

ALTER TABLE venta ADD id_usuario_registro NUMBER;
ALTER TABLE venta ADD id_usuario_actualiza NUMBER;
ALTER TABLE venta ADD fecha_registro DATE;
ALTER TABLE venta ADD fecha_actualiza DATE;



ALTER TABLE personas ADD id_usuario_registro NUMBER;
ALTER TABLE personas ADD id_usuario_actualiza NUMBER;
ALTER TABLE personas ADD fecha_registro DATE;
ALTER TABLE personas ADD fecha_actualiza DATE;


ALTER TABLE personal ADD id_usuario_registro NUMBER;
ALTER TABLE personal ADD id_usuario_actualiza NUMBER;
ALTER TABLE personal ADD fecha_registro DATE;
ALTER TABLE personal ADD fecha_actualiza DATE;


ALTER TABLE carrito_detalle ADD id_usuario_registro NUMBER;
ALTER TABLE carrito_detalle ADD id_usuario_actualiza NUMBER;
ALTER TABLE carrito_detalle ADD fecha_registro DATE;
ALTER TABLE carrito_detalle ADD fecha_actualiza DATE;

-----------------------------
CREATE OR REPLACE TRIGGER trg_registrar_fechas_personal
BEFORE INSERT OR UPDATE ON personal
FOR EACH ROW
BEGIN
  -- Al insertar, registra la fecha de registro
  IF INSERTING THEN
    :new.fecha_inicio_contrato := SYSDATE;
  END IF;

  -- Al actualizar, registra la fecha de actualización
  IF INSERTING THEN
    :new.fecha_fin_contrato := SYSDATE;
  END IF;
END;

---------------------------------------------
CREATE OR REPLACE TRIGGER trg_orden_generos
BEFORE INSERT OR UPDATE ON generos
FOR EACH ROW
BEGIN
 
    -- Asigna el valor de la secuencia al campo 'orden' si no se ha asignado previamente
    IF :new.orden IS NULL THEN
      :new.orden := seq_generos.NEXTVAL;
    END IF;
  END ;

---------------------------------

 
CREATE OR REPLACE TRIGGER trg_pais_tipo_documento
BEFORE INSERT OR UPDATE ON tipo_documento
FOR EACH ROW
BEGIN
  -- Al insertar, registra la fecha de registro
  IF INSERTING THEN
    :new.pais :=   CASE round (dbms_random.value (1,4)) 
                   WHEN 1 THEN 'peru'
                   WHEN 2 THEN 'Argentina'
                   WHEN 3 THEN 'Bolivia'
                   WHEN 4 THEN 'Chile'
                   END;
  END IF;

  -- Asigna el valor de la secuencia al campo 'orden' si no se ha asignado previamente
    IF :new.orden IS NULL THEN
      :new.orden := seq_tipo_documento.NEXTVAL;
    END IF;
  END ;


---------------------------------------------------

CREATE OR REPLACE TRIGGER trg_apellidos_personas
BEFORE INSERT OR UPDATE ON personas
FOR EACH ROW
BEGIN
  
  IF INSERTING THEN
    :new.apellido_paterno := CASE round (dbms_random.value (1,10)) 
                   WHEN 1 THEN 'lipa'
                   WHEN 2 THEN 'mendez'
                   WHEN 3 THEN 'cruz'
                   WHEN 4 THEN 'machaca'
                    WHEN 5 THEN 'peña'
                   WHEN 6 THEN 'laura'
                   WHEN 7THEN 'mendoza'
                   WHEN 8 THEN 'espinoza'
                   WHEN 9 THEN 'bautista'
                   WHEN 10 THEN 'riveera'
                   END;
  END IF;

  
  IF INSERTING THEN
    :new.apellido_materno := CASE round (dbms_random.value (1,10)) 
                   WHEN 1 THEN 'garcia'
                   WHEN 2 THEN 'rodrigues'
                   WHEN 3 THEN 'gomes'
                   WHEN 4 THEN 'cutipa'
                    WHEN 5 THEN 'lipa'
                   WHEN 6 THEN 'laura'
                   WHEN 7 THEN 'perez'
                   WHEN 8 THEN 'machaca'
                   WHEN 9 THEN 'bautista'
                   WHEN 10 THEN 'ramos'
                   END;  
  END IF;


END;

---------------------------------------------------------------------
--CLIENTES
CREATE OR REPLACE TRIGGER trg_registrar_fechas_cliente
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
BEGIN
  -- Al insertar, registra la fecha de registro
  IF INSERTING THEN
    :new.fecha_registro   := SYSDATE;
  END IF;

  -- Al actualizar, registra la fecha de actualización
  IF INSERTING THEN
    :new.id_cliente := seq_cliente.NEXTVAL;
  END IF;
END;

-----------------------------------------------

--tipo_pago

CREATE OR REPLACE TRIGGER trg_orden_tipo_pago
BEFORE INSERT OR UPDATE ON tipo_pago
FOR EACH ROW
BEGIN
 
    -- Asigna el valor de la secuencia al campo 'orden' si no se ha asignado previamente
    IF INSERTING THEN
      :new.orden := seq_tipo_pago1.NEXTVAL;
    END IF;
  
 IF INSERTING THEN
    :new.id_tipo_pago := seq_tipo_pago.NEXTVAL;
  END IF;
END;
ALTER SEQUENCE seq_tipo_pago1
RESTART START WITH 1;
-----------------------------------------------------------
--dato_envio_cliente

CREATE OR REPLACE TRIGGER trg_registrar_fechas_dato_envio_cliente
BEFORE INSERT OR UPDATE ON dato_envio_cliente
FOR EACH ROW
BEGIN
  -- Al insertar, registra la fecha de registro
  IF INSERTING THEN
    :new.fecha_envio := SYSDATE;
  END IF;

  -- Al actualizar, registra la fecha de actualización
  IF INSERTING THEN
    :new.fecha_entrega := SYSDATE;
  END IF;
 IF INSERTING THEN
    :new.id_dato_envio_cliente:= seq_dato_envio_cliente.NEXTVAL;
  END IF;
END;

----------------------------------------------------
--tienda

CREATE OR REPLACE TRIGGER trg_nombre_tienda
BEFORE INSERT OR UPDATE ON tienda
FOR EACH ROW
BEGIN
  -- Al insertar, registra la fecha de registro
  IF INSERTING THEN
    :new.nombre   := 'shopify pos';
  END IF;

  -- Al actualizar, registra la fecha de actualización
  IF INSERTING THEN
    :new.ubicacion := 'av.los pensamientos';
  END IF;
 IF INSERTING THEN
    :new.telefono := 958742166 ;
  END IF;
 IF INSERTING THEN
    :new.id_tienda := seq_tienda.NEXTVAL ;
  END IF;
END;


----------------------------------
--PRODUCTO

CREATE OR REPLACE TRIGGER trg_nombre_producto
BEFORE INSERT OR UPDATE ON producto
FOR EACH ROW
BEGIN
 
	IF INSERTING THEN
    :new.nombre := CASE round (dbms_random.value (1,10)) 
                   WHEN 1 THEN 'gjzr'
                   WHEN 2 THEN 'hjzt'
                   WHEN 3 THEN 'th'
                   WHEN 4 THEN 'tdh'
                    WHEN 5 THEN 'thr'
                   WHEN 6 THEN 'th'
                   WHEN 7THEN 'ryh'
                   WHEN 8 THEN 'edrth'
                   WHEN 9 THEN 'rwyhrh'
                   WHEN 10 THEN 'wshywsr'
                   END;
  END IF;
    
   
  IF INSERTING THEN
    :new.id_promocion := CASE round (dbms_random.value (1,2)) 
                   WHEN 1 THEN '1'
                   WHEN 2 THEN '2'
                  END;
  END IF;
 
  IF INSERTING THEN
    :new.id_producto := seq_producto.NEXTVAL ;
  END IF;
END;


------------------------------------------
--PROMOCION

CREATE OR REPLACE TRIGGER trg_registrar_fechas_promocion
BEFORE INSERT OR UPDATE ON promocion
FOR EACH ROW
BEGIN
  -- Al insertar, registra la fecha de registro
  IF INSERTING THEN
    :new.fecha_inicio := SYSDATE;
  END IF;

  -- Al actualizar, registra la fecha de actualización
  IF INSERTING THEN
    :new.fecha_fin := SYSDATE;
  END IF;
 IF INSERTING THEN
    :new.id_promocion := seq_promocion.NEXTVAL ;
  END IF;
END;

-------------
--insert into para cada tabla

-- 1_Tabla generos
INSERT INTO generos (id_genero, nombre_genero, sigla, orden, estado) VALUES (4, 'Masculino3', 'M3', '1', 1);

-- 2_Tabla tipo_documento
INSERT INTO tipo_documento (id_tipo_documento, nombre, sigla, pais, cantidad_digitos, orden, estado) VALUES (5, 'Documento Nacional de Identidad2', 'DNI2', 'Perú', 8,' 5', 1);

-- 3-Tabla personas
INSERT INTO personas (id_persona, id_tipo_documento, id_genero, nombres, apellido_paterno, apellido_materno, fecha_nacimiento, celular, numero_documento, correo, estado) VALUES (11, 1, 1, 'Juan', 'Pérez', 'Gómez', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 987654321, 12345678, 'juan.perez@email.com', '1');

-- 4-Tabla cliente
INSERT INTO cliente (id_cliente, id_persona, direccion, fecha_registro) VALUES (11, 11, 'Av. Principal 123', TO_DATE('2023-01-10', 'YYYY-MM-DD'));

-- 5-Tabla personal
INSERT INTO personal (id_personal, id_persona, id_venta, direccion, cargo, sueldo, estado, fecha_inicio_contrato, fecha_fin_contrato) VALUES (6, 11, 1, 'Jr. Libertad 789', 'Vendedor', 1500.00, '1', TO_DATE('2022-07-01', 'YYYY-MM-DD'), NULL);

-- 6_Tabla tipo_pago
INSERT INTO tipo_pago (id_tipo_pago, nombre, estado, orden) VALUES (5, 'transferencia', '1', 5);

-- 7_Tabla dato_envio_cliente
INSERT INTO dato_envio_cliente (id_dato_envio_cliente, estado, fecha_envio, fecha_entrega, tipo_envio, costo_envio, direccion, ubicacion) VALUES (4, '1', TO_DATE('2025-04-09', 'YYYY-MM-DD'), TO_DATE('2025-04-14', 'YYYY-MM-DD'), 'Estándar', 15.00, 'Av. Los Incas 321', 'Puno');


--8_ Tabla tipo_comprobante
INSERT INTO tipo_comprobante (id_tipo_comprobante, nombre, descripcion, fecha_emision, monto, comision) VALUES (2, 'Boleta de Venta', 'Comprobante simple', TO_DATE('2025-04-08', 'YYYY-MM-DD'), 50.00, 1);

--9_ Tabla producto
INSERT INTO producto (id_producto, id_proveedor, id_promocion, nombre, descripcion, precio, cantidad, echa_creacion, id_marca) VALUES (16, 1, 1, 'Camiseta Algodón1', 'Camiseta de algodón suave1', 20, 10, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 1);

--10_ Tabla marca
INSERT INTO marca (id_marca, nombre, estado) VALUES (6, 'Nike', '1');


SELECT * FROM  TIPO_PAGO tp 

--------------------------------------------
--UDATE ACTUALIZA UNA TABLA
UPDATE GENEROS 
SET NOMBRE_GENERO = 'masculino10'
WHERE ID_GENERO = 4;
-----------------------------------------
UPDATE TIPO_DOCUMENTO  
SET SIGLA = 'BOL'
WHERE ID_TIPO_DOCUMENTO  = 4;

SELECT * FROM TIPO_DOCUMENTO td 

-----------------------------------
UPDATE PERSONAS  
SET NOMBRES = 'masculino10'
WHERE ID_PERSONA  = 4;
---------------------------
UPDATE CLIENTE  
SET DIRECCION  = 'masculino10'
WHERE ID_CLIENTE  = 4;
------------------------------------
UPDATE PERSONAL  
SET DIRECCION  = 'masculino10'
WHERE ID_PERSONAL  = 4;
----------------------------
UPDATE TIPO_PAGO  
SET NOMBRE = 'masculino10'
WHERE ID_TIPO_PAGO  = 4;
---------------------------
UPDATE DATO_ENVIO_CLIENTE  
SET DIRECCION = 'masculino10'
WHERE ID_DATO_ENVIO_CLIENTE  = 4;
------------------------------------
--7 DELETE 

DELETE FROM GENEROS g  
WHERE ID_GENERO = 4;
-------------------------------
DELETE FROM TIPO_DOCUMENTO td  
WHERE ID_TIPO_DOCUMENTO = 5;

SELECT * FROM TIPO_DOCUMENTO td 
----------------------------
DELETE FROM PERSONAS p  
WHERE ID_PERSONA = 4;
--------------------------
DELETE FROM CLIENTE c  
WHERE ID_CLIENTE = 4;
---------------------
DELETE FROM PERSONAL p  
WHERE ID_PERSONAL = 4;
------------------
DELETE FROM TIPO_PAGO tp  
WHERE ID_TIPO_PAGO = 4;
------------------
DELETE FROM DATO_ENVIO_CLIENTE dec2  
WHERE ID_DATO_ENVIO_CLIENTE = 4;
----------------------

SELECT * FROM CLIENTE c ;
INNER JOIN PERSONAS p 
ON c.ID_PERSONA = p.ID_PERSONA


--CREANDO UNA FUNCION EN ORACLE 

   CREATE FUNCTION FN_PERSONA_NOMBRE_COMPLETO(p_id_persona IN INTEGER)
RETURN VARCHAR2 IS
	v_nombre_completo VARCHAR2(150);
BEGIN
	SELECT 
	UPPER(p.NOMBRES)||','||' '|| 
	INITCAP(p.APELLIDO_PATERNO)||' '|| 
	TRIM(INITCAP(LOWER(p.APELLIDO_MATERNO))) INTO v_nombre_completo 
	FROM PERSONAS p 
	WHERE p.ID_PERSONA  = p_id_persona;
	
	RETURN v_nombre_completo;
END;

SELECT * FROM personas p;
SELECT * FROM PERSONAL p  ;
SELECT FN_PERSONA_NOMBRE_COMPLETO(id_persona)   
FROM CLIENTE c   ; 



------------------------------


SELECT * FROM CLIENTE c 
INNER JOIN PERSONAS p 
ON c.ID_PERSONA = p.ID_PERSONA
;
--------------------------------------------------------------
--unir con la tabla cliente y luego con la tabla persona
--REPORTE VENTAS
SELECT 
v.ID_VENTA ,
p.NOMBRES  AS nombre_cliente,
P.APELLIDO_MATERNO AS APELLIDO_MATERNO_CLIENTE,
P.CELULAR  AS CELULAR__CLIENTE,
P2.NOMBRE  AS NONBRE_PRODUCTO ,
P.CORREO AS CORREO_CLIENTE ,
V.FECHA_VENTA ,
V.ESTADO ,
V.TOTAL ,
T2.NOMBRE AS NOMBRE_TIENDA,
tc.NOMBRE AS NOMBRE_COMPROBANTE,
TP.NOMBRE AS NOMBRE_TIPO_PAGO,
CD.CANTIDAD AS CANTIDAD_PRODUCTO
FROM VENTA v 
INNER JOIN CLIENTE c 
ON C.ID_CLIENTE = V.ID_CLIENTE 
INNER JOIN PERSONAS p 
ON P.ID_PERSONA = C.ID_PERSONA 
INNER JOIN CARRITO_DETALLE cd 
ON V.ID_VENTA = cd.ID_VENTA
INNER JOIN  PRODUCTO p2
ON cd.ID_PRODUCTO = p2.ID_PRODUCTO 
INNER JOIN TIENDA t2 
ON  T2.ID_TIENDA = V.ID_TIENDA 
INNER JOIN TIPO_COMPROBANTE tc 
ON tc.ID_TIPO_COMPROBANTE = V.ID_TIPO_COMPROBANTE 
INNER JOIN TIPO_PAGO tp 
ON TP.ID_TIPO_PAGO = V.ID_TIPO_PAGO 

;
SELECT * FROM CARRITO_DETALLE cd 
--------------------------------------------------
--REPORTE DE PRODUCTOS--


SELECT  
P.NOMBRE  AS NOMBRE_PRODUCTO,
P.DESCRIPCION ,
P.PRECIO,
P.CANTIDAD,
M.NOMBRE AS MARCA,
P2.NOMBRE AS NOMBRE_PROVEEDOR,
P2.CORREO AS CORREO_PROVEEDOR,
P2.TELEFONO AS CELULAR_PROVEEDOR,
P3.DESCUERNTO AS PROMOCION,
P3.FECHA_INICIO  ,
P3.FECHA_FIN 
FROM PRODUCTO p 
INNER JOIN MARCA m 
ON M.ID_MARCA = P.ID_MARCA
INNER JOIN PROVEEDOR p2 
ON P2.ID_PROVEEDOR = P.ID_PROVEEDOR
INNER  JOIN PROMOCION p3 
ON P3.ID_PROMOCION = P.ID_PROMOCION 
------------------------

--REPORTE DE PERSONAL--

SELECT 
P2.NOMBRES AS NOMBRE_PERSONAL, 
	INITCAP(p2.APELLIDO_PATERNO)||' '|| 
	TRIM(INITCAP(LOWER(p2.APELLIDO_MATERNO))) AS  APELLIDO_PERSONAL,
P.DIRECCION,
P.CARGO ,
P.SUELDO ,
P.FECHA_INICIO_CONTRATO ,
P.FECHA_FIN_CONTRATO,
P2.CELULAR 
FROM PERSONAL p 
INNER JOIN PERSONAS p2 
ON P2.ID_PERSONA = P.ID_PERSONA
-----------------------
--REPORTE CLIENTES--

SELECT 
P.NOMBRES AS NOMBRE_CLIENTE,
INITCAP(p.APELLIDO_PATERNO)||' '|| 
	TRIM(INITCAP(LOWER(p.APELLIDO_MATERNO))) AS  APELLIDO_PERSONAL,
G.NOMBRE_GENERO AS GENERO,
TD.NOMBRE AS TIPO_DOCUMENTO ,
P.NUMERO_DOCUMENTO,
P.CELULAR,
P.CORREO 
FROM CLIENTE c 
INNER JOIN PERSONAS p 
ON P.ID_PERSONA = C.ID_PERSONA 
INNER JOIN GENEROS g 
ON G.ID_GENERO = P.ID_GENERO 
INNER JOIN TIPO_DOCUMENTO td 
ON TD.ID_TIPO_DOCUMENTO = P.ID_TIPO_DOCUMENTO 


























































































































































































