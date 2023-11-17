drop database simulacro;
create database simulacro;
use simulacro;

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `fabricante` varchar(50) DEFAULT NULL,
  `precio` float DEFAULT NULL,
  `nº_serie` int(11) DEFAULT NULL
);

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `nombre`, `descripcion`, `fabricante`, `precio`, `nº_serie`) VALUES
(1, 'portatil 1', 'portatil gama alta', 'HP', 1500, 111),
(2, 'portatil 2', 'portatil gama baja', 'APPLE', 10000, 222),
(3, 'monitor 1', 'monitor gama alta', 'LG', 800, 333),
(4, 'monitor 2', 'monitor gama baja', 'HP', 200, 444);
