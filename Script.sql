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

SELECT * FROM tipo_documento ;

CREATE TABLE generos (
id_genero NUMBER PRIMARY KEY,
nombre_genero varchar2(15) UNIQUE NOT NULL,
sigla VARCHAR2 (2) UNIQUE,
orden NUMBER,
estado char(1)
);
SELECT * FROM GENEROS ;



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
SELECT * FROM personas ;

);


--TABLE PROFESOR 
CREATE TABLE profesor(
id_profesor NUMBER PRIMARY KEY,
id_persona NUMBER,
cargo VARCHAR (100),
tipo_jornada VARCHAR (100),
sueldo NUMBER(5,2),
estado char(1),
fecha_inicio_contrato DATE NOT NULL,
fecha_fin_contrato DATE NOT NULL,
id_usuario_registra NUMBER,
id_usuario_actualiza NUMBER,
fecha_registro DATE,
fecha_actualiza DATE,

CONSTRAINT fk_personas_profesor
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona)

SELECT * FROM  profesor;
);


INSERT INTO profesor(
id_profesor, 
id_persona,
cargo,
tipo_jornada,
sueldo,
estado,
fecha_inicio_contrato,
fecha_fin_contrato
 ) VALUES (
1,
6, 
'instrucctor',
'parcial',
10,
1,
TO_DATE('10/03/2025', 'DD/MM/YYYY'),
TO_DATE('30/07/2025', 'DD/MM/YYYY')
)
DROP TABLE PERSONAL;

CREATE TABLE personal(
id_personal NUMBER PRIMARY KEY,
id_persona NUMBER UNIQUE,
cargo varchar2 (100) NOT NULL,
tipo_jornada varchar2 (50) NOT NULL,
sueldo NUMBER (10,2) NOT NULL,
estado char(1),
fecha_inicio_contrato date,
fecha_fin_contrato DATE,

CONSTRAINT fk_personas_personal
FOREIGN KEY (id_persona)
REFERENCES PERSONAS (id_persona)


);
--CORRIGIENDO LA  TABLA ESTUDIANTE
ALTER TABLE ESTUDIANTES 
ADD CONSTRAINT fk_personas_estudiantes
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona);


--Nombre : 

SELECT * FROM PERSONAS ;
SELECT * FROM GENEROS ;
SELECT * FROM TIPO_DOCUMENTO ;
SELECT * FROM ESTUDIANTES ;
SELECT * FROM PROFESOR;
SELECT * FROM PERSONAL;

--::::ACTIVIDAD 001::::
--NOMBRE: Diego Lipa
--nombre
--apellido paterno y materno juntos ()
--edad
--tipo documento (DNI)
--celular

SELECT * FROM PERSONAS ;
SELECT * FROM GENEROS ;
SELECT * FROM TIPO_DOCUMENTO ;
SELECT * FROM ESTUDIANTES ;
SELECT * FROM PROFESOR;
SELECT * FROM PERSONAL;


--SOLUCION INSTRUCCTOR
SELECT 
    p.NOMBRES AS NOMBRE, 
    (p.APELLIDO_PATERNO || ' ' || p.APELLIDO_MATERNO) AS APELLIDOS, 
    FLOOR(MONTHS_BETWEEN(SYSDATE, p.FECHA_NACIMIENTO) / 12) AS EDAD, 
    td.NOMBRE AS TIPO_DOCUMENTO, 
    p.CELULAR 
FROM PERSONAS p
JOIN TIPO_DOCUMENTO td ON p.ID_TIPO_DOCUMENTO = td.ID_TIPO_DOCUMENTO
WHERE td.SIGLA = 'DNI';





SELECT 
	p.NOMBRES,
	P.APELLIDO_PATERNO ||' '||
	P.APELLIDO_MATERNO AS APELLIDOS,
	FLOOR(MONTHS_BETWEEN(SYSDATE,P.FECHA_NACIMIENTO)/12) AS FECHA_NACIMIENTO,
	EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM P.FECHA_NACIMIENTO) AS FECHA_NACIMIENTO2, 
	td.sigla AS tipo_documento,
	p.CELULAR
FROM PERSONAS p 
LEFT JOIN TIPO_DOCUMENTO td 
ON p.ID_TIPO_DOCUMENTO = td.ID_TIPO_DOCUMENTO ;





























