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
CREATE TABLE clientes (
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
id_tienda NUMBER UNIQUE,
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


CREATE TABLE tipo_pago(
id_tipo_pago NUMBER PRIMARY KEY,
nombre VARCHAR2 (20),
estado char(1),
orden NUMBER
);

CREATE TABLE dato_envio_cliente (
dato_envio_cliente NUMBER PRIMARY KEY,
id_cliente NUMBER,
estado char(1),
fecha_envio DATE,
fecha_entrega DATE,
tipo_envio VARCHAR2 (20),
costo_envio NUMBER (5,2),
direccion VARCHAR2(50),
ubicacion VARCHAR2 (30)
);


CREATE TABLE tienda(
id_tienda NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
ubicacion VARCHAR2 (30),
telefono NUMBER (9),
estado char(1)

);

CREATE TABLE tipo_comprobante(
id_tipo_comprobante NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
descripcion VARCHAR2 (100),
fecha_emision DATE,
monto NUMBER (10,2),
comision NUMBER (5)
);

CREATE TABLE comprobante_detalle(
id_comprobante_detalle NUMBER PRIMARY KEY,
id_cliente NUMBER,
id_tipo_comprobante NUMBER, 
id_venta NUMBER,
id_producto NUMBER,
id_promocion NUMBER
);

CREATE TABLE carrito_detalle(
id_carrito_detalle NUMBER PRIMARY KEY,
id_producto NUMBER (5),
id_venta NUMBER (5),
cantidad NUMBER (5)
);

CREATE TABLE producto(
id_producto NUMBER PRIMARY KEY,
id_proveedor NUMBER,
id_promocion NUMBER,
nombre VARCHAR2 (20),
descripcion VARCHAR2,
precio NUMBER (10),
cantidad NUMBER (5),
echa_creacion DATE,
marca VARCHAR2
);


CREATE TABLE proveedor(
id_proveesor NUMBER PRIMARY KEY,
nombre VARCHAR2 (30),
telefono NUMBER (9),
correo VARCHAR2 (20),
direccion VARCHAR2(50),
estado char(1)
);

CREATE TABLE promocion(
id_promocion NUMBER PRIMARY KEY,
descripcion VARCHAR2 (100),
descuernto NUMBER (20),
fecha_inicio DATE,
fecha_fin DATE
);

CREATE TABLE reembolso_detalle(
id_reembolso_detalle NUMBER PRIMARY KEY,
id_reembolso NUMBER,
id_carrito_detalle NUMBER
);

CREATE TABLE reembolso(
id_reembolso NUMBER PRIMARY KEY,
id_venta NUMBER UNIQUE,
id_ticket_soporte NUMBER UNIQUE,
precio NUMBER,
fecha_reembolso DATE
);

CREATE TABLE ticket_soporte(
id_ticket_soporte NUMBER PRIMARY KEY,
id_requisitos NUMBER,
fecha_creacion DATE,
descripcion VARCHAR2 (100),
estado char(1)
);

CREATE TABLE requisitos(
id_requisitos NUMBER PRIMARY KEY,
descripcion VARCHAR2 (100),
estado char(1)
);



CREATE TABLE venta(
id_venta NUMBER PRIMARY KEY,
id_cliente NUMBER UNIQUE,
id_tienda NUMBER ,
id_tipo_pago NUMBER,
id_tipo_comprobante NUMBER,
id_personal NUMBER UNIQUE,
id_dato_envio NUMBER,
fecha_venta DATE,
estado char(1)
);

















































































































