-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: courier
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '78db73cc-d199-11f0-bab7-f8e4e34e7be9:1-1792';

--
-- Table structure for table `destinatarios`
--

DROP TABLE IF EXISTS `destinatarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destinatarios` (
  `id_destinatario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `contacto` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) NOT NULL,
  PRIMARY KEY (`id_destinatario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinatarios`
--

LOCK TABLES `destinatarios` WRITE;
/*!40000 ALTER TABLE `destinatarios` DISABLE KEYS */;
INSERT INTO `destinatarios` VALUES (1,'Roberto Paez','0999111222','Av. 9 de Octubre 456, Guayaquil'),(2,'Camila Vera','0999222333','Av. Kennedy 789, Quito'),(3,'John Smith','+15551234567','5th Avenue 200, New York, USA'),(4,'Laura Jimenez','0999333444','Av. Eloy Alfaro 321, Quito'),(5,'Diego Salazar','0999444555','Malecon 2000, Guayaquil'),(6,'Marie Dubois','+33612345678','Rue de Rivoli 50, Paris, Francia'),(7,'Andres Leon','0999555666','Calle Larga 88, Cuenca'),(8,'Patricia Mora','0999666777','Av. Quito 150, Loja'),(9,'Michael Brown','+447911123456','Oxford Street 100, Londres, UK'),(10,'Isabel Castro','0999777888','Av. Del Ejercito 12, Guayaquil');
/*!40000 ALTER TABLE `destinatarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_paquete`
--

DROP TABLE IF EXISTS `detalles_paquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_paquete` (
  `id_dp` int NOT NULL AUTO_INCREMENT,
  `id_ge` int NOT NULL,
  `peso` decimal(6,2) NOT NULL,
  `largo` decimal(6,2) NOT NULL,
  `ancho` decimal(6,2) NOT NULL,
  `alto` decimal(6,2) NOT NULL,
  `contenido_declarado` varchar(200) DEFAULT NULL,
  `valor_asegurado` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_dp`),
  KEY `id_ge` (`id_ge`),
  CONSTRAINT `detalles_paquete_ibfk_1` FOREIGN KEY (`id_ge`) REFERENCES `guias_envios` (`id_ge`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_paquete`
--

LOCK TABLES `detalles_paquete` WRITE;
/*!40000 ALTER TABLE `detalles_paquete` DISABLE KEYS */;
INSERT INTO `detalles_paquete` VALUES (1,1,3.50,30.00,20.00,15.00,'Ropa',50.00),(2,2,5.00,40.00,30.00,25.00,'Libros',30.00),(3,3,8.20,50.00,40.00,30.00,'Electronicos',300.00),(4,4,2.00,25.00,15.00,10.00,'Documentos',20.00),(5,5,4.30,35.00,25.00,20.00,'Zapatos',60.00),(6,6,10.00,60.00,45.00,35.00,'Regalos',150.00),(7,7,1.50,20.00,15.00,10.00,'Accesorios',25.00),(8,8,6.70,45.00,35.00,25.00,'Juguetes',80.00),(9,9,9.10,55.00,40.00,30.00,'Herramientas',200.00),(10,10,3.00,28.00,18.00,12.00,'Cosmeticos',40.00),(11,11,35.00,2.00,2.00,2.00,'Relojes',20.00),(12,12,35.00,23.00,30.00,20.00,'Ropa',50.00),(13,13,35.00,170.00,150.00,100.00,'Disfraces',100.00),(14,14,15.00,50.00,20.00,25.00,'Perfumes',125.00),(15,15,7.50,40.00,40.00,40.00,'Caja de ropa',100.00);
/*!40000 ALTER TABLE `detalles_paquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guias_envios`
--

DROP TABLE IF EXISTS `guias_envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guias_envios` (
  `id_ge` int NOT NULL AUTO_INCREMENT,
  `id_remitente` int NOT NULL,
  `id_destinatario` int NOT NULL,
  `direccion_origen` varchar(200) NOT NULL,
  `fecha_despacho` date NOT NULL,
  `costo_total` decimal(10,2) DEFAULT NULL,
  `estado` enum('Pendiente','Asignado','En Recolección','En Tránsito','Entregado','Cancelado') DEFAULT 'Pendiente',
  `tiempo_entrega` varchar(50) DEFAULT NULL,
  `tipo_envio` enum('Nacional','Internacional') NOT NULL,
  PRIMARY KEY (`id_ge`),
  KEY `id_remitente` (`id_remitente`),
  KEY `id_destinatario` (`id_destinatario`),
  CONSTRAINT `guias_envios_ibfk_1` FOREIGN KEY (`id_remitente`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `guias_envios_ibfk_3` FOREIGN KEY (`id_destinatario`) REFERENCES `destinatarios` (`id_destinatario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guias_envios`
--

LOCK TABLES `guias_envios` WRITE;
/*!40000 ALTER TABLE `guias_envios` DISABLE KEYS */;
INSERT INTO `guias_envios` VALUES (1,2,1,'Av. Amazonas 123, Quito','2026-08-15',12.50,'Entregado','2 dias','Nacional'),(2,3,2,'Calle Bolivar 45, Cuenca','2026-08-16',15.00,'En Tránsito','3 dias','Nacional'),(3,4,3,'Av. 6 de Diciembre 100, Quito','2026-08-17',45.00,'Pendiente','7 dias','Internacional'),(4,7,4,'Calle Rocafuerte 55, Ambato','2026-08-14',10.00,'Entregado','1 dia','Nacional'),(5,8,5,'Av. Colon 200, Quito','2026-08-18',13.75,'Asignado','2 dias','Nacional'),(6,2,6,'Calle Venezuela 10, Quito','2026-08-19',60.00,'Pendiente','10 dias','Internacional'),(7,3,7,'Av. Rio Amazonas 500, Quito','2026-08-13',9.50,'Entregado','1 dia','Nacional'),(8,4,8,'Av. Naciones Unidas 300, Quito','2026-08-20',18.00,'En Recolección','3 dias','Nacional'),(9,7,9,'Av. Shyris 250, Quito','2026-08-20',55.00,'Pendiente','8 dias','Internacional'),(10,8,10,'Calle Sucre 33, Quito','2026-08-12',11.25,'Cancelado','2 dias','Nacional'),(11,7,7,'Ibarra','2026-08-30',2.30,'En Tránsito','2 a 3 días hábiles','Nacional'),(12,7,6,'Ecuador','2026-08-30',17.30,'Entregado','7 a 10 días hábiles','Internacional'),(13,7,6,'Ibarra, Ecuador','2026-08-31',17.30,'Pendiente','7 a 10 días hábiles','Internacional'),(14,7,3,'Ibarra','2026-08-31',17.75,'En Tránsito','7 a 10 días hábiles','Internacional'),(15,15,5,'Los Ceibos','2026-08-31',3.20,'Pendiente','2 a 3 días hábiles','Nacional');
/*!40000 ALTER TABLE `guias_envios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarifas_peso`
--

DROP TABLE IF EXISTS `tarifas_peso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarifas_peso` (
  `id_tarifa` int NOT NULL AUTO_INCREMENT,
  `peso_min` decimal(10,2) NOT NULL,
  `peso_max` decimal(10,2) NOT NULL,
  `precio_kg` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_tarifa`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifas_peso`
--

LOCK TABLES `tarifas_peso` WRITE;
/*!40000 ALTER TABLE `tarifas_peso` DISABLE KEYS */;
INSERT INTO `tarifas_peso` VALUES (1,0.00,1.00,4.50),(2,1.00,5.00,3.80),(3,5.00,10.00,3.20),(4,10.00,20.00,2.75),(5,20.00,50.00,2.30);
/*!40000 ALTER TABLE `tarifas_peso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('Administrador','Remitente') NOT NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Carlos Andrade','carlos.andrade@mail.com','0991234567','candrade','1234','Administrador','Activo'),(2,'Maria Sanchez','maria.sanchez@mail.com','0987654321','msanchez','1234','Remitente','Activo'),(3,'Luis Torres','luis.torres@mail.com','0976543210','ltorres','1234','Remitente','Activo'),(4,'Ana Ramirez','ana.ramirez@mail.com','0965432109','aramirez','1234','Remitente','Inhabilitado'),(5,'Pedro Vega','pedro.vega@mail.com','0954321098','pvega','1234','Administrador','Activo'),(6,'Sofia Morales','sofia.morales@mail.com','0943210987','smorales','1234','Administrador','Activo'),(7,'Jorge Castillo','jorge.castillo@mail.com','0932109876','jcastillo','1234','Remitente','Activo'),(8,'Daniela Ortiz','daniela.ortiz@mail.com','0921098765','dortiz','1234','Remitente','Inhabilitado'),(9,'Miguel Rios','miguel.rios@mail.com','0910987654','mrios','1234','Administrador','Activo'),(10,'Valentina Cruz','valentina.cruz@mail.com','0909876543','vcruz','1234','Administrador','Activo'),(11,'Dilan Suarez','dxlansuarez@hotmail.com','0968145241','DilanPA','12345','Administrador','Activo'),(12,'Axel Andrade','axel18_01@hotmail.com','0939008101','Axelillo','123456','Remitente','Activo'),(13,'David Queenn','davoobj@gmail.com','0939272720','Davo Xeneize','12345','Administrador','Inhabilitado'),(14,'Lautaro Del Campo','lacobraa@gmail.com','0984758654','LACOBRAA','12345','Administrador','Inhabilitado'),(15,'Gaby Valladares','g@gmail.com','0992937736','gv','123a','Remitente','Activo');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'courier'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizar_estado_guias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_guias`(IN p_id_ge INT,
    IN p_nuevo_estado VARCHAR(30))
