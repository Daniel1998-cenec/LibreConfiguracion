-- drop database supermercado;
create database supermercado;
use supermercado;

create table productos (
id int auto_increment primary key,
nombre varchar(50),
precio double,
tipoIva int
);

create table tickets (
codigo int auto_increment primary key, 
idProducto int,
unidades int,
index idx_idProducto (idProducto)
);

-- 1 es 4 %, 2 es 10%, 3 es 21 %
 
insert into productos(id, nombre, precio, tipoIva) values
(1, 'tarta', 10, 2),
(2, 'portatil', 600, 3),
(3, 'camisas', 30, 2),
(4, 'pan', 1, 1);

insert into tickets (codigo, idProducto, unidades) values
(1, 1, 2),
(2, 1, 1),
(3, 2, 3),
(4, 3, 1),
(5, 3, 2),
(6, 4, 4),
(7, 1, 1),
(8, 1, 5);

alter table tickets
add constraint idx_idProducto
foreign key (idProducto) references productos(id);
