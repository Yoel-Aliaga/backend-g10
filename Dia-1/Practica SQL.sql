-- Muestra la hora 
select now();

-- Modificamos la tabla para agregar la columna categoria_id
-- ALTER TABLE productos ADD COLUMN categoria_id INT;
-- Agregamos la relacion entre productos y categorias
-- ALTER TABLE productos ADD FOREIGN KEY (categoria_id) REFERENCES categorias(id);

-- ELIMINAR UNA BASE DE DATOS
DROP DATABASE minimarket;

-- ELIMINAR UNA TABLA 
DROP TABLE categoria;

-- 1.- Crear una base de datos llamada minimarket
CREATE DATABASE IF NOT EXISTS minimarket;
USE minimarket;

-- 2.- Crear una tabla llamada categoria:
-- id entero llave primaria y auto incrementable
-- nombre text
CREATE TABLE categorias(
	id						INT 		PRIMARY KEY AUTO_INCREMENT,
    nombre 					TEXT    
);

-- 3.- Crear una tabla llamada productos en la cual tengamos lo siguiente:
-- id entero llave primaria y auto incrementable
-- nombre text
-- imagen text
-- fecha_vencimiento date
-- precio float
-- disponible boolean defecto (verdadero)
CREATE TABLE productos(
	id						INT 		PRIMARY KEY AUTO_INCREMENT,
    nombre 					TEXT,
    imagen 					TEXT,
    fecha_vencimiento		DATE,
    precio 					FLOAT,
    disponible 				BOOLEAN DEFAULT TRUE,     
    -- Creas la llave foranea 
    categoria_id			INT,
    -- La llave foranea categoria_id se relaciona con el id de la tabla categorias  
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- 4. CREAR UNA TABLA LLAMADA ALMACEN en la cual seria de la sgte manera:
-- id entero llave primaria y auto incrementable
-- nombre text
-- direccion text
CREATE TABLE almacenes(
	id						INT 		PRIMARY KEY AUTO_INCREMENT,
    nombre 					TEXT,
    direccion 				TEXT    
);
-- Una categoria puede tener varios productos pero un producto pertenece a una sola categoria


-- Cambiar nombre de la tabla
-- ALTER TABLE nombre_antiguo RENAME nombre_nuevo;


-- Un producto puede estar en varios almacenes y a su vez cada almacen puede tener varios productos
-- Relacion de muchos a muchos
CREATE TABLE almacen_productos(
	id				INT PRIMARY KEY AUTO_INCREMENT,
    almacenes_id  	INT NOT NULL,
    productos_id	INT NOT NULL,
    FOREIGN KEY (almacenes_id) REFERENCES almacenes(id),
    FOREIGN KEY (productos_id) REFERENCES productos(id)    
);

DROP TABLE almacen_producto;

INSERT INTO categorias(id, nombre) VALUES (DEFAULT, 'Frutas'),
										  (DEFAULT, 'Legumbres'),
										  (DEFAULT, 'Snacks'),
										  (DEFAULT, 'Otros');

INSERT INTO productos (id, nombre, imagen, fecha_vencimiento, precio, disponible, categoria_id) VALUES (DEFAULT, 'Lechuga Carola', 'https://google.com','2022-01-10',2.90, true, 2),
                                                                                                       (DEFAULT, 'Beterraga', 'https://google.com','2022-02-14',1.90, true, 2),
                                                                                                       (DEFAULT, 'Papitas fritas', 'https://google.com','2025-01-10',2.90, true, 3),
                                                                                                       (DEFAULT, 'Platano de seda', 'https://google.com','2022-01-10',4.75, true, 1),
                                                                                                       (DEFAULT, 'Short playero', 'https://google.com','2022-12-31',39.90, true, 4),
                                                                                                       (DEFAULT, 'Mandarina', 'https://google.com','2022-05-23',2.90, true, 1);

INSERT INTO almacenes (id, nombre, direccion ) VALUES (DEFAULT, 'ALMACEN A', 'Calle los ruiseñores 1080'),
                                                      (DEFAULT, 'ALMACEN B', 'Calle los girasoles 570'),
                                                      (DEFAULT, 'ALMACEN C', 'Av Venezuela 3040');

INSERT INTO almacen_producto (id, almacen_id, producto_id) VALUES (DEFAULT, 1, 1),
                                                                  (DEFAULT, 1, 2),
                                                                  (DEFAULT, 2, 2),
                                                                  (DEFAULT, 2, 3),
                                                                  (DEFAULT, 3, 4),
                                                                  (DEFAULT, 1, 5),
                                                                  (DEFAULT, 2, 6),
                                                                  (DEFAULT, 3, 5);
select * from productos;

-- EJERCICIOS
-- 1.- Mostrar todos los productos que tengan un precio mayor o igual que 3
-- 2.- Mostrar todos los productos cuya fecha de vencimiento sea menor al 1 de agosto del 2022
-- 3.- Mostrar los nombres de los productos concatenados con su URL de la imagen en un sola columna 
-- que se llame 'producto imagen'

SELECT * FROM productos WHERE precio >= 3;

SELECT * FROM productos WHERE fecha_vencimiento < '2022-08-01';

SELECT CONCAT(nombre, ' ' ,imagen ) AS 'producto imagen' FROM productos;

-- 4.- Devolver todos los productos de la categoria frutas

SELECT p.* FROM productos AS p INNER JOIN categorias AS c ON p.categoria_id = c.id Where c.nombre = 'Frutas';

-- 5.- Devolcver el nombre de la categoria, el nombre del producto y el precio del producto si es mayor a 10

SELECT c.nombre AS 'Categoria Nombre',
	   p.nombre AS 'Producto Nombre',
       p.precio 
FROM productos AS p INNER JOIN categorias AS c ON p.categoria_id = c.id 
WHERE p.PRECIO > 10 ;

-- 6.- Devolver loa almacanes con sus productos 

SELECT * FROM almacenes AS a INNER JOIN almacen_producto AS ap ON a.id = ap.almacen_id 
							 INNER JOIN productos AS p ON ap.producto_id = p.id;


-- 7.- Mostrar lo siguiente :
-- Tabla categoria : El nombre 
-- Tabla productos: Nombre y precio
-- Tabla almacenes : Nombre y direccion 

SELECT c.nombre, p.nombre, p.precio, a.nombre,a.direccion 
 FROM categorias as c 
	INNER JOIN productos AS p ON c.id = p.categorias_id 
	 INNER JOIN almacen_producto AS ap ON p.id = ap.producto_id
     INNER JOIN almacenes AS a ON ap.almacen_id = a.id;




















