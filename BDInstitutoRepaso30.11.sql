DROP DATABASE IF EXISTS instituto;
CREATE DATABASE instituto CHARACTER SET utf8mb4;
USE instituto;
CREATE TABLE alumno (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
fecha_nacimiento DATE NOT NULL,
es_repetidor ENUM('sí', 'no') NOT NULL,
teléfono VARCHAR(9)
);
INSERT INTO alumno VALUES(1, 'María', 'Sánchez', 'Pérez', '1990/12/01', 'no', NULL
);
INSERT INTO alumno VALUES(2, 'Juan', 'Sáez', 'Vega', '1998/04/02', 'no',
618253876);
INSERT INTO alumno VALUES(3, 'Pepe', 'Ramírez', 'Gea', '1988/01/03', 'no', NULL);
INSERT INTO alumno VALUES(4, 'Lucía', 'Sánchez', 'Ortega', '1993/06/13', 'sí',
678516294);
INSERT INTO alumno VALUES(5, 'Paco', 'Martínez', 'López', '1995/11/24', 'no',
692735409);
INSERT INTO alumno VALUES(6, 'Irene', 'Gutiérrez', 'Sánchez', '1991/03/28', 'sí',
NULL);
INSERT INTO alumno VALUES(7, 'Cristina', 'Fernández', 'Ramírez', '1996/09/17', 'no', 628349590);
INSERT INTO alumno VALUES(8, 'Antonio', 'Carretero', 'Ortega', '1994/05/20', 'sí',
612345633);
INSERT INTO alumno VALUES(9, 'Manuel', 'Domínguez', 'Hernández', '1999/07/08', 'no', NULL);
INSERT INTO alumno VALUES(10, 'Daniel', 'Moreno', 'Ruiz', '1998/02/03', 'no', NULL
);

-- Devuelve los datos del alumno cuyo id es igual a 1

SELECT * FROM alumno WHERE id = 1;

-- Devuelve los datos del alumno cuyo teléfono es igual a 692735409.

select * from alumno where teléfono = 692735409;

-- Devuelve un listado de todos los alumnos que son repetidores. 

select * from alumno where es_repetidor = 'sí';

-- Devuelve un listado de todos los alumnos que no son repetidores. 

select * from alumno where es_repetidor = 'no';

-- Devuelve el listado de los alumnos que han nacido antes del 1 de enero de 1993. 

select * from alumno where fecha_nacimiento < '1993/01/01';

-- Devuelve el listado de los alumnos que han nacido después del 1 de enero de 1994.

select * from alumno where fecha_nacimiento > '1994/01/01';

-- Devuelve el listado de los alumnos que han nacido después del 1 de enero de 1994 y no son repetidores. 

select * from alumno where fecha_nacimiento > '1994/01/01' and es_repetidor = 'no';

-- Devuelve el listado de todos los alumnos que nacieron en 1998.

SELECT * FROM alumno WHERE year(fecha_nacimiento) = 1998;

-- Devuelve el listado de todos los alumnos que no nacieron en 1998.

SELECT * FROM alumno WHERE year(fecha_nacimiento) != 1998;

-- Operador BETWEEN 
-- Devuelve los datos de los alumnos que hayan nacido entre el 1 de enero de 1998 y el 31 de mayo de 1998. 

select * from alumno where fecha_nacimiento between '1998/01/01' and '1998/5/31';

-- Ejercicios con Operadores y funciones 
-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre de los alumnos y en la segunda, el nombre con todos los caracteres invertidos. 

SELECT nombre, REVERSE(nombre) AS nombre_invertido FROM alumno;

-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre y los apellidos de los alumnos y en la segunda, el nombre y los apellidos con todos los caracteres invertidos.

select nombre, apellido1, apellido2, 
reverse(nombre) as nombre_invertido,
reverse(apellido1) as apellido1_invertido,
reverse(apellido2) as apellido2_invertido
from alumno;

-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre y los apellidos de los alumnos en mayúscula y en la segunda, el nombre y los apellidos con todos los caracteres invertidos en minúscula. 

