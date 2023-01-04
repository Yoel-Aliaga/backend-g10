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








