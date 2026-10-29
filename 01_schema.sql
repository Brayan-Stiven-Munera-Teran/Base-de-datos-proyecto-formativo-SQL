-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: transikids
-- ------------------------------------------------------
-- Server version	5.5.5-10.11.16-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asistencias`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencias` (
  `id_asistencia` int(11) NOT NULL AUTO_INCREMENT,
  `id_viaje` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `id_parada` int(11) NOT NULL,
  `estado_asistencia` enum('subio','bajo','ausente','justificado') NOT NULL,
  `fecha_hora_evento` datetime NOT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_asistencia`),
  KEY `fk_asistencias_viajes` (`id_viaje`),
  KEY `fk_asistencias_estudiantes` (`id_estudiante`),
  KEY `fk_asistencias_paradas` (`id_parada`),
  CONSTRAINT `fk_asistencias_estudiantes` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_paradas` FOREIGN KEY (`id_parada`) REFERENCES `paradas` (`id_parada`) ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_viajes` FOREIGN KEY (`id_viaje`) REFERENCES `viajes` (`id_viaje`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias`
--

LOCK TABLES `asistencias` WRITE;
/*!40000 ALTER TABLE `asistencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auxiliares`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auxiliares` (
  `id_auxiliar` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `certificacion_primeros_auxilios` tinyint(1) NOT NULL DEFAULT 0,
  `observaciones` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_auxiliar`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `fk_auxiliares_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auxiliares`
--

LOCK TABLES `auxiliares` WRITE;
/*!40000 ALTER TABLE `auxiliares` DISABLE KEYS */;
/*!40000 ALTER TABLE `auxiliares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `codigos_entrega`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `codigos_entrega` (
  `id_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `id_viaje` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `codigo_seguridad` varchar(10) NOT NULL,
  `tipo_documento_receptor` enum('CC','CE','PASAPORTE','PPT','OTRO') DEFAULT NULL,
  `documento_receptor` varchar(30) DEFAULT NULL,
  `nombre_receptor` varchar(150) DEFAULT NULL,
  `validado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_hora_validacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_codigo`),
  KEY `fk_codigos_viajes` (`id_viaje`),
  KEY `fk_codigos_estudiantes` (`id_estudiante`),
  CONSTRAINT `fk_codigos_estudiantes` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON UPDATE CASCADE,
  CONSTRAINT `fk_codigos_viajes` FOREIGN KEY (`id_viaje`) REFERENCES `viajes` (`id_viaje`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codigos_entrega`
--

LOCK TABLES `codigos_entrega` WRITE;
/*!40000 ALTER TABLE `codigos_entrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `codigos_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conductores`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conductores` (
  `id_conductor` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `numero_licencia` varchar(50) NOT NULL,
  `categoria_licencia` varchar(10) NOT NULL,
  `fecha_vencimiento_licencia` date NOT NULL,
  `anios_experiencia` int(11) NOT NULL DEFAULT 0,
  `estado_disponibilidad` enum('disponible','en_ruta','incapacitado','vacaciones') NOT NULL DEFAULT 'disponible',
  PRIMARY KEY (`id_conductor`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `numero_licencia` (`numero_licencia`),
  CONSTRAINT `fk_conductores_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conductores`
--

LOCK TABLES `conductores` WRITE;
/*!40000 ALTER TABLE `conductores` DISABLE KEYS */;
/*!40000 ALTER TABLE `conductores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escuelas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `escuelas` (
  `id_escuela` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `telefono_contacto` varchar(20) NOT NULL,
  PRIMARY KEY (`id_escuela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escuelas`
--

LOCK TABLES `escuelas` WRITE;
/*!40000 ALTER TABLE `escuelas` DISABLE KEYS */;
/*!40000 ALTER TABLE `escuelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes` (
  `id_estudiante` int(11) NOT NULL AUTO_INCREMENT,
  `id_padre` int(11) NOT NULL,
  `id_escuela` int(11) NOT NULL,
  `tipo_documento` enum('TI','RC','CE','PASAPORTE','PPT','OTRO') NOT NULL,
  `documento_identidad` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `grado_curso` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `informacion_medica` text DEFAULT NULL,
  `foto_url` varchar(255) DEFAULT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_estudiante`),
  UNIQUE KEY `uk_estudiantes_tipo_documento` (`tipo_documento`,`documento_identidad`),
  KEY `fk_estudiantes_padres` (`id_padre`),
  KEY `fk_estudiantes_escuelas` (`id_escuela`),
  CONSTRAINT `fk_estudiantes_escuelas` FOREIGN KEY (`id_escuela`) REFERENCES `escuelas` (`id_escuela`) ON UPDATE CASCADE,
  CONSTRAINT `fk_estudiantes_padres` FOREIGN KEY (`id_padre`) REFERENCES `padres` (`id_padre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes_ruta`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes_ruta` (
  `id_estudiante_ruta` int(11) NOT NULL AUTO_INCREMENT,
  `id_estudiante` int(11) NOT NULL,
  `id_ruta` int(11) NOT NULL,
  `id_parada` int(11) NOT NULL,
  `dias_semana` varchar(20) NOT NULL DEFAULT 'L-M-M-J-V',
  `estado` enum('activo','pausado','cancelado') NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_estudiante_ruta`),
  UNIQUE KEY `uk_estudiante_ruta` (`id_estudiante`,`id_ruta`),
  KEY `fk_er_rutas` (`id_ruta`),
  KEY `fk_er_paradas` (`id_parada`),
  CONSTRAINT `fk_er_estudiantes` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_er_paradas` FOREIGN KEY (`id_parada`) REFERENCES `paradas` (`id_parada`) ON UPDATE CASCADE,
  CONSTRAINT `fk_er_rutas` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes_ruta`
--

LOCK TABLES `estudiantes_ruta` WRITE;
/*!40000 ALTER TABLE `estudiantes_ruta` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiantes_ruta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_viaje` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `mensaje` text NOT NULL,
  `tipo_canal` enum('push','sms','email','in_app') NOT NULL DEFAULT 'push',
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_envio` datetime NOT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `fk_notificaciones_usuarios` (`id_usuario`),
  KEY `fk_notificaciones_viajes` (`id_viaje`),
  CONSTRAINT `fk_notificaciones_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_notificaciones_viajes` FOREIGN KEY (`id_viaje`) REFERENCES `viajes` (`id_viaje`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `novedades`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `novedades` (
  `id_novedad` int(11) NOT NULL AUTO_INCREMENT,
  `id_viaje` int(11) DEFAULT NULL,
  `id_usuario_reporta` int(11) NOT NULL,
  `tipo_novedad` enum('mecanica','trafico','salud_estudiante','clima','conducta','otro') NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `gravedad` enum('baja','media','alta') NOT NULL DEFAULT 'baja',
  PRIMARY KEY (`id_novedad`),
  KEY `fk_novedades_viajes` (`id_viaje`),
  KEY `fk_novedades_usuarios` (`id_usuario_reporta`),
  CONSTRAINT `fk_novedades_usuarios` FOREIGN KEY (`id_usuario_reporta`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE,
  CONSTRAINT `fk_novedades_viajes` FOREIGN KEY (`id_viaje`) REFERENCES `viajes` (`id_viaje`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novedades`
--

LOCK TABLES `novedades` WRITE;
/*!40000 ALTER TABLE `novedades` DISABLE KEYS */;
/*!40000 ALTER TABLE `novedades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `padres`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `padres` (
  `id_padre` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `direccion_residencia` varchar(255) NOT NULL,
  `telefono_emergencia` varchar(20) NOT NULL,
  `parentesco` varchar(50) NOT NULL,
  PRIMARY KEY (`id_padre`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `fk_padres_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `padres`
--

LOCK TABLES `padres` WRITE;
/*!40000 ALTER TABLE `padres` DISABLE KEYS */;
/*!40000 ALTER TABLE `padres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paradas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paradas` (
  `id_parada` int(11) NOT NULL AUTO_INCREMENT,
  `id_ruta` int(11) NOT NULL,
  `nombre_parada` varchar(100) NOT NULL,
  `direccion_referencia` varchar(255) NOT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `orden_secuencia` int(11) NOT NULL,
  `hora_estimada` time NOT NULL,
  PRIMARY KEY (`id_parada`),
  KEY `fk_paradas_rutas` (`id_ruta`),
  CONSTRAINT `fk_paradas_rutas` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paradas`
--

LOCK TABLES `paradas` WRITE;
/*!40000 ALTER TABLE `paradas` DISABLE KEYS */;
/*!40000 ALTER TABLE `paradas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posiciones_viaje`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posiciones_viaje` (
  `id_posicion` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_viaje` int(11) NOT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `velocidad_kmh` decimal(5,2) DEFAULT NULL,
  `rumbo_grados` decimal(5,2) DEFAULT NULL,
  `fecha_hora_reporte` datetime NOT NULL,
  PRIMARY KEY (`id_posicion`),
  KEY `idx_posiciones_viaje_tiempo` (`id_viaje`,`fecha_hora_reporte`),
  CONSTRAINT `fk_posiciones_viajes` FOREIGN KEY (`id_viaje`) REFERENCES `viajes` (`id_viaje`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posiciones_viaje`
--

LOCK TABLES `posiciones_viaje` WRITE;
/*!40000 ALTER TABLE `posiciones_viaje` DISABLE KEYS */;
/*!40000 ALTER TABLE `posiciones_viaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutas` (
  `id_ruta` int(11) NOT NULL AUTO_INCREMENT,
  `id_escuela` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `id_conductor` int(11) NOT NULL,
  `id_auxiliar` int(11) NOT NULL,
  `nombre_ruta` varchar(100) NOT NULL,
  `tipo_trayecto` enum('recogida','entrega','mixto') NOT NULL,
  `hora_inicio_estimada` time NOT NULL,
  PRIMARY KEY (`id_ruta`),
  KEY `fk_rutas_escuelas` (`id_escuela`),
  KEY `fk_rutas_vehiculos` (`id_vehiculo`),
  KEY `fk_rutas_conductores` (`id_conductor`),
  KEY `fk_rutas_auxiliares` (`id_auxiliar`),
  CONSTRAINT `fk_rutas_auxiliares` FOREIGN KEY (`id_auxiliar`) REFERENCES `auxiliares` (`id_auxiliar`) ON UPDATE CASCADE,
  CONSTRAINT `fk_rutas_conductores` FOREIGN KEY (`id_conductor`) REFERENCES `conductores` (`id_conductor`) ON UPDATE CASCADE,
  CONSTRAINT `fk_rutas_escuelas` FOREIGN KEY (`id_escuela`) REFERENCES `escuelas` (`id_escuela`) ON UPDATE CASCADE,
  CONSTRAINT `fk_rutas_vehiculos` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculos` (`id_vehiculo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutas`
--

LOCK TABLES `rutas` WRITE;
/*!40000 ALTER TABLE `rutas` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NOT NULL,
  `tipo_documento` enum('CC','CE','TI','PASAPORTE','PPT','OTRO') NOT NULL,
  `documento_identidad` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `estado` enum('activo','inactivo','bloqueado') NOT NULL DEFAULT 'activo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `uk_usuarios_tipo_documento` (`tipo_documento`,`documento_identidad`),
  KEY `fk_usuarios_roles` (`id_rol`),
  CONSTRAINT `fk_usuarios_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiculos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculos` (
  `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `placa` varchar(15) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `anio` int(11) NOT NULL,
  `capacidad_pasajeros` int(11) NOT NULL,
  `numero_soat` varchar(50) NOT NULL,
  `vencimiento_soat` date NOT NULL,
  `vencimiento_tecnomecanica` date NOT NULL,
  `estado` enum('operativo','en_taller','fuera_servicio') NOT NULL DEFAULT 'operativo',
  PRIMARY KEY (`id_vehiculo`),
  UNIQUE KEY `placa` (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculos`
--

LOCK TABLES `vehiculos` WRITE;
/*!40000 ALTER TABLE `vehiculos` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehiculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viajes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viajes` (
  `id_viaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_ruta` int(11) NOT NULL,
  `id_conductor` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `id_auxiliar` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_salida_real` datetime DEFAULT NULL,
  `hora_llegada_real` datetime DEFAULT NULL,
  `kilometraje_inicial` decimal(10,2) DEFAULT NULL,
  `kilometraje_final` decimal(10,2) DEFAULT NULL,
  `estado` enum('programado','en_curso','finalizado','cancelado') NOT NULL DEFAULT 'programado',
  PRIMARY KEY (`id_viaje`),
  KEY `fk_viajes_rutas` (`id_ruta`),
  KEY `fk_viajes_conductores` (`id_conductor`),
  KEY `fk_viajes_vehiculos` (`id_vehiculo`),
  KEY `fk_viajes_auxiliares` (`id_auxiliar`),
  CONSTRAINT `fk_viajes_auxiliares` FOREIGN KEY (`id_auxiliar`) REFERENCES `auxiliares` (`id_auxiliar`) ON UPDATE CASCADE,
  CONSTRAINT `fk_viajes_conductores` FOREIGN KEY (`id_conductor`) REFERENCES `conductores` (`id_conductor`) ON UPDATE CASCADE,
  CONSTRAINT `fk_viajes_rutas` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`) ON UPDATE CASCADE,
  CONSTRAINT `fk_viajes_vehiculos` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculos` (`id_vehiculo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes`
--

LOCK TABLES `viajes` WRITE;
/*!40000 ALTER TABLE `viajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `viajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'transikids'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-29  9:57:35
