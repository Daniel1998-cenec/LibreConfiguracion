drop database phonelandSupremo;
create database phonelandSupremo;
use phonelandSupremo;

CREATE TABLE `clientes` (
  `Id_CLIENTES` int(2) NOT NULL,
  `FECHA_DE_ALTA` varchar(9) DEFAULT NULL,
  `CIF_NIF` varchar(9) DEFAULT NULL,
  `NOMBRE` varchar(17) DEFAULT NULL,
  `DIRECCION` varchar(18) DEFAULT NULL,
  `CP` int(5) DEFAULT NULL,
  `CIUDAD` varchar(7) DEFAULT NULL,
  `PROVINCIA` varchar(6) DEFAULT NULL,
  `EMPRESA` varchar(2) DEFAULT NULL,
  `COMO_NOS_CONOCIO` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id_CLIENTES`, `FECHA_DE_ALTA`, `CIF_NIF`, `NOMBRE`, `DIRECCION`, `CP`, `CIUDAD`, `PROVINCIA`, `EMPRESA`, `COMO_NOS_CONOCIO`) VALUES
(1, '15-nov-20', '11111111A', 'ANA PEREZ', 'CALLE SOL,12', 29002, 'GRANADA', 'MALAGA', 'NO', 'GOOGLE'),
(2, '16-nov-20', '33241111J', 'EVA RUIZ', 'CALLE LUNA,13', 29003, 'SEVILLA', 'MALAGA', 'NO', 'GOOGLE'),
(3, '19-nov-20', '11111116A', 'ALBERTO GONZALEZ', 'AV.ANDALUCIA,14', 29005, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(4, '21-nov-20', '33111111A', 'MARIO VARGAS', 'AV. ANDALUCIA, 15', 29005, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(5, '22-nov-20', '11341111A', 'ALFREDO SANEZ', 'CALLE CUARTELES 1', 29002, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(6, '23-nov-20', '34113411C', 'BARTOLOME SANCHEZ', 'CALLE SALISTRE ,12', 29002, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(7, '24-nov-20', '11111111A', 'CARMEN RUIZ perez', 'HUELIN, 23', 29002, 'MALAGA', 'MALAGA', 'NO', 'REDES SOCIALES'),
(8, '26-nov-20', '33111111J', 'MARIA RUIZ', 'CALLE SALISTRE,14', 29002, 'MALAGA', 'MALAGA', 'NO', 'REDES SOCILAES'),
(9, '28-nov-20', '11111111A', 'MARIO SANCHEZ', 'CALLE SALISTRE,22', 29002, 'MALAGA', 'MALAGA', 'NO', 'REDES SOCIALES'),
(10, '03-dic-20', 'B33111111', 'CORSAN', 'CALLE CUARTELES', 29002, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(11, '05-dic-20', 'A11111111', 'FERROVIAL', 'HUELIN ,34', 29002, 'SEVILLA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(12, '06-dic-20', 'C33111111', 'CORTES INGLES', 'AVD , AMERICAS 12', 29005, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(13, '10-feb-20', 'C11111111', 'ENDESA', 'AVD, AMERICAS 14', 29005, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(14, '11-feb-20', 'C11111111', 'MICROSOFT IBERICA', 'AVD,AMERICAS 15', 29005, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(102, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, NULL, NULL, 'Gandalf', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Disparadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `TRIGGER1` BEFORE INSERT ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO clientes_copia  VALUES (NEW.id_clientes,NEW.nombre);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_copia`
--

CREATE TABLE `clientes_copia` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes_copia`
--

INSERT INTO `clientes_copia` (`id`, `nombre`) VALUES
(121, 'Gandalf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_PRODUCTO` int(2) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `NOMBRE` varchar(58) DEFAULT NULL,
  `FABRICANTE` varchar(7) DEFAULT NULL,
  `PRECIO` varchar(8) DEFAULT NULL,
  `PVP` decimal(10,2) DEFAULT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `Columna 8` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_PRODUCTO`, `id_proveedor`, `NOMBRE`, `FABRICANTE`, `PRECIO`, `PVP`, `Descripcion`, `Columna 8`) VALUES
(1, 1, 'XIAOMI IMI10LITE5G 6GB+128GBAzulBoreal', 'XIOAMI', '220,00 €', NULL, 'Alta gama usando en entornos de empresa', NULL),
(2, 2, 'SAMSUN GALAXYS20-FE-5G 8GB+256 AZUL MARINO MOVIL LIBRE', 'SAMSUNG', '650,00 €', NULL, NULL, NULL),
(3, 1, 'APPLE Iphone 11 128GB BLANCO MOVIL LIBRE', 'APPLE', '650,00 €', NULL, NULL, NULL),
(4, 1, 'XIAOMI MI 10T Pro 8 GB+256 GB Lunar Silver movil libre', 'XIOAMI', '580,00 €', NULL, 'gama baja entorno hogar', NULL),
(5, 1, 'SAMSUN GALAYI S20 FE 5G 8GB + 256 violeta movil libre', 'SAMSUNG', '600,00 €', NULL, NULL, NULL),
(6, 1, 'XIAOMI REDMI NOTE 9,4GB + 128 GB Polar white', 'XIOAMI', '100,00 €', NULL, NULL, NULL),
(7, 1, 'XIAOMI Mi 10 Lite 5G 6GB +128 Gris CoSmico', 'XIOAMI', '189,00 €', NULL, NULL, NULL),
(8, 1, 'SAMNUNG GALAXI A31 AZUL 4 GB + 64 GB Movil Libre', 'SAMSUNG', '100,00 €', NULL, NULL, NULL),
(9, 1, 'APPLE IPHONE 11 128GB Malva movil libre', 'APPLE', '650,00 €', NULL, 'alta gama entorno empresa', NULL),
(10, 2, 'SAMSUN GALAXY A51 4+128GB AZUL MOVIL LIBRE', 'SAMSUNG', '190,00 €', NULL, NULL, NULL),
(11, 2, 'LG K30 NEGRO 2GB + 16 GB MOVIL LIBRE', 'LG', '70,00 €', NULL, NULL, NULL),
(12, 2, 'iaomi Redmi Note 8 Pro Mineral Grey 128 GB + 6 GB Móvil li', 'XIOAMI', '180,00 €', NULL, NULL, NULL),
(13, 2, 'Samsung Galaxy S10 Lite 8 GB + 128 GB Azul móvil libre', 'SAMSUNG', '300,00 €', NULL, 'alta gama entorno hogar', NULL),
(14, 1, 'Samsung Galaxy S10 Lite 8 GB + 128 GB Azul móvil libre', 'APPLE', '600,00 €', NULL, NULL, NULL),
(15, 1, 'amsung Galaxy A21s 4 + 64 GB blanco móvil libre', 'SAMSUNG', '100,00 €', NULL, NULL, NULL),
(16, 1, 'Bronze móvil libre', 'SAMSUNG', '850,00 €', NULL, 'baja gama entorno empresa', NULL),
(17, 1, 'Xiaomi MI 10T Pro 8 GB + 256 GB Cosmic Black móvil libre', 'XIOAMI', '580,00 €', NULL, NULL, NULL),
(18, 1, 'Huawei P40 Lite 6+128 GB Verde móvil libre', 'HUAWEI', '190,00 €', NULL, NULL, NULL),
(19, 1, 'LG K51S 3+64 GB titán móvil libr', 'LG', '100,00 €', NULL, NULL, NULL),
(20, 2, 'LENOVO ONM', 'LENOVO', '200', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(30) NOT NULL,
  `tlf_proveedor` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre_proveedor`, `tlf_proveedor`) VALUES