SELECT
  CONCAT(UPPER(nombre), ' ', UPPER(apellido1), ' ', UPPER(apellido2)) AS nombre_apellidos_mayus,
  LOWER(REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2))) AS nombre_apellidos_invertidos
FROM alumno;

-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre y los apellidos de los alumnos y en la segunda, el número de caracteres que tiene en total el nombre y los apellidos. 

Select concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_apellidos,
CHAR_LENGTH(concat(nombre, '', apellido1, '', apellido2)) as total_caracteres
from alumno;

-- Devuelve un listado con dos columnas, donde aparezca en la primera columna el nombre y los dos apellidos de los alumnos. 
-- En la segunda columna se mostrará una dirección de correo electrónico que vamos a calcular para cada alumno. 
-- La dirección de correo estará formada por el nombre y el primer apellido, separados por el carácter . y seguidos por el dominio @iescelia.org. 
-- Tenga en cuenta que la dirección de correo electrónico debe estar en minúscula. Utilice un alias apropiado para cada columna.

select concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_apellidos,
lower(concat(nombre, '.', apellido1, '@iescelia.org.')) as correo_electronico
from alumno;

-- Devuelve un listado con tres columnas, donde aparezca en la primera columna el nombre y los dos apellidos de los alumnos. 
-- En la segunda columna se mostrará una dirección de correo electrónico que vamos a calcular para cada alumno. 
-- La dirección de correo estará formada por el nombre y el primer apellido, separados por el carácter . y seguidos por el dominio @iescelia.org. 
-- Tenga en cuenta que la dirección de correo electrónico debe estar en minúscula. 
-- La tercera columna será una contraseña que vamos a generar formada por los caracteres invertidos del segundo apellido, 
-- seguidos de los cuatro caracteres del año de la fecha de nacimiento. Utilice un alias apropiado para da columna. 

select concat(nombre, ' ', apellido1, ' ', apellido2) as nombre_apellidos,
lower(concat(nombre, '.', apellido1, '@iescelia.org.')) as correo_electronico,
reverse(concat(apellido2,substring(fecha_nacimiento,1,4))) as contrasenia
from alumno;

-- Funciones de fecha y hora

-- Devuelva un listado con cuatro columnas, donde aparezca en la primera columna la fecha de nacimiento completa de los alumnos,
-- en la segunda columna el día, en la tercera el mes y en la cuarta el año. Utilice las funciones DAY, MONTH y YEAR.

SELECT
  fecha_nacimiento AS fecha_completa,
  DAY(fecha_nacimiento) AS dia,
  MONTH(fecha_nacimiento) AS mes,
  YEAR(fecha_nacimiento) AS año
FROM alumno;

-- Devuelva un listado con tres columnas, donde aparezca en la primera columna la fecha de nacimiento de los alumnos,
-- en la segunda el nombre del día de la semana de la fecha de nacimiento y en la tercera el nombre del mes de la fecha de nacimiento.

SELECT 
    fecha_nacimiento AS fecha_de_nacimiento,
    DAYNAME(fecha_nacimiento) AS nombre_dia_semana,
    MONTHNAME(fecha_nacimiento) AS nombre_mes
FROM
    alumno;

-- Devuelva un listado con dos columnas, donde aparezca en la primera columna la fecha de nacimiento de los alumnos 
-- y en la segunda columna el número de días que han pasado desde la fecha actual hasta la fecha de nacimiento. 
-- Utilice las funciones DATEDIFF y NOW.

SELECT
  fecha_nacimiento AS fecha_de_nacimiento,
  DATEDIFF(NOW(), fecha_nacimiento) AS dias_pasados
FROM alumno;

-- Devuelva un listado con dos columnas, donde aparezca en la primera columna la fecha de nacimiento de los alumnos 
-- y en la segunda columna la edad de cada alumno/a. La edad (aproximada) la podemos calcular realizando las siguientes operaciones:

SELECT
  fecha_nacimiento AS fecha_de_nacimiento,
  TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM alumno;






