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
-------------------------

CREATE TABLE tienda(
id_tienda NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
ubicacion VARCHAR2 (30),
telefono NUMBER (9),
estado char(1)

);
----------------------------------
CREATE TABLE tipo_comprobante(
id_tipo_comprobante NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
descripcion VARCHAR2 (100),
fecha_emision DATE,
monto NUMBER (10,2),
comision NUMBER (5)

);

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
id_marca VARCHAR2 (20),


CONSTRAINT fk_proveedor_producto
FOREIGN KEY (id_proveedor)
REFERENCES proveedor (id_proveedor),

CONSTRAINT fk_promocion_producto
FOREIGN KEY (id_promocion)
REFERENCES promocion (id_promocion)
);
------------------------------------------
CREATE TABLE marca(
id_marca NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
estado char(1)

);


------------------------------------------
CREATE TABLE proveedor(
id_proveedor NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
telefono NUMBER (9),
correo VARCHAR2 (20),
direccion VARCHAR2(50),
estado char(1)
);

-------------------------------------------
CREATE TABLE promocion(
id_promocion NUMBER PRIMARY KEY,
descripcion VARCHAR2 (100),
descuernto NUMBER (20),
fecha_inicio DATE,
fecha_fin DATE
);
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


-----------------------
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

-----------------------------------
 
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




































































































































































































