-- FUNCIONES DE AGREGACION 
-- https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html

USE minimarket;

SELECT * FROM productos;

-- SIEMPRE USAR GRUOUP BY PARA AGRUPAR LOS DATOS QUE NECESITAMOS EN LAS FUNCIONES DE AGREGACION 
-- AVG (columna) > promedio de columna
SELECT AVG (precio)
FROM productos
GROUP BY categoria_id;
-- WHERE categoria_id = 2;

-- MAX(columna)
SELECT MAX(precio)
FROM productos;
-- GROUP BY categoria_id;

-- MAX(columna)
SELECT MIN(precio)
FROM productos;
-- GROUP BY categoria_id;

-- COUNT (columna) contador 
SELECT COUNT(precio)
FROM productos;

-- SUM(columna) Suma el contenido de esa columna
SELECT SUM(precio)
FROM productos;

-- PAGINACION
-- Devolver solo la informacion necesaria
SELECT * FROM productos
-- Indica cuantos se mostrarán
LIMIT 2
-- Cuantos datos se van a saltar antes de mostrar la informacion 
-- A partir de donde empezará a contar el limit para mostrar
OFFSET 0;

-- ORDENAMIENTO
SELECT * FROM productos
ORDER BY nombre DESC, fecha_vencimiento DESC; -- ASC = Ascendente DESC = Decendente

-- En MySql limit y offset debes estar juntos
-- Ordenar asi
SELECT SUM(p.precio)
FROM productso AS p INNER JOIN categorias AS c ON p.categoria_id = c.id
WHERE c.nombre = 'Otros'
GROUP BY p.id
ORDER BY fecha_vencimiento DESC
LIMIT 1
OFFSET 0;




