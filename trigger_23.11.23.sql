/*use phoneland;

drop table replica_ventas;
-- trigger --
CREATE TABLE replica_ventas AS
SELECT * FROM ventas WHERE 1=0;

-- ahora crearemos el trigger --
DELIMITER $$
CREATE TRIGGER TRIGGER1
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
	INSERT INTO replica_ventas (Id_VENTAS, Id_CLIENTES, id_PRODUCTOS, FECHA_DE_VENTA)
    VALUES (NEW.Id_VENTAS, NEW.Id_CLIENTES, NEW.id_PRODUCTOS, NEW.FECHA_DE_VENTA);
END$$
DELIMITER ;

INSERT INTO ventas(Id_VENTAS, Id_CLIENTES, id_PRODUCTOS, FECHA_DE_VENTA)
VALUES (7,1,2,'2023-01-01');
SELECT * FROM replica_ventas;
*/
-- no funciona

use tiendaPc;

drop table replica_productos;
create table replica_productos as
select * from productos where 1=0;

delimiter $$
drop trigger trigger1;
create trigger trigger1
before insert on productos
for each row
begin
	insert into replica_productos (id,nombreProducto,fabricante)
    values (new.id,new.nombreProducto,new.fabricante);
    end$$
    delimiter ;
    
    insert into productos(id,nombreProducto,fabricante)
    values(5,'Tablet','hp');
    select * from replica_productos;
    
    -- si funciona pero tengo que insertar nuevos productos sino me sale que esta duplicado
    
/*use tiendaPc;

drop table replica_productos;
create table replica_productos as
select * from productos where 1=0;

delimiter $$
drop trigger trigger_update_productos2;
create trigger trigger_update_productos2
after update on productos
for each row
begin
	update replica_productos
    set nombreProducto= new.nombreProducto,
	fabricante= new.fabricante
    where   id= new.id;
end $$

delimiter ;

update productos 
set fabricante ='Tablet' 
where id=5;

select * from replica_productos;*/

-- No funciona :(

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use phoneland;

drop table historial;
CREATE TABLE historial (
    idhistorial INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora_actual TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    mensaje VARCHAR(255)
);
DELIMITER $$

DROP TRIGGER if EXISTS TRIGGER_DELETE_REPLICA_VENTAS $$
CREATE TRIGGER TRIGGER_DELETE_REPLICA_VENTAS
BEFORE DELETE ON replica_ventas
FOR EACH ROW
BEGIN
    -- Insertar en historial antes de la eliminación
    INSERT INTO historial (fecha_hora_actual, mensaje)
    VALUES (NOW(), CONCAT('Se ha borrado el registro con idventas = ', OLD.Id_VENTAS,
                          ', idclientes = ', OLD.Id_CLIENTES,
                          ', idproductos = ', OLD.id_PRODUCTOS,
                          ', fecha_Ventas = ', OLD.FECHA_DE_VENTA
								  ));
END $$

DELIMITER ;

DELETE FROM replica_ventas WHERE idventas=11;

SELECT * FROM historial;

-- nose porque me da error


    




