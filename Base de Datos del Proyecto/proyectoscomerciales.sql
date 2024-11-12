-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-11-2024 a las 01:19:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectoscomerciales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etapa`
--

CREATE TABLE `etapa` (
  `idEtapa` int(11) NOT NULL,
  `etapaNombre` varchar(30) NOT NULL,
  `estadoEtapa` varchar(40) NOT NULL,
  `contratoEtapa` varchar(50) NOT NULL,
  `propuestaEtapa` varchar(40) NOT NULL,
  `montoEtapa` int(20) NOT NULL,
  `fechaCreacionEtapa` varchar(10) NOT NULL,
  `fechaAprobacionEtapa` varchar(10) NOT NULL,
  `idProyecto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `contrato` varchar(255) DEFAULT NULL,
  `propuesta` text DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_aprobacion` timestamp NULL DEFAULT NULL,
  `fecha_de_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_de_aprobacion` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `nombre`, `estado`, `contrato`, `propuesta`, `monto`, `fecha_creacion`, `fecha_aprobacion`, `fecha_de_creacion`, `fecha_de_aprobacion`) VALUES
(2, 'Proyecto B', 'pendiente', 'Contrato xd', 'Propuesta B', 75000.00, '2024-10-30 11:54:25', NULL, '2024-10-30 12:36:04', NULL),
(3, 'Proyecto C', 'aprobado', 'Contrato C', 'Propuesta C', 20000.00, '2024-10-30 11:54:25', NULL, '2024-10-30 12:36:04', NULL),
(4, 'Proyecto D', 'pendiente', 'Contrato D', 'Propuesta D', 100000.00, '2024-10-30 11:54:25', NULL, '2024-10-30 12:36:04', NULL),
(5, 'Proyecto E', '', 'Contrato E', 'Propuesta E', 30000.00, '2024-10-30 11:54:25', NULL, '2024-10-30 12:36:04', NULL),
(6, 'daniel', 'pendiente', 'rappi', 'exclavitud', 12.00, '2024-10-30 13:02:17', NULL, '2024-10-30 13:02:17', NULL),
(7, 'gfggf', 'pendiente', 'gfgdfgh', 'gfhjhj', 55545.00, '2024-10-30 13:17:41', NULL, '2024-10-30 13:17:41', NULL),
(8, 'papu lince', 'pendiente', 'dsasda', 'gfdfd', 1234.00, '2024-10-30 13:56:00', NULL, '2024-10-30 13:56:00', NULL),
(9, 'Polentazo', 'pendiente', 'no se permite objetos ilegales', 'Hacer el mejor viaje del mundo', 109000.00, '2024-11-01 14:59:14', NULL, '2024-11-01 14:59:14', NULL),
(10, 'papu lince', 'pendiente', 'skibidi', 'toilet', 69.00, '2024-11-05 11:52:33', NULL, '2024-11-05 11:52:33', NULL),
(11, 'Proyecto X', 'pendiente', 'X', 'X', 10.00, '2024-11-05 11:58:03', NULL, '2024-11-05 11:58:03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos_asignados`
--

CREATE TABLE `proyectos_asignados` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos_asignados`
--

INSERT INTO `proyectos_asignados` (`id`, `proyecto_id`, `usuario_id`) VALUES
(5, 3, 5),
(6, 6, 2),
(7, 10, 5),
(8, 11, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', 'xd', 'admin'),
(2, 'usuario', 'nashe', 'user'),
(5, 'usuario2', 'xd2', 'user'),
(6, 'usuario3', 'xd3', 'user');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `etapa`
--
ALTER TABLE `etapa`
  ADD PRIMARY KEY (`idEtapa`),
  ADD KEY `fk_proyecto` (`idProyecto`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proyectos_asignados`
--
ALTER TABLE `proyectos_asignados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `proyectos_asignados`
--
ALTER TABLE `proyectos_asignados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `etapa`
--
ALTER TABLE `etapa`
  ADD CONSTRAINT `fk_proyecto` FOREIGN KEY (`idProyecto`) REFERENCES `proyectos` (`id`);

--
-- Filtros para la tabla `proyectos_asignados`
--
ALTER TABLE `proyectos_asignados`
  ADD CONSTRAINT `proyectos_asignados_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `proyectos_asignados_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
