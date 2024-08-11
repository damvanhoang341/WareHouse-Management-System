-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: swp_project
-- ------------------------------------------------------
-- Server version	8.0.37

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

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `Account_Id` int NOT NULL AUTO_INCREMENT,
  `Account_Name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Staff_Name` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Phone` varchar(250) NOT NULL,
  `Email` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SAddress` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Role_Id` int DEFAULT NULL,
  `Password` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `profileImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Account_Id`),
  KEY `Role_Id` (`Role_Id`),
  CONSTRAINT `Account_ibfk_1` FOREIGN KEY (`Role_Id`) REFERENCES `roles` (`Role_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'admin','Quang','0346963168','quangsan621@gmail.com','Hà Nội',1,'12345678',NULL),(2,'check','Dang Duc','0342213621','dangduc504@gmail.com','nghe an',3,'4f9f10b304cfe9b2b11fcb1387f694e18f08ea358c7e9f567434d3ad6cbd7fc4','uploads/2_202407_Nitro_Wallpaper_07_3840x2400.jpg'),(11,'user','thanh','0356239023','thanhconjmg2003@gmail.com','ha noi',1,'924592b9b103f14f833faafb67f480691f01988aa457c0061769f58cd47311bc','uploads/11_202407_Nitro_Wallpaper_06_3840x2400.jpg'),(12,'user1','do tien thanh','034203003117','chungthanh2003@gmail.com','ha noi',3,'afa6f67fecf04e1a234634227e054c5447528140a7dd059798e62f8c6ab0e732',NULL),(14,'admin1','Nam','0976999831','dotienthanh2003@gmail.com','ha noi',2,'924592b9b103f14f833faafb67f480691f01988aa457c0061769f58cd47311bc',NULL),(22,'thanh2003','thanhdo','0967487329','thanhdosky2003@gmail.com','150 đường Hoàng Hoa Thám , Hà Nội',2,'d864c5431df52e05ef94c7f2febcec36cedbc6513e440bf2e5808f51252b20cc','uploads/22_202407_Nitro_Wallpaper_05_3840x2400.jpg');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car` (
  `Car_Id` int NOT NULL AUTO_INCREMENT,
  `Car_Name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Car_origin` longtext,
  `Car_description` longtext,
  PRIMARY KEY (`Car_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (1,'INNOVA','Nhật Bản','Toyota Innova là dòng xe MPV được ưa chuộng nhất tại thị trường Việt Nam, với một thiết kế linh hoạt phục vụ nhiều đối tượng khách hàng từ các gia đình đến các doanh nghiệp vận tải. Thế hệ mới của Toyota Innova đã được ra mắt tại Việt Nam vào ngày 18/7/2016, đánh dấu một sự thay đổi toàn diện về hình dáng cũng như giá trị của mẫu xe này. Phiên bản cao cấp nhất, bản V, có giá gần 1 tỷ đồng, là một minh chứng cho việc MPV này đang dần rời xa khái niệm ban đầu của dự án “Xe đa dụng đổi mới toàn cầu” (IMV) dành cho các thị trường đang phát triển, nơi mà mẫu xe này được biết đến với giá cả hợp lý, độ bền và tính đa dụng.'),(2,'MATIZ','Hàn Quốc','Daewoo Matiz (còn gọi là Chevrolet Spark ở một số phiên bản) là một loại xe hơi nội thị sản xuất bởi GM Daewoo từ năm 1998. Nó thay thế Daewoo Tico, một biến thể của Suzuki Alto năm 1981. Nó đã được bán ở nhiều nước dưới nhiều tên gọi khác nhau, tùy theo sở thích thị trường địa phương.'),(3,'MAZDA','Nhật Bản','Dòng xe Mazda hiện nay bao gồm nhiều mẫu xe phổ biến như Mazda3, Mazda6, Mazda CX-3, CX-5, CX-9 và Mazda MX-5 (còn gọi là Miata). Mazda được biết đến với thiết kế đậm chất thể thao và công nghệ Skyactiv, nhằm tối ưu hóa hiệu suất và tiết kiệm nhiên liệu.Mazda luôn chú trọng vào chất lượng và trải nghiệm lái xe, mang đến sự lựa chọn đa dạng cho người tiêu dùng từ xe hạng nhỏ đến xe SUV và xe thể thao.\n\n\n\n\n\n\n'),(4,'HUYNDAI','Hàn Quốc','Hyundai là công ty sản xuất oto nổi tiếng từ Hàn Quốc và có trụ sở tại Seoul. Được thành lập vào năm 1967, Hyundai dần vươn mình phát triển vững mạnh, trở thành nhà sản xuất oto hàng đầu thế giới hiện nay.'),(5,'CỬU LONG','Việt Nam','Cửu Long là dòng xe ben với kiểu dáng hiện đại tinh tế, đa dạng về tải trọng được sản xuất và lắp ráp trên dây chuyền công nghệ hiện đại tại nhà máy Ô Tô Cửu Long. TMT đã không ngừng phát triển, cải tiến công nghệ, nội địa hóa sản phẩm nhằm mang đến cho người dùng những dòng xe ben tốt nhất với giá thành hợp lý nhất.'),(6,'ISUZU','Nhật Bản','Năm 2005, Isuzu trở thành hãng lớn nhất thế giới sản xuất các dòng xe tải từ trung bình đến hạng nặng.  Isuzu nổi tiếng về sản xuất các xe thương mại và động cơ diesel. Vào năm 2009, Isuzu đã sản xuất được 21 triệu động cơ diesel. Động cơ diesel của Isuzu được các hãng ô tô khác như Renault, Opel và General Motors sử dụng.'),(7,'VIOS','Nhật Bản','Dòng xe Toyota Vios là một trong những mẫu xe sedan nhỏ phổ biến của hãng Toyota, đặc biệt được ưa chuộng tại các thị trường Đông Nam Á, bao gồm cả Việt Nam.Vios có thiết kế đơn giản, thể hiện sự thanh lịch và tiện dụng. Đây là một mẫu xe sedan hạng nhỏ, phù hợp cho việc di chuyển trong thành phố và cả trên đường cao tốc.Nó có  thiết kế đơn giản, hiệu suất ổn định và tính tiện ích cao, phù hợp cho nhu cầu sử dụng hàng ngày và di chuyển trong đô thị.'),(8,'TOYOTA','Nhật Bản','Dòng xe Toyota bao gồm rất nhiều mẫu xe khác nhau, đáp ứng từ các nhu cầu sử dụng cá nhân đến các nhu cầu của gia đình và doanh nghiệp.Toyota nổi tiếng với sự đa dạng và chất lượng sản phẩm cao, mang lại các giải pháp di chuyển phù hợp cho nhiều đối tượng khách hàng trên toàn thế giới.'),(9,'KIA','Hàn Quốc','\nDòng xe Kia Morning, được biết đến như là Kia Picanto tại nhiều thị trường quốc tế, là một mẫu xe hatchback nhỏ gọn và rất phổ biến của hãng xe Hàn Quốc Kia. Kia Morning (hoặc Kia Picanto) là một mẫu xe hatchback nhỏ gọn, phổ biến với thiết kế hiện đại, tính tiện nghi và tiết kiệm năng lượng, phù hợp cho nhu cầu di chuyển hàng ngày và trong thành phố.'),(10,'FORD','Hoa Kì','\nDòng xe của Ford bao gồm nhiều mẫu xe đa dạng từ các loại sedan, crossover, SUV đến xe bán tải và xe thể thao. Ford nổi tiếng với sự đa dạng và sự phát triển của các mẫu xe hiện đại và tiện ích. Ford là một trong những nhà sản xuất xe hơi lâu đời và lớn nhất trên thế giới, cung cấp các giải pháp di chuyển phù hợp cho nhiều đối tượng khách hàng và điều kiện sử dụng khác nhau'),(11,'HONDA','Nhật Bản','Dòng xe của Honda bao gồm nhiều mẫu xe phổ biến và đa dạng từ sedan, hatchback, SUV đến xe thể thao và xe địa hình. Honda nổi tiếng với sự đổi mới công nghệ, hiệu suất và độ tin cậy của các sản phẩm của mình.Honda là một trong những thương hiệu ô tô lớn và có uy tín trên toàn cầu, cung cấp các sản phẩm chất lượng và đa dạng, phù hợp với nhiều nhu cầu và phong cách sử dụng khác nhau'),(12,'SUZUKI','Nhật Bản','Dòng xe của Suzuki bao gồm các mẫu xe phổ biến từ sedan, hatchback, SUV đến xe du lịch và xe thể thao nhỏ. Suzuki nổi tiếng với sự đơn giản, độ tin cậy và khả năng tiết kiệm nhiên liệu của các sản phẩm của mình.Suzuki là một thương hiệu xe hơi Nhật Bản có mặt trên toàn cầu, cung cấp các giải pháp di chuyển đa dạng và phù hợp với nhiều đối tượng khách hàng khác nhau. Các mẫu xe của Suzuki thường mang đến sự đơn giản, tiết kiệm và sự tin cậy trong mọi điều kiện sử dụng.\n\n\n\n\n\n\n'),(13,'MITSUBISHI','Nhật Bản','Dòng xe Mitsubishi bao gồm các mẫu xe đa dạng từ sedan, hatchback, SUV đến xe bán tải và xe điện. Mitsubishi nổi tiếng với sự bền bỉ, độ tin cậy và khả năng vận hành ổn định của các sản phẩm của mình.'),(14,'NISSAN','Nhật Bản','Hãng xe Nissan là một hãng xe ô tô lớn của Nhật Bản, Nissan được thành lập vào tháng 12 năm 1933,  sau gần 85 năm hình thành và phát triển, dòng xe Nissan đã khẳng định được vị thế của mình trên “ thương trường ” các hãng sản xuất ô tô trên thế giới.'),(15,'THACO','Việt Nam','là một trong những thương hiệu xe lớn của Việt Nam, sản xuất và lắp ráp trong nước, đạt tiêu chuẩn châu Âu, được nhiều khách hàng tin tưởng lựa chọn trong 26 năm qua.'),(16,'KENBO','Trung Quốc ','Hãng xe Kenbo là một thương hiệu thuộc Tập đoàn Ô Tô Bắc Kinh Trung Quốc sản xuất. Mặc dù có nguồn gốc xuất xứ là từ Trung Quốc nhưng đây là một thương hiệu lớn lâu năm vì thế về chất lượng và uy tín thì không phải bàn. Các dòng xe của Kenbo khi về Việt Nam sẽ được lắp ráp linh kiện đồng bộ bởi Nhà Máy Ô Tô Chiến Thắng.');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Customer_Id` int NOT NULL AUTO_INCREMENT,
  `Type_Id` int NOT NULL,
  `Customer_Name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Customer_Phone` varchar(45) DEFAULT NULL,
  `Customer_Address` varchar(255) DEFAULT NULL,
  `Customer_Tax` varchar(255) DEFAULT NULL,
  `Customer_Debt` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`Customer_Id`),
  KEY `CT_Id` (`Type_Id`),
  CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`Type_Id`) REFERENCES `customer_type` (`Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,1,'Nguyễn Văn Long','0915678901',' 456 Đường DEF, Phường 2, Quận 2, Thành phố Hà Nội',' 9876543219',1300000.00),(2,2,'Xưởng A','090234 678','789 Đường GHI, Phường 3, Quận 3, Thành phố Đà Nẵng','1122334455',596860.00),(4,2,'Gara Ô Tô Thành Công','0367345666','321 Đường JKL, Phường 4, Quận 4, Thành phố Hải Phòng','5566778899',819590.00),(5,1,'Mai Anh bảo ','0967487329','150 đường Hoàng Hoa Thám , Hà Nội',NULL,600000.00),(7,1,'Nguyễn Đinh','0936216783','123 Đường ABC, Phường 1, Quận 1, Thành phố Hồ Chí Minh','0123456789',300000.00);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_type`
--

DROP TABLE IF EXISTS `customer_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_type` (
  `Type_Id` int NOT NULL AUTO_INCREMENT,
  `Type_Names` varchar(250) DEFAULT NULL,
  `Payment_Discount` float DEFAULT NULL,
  PRIMARY KEY (`Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_type`
--

LOCK TABLES `customer_type` WRITE;
/*!40000 ALTER TABLE `customer_type` DISABLE KEYS */;
INSERT INTO `customer_type` VALUES (1,'Khách lẻ',0),(2,'Khách xưởng',0.06);
/*!40000 ALTER TABLE `customer_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debt_collection`
--

DROP TABLE IF EXISTS `debt_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debt_collection` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `so_tien` decimal(12,2) DEFAULT NULL,
  `Dates` date DEFAULT NULL,
  `Descriptions` varchar(255) DEFAULT NULL,
  `Pay_method` varchar(255) DEFAULT NULL,
  `booking_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account id_idx` (`employee_id`),
  KEY `customer _id_idx` (`customer_id`),
  CONSTRAINT `account_id` FOREIGN KEY (`employee_id`) REFERENCES `account` (`Account_Id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`Customer_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debt_collection`
