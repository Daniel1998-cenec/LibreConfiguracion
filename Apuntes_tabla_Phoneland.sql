drop database phoneland;
create database phoneland; 
use phoneland;

create table clientes (
	id int auto_increment primary key,
	nombre varchar (50),
	apellidos varchar(50),
	direccion varchar(100),
	ciudad varchar(50),
    provincia varchar(50),
    cp varchar(10),
    tipo_cliente varchar(20),
    ingresos double,
    fecha date
);

create table productos (
	id int auto_increment primary key,
	idfabricante int,
	nombre varchar (50),
	precio double,
    index idx_idfabricantes (idfabricante)
);

create table ventas (
	id int auto_increment primary key,
	idclientes int,
	idproductos int,
	fecha date,
	index idx_idclientes (idclientes),
	index idx_idproductos (idproductos)
);

create table fabricantes (
	id int auto_increment primary key,
	nombre varchar(50),
    tipo_productos enum('Electrónica', 'Ropa', 'Alimentos', 'Muebles', 'Otros', 'Juguetes') not null,
    sede varchar(50)
);

insert into clientes (nombre, apellidos, direccion, ciudad, provincia, cp, tipo_cliente, ingresos, fecha) values
    ('Alberto', 'Ruiz', 'Avenida Gandalf', 'Gondor', 'Tierra media', '29003', 'empresa', 9000.50, '2023-01-15'),
    ('Laura', 'Perez', 'Calle Frodo', 'Bolso cerrado', 'La comarca', '28003', 'particular', 6000.75, '2023-02-20'),
    ('Sauron', 'Gonzalez', 'Avenida maligna', 'Mordor city', 'Mordor', '38003', 'particular',8000.75, '2023-02-20'),
    ('Macron', 'Rizzo', 'calle Francia', 'Bordeaux', 'Baguette', '66003', 'particular',7000.75, '2023-03-10');

insert into productos (idfabricante, nombre, precio) values
    (1, 'Movil iPhone', 999.99),
    (2, 'Movil Honor', 499.99),
    (3, 'Movil Samsung', 799.99);
    
insert into fabricantes (nombre, tipo_productos, sede) values
	('Hotwheels', 'Juguetes', 'Dinamarca'),
    ('Razer', 'Electrónica', 'USA'),
    ('Martins', 'Alimentos', 'España');
    
insert into ventas (idclientes, idproductos, fecha) values
	(1,1,'2023-01-15'),
	(2,2,'2023-02-20');

alter table ventas
add constraint fk_idclientes
foreign key (idclientes) references clientes(id),
add constraint fk_idproductos
foreign key (idproductos) references productos(id);

alter table productos
add constraint fk_idfabricantes
foreign key (idfabricante) references fabricantes(id);

select * from clientes;
select * from ventas;
select * from productos;
select * from fabricantes;
select * from clientes left join ventas on clientes.id = ventas.idclientes;
select * from productos inner join fabricantes on productos.idfabricante = fabricantes.id;
select * from clientes 
	inner join ventas on clientes.id = ventas.idclientes
    inner join productos on ventas.idproductos = productos.id
    inner join fabricantes on productos.idfabricante = fabricantes.id;
    
-- creando consultas
/* 1 */
SELECT 
	clientes.id AS Cod_cli
FROM clientes;

/* 2 */
set @iva:=0.21; -- Creando una variable que vamos a usar en esta consulta con valor 0.21;
set @Desc:=0.10;

select precio,@iva,  -- as para cambiar el nombre de la columna en vez de llamarse precio*@iva, se llamara iva
round(precio*@iva,2) as iva,
precio+(precio*@iva) as total, 
precio+(precio*@iva)*@desc as total
from productos;


/* 3 */
select concat_ws(" ",clientes.nombre, clientes.provincia) 
from clientes;

/* 4 */
select 
lower(nombre)
from clientes;


/* 5 */
select 
substr(nombre, 1, length(nombre)) as Nombre_cliente
from clientes;


/* 6 */
select ventas.idproductos
from ventas; -- con esta consulta aparece repetido las ventas de productos


/* 7 */
select distinct ventas.idproductos
from ventas; -- con esta consulta NO se repite las ventas de productos