BEGIN

UPDATE guias_envios
    SET estado = p_nuevo_estado
    WHERE id_ge = p_id_ge;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_usuario`(IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_rol VARCHAR(20),
    OUT p_filasAfectadas INT)
BEGIN

    UPDATE Usuarios
    SET nombre = p_nombre, email = p_email, telefono = p_telefono, rol = p_rol
    WHERE id_usuario = p_id;
    SET p_filasAfectadas = ROW_COUNT();
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_detalle_paquete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_detalle_paquete`(IN p_id_ge INT,
    IN p_peso DECIMAL(10,2),
    IN p_largo DECIMAL(10,2),
    IN p_ancho DECIMAL(10,2),
    IN p_alto DECIMAL(10,2),
    IN p_contenido_declarado VARCHAR(200),
    IN p_valor_asegurado DECIMAL(10,2))
BEGIN

INSERT INTO Detalles_paquete (id_ge, peso, largo, ancho, alto, contenido_declarado, valor_asegurado)
    VALUES (p_id_ge, p_peso, p_largo, p_ancho, p_alto, p_contenido_declarado, p_valor_asegurado);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_guia_envio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_guia_envio`(IN p_id_remitente INT,
    IN p_id_destinatario INT,
    IN p_direccion_origen VARCHAR(200),
    IN p_costo_total DECIMAL(10,2),
    IN p_tiempo_entrega VARCHAR(50),
    IN p_tipo_envio VARCHAR(20),
    OUT p_id_ge INT)
BEGIN

    INSERT INTO Guias_envios (id_remitente, id_destinatario, direccion_origen, fecha_despacho, costo_total, estado, tiempo_entrega, tipo_envio)
    VALUES (p_id_remitente, p_id_destinatario, p_direccion_origen, CURDATE(), p_costo_total, 'Pendiente', p_tiempo_entrega, p_tipo_envio);
    SET p_id_ge = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_usuario`(IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_username VARCHAR(50),
    IN p_contrasena VARCHAR(255),
    IN p_rol VARCHAR(20),
    OUT p_idGenerado INT)