--

LOCK TABLES `debt_collection` WRITE;
/*!40000 ALTER TABLE `debt_collection` DISABLE KEYS */;
INSERT INTO `debt_collection` VALUES (1,2,14,200000.00,'2024-07-17','Thanh toán ','Tiền mặt','CD01'),(2,2,14,104000.00,'2024-07-17','Thanh toán lần 2','Tiền mặt','CD02'),(8,2,14,300000.00,'2024-07-17','Thanh toán lần 3','Tiền mặt','CD03'),(9,5,12,1000000.00,'2024-07-26','thu nợ xuất hàng','Tiền mặt','CD04'),(10,5,12,700000.00,'2024-07-27','Trả nợ ','Tiền mặt','CD05');
/*!40000 ALTER TABLE `debt_collection` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_debt_collection` BEFORE INSERT ON `debt_collection` FOR EACH ROW BEGIN
    DECLARE latest_code INT DEFAULT 0;
    DECLARE new_code VARCHAR(10);

    -- Lấy số thứ tự của bản ghi cuối cùng
    SELECT COUNT(*) INTO latest_code FROM debt_collection;

    -- Sinh mã booking_code dạng CDxx
    SET new_code = CONCAT('CD', LPAD(latest_code + 1, 2, '0'));

    -- Gán giá trị cho booking_code trước khi INSERT
    SET NEW.booking_code = new_code;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `debt_payment`
--

DROP TABLE IF EXISTS `debt_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debt_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Dates` date DEFAULT NULL,
  `paid` decimal(10,2) DEFAULT NULL,
  `Supplier_id` int DEFAULT NULL,
  `employees_id` int DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `description` text,
  `booking_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Supplier_id` (`Supplier_id`),
  KEY `employees_id` (`employees_id`),
  CONSTRAINT `debt_payment_ibfk_1` FOREIGN KEY (`Supplier_id`) REFERENCES `supplier` (`Supplier_Id`),
  CONSTRAINT `debt_payment_ibfk_2` FOREIGN KEY (`employees_id`) REFERENCES `account` (`Account_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debt_payment`
--

LOCK TABLES `debt_payment` WRITE;
/*!40000 ALTER TABLE `debt_payment` DISABLE KEYS */;
INSERT INTO `debt_payment` VALUES (1,'2024-07-15',200000.00,6,14,'Tiền mặt','thanh toán đơn nhập','PD01'),(3,'2024-07-15',200000.00,6,14,'Tiền mặt','Thanh toán đơn nhập','PD02'),(4,'2024-07-17',200000.00,6,14,'Tiền mặt','Thanh toán nhập hàng','PD03'),(5,'2024-07-18',200000.00,6,12,'Tiền mặt','thanh toán ','PD04'),(6,'2024-07-26',100000.00,5,12,'Tiền mặt','Trả nợ đơn nhập ','PD05'),(7,'2024-07-26',1000000.00,1,12,'Tiền mặt','Trả nợ ','PD06'),(8,'2024-07-27',600000.00,7,12,'Tiền mặt','Trả nợ nhập hàng','PD07');
/*!40000 ALTER TABLE `debt_payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_debt_payment` BEFORE INSERT ON `debt_payment` FOR EACH ROW BEGIN
    DECLARE latest_code INT DEFAULT 0;
    DECLARE new_code VARCHAR(10);

    -- Lấy số thứ tự của bản ghi cuối cùng
    SELECT COUNT(*) INTO latest_code FROM debt_payment;

    -- Sinh mã booking_code dạng PDxx
    SET new_code = CONCAT('PD', LPAD(latest_code + 1, 2, '0'));

    -- Gán giá trị cho booking_code trước khi INSERT
    SET NEW.booking_code = new_code;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `freight`
--

DROP TABLE IF EXISTS `freight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `freight` (
  `id_freight` int NOT NULL AUTO_INCREMENT,
  `P_Id` int NOT NULL,
  `id_ShipmentNew` int NOT NULL,
  `status_product` varchar(45) DEFAULT NULL,
  `checked` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_freight`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `freight`
--

LOCK TABLES `freight` WRITE;
/*!40000 ALTER TABLE `freight` DISABLE KEYS */;
INSERT INTO `freight` VALUES (1,10,7,'OK','OK'),(2,11,6,'NOT','NOT'),(3,1,5,'OK','OK'),(4,2,10,'OK','OK'),(5,1,4,'OK','OK');
/*!40000 ALTER TABLE `freight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import`
--

DROP TABLE IF EXISTS `import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import` (
  `Import_Id` int NOT NULL,
  `Input_Amount` decimal(12,2) DEFAULT NULL,
  `Debt` decimal(12,2) DEFAULT NULL,
  `Input_Date` date DEFAULT NULL,
  `Account_Id` int NOT NULL,
  `Check_Status` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Problem` longtext,
  `Envident` longtext,
  `Warehouse_Id` int DEFAULT NULL,
  `AddedImport` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`Import_Id`),
  KEY `Checker_Id` (`Account_Id`),
  CONSTRAINT `Import_ibfk_1` FOREIGN KEY (`Account_Id`) REFERENCES `account` (`Account_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import`
--

LOCK TABLES `import` WRITE;
/*!40000 ALTER TABLE `import` DISABLE KEYS */;
INSERT INTO `import` VALUES (3,20000.00,20000.00,'2024-01-03',14,'Chờ duyêt','ok','',1,'NOT'),(4,920000.00,920000.00,'2024-07-15',2,'Chờ duyệt','','',1,'NOT'),(6515312,1080000.00,1080000.00,'2024-06-18',14,'Đã duyệt',NULL,NULL,1,'NOT'),(51577473,240000.00,240000.00,'2024-07-23',11,'Đã duyệt','','',1,'ADDED'),(56752687,420000.00,420000.00,'2024-06-18',14,'Từ chối','Hàng có dấu hiệu hỏng',NULL,2,'NOT'),(58439701,480000.00,480000.00,'2024-07-27',11,'Đã duyệt','','/evidence/Nitro_Wallpaper_06_3840x2400.jpg',2,'ADDED'),(275765391,160000.00,160000.00,'2024-07-26',11,'Đã duyệt','','/evidence/vn-11134207-7qukw-li5q9j217yky99_tn.jpg',1,'ADDED'),(280445194,1440000.00,1440000.00,'2024-07-26',11,'Đã duyệt','','/evidence/lazang-1.jpg',1,'ADDED'),(847159364,240000.00,240000.00,'2024-07-26',11,'Đã duyệt','','/evidence/images (1).jpg',1,'ADDED'),(855798586,2250000.00,2250000.00,'2024-07-26',11,'Đã duyệt','','/evidence/246c10c3880b9c92c3584501db50ce0a.jpg',2,'ADDED'),(857299252,60000.00,60000.00,'2024-07-26',11,'Đã duyệt','','/evidence/images (1).jpg',1,'ADDED'),(1552755410,560000.00,560000.00,'2024-07-22',2,'Từ chối','','',1,'NOT');
/*!40000 ALTER TABLE `import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_detail`
--

DROP TABLE IF EXISTS `import_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_detail` (
  `Detail_Id` int NOT NULL AUTO_INCREMENT,
  `Import_Id` int DEFAULT NULL,
  `P_ID` int DEFAULT NULL,
  `import_quantity` int DEFAULT NULL,
  `product_total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`Detail_Id`),
  KEY `Import_Id_idx` (`Import_Id`),
  KEY `P_id_idx` (`P_ID`),
  CONSTRAINT `P_id` FOREIGN KEY (`P_ID`) REFERENCES `product` (`P_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_detail`
--

LOCK TABLES `import_detail` WRITE;
/*!40000 ALTER TABLE `import_detail` DISABLE KEYS */;
INSERT INTO `import_detail` VALUES (28,1552755410,1,1,80000.00),(29,1552755410,2,1,480000.00),(30,51577473,1,3,240000.00),(32,847159364,17,4,240000.00),(33,857299252,17,1,60000.00),(34,280445194,2,3,1440000.00),(36,275765391,19,2,160000.00),(37,855798586,21,5,2250000.00),(38,58439701,1,6,480000.00);
/*!40000 ALTER TABLE `import_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `output_detail`
--

DROP TABLE IF EXISTS `output_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `output_detail` (
  `Detail_Id` int NOT NULL AUTO_INCREMENT,
  `Output_Id` int NOT NULL,
  `P_Id` int DEFAULT NULL,
  `export_quantity` int DEFAULT NULL,
  `product_total` double DEFAULT NULL,
  PRIMARY KEY (`Detail_Id`),
  KEY `Output_Id` (`Output_Id`),
  KEY `P_Id` (`P_Id`),
  CONSTRAINT `Output_Detail_ibfk_2` FOREIGN KEY (`P_Id`) REFERENCES `product` (`P_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `output_detail`
--

LOCK TABLES `output_detail` WRITE;
/*!40000 ALTER TABLE `output_detail` DISABLE KEYS */;
INSERT INTO `output_detail` VALUES (6,467137027,3,1,1500000),(19,478938255,4,6,3600000),(20,478938255,5,4,2400000),(21,62013673,6,1,150000),(22,62013673,5,1,600000),(49,581706299,3,1,1500000),(50,578337706,1,2,360000),(51,490836,1,2,360000),(55,323189,19,1,140000),(56,57685,19,2,280000),(57,484172,15,1,70000),(58,484172,6,5,750000),(59,699516,16,1,450000),(60,885449,1,1,180000),(61,885449,2,1,550000),(62,29430309,6,5,750000);
/*!40000 ALTER TABLE `output_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `output_order`
--

DROP TABLE IF EXISTS `output_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `output_order` (
  `Output_Id` int NOT NULL AUTO_INCREMENT,
  `Customer_Id` int DEFAULT NULL,
  `Seller` int DEFAULT NULL,
  `Output_Date` date DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `Total_money` decimal(12,2) DEFAULT NULL,
  `Paid` decimal(12,2) DEFAULT NULL,
  `Amount_Owed` decimal(12,2) DEFAULT NULL,
  `Note` varchar(45) DEFAULT NULL,
  `Check_status` varchar(45) DEFAULT NULL,
  `evedent` longtext,
  `AddedExport` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Output_Id`),
  KEY `Customer_Id` (`Customer_Id`),
  KEY `Seller` (`Seller`),
  CONSTRAINT `Output_Order_ibfk_1` FOREIGN KEY (`Customer_Id`) REFERENCES `customer` (`Customer_Id`),
  CONSTRAINT `Output_Order_ibfk_2` FOREIGN KEY (`Seller`) REFERENCES `account` (`Account_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=981137006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `output_order`
--

LOCK TABLES `output_order` WRITE;
/*!40000 ALTER TABLE `output_order` DISABLE KEYS */;
INSERT INTO `output_order` VALUES (57685,5,11,'2024-07-26',0,280000.00,0.00,280000.00,'','Đã duyệt','/evidence/xupap-xa-2.jpg','ADDED'),(323189,5,11,'2024-07-26',0,140000.00,0.00,140000.00,'','Đã duyệt','/evidence/S5cfe4036bf8c4bf4a6bfe038327422a7D.jpg','NOT'),(484172,4,11,'2024-07-26',0.05000000074505806,819590.00,0.00,819590.00,'','Đã duyệt','/evidence/dau-hieu-ma-phanh-o-to-bi-mon.png','ADDED'),(490836,7,11,'2024-07-26',0,360000.00,60000.00,300000.00,'','Đã duyệt','','NOT'),(699516,5,11,'2024-07-26',0,450000.00,0.00,450000.00,'','Đã duyệt','/evidence/images (1).jpg','ADDED'),(828698,2,11,'2024-07-26',0.05000000074505806,279860.00,79000.00,200860.00,'','Đã duyệt','/evidence/S5cfe4036bf8c4bf4a6bfe038327422a7D.jpg','NOT'),(885449,5,11,'2024-07-26',0,730000.00,0.00,730000.00,'','Đã duyệt','/evidence/246c10c3880b9c92c3584501db50ce0a.jpg','ADDED'),(29430309,5,11,'2024-07-27',5,712500.00,12500.00,700000.00,'','Đã duyệt','/evidence/Nitro_Wallpaper_05_3840x2400.jpg','ADDED'),(578337706,1,11,'2024-07-23',0,360000.00,60000.00,300000.00,'','Đã duyệt','','NOT'),(581706299,1,11,'2024-07-23',0,1500000.00,500000.00,1000000.00,'',' Đã duyệt','','NOT');
/*!40000 ALTER TABLE `output_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producer`
--

DROP TABLE IF EXISTS `producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producer` (
  `Producer_Id` int NOT NULL AUTO_INCREMENT,
  `Producer_Name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`Producer_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producer`
--

LOCK TABLES `producer` WRITE;
/*!40000 ALTER TABLE `producer` DISABLE KEYS */;
INSERT INTO `producer` VALUES (1,'GROOVE'),(2,'OEM'),(3,'KOYO SEIKO'),(4,'PMC'),(5,'SUNFILL'),(6,'ABC'),(7,'NSK'),(8,'DENSO'),(9,'DG'),(10,'MOBIS'),(11,'KOREA'),(12,'N/A'),(13,'INZI');
/*!40000 ALTER TABLE `producer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `P_Id` int NOT NULL AUTO_INCREMENT,
  `Product_code` varchar(100) DEFAULT NULL,
  `Product_Name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Car_Id` int DEFAULT NULL,
  `Inventory` int DEFAULT NULL,
  `Supplier_Id` int DEFAULT NULL,
  `Producer_Id` int DEFAULT NULL,
  `Unit` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Import_Price` decimal(12,2) DEFAULT NULL,
  `Sales_Price` decimal(12,2) DEFAULT NULL,
  `Shipment_Id` int DEFAULT NULL,
  `Image_Link` varchar(255) DEFAULT NULL,
  `Description` longtext,
  PRIMARY KEY (`P_Id`),
  KEY `Car_Id` (`Car_Id`),
  KEY `Supplier_Id` (`Supplier_Id`),
  KEY `Producer_Id` (`Producer_Id`),
  KEY `Product_ibfk_4_idx` (`Shipment_Id`),
  CONSTRAINT `Product_ibfk_1` FOREIGN KEY (`Car_Id`) REFERENCES `car` (`Car_Id`),
  CONSTRAINT `Product_ibfk_2` FOREIGN KEY (`Supplier_Id`) REFERENCES `supplier` (`Supplier_Id`),
  CONSTRAINT `Product_ibfk_3` FOREIGN KEY (`Producer_Id`) REFERENCES `producer` (`Producer_Id`),
  CONSTRAINT `Product_ibfk_4` FOREIGN KEY (`Shipment_Id`) REFERENCES `shipment` (`Shipment_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'VP123455','[XBA] VAN CHIA NƯỚC 3 CHẠC-NHÔM (KOREA) 96666227(MATIZ, SPARK)			',2,10,7,11,'Cái',80000.00,180000.00,4,'./product_image/071424094412_4c5344d3172022a650664b1f5a054861.jpg',''),(2,'SP654321','ỐP LA RĂNG ĐÚC',1,2,4,1,'Bộ',480000.00,550000.00,1,'./product_image/071424100204_6055brmvzg1mvuvyat4gjzs4_simg_de2fe0_500x500_maxb.jpg',NULL),(3,'SP789012','[XBA] MÁY ĐỀ (OEM)(INNOVA,PRADO 03,CAMAP )			',1,10,6,2,'Cái',1000000.00,1500000.00,2,'./product_image/071424100259_1690791889_may-innova-17.jpg',NULL),(4,'SP345678',' ỐNG XẢ ĐOẠN SAU (M150) HÌNH CÁNH BƯỚM(MATIZ 2.MATIZ 1)',2,20,2,12,'Cái',420000.00,600000.00,2,'./product_image/071424100359_bau-giam-am-ong-xa-toyota-innova-600x937.jpg',NULL),(5,'SP901234','Lốp Xe Innova',1,34,4,3,'Cái',500000.00,600000.00,2,'./uploads/072724035959_images (2).jpg',''),(6,'SP567890','Má phanh mỏ dầy lỗ dài',1,15,2,2,'Cái ',100000.00,150000.00,1,'./uploads/072624114841_dau-hieu-ma-phanh-o-to-bi-mon.png',''),(7,'AT-004','LÁ CÔN XE TẢI IZ49',1,12,3,5,'Cái',900000.00,1200000.00,3,'./uploads/072624115015_48600fae49494f6cdedd5d6cc02263a1.jpg',''),(8,'BH18101','BƠM XĂNG NGOÀI SUZUKI ĐIỆN TỬ XỊN',1,6,9,3,'Cái',400000.00,600000.00,6,'./uploads/072624063949_Screenshot 2024-07-26 183932.png',''),(9,'GTR-6721-WQ','CÀNG I SUZUKI 5 TẠ ,7 CHỖ ,THACO 750, GIẢI PHÓNG 810KG,VINAXUKI 5 TẠ',1,18,5,4,'Cái',350000.00,450000.00,4,'./uploads/072624054404_12(1).jpg',''),(10,'BH17633','TỔNG CÔN DƯỚI ĐÔ THÀNH IZ49',1,40,3,5,'Cái',150000.00,200000.00,5,'./uploads/072624114739_vn-11134207-7qukw-li5q9j217yky99_tn.jpg',''),(11,'BTL01118','TAY MỞ CỬA THACO TOWNER 990',1,30,1,6,'Cái',100000.00,150000.00,7,'./uploads/072624114508_images.jpg',''),(12,'BH18016','QUẠT KÉT NƯỚC KENBO RH',1,23,8,7,'Cái',450000.00,470000.00,5,'./uploads/072724035516_S5cfe4036bf8c4bf4a6bfe038327422a7D (1).jpg',''),(13,'RH18016','Quạt két nước kenbo LH',1,9,8,7,'Cái',430000.00,450000.00,5,'./uploads/072624054757_9eabbde4396488d37e2ae87a19df4b42.jpg',''),(14,'BH18110','XUPAP HÚT ( PHI 40 THÂN 8X118) ISUZU 4JA1.4JB1',1,5,6,5,'Cái',50000.00,80000.00,3,'./uploads/072624063637_Screenshot 2024-07-26 183413.png',''),(15,'BH18102','XUPAP XẢ ISUZU 4JA1.4JB1( phi 36 thân 8x118)',1,8,6,3,'Cái',50000.00,70000.00,8,'./uploads/072624063622_xupap-xa-2.jpg',''),(16,'BH17572','BÀN ÉP PHI 265 ISUZU, IZ49, IZ65 ,TERACO , HÀNG ZHLN',1,9,6,4,'Cái',300000.00,450000.00,9,'./uploads/072624063745_vn-11134207-7qukw-lk99z8drg2vw1c.jpg',''),(17,'AA029225',' LỌC  XĂNG (SẮT) CÓ TAI (OEM) 23300-75140(INNOVA 06-20 ,FORTUNER 08-18)	',1,5,5,2,'Cái',60000.00,90000.00,5,'./uploads/072624062938_a89cf6b2b5a87252a169a7e5ca4281a2.jpg',''),(18,'MT029361		','MÔ TƠ BƠM XĂNG NGẮN (OEM) 23220-0C081(INNOVA)		',1,4,10,2,'Cái',300000.00,350000.00,7,'./uploads/072624064028_4665mo-to-bom-xang-toyota-innova-2010-232200c081-chinh-hang-gia-re----.jpg',''),(19,'CB9438719',' CẢM BIẾN BÁO QUẠT (Inzi) (2G -ĐẦU CẮM ĐEN )S(MATIZ )	',1,8,5,13,'Cái',80000.00,140000.00,1,'./uploads/072624063036_15a62a20e386100ff2a541b5cc7bcd24.jpg',''),(20,'CK98377826',' CHẮN BÙN BÁNH (OEM)(INNOVA )			',1,0,6,4,'Cái',140000.00,160000.00,NULL,'./uploads/072624063113_z2604590282157-e68c5db8cfcb27c6f1c68945389ab455.webp',''),(21,'UH1980969','NẮP CHỤP LA RĂNG ĐÚC (CHỨ THẬP ) MÀU VÀNG(GROOVE)',1,5,1,1,'Cái',450000.00,600000.00,10,'./product_image/072624081156_246c10c3880b9c92c3584501db50ce0a.jpg','');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revenue`
--

DROP TABLE IF EXISTS `revenue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revenue` (
  `Revenue_Id` int NOT NULL AUTO_INCREMENT,
  `Revenue_money` decimal(12,2) DEFAULT NULL,
  `Dates` date DEFAULT NULL,
  PRIMARY KEY (`Revenue_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revenue`
--

LOCK TABLES `revenue` WRITE;
/*!40000 ALTER TABLE `revenue` DISABLE KEYS */;
INSERT INTO `revenue` VALUES (1,800000.00,'2024-06-18'),(2,604000.00,'2024-07-17'),(3,-200000.00,'2024-07-18'),(5,560000.00,'2024-07-23'),(6,110000.00,'2024-07-26'),(7,112500.00,'2024-07-27');
/*!40000 ALTER TABLE `revenue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Role_Id` int NOT NULL AUTO_INCREMENT,
  `Role_Name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Role_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (0,'Ban'),(1,'Admin'),(2,'Manager'),(3,'Employee');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment` (
  `Shipment_Id` int NOT NULL AUTO_INCREMENT,
  `Warehouse_Id` int NOT NULL,
  `Place` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`Shipment_Id`),
  KEY `Warehouse_Id_idx` (`Warehouse_Id`),
  CONSTRAINT `Warehouse_Id` FOREIGN KEY (`Warehouse_Id`) REFERENCES `warehouse` (`Warehouse_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
INSERT INTO `shipment` VALUES (1,1,'PT1-A1'),(2,2,'PT1-A1'),(3,1,'PT1-A2'),(4,1,'PT1-A3'),(5,1,'PT1-A4'),(6,1,'PT1-A5'),(7,2,'PT1-A2'),(8,2,'PT1-A3'),(9,2,'PT1-A4'),(10,2,'PT1-A5');
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `Supplier_Id` int NOT NULL AUTO_INCREMENT,
  `Supplier_Name` varchar(250) NOT NULL,
  `Phone` varchar(45) DEFAULT NULL,
  `Supplier_Address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `Debt` decimal(12,2) DEFAULT NULL,
  `Tax_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Supplier_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Công ty TNHH Phụ Tùng Ô Tô An Phát','0901234567','123 Đường Trường Chinh, Quận Đống Đa, Hà Nội',1250000.00,'1859774414'),(2,'Công ty Cổ phần Thiết Bị Ô Tô Thành Đạt','0912345678','456 Đường Nguyễn Văn Cừ, Quận 1, TP. Hồ Chí Minh',0.00,'5105747382'),(3,'Công ty TNHH Linh Kiện Ô Tô Minh Đức','0923456789',' 789 Đường Phạm Văn Đồng, Quận Thủ Đức, TP. Hồ Chí Minh',0.00,'2788770098'),(4,'Công ty Cổ phần Phụ Tùng Xe Hơi Đại Nam',' 0934567890','101 Đường Nguyễn Trãi, Quận Thanh Xuân, Hà Nội',1440000.00,'0385840529'),(5,'Công ty TNHH Thiết Bị Ô Tô Hoàng Long','0945678901','202 Đường Lê Văn Lương, Quận Cầu Giấy, Hà Nội',360000.00,'7295720366'),(6,'Công ty Cổ phần Phụ Tùng Ô Tô Việt Hưng','0956789012','303 Đường Tôn Đức Thắng, Quận Liên Chiểu, Đà Nẵng',200000.00,'3625745560'),(7,'Công ty TNHH Linh Kiện Ô Tô Kim Ngân','0967890123','404 Đường Trần Hưng Đạo, Quận 5, TP. Hồ Chí Minh',200000.00,'0538399240'),(8,'Công ty TNHH Phụ Tùng Ô Tô Thái Bình An','0901238964','123 Đường Lý Bôn, Thành phố Thái Bình, Thái Bình',0.00,'0568694153'),(9,'Công ty Cổ phần Phụ Tùng Xe Hơi Tân Phát','0912345678','456 Đường Trần Hưng Đạo, Thành phố Thái Bình, Thái Bình',0.00,'4602409649'),(10,'Công ty TNHH Thiết Bị Ô Tô Hưng Thịnh','0923456789','789 Đường Lê Quý Đôn, Thành phố Thái Bình, Thái Bình',0.00,'7327619713 '),(21,'Công ty TNHH Thiết Bị Ô Tô TNT','0982984338','125 Đường Lê Quý Đôn, Thành phố Thái Bình, Thái Bình',0.00,'1928372933'),(22,'Công ty TNHH Phụ Tùng ô tô VLC','0923456878','222 Đường Nguyễn Đức Cảnh, Thành phố Thái Bình, Thái Bình',0.00,'732761000');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `Warehouse_Id` int NOT NULL AUTO_INCREMENT,
  `Warehouse_Name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`Warehouse_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'Kho phụ tùng'),(2,'Kho vật liệu');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'swp_project'
--

--
-- Dumping routines for database 'swp_project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-27  8:01:25