/* 8 */
select * 
from clientes 
where nombre not like '_____'; -- '%a%' busca en todo la cantidad de caracteres;

SELECT *
FROM clientes 
WHERE nombre not LIKE '%a%';

select * from clientes where nombre is null;

/* 8 */
SELECT 
MAX(precio) AS max,
MIN(precio) AS min,
AVG(precio) AS medio
FROM productos;

SELECT 
	COUNT(*),
	COUNT(precio)
 FROM productos;

/* 9 */
SELECT idfabricante,
COUNT(distinct idfabricante) as n    
FROM productos;

/* 10 */
SELECT c.id, V.fecha
FROM clientes c
INNER JOIN ventas v
ON c.id = v.idclientes;

/* 11 */
SET @iva = 0.21;
SELECT 
    c.NOMBRE AS Cliente, c.CIUDAD AS Ciudad, SUBSTR(p.nombre, length(p.nombre)-10, LENGTH(p.nombre)) AS Producto,
	p.PRECIO AS Precio, ROUND(p.precio + p.precio*@iva,0) AS Total, v.FECHA AS Fecha, v.idproductos AS Uds
FROM clientes c
INNER JOIN ventas v
ON c.Id = v.idclientes
INNER JOIN productos p
ON p.id = v.idproductos;

/* 12 */
SELECT v.idclientes, c.NOMBRE
FROM clientes c INNER JOIN ventas v
ON c.Id = v.idclientes
GROUP BY V.IdCLIENTES
HAVING COUNT(*) >= 3;

/* primer ejercicio de delimeter */

Delimiter $$
drop procedure if exists CalculaPrecioIva2 $$
create procedure CalculaPrecioIva2
(in precio decimal(10,2), out total decimal(10,2))
begin
	declare iva decimal(10,2);
    set iva :=0.21;
    set total := precio + (precio*iva);
end $$
Delimiter ;

call CalculaPrecioIva2 (100.0,@resultado);
select @resultado as TotalConIva;



/* Segundo ejercicio de delimeter */
delimiter $$
drop procedure if exists calcularFactura $$
create procedure calcularFactura
(in precioBase decimal(10,2), out precioConIVA decimal(10,2), out precioTotal decimal(10,2))
begin
	declare iva decimal(10,2);
	set iva := 0.21;
    set precioConIVA := precioBase + (precioBase * iva);
	set precioTotal := precioBase + precioConIVA;
end $$
delimiter ;

call calcularFactura(100.00, @precioConIVA, @precioTotal);
select @precioConIVA;

/* tercer ejercicio de delimeter*/

DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaPrecioDescuentoIvaTotal $$
CREATE PROCEDURE CalculaPrecioDescuentoIvaTotal
(IN precioBase DECIMAL(10,2), OUT descuento DECIMAL(10,2), OUT precioDescuento DECIMAL(10,2), OUT iva DECIMAL(10,2), OUT total DECIMAL(10,2))
BEGIN 
    -- Definir el descuento (10%)
    SET descuento := precioBase * 0.10;

    -- Calcular el precio con descuento
    SET precioDescuento := precioBase - descuento; -- Aquí corregí precio_descuento a precioDescuento
    
    -- Definir la tasa de IVA (21%)
    SET iva := precioDescuento * 0.21;
    
    -- Calcular el total
    SET total := precioDescuento + iva;
END $$
DELIMITER ;

SET @precioBase = 1000; -- Establece el precio base
CALL CalculaPrecioDescuentoIvaTotal(@precioBase, @descuento, @precioDescuento, @iva, @total); -- Llama al procedimiento y obtén todos los resultados
SELECT @precioBase, @descuento, @precioDescuento, @iva, @total; -- Muestra todos los resultados


/* ejercicio de delimeter de edades */
/*
Delimiter $$
drop procedure if exists CalculaEdad $$
create procedure CalculaEdad
(in fechaNacimiento int, out edad int)
begin 
	declare actual int default 2023;
    set edad = actual-fechaNacimiento;
end $$
delimiter ;

call CalculaEdad(1977,@edad_actual);
select @edad_actual;

*/

-- 9-11-2023
-- actividad 1
DELIMITER $$