BEGIN

INSERT INTO Usuarios (nombre, email, telefono, username, contrasena, rol, estado)
    VALUES (p_nombre, p_email, p_telefono, p_username, p_contrasena, p_rol, 'Activo');
    SET p_idGenerado = LAST_INSERT_ID();
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inhabilitar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inhabilitar_usuario`(IN p_id INT,
    OUT p_filasAfectadas INT)
BEGIN

UPDATE Usuarios SET estado = 'Inhabilitado' WHERE id_usuario = p_id;
    SET p_filasAfectadas = ROW_COUNT();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inicio_sesion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inicio_sesion`(IN p_username VARCHAR(50),
    IN p_contrasena VARCHAR(50))
BEGIN

	SELECT id_usuario, nombre, email, telefono, rol, estado
		FROM usuarios
		WHERE username = p_username AND contrasena = p_contrasena;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mostrar_destinatarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_destinatarios`()
BEGIN

SELECT id_Destinatario, nombre, contacto, direccion
    FROM destinatarios;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mostrar_guias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_guias`()
BEGIN

    SELECT g.id_ge, u.nombre AS remitente, d.nombre AS destinatario, g.estado, g.costo_total, g.fecha_despacho
    FROM Guias_envios g
    JOIN Usuarios u ON g.id_remitente = u.id_usuario
    JOIN Destinatarios d ON g.id_destinatario = d.id_Destinatario
    ORDER BY g.id_ge;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mostrar_guias_remitente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_guias_remitente`(IN p_id_remitente INT)
BEGIN

    SELECT g.id_ge, d.nombre AS destinatario, g.estado, g.costo_total, g.fecha_despacho, g.tipo_envio
    FROM guias_envios g
    JOIN destinatarios d ON g.id_destinatario = d.id_destinatario
    WHERE g.id_remitente = p_id_remitente
    ORDER BY g.id_ge;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mostrar_remitentes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_remitentes`()
BEGIN

SELECT id_usuario, nombre
    FROM usuarios
    WHERE rol = 'Remitente'
    ORDER BY nombre;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mostrar_tarifas_peso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_tarifas_peso`()
BEGIN

SELECT id_tarifa, peso_min, peso_max, precio_kg
    FROM tarifas_peso;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mostrar_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_usuarios`()
BEGIN

SELECT * FROM Usuarios;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reportes_envios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reportes_envios`(IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_id_remitente INT,
    IN p_tipo_envio VARCHAR(20))
BEGIN

    SELECT ge.tipo_envio, COUNT(*) AS cantidad
    FROM guias_envios ge
    WHERE ge.fecha_despacho BETWEEN p_fecha_inicio AND p_fecha_fin
      AND (p_id_remitente IS NULL OR ge.id_remitente = p_id_remitente)
      AND (p_tipo_envio IS NULL OR ge.tipo_envio = p_tipo_envio)
    GROUP BY ge.tipo_envio;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-01 22:55:47
