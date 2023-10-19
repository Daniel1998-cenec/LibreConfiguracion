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
set @iva:=0.21; -- Creando una variable que vamos a usar en esta consulta con valor 0.21;
set @Desc:=0.10;

select precio,@iva,  -- as para cambiar el nombre de la columna en vez de llamarse precio*@iva, se llamara iva
round(precio*@iva,2) as iva,
precio+(precio*@iva) as total, 
precio+(precio*@iva)*@desc as total
from productos;

select concat_ws(" ",clientes.nombre, clientes.provincia) 
from clientes;

select 
lower(nombre)
from clientes;

select 
substr(nombre, 1, length(nombre)) as Nombre_cliente
from clientes;

select ventas.idproductos
from ventas; -- con esta consulta aparece repetido las ventas de productos

select distinct ventas.idproductos
from ventas; -- con esta consulta NO se repite las ventas de productos

select * 
from clientes 
where nombre not like '_____'; -- '%a%' busca en todo lo que tiene la letra 'a';

select * from clientes where nombre is null;

select count(*) from productos;
select count(distinct productos.fabricante) 
from productos