drop procedure if exists CalculaMayoriaEdad $$
create procedure CalculaMayoriaEdad(
in fecha_nacimiento int,
out edad int,
out tipo varchar(20))
begin 	
	declare actual int default 2023;
    set edad=actual- fecha_nacimiento;
    if edad>=18 then
		select concat(edad," ",'Mayor de edad') as mayorEdad;
	else
		select 'menor de edad';
	end if;
end $$
DELIMITER ;

DELIMITER $$

call CalculaMayoriaEdad(1950,@edad,@tipo);

/*-- actividad 2
drop procedure if exists CalculaMayoriaEdad $$
create procedure CalculaMayoriaEdad(
in fecha_nacimiento int,
out edad int,
out tipo varchar(20))
begin 	
	declare actual int default 2023;
    set edad=actual- fecha_nacimiento;
    if edad>=18 then
		select concat(edad," ",'Mayor de edad');
	else
		select 'menor de edad';
	end if;
    select 'jubilado';
end $$
DELIMITER ;

call CalculaMayoriaEdad(1950,@edad,@tipo);*/

-- actividad 3

delimiter $$
drop procedure if exists CalcularMayoriaEdad $$
create procedure CalcularMayoriaEdad(
in fecha_nacimiento int,
out edad int,
out tipo varchar(20))

begin
	declare actual int default 2023;
    set edad=actual-fecha_nacimiento;
    if edad>=18 and edad<=65 then
		select concat("Edad: ",edad, ". ",'Mayor de edad') as Resultado;
	elseif edad<10 then
		select concat("Edad: ",edad, ". ",'Niño') as Resultado;
	elseif edad>10 and edad<17 then
		select concat("Edad: ",edad, ". ",'Adolescente') as Resultado;
	else
		select 'Jubilado' as Resultado;
	end if;
end $$
delimiter ;

call CalcularMayoriaEdad(1994,@edad,@tipo);

-- 16-11-2023 
-- Funcion que devuelven en euros a las pesetas 

Delimiter $$
drop function if exists funcion1 $$
create function funcion1 (p_pesetas Decimal(12,2))
-- conversor de pesetas a euros
	returns decimal(10,2)
begin
return(p_pesetas/166.386);
end$$
Delimiter ;

select funcion1(precio) as rublos from productos;

-- Funcion que devuelven en euros con el iva 

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_iva $$
CREATE FUNCTION calcular_iva (euros DECIMAL(12,2))
	RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	RETURN (descuento(euros)*0.21);
END $$
DELIMITER ;

-- Funcion que devuelven descuento

DELIMITER $$
DROP FUNCTION IF EXISTS descuento $$
CREATE FUNCTION descuento (euros DECIMAL(12,2))
	RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	RETURN euros-(euros*0.10);
END $$
DELIMITER ;

SELECT precio, descuento(precio) AS Descuento, calcular_iva(precio) AS IVA FROM productos;

-- ////////////////////////////////////////////////////

delimiter $$
	DROP FUNCTION if EXISTS funcionIva $$
	CREATE FUNCTION funcionIva (euros decimal(12,2))
	RETURNS DECIMAL (10,2) DETERMINISTIC
	BEGIN
		RETURN euros+euros*0.21 ;
	END $$
delimiter ;

SELECT precio, funcionIva(precio) as precioConIva FROM productos;

-- ///////////////////////////////////////////////////////

delimiter $$
	DROP FUNCTION if EXISTS funcionDescuento $$
	CREATE FUNCTION funcionDescuento (euros decimal(12,2))
	RETURNS DECIMAL (10,2) DETERMINISTIC
	BEGIN
		if euros > 200 then
			RETURN euros-euros*0.10 ;
        else
			RETURN euros;
        END IF;
	END $$
delimiter ;

SELECT precio, funcionDescuento(precio)  as descuento , 
funcionIva(funcionDescuento(precio)) as descuentoConIva from productos;

-- ///////////////////////////////////////////////////////

delimiter $$
	DROP FUNCTION if EXISTS funcionTotal $$
	CREATE FUNCTION funcionTotal(euros DECIMAL(12,2))
	RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN funcionIva(funcionDescuento(euros));
END $$

DELIMITER ;

SELECT precio, funcionTotal(precio) AS total FROM productos;