(1, 'Apple', '123456789'),
(2, 'Microsoft', '123456789'),
(3, 'alberto', ''),
(4, 'eva', ''),
(5, 'eva', ''),
(6, 'eva', ''),
(7, 'HP', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `Id_VENTAS` int(2) NOT NULL,
  `id_PRODUCTOS` int(2) DEFAULT NULL,
  `Id_CLIENTES` int(2) DEFAULT NULL,
  `FECHA_DE_VENTA` varchar(9) DEFAULT NULL,
  `UNIDADES` int(2) DEFAULT NULL,
  `FEMISION` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`Id_VENTAS`, `id_PRODUCTOS`, `Id_CLIENTES`, `FECHA_DE_VENTA`, `UNIDADES`, `FEMISION`) VALUES
(1, 1, 6, '01-oct-20', 10, '2023-03-15'),
(52, 2, 13, '16-sep-20', 1, '2023-03-15'),
(53, 1, 13, '30-nov-20', 1, '2023-03-15'),
(54, 10, 6, '18-dic-20', 1, '2023-03-15'),
(55, 8, 4, '19-dic-20', 1, '2023-03-15'),
(56, 7, 6, '20-dic-20', 1, NULL),
(58, 11, 4, '22-dic-20', 1, NULL),
(60, 5, 14, '24-dic-20', 1, NULL),
(61, 2, 14, '18-nov-20', 1, NULL),
(62, 2, 11, '26-dic-20', 1, NULL),
(64, 4, 2, '28-dic-20', 1, NULL),
(65, 6, 12, '29-dic-20', 1, NULL),
(68, 5, 8, '01-nov-20', 1, NULL),
(69, 9, 1, '02-ene-21', 1, NULL),
(70, 12, 10, '03-ene-21', 1, NULL),
(71, 12, 11, '04-ene-21', 1, NULL),
(72, 8, 7, '05-ene-21', 1, NULL),
(73, 3, 2, '01-oct-20', 1, NULL),
(74, 12, 6, '07-ene-21', 1, NULL),
(75, 9, 14, '08-ene-21', 1, NULL),
(76, 3, 13, '09-ene-21', 1, NULL),
(77, 12, 12, '10-ene-21', 1, NULL),
(78, 10, 2, '11-ene-21', 1, NULL),
(80, 6, 6, '13-ene-21', 1, NULL),
(81, 12, 9, '14-ene-21', 1, NULL),
(82, 3, 3, '15-ene-21', 1, NULL),
(85, 7, 7, '18-ene-21', 1, NULL),
(86, 8, 6, '19-ene-21', 1, NULL),
(87, 10, 14, '20-ene-21', 1, NULL),
(89, 9, 10, '22-ene-21', 1, NULL),
(90, 8, 13, '23-ene-21', 1, NULL),
(91, 1, 6, '11-nov-20', 1, NULL),
(92, 11, 13, '25-ene-21', 1, NULL),
(94, 2, 11, '27-ene-21', 1, NULL),
(95, 14, 4, '28-ene-21', 1, NULL),
(96, 8, 2, '29-ene-21', 1, NULL),
(99, 7, 13, '01-feb-21', 1, NULL);

