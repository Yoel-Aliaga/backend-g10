-- 1ero Asi se crea una base de datos
CREATE DATABASE IF NOT EXISTS practicas;

-- 2do Indicas que Bd se utilizara 
USE practicas;

-- ahora procedemos a crear nuestra primera tabla
-- tipos de datos
-- autoincrement sol opuede haber uno por tabla

CREATE TABLE usuarios(
-- nombre 	tipo de dato  	[conf adicionales ]
	id			INT		 	AUTO_INCREMENT UNIQUE PRIMARY KEY,
    nombre		TEXT  		NOT NULL,
    DNI			CHAR(8)		UNIQUE   
    
);

CREATE TABLE tareas(
	id 			INT				AUTO_INCREMENT PRIMARY KEY,
    titulo 		VARCHAR(100) 	UNIQUE,
    descripcion TEXT,
	usuario_id 	INT,
    -- Creo la relacion entre las tablas 
    -- Indico entre parentesis la columa de esta tabla y luego la tabla (su columna)
	FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);






-- 5 FORMAS NORMALES (Normalizacion) Veremos solo 4

-- 1.- Nos ayuda a eliminar valores repetidos y no son atomicos
-- 	   No debe existir variacion en el numero de columnas
-- 	   Los campos no claves deben identificarse por un indice
-- 	   Todas las tablas deben tener al menos un indice

-- 2.- Si los atributos no forman parte de ninguna clave dependen de forma completa de 
-- 		la PK (Primary Ky)

-- 3.- No existe ninguna dependencia funcional en los atributos que no son clave
-- 4.- Los campos repetidos se identifican por una llave primaria

-- SUB LENGUAJES 
-- DDL (Data Definition Language)
-- Es un lenguaje que sirve para definir estructuras de datos (Crear bd, crear tablas, actualizar, eliminar)
-- CREATE (Crear)
-- ALTER (Actualizar)
-- DROP (Eliminar) elimina absolutamente TODO

-- DML (Data Manipulation Language)
-- Es un lenguaje que sirve para definir la informacion que irea dentro de las estructuras 
-- INSERTAR (Insertar)
-- SELECT   (Visualizar)
-- UPDATE   (Actualizar)
-- DELETE   (Eliminar)

-- En este caso como el 'id' es auto_increment no le pondremos un valor
INSERT INTO usuarios(nombre, DNI) VALUES('Eduardo','73500746');

-- Si queremos utiliza el valor por defecto de una columna 
INSERT INTO usuarios(id,nombre,dni)VALUES (DEFAULT,'Juana','71589264');

-- Si queremos ingresar varios registros
INSERT INTO usuarios(id,nombre,dni)VALUES (DEFAULT,'Roberto','35269485'),
										  (DEFAULT,'Maria','29165148'),
										  (DEFAULT,'Roxana','56236841');

INSERT INTO tareas (id, titulo, descripcion, usuario_id) VALUES 
				(DEFAULT,'ir a la playa', 'ire a la playa el fin de semana',1),
                (DEFAULT,'ir a la piscina', 'ire a la piscina a mis clases de natacion',2);

-- Visualizar la informacion 
-- de la tabla usuarios la columna nombre y cualquien columna que deseamos
SELECT nombre, dni, id, id FROM usuarios;

-- Visualizar la totalidad de las columnas utilizamos el asterisco 
SELECT * FROM usuarios;

INSERT INTO usuarios(id, nombre, dni) VALUES (DEFAULT, 'Juana', '33265946'),
											 (DEFAULT, 'Maria', '52698524');
                                             
-- Seleccioan todas las columnas de la tabla usuarios donde nombre sea Juana
SELECT * FROM usuarios WHERE nombre='Juana' AND id=2;

-- Visualizar todas las tareas del usuario 1 
SELECT * FROM tareas WHERE usuario_id=1 AND usuario_id=2;
SELECT * FROM tareas WHERE usuario_id=1 OR usuario_id=2;

INSERT INTO tareas (id, titulo, descripcion, usuario_id)VALUES (DEFAULT,'Ir a comer', 'Comer un sabroso pollito a la brasa',1),
															   (DEFAULT,'Comer pizza', 'Comer una sabrosa pizza con peperoni',1);

SELECT * FROM tareas WHERE usuario_id=1;


-- buscar una palabra o palabras dentro de un texto
SELECT * FROM usuarios WHERE nombre LIKE '%O';

-- Hace la comparacion a nivel de caracteres ASCII
SELECT * FROM usuarios WHERE nombre LIKE BINARY 'J%';


SELECT * FROM usuarios WHERE nombre LIKE '__u%';
SELECT * FROM usuarios WHERE nombre NOT LIKE '__u%';

SELECT * FROM tareas;
-- Ahora insertamos una tabla sin dueño
INSERT INTO tareas (id, titulo, descripcion, usuario_id) VALUES (DEFAULT, 'No hacer nada', 'no hacer nada porque es domingo',null);
INSERT INTO tareas (id, titulo, descripcion, usuario_id) VALUES (DEFAULT, 'no hacer nada', 'no hacer nada porque es domingo', null);

SELECT * FROM tareas;
-- Unir dos tablas  : Interseccion entre la tabla usuarios con la tabla tareas donde usuarios.id 
SELECT * FROM usuarios INNER JOIN tareas ON usuarios.id = tareas.usuario_id;

-- Devuelve todos los usuarios de la izquierda pero a la derecha solo devuelve los que tienen tareas sino los devuelve como null
SELECT * FROM usuarios LEFT JOIN tareas ON usuarios.id = tareas.usuario_id;
SELECT * FROM usuarios RIGHT JOIN tareas ON usuarios.id = tareas.usuario_id;

-- FULL OUTER JOIN no existe entonces usamos UNION
-- UNION Mezcla o combina las dos o mas consultas en una sola 'tabla virtual' 
-- pero ambas consultas deben tener el mismo numero de columnas
SELECT * FROM usuarios LEFT JOIN tareas ON usuarios.id = tareas.usuario_id UNION 
SELECT * FROM usuarios RIGHT JOIN tareas ON usuarios.id = tareas.usuario_id;

SELECT nombre FROM usuarios UNION
SELECT titulo FROM tareas;

-- CONCATENAR = JUNTAR O COMBINAR
-- AS pone un alias al titulo de la columa 
-- si el alias es compuesto osea dos nombres se pone entre comillas simples
-- OJO en base de datos NO SE USAN COMILLAS DOBLES solo simples
SELECT CONCAT(titulo, ' ', descripcion) AS 'nombre completo' FROM tareas;

SELECT * FROM usuarios;
-- EJERCICIOS
-- 1.- Devolver todos los usuarios que sus DNI contengan el numero 5 
SELECT * FROM usuarios WHERE dni LIKE '%5%';
-- 2.- Devolver todos los usuarios cuyo DNI tengan el tercer digito 8
SELECT * FROM usuarios WHERE dni LIKE '__8%';
-- 3.- Devolver todas las tareas del usuario 'Eduardo'
SELECT * FROM usuarios INNER JOIN tareas ON usuarios.id = tareas.usuario_id WHERE nombre = 'Eduardo';