-- 1º Calcula el número total de productos que hay en la tabla productos:

SELECT COUNT(*) AS TotalProductos FROM productos;

-- 2º Calcula el número total de fabricantes que hay en la tabla fabricante:

SELECT COUNT(DISTINCT fabricante) AS TotalFabricantes FROM productos;

-- Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.

SELECT COUNT(DISTINCT fabricante) AS ValoresDistintosFabricante FROM productos;

-- Calcula la media del precio de todos los productos:

SELECT AVG(precio) AS MediaPrecio FROM productos;

-- 5º Calcula el precio más barato de todos los productos:

SELECT MIN(precio) AS PrecioMasBarato FROM productos;

-- 6º Calcula el precio más caro de todos los productos:

SELECT MAX(precio) AS PrecioMasCaro FROM productos;

-- 7º Lista el nombre y el precio del producto más barato.

SELECT nombre, precio
FROM productos
WHERE precio = (SELECT MIN(precio) FROM productos);

-- 8º Lista el nombre y el precio del producto más caro:

SELECT nombre, precio
FROM productos
WHERE precio = (SELECT MAX(precio) FROM productos);

-- 9 Calcula la suma de los precios de todos los productos:

SELECT SUM(precio) AS SumaPrecios FROM productos;

-- 10º Calcula el número de productos que tiene el PROVEEDOR APPLE:
SELECT COUNT(*) AS NumeroProductosapple
FROM productos WHERE productos.id_proveedor=(SELECT proveedores.id_proveedor 
FROM PROVEEDORES WHERE nombre_PROVEEDOR = 'APPLE'); 

-- 11º Calcula el precio más barato de todos los productos del PROVEEDOR XIAOMI:

SELECT MIN(precio) AS PrecioMinXIAOMI FROM productos
WHERE productos.id_proveedor = (SELECT id_proveedor FROM proveedores 
WHERE proveedores.nombre_proveedor = 'LG');

-- 12º Calcula el precio más caro de todos los productos del proveedor LG

select max(precio) as PrecioMaxCaroLg from productos
where id_proveedor=(select id_proveedor from proveedores
where nombre_proveedor='LG');

-- 13º Calcula la suma de todos los productos del proveedor XIAOMI:
SELECT SUM(precio) AS SumaPreciosXIAOMI
FROM productos
WHERE id_proveedor= (SELECT id_proveedor FROM proveedores WHERE nombre_proveedor = 'XIAOMI');

-- 14º Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el proveedor XIAOMI:


SELECT 
    MAX(precio) AS PrecioMasCaroXIAOMI,
    MIN(precio) AS PrecioMasBaratoXIAOMI,
    AVG(precio) AS MediaPrecioXIAOMI,
    COUNT(*) AS TotalProductosXIAOMI
FROM productos
WHERE id_proveedor = (SELECT id_proveedor FROM proveedores WHERE nombre_proveedor = 'XIAOMI');

/*muestra el nombre de los clientes que han realizado compras con un precio promedio por encima
del promedio de todos los productos*/

SELECT c.nombre AS nombre_cliente
FROM clientes c
WHERE c.id_clientes IN (
  SELECT v.id_clientes
  FROM ventas v
  JOIN productos p ON v.id_PRODUCTOS= p.id_PRODUCTO
  GROUP BY v.id_PRODUCTOS
  HAVING AVG(p.precio) > (
    SELECT AVG(precio) FROM productos
  )
);




















