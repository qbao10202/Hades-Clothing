-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: sales_app
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.18-MariaDB

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
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (2,'TOPS','tops','T-shirts, polo shirts, tank tops 2','/uploads/categories/2/1752167368744_080425.jpg',NULL,5,1,'2025-07-10 17:09:28'),(3,'BOTTOMS','bottoms','Pants, shorts, jeans','/uploads/categories/3/1751393203059_dsc04804_e0be9af53da54231be42e0a6da3932c6.jpg',NULL,3,1,'2025-06-29 07:57:42'),(4,'OUTERWEARS','outerwears','Jackets, hoodies, sweaters','/uploads/categories/4/1752175631989_dsc09069_188126c239524a9cb4beb36c49925e34.jpg',NULL,4,1,'2025-07-10 19:27:13'),(5,'UNDERWEARS','underwears','Underwear, socks','/uploads/categories/5/1752163696915_untitled_session0156_c644f3db69f74052bef5b087ebe22e2e.jpg',NULL,5,1,'2025-07-10 16:08:16'),(6,'BAGS','bags','Backpacks, bags, accessories','/uploads/categories/6/1752175663315_dsc02268_598e261939cd4e76b39aefc724cabebc.jpg',NULL,6,1,'2025-07-10 19:27:43'),(7,'ACCESSORIES','accessories','Caps, belts, jewelry','/uploads/categories/7/1752175708214_khan1_8d8623c7900244578ec2606b7d6f2e0b.webp',NULL,8,1,'2025-07-10 19:43:16'),(8,'SALE','sale','Discounted products','/uploads/categories/8/1752164160679_untitled_session0156_c644f3db69f74052bef5b087ebe22e2e.jpg',NULL,8,1,'2025-07-10 19:43:36');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_usage`
--

DROP TABLE IF EXISTS `coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_usage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `used_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `coupon_usage_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  CONSTRAINT `coupon_usage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `coupon_usage_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_usage`
--

LOCK TABLES `coupon_usage` WRITE;
/*!40000 ALTER TABLE `coupon_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupon_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','FIXED_AMOUNT') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT 0.00,
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0,
  `valid_from` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `valid_until` timestamp NOT NULL DEFAULT '2038-01-18 20:14:07',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'WELCOME10','Welcome Discount','10% off for new customers','PERCENTAGE',10.00,500000.00,NULL,NULL,0,'2025-06-29 07:57:42','2025-07-29 07:57:42',1,'2025-06-29 07:57:42'),(2,'SAVE50K','Save 50K','Save 50,000 VND on orders over 500K','FIXED_AMOUNT',50000.00,500000.00,NULL,NULL,0,'2025-06-29 07:57:42','2025-08-28 07:57:42',1,'2025-06-29 07:57:42'),(3,'SUMMER20','Summer Sale','20% off summer collection','PERCENTAGE',20.00,1000000.00,NULL,NULL,0,'2025-06-29 07:57:42','2025-09-27 07:57:42',1,'2025-06-29 07:57:42');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_code` varchar(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'Vietnam',
  `tax_id` varchar(50) DEFAULT NULL,
  `customer_type` enum('INDIVIDUAL','BUSINESS','WHOLESALE') DEFAULT 'INDIVIDUAL',
  `credit_limit` decimal(12,2) DEFAULT 0.00,
  `payment_terms` int(11) DEFAULT 30,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_code` (`customer_code`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'CUST001',NULL,'Tech Solutions Inc','John Smith','john@techsolutions.com','0123456789','123 Tech Street','Ho Chi Minh City','District 1',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(2,'CUST002',NULL,'Fashion Retail Co','Jane Doe','jane@fashionretail.com','0987654321','456 Fashion Ave','Ha Noi','Dong Da',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(3,'CUST003',NULL,'Book Store Plus','Bob Wilson','bob@bookstore.com','0111222333','789 Book Lane','Da Nang','Hai Chau',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(4,'CUST-2',2,NULL,'Admin User','admin@gmail.com','VN-0389911823',NULL,NULL,NULL,NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-07-01 18:22:30','2025-07-09 14:42:07'),(5,'CUST-3',NULL,NULL,NULL,'quocbao01651@gmail.com',NULL,NULL,NULL,NULL,NULL,'VN',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-07-05 08:48:11','2025-07-05 08:48:11');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_logs`
--

DROP TABLE IF EXISTS `inventory_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `action` enum('STOCK_IN','STOCK_OUT','ADJUSTMENT','TRANSFER','RETURN') NOT NULL,
  `quantity` int(11) NOT NULL,
  `previous_stock` int(11) NOT NULL,
  `new_stock` int(11) NOT NULL,
  `reference_type` enum('ORDER','PURCHASE','ADJUSTMENT','TRANSFER') DEFAULT NULL,
  `reference_id` bigint(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `inventory_logs_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `inventory_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_logs`
--

LOCK TABLES `inventory_logs` WRITE;
/*!40000 ALTER TABLE `inventory_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `type` enum('INFO','SUCCESS','WARNING','ERROR','SYSTEM') DEFAULT 'INFO',
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `product_sku` varchar(50) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,'HADES SPLICE POLO - BROWN',NULL,7,521000.00,3647000.00,0.00,0.00,'2025-07-04 17:41:19','2025-07-04 18:52:57'),(2,1,4,'HADES ROCK SOLID ZIP HOODIE',NULL,1,850000.00,850000.00,0.00,0.00,'2025-07-04 17:42:23','2025-07-04 18:52:57'),(3,1,16,'baaaaagfg',NULL,8,232.00,1856.00,0.00,0.00,'2025-07-04 18:55:00','2025-07-04 18:55:00'),(4,1,2,'HADES CHAMPION TANK TOP - BLACK',NULL,4,420000.00,1680000.00,0.00,0.00,'2025-07-04 18:58:56','2025-07-04 18:58:56'),(8,2,16,'baaaaagfg',NULL,6,232.00,1392.00,0.00,0.00,'2025-07-06 11:06:48','2025-07-06 11:06:48'),(9,2,3,'HADES COZY STRIPE POLO SWEATER - RED',NULL,1,1150000.00,1150000.00,0.00,0.00,'2025-07-06 13:51:30','2025-07-06 13:51:30'),(10,5,16,'baaaaagfg',NULL,6,232.00,1392.00,0.00,0.00,'2025-07-06 15:55:37','2025-07-06 15:55:37'),(11,5,3,'HADES COZY STRIPE POLO SWEATER - RED',NULL,1,1150000.00,1150000.00,0.00,0.00,'2025-07-06 15:55:37','2025-07-06 15:55:37'),(14,6,13,'ao Bao',NULL,3,2344555.00,7033665.00,0.00,0.00,'2025-07-06 16:13:52','2025-07-06 16:13:52'),(15,6,6,'HADES BLACK WAX BIKER JACKET',NULL,2,1190000.00,2380000.00,0.00,0.00,'2025-07-06 16:13:52','2025-07-06 16:13:52'),(17,7,8,'HADES VOID DRIFTER PANTS',NULL,2,790000.00,1580000.00,0.00,0.00,'2025-07-09 14:16:44','2025-07-09 21:16:44'),(18,8,8,'HADES VOID DRIFTER PANTS',NULL,2,790000.00,1580000.00,0.00,0.00,'2025-07-09 14:16:56','2025-07-09 21:16:56'),(20,9,6,'HADES BLACK WAX BIKER JACKET',NULL,5,1190000.00,5950000.00,0.00,0.00,'2025-07-09 14:42:07','2025-07-09 21:42:07'),(23,10,4,'HADES ROCK SOLID ZIP HOODIE',NULL,1,850000.00,850000.00,0.00,0.00,'2025-07-09 14:49:35','2025-07-09 21:49:35'),(24,11,4,'HADES ROCK SOLID ZIP HOODIE',NULL,1,850000.00,850000.00,0.00,0.00,'2025-07-09 14:49:50','2025-07-09 21:49:50'),(27,12,16,'baaaaagfg',NULL,1,232.00,232.00,0.00,0.00,'2025-07-09 14:54:23','2025-07-09 21:54:23'),(29,13,6,'HADES BLACK WAX BIKER JACKET',NULL,1,1190000.00,1190000.00,0.00,0.00,'2025-07-09 14:58:07','2025-07-09 21:58:07'),(32,14,6,'HADES BLACK WAX BIKER JACKET',NULL,3,1190000.00,3570000.00,0.00,0.00,'2025-07-10 11:40:59','2025-07-10 18:40:59'),(33,14,8,'HADES VOID DRIFTER PANTS',NULL,2,790000.00,1580000.00,0.00,0.00,'2025-07-10 11:40:59','2025-07-10 18:40:59');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('CART','PENDING','CONFIRMED','PROCESSING','SHIPPED','DELIVERED','CANCELLED','REFUNDED') DEFAULT NULL,
  `payment_status` enum('PENDING','PAID','FAILED','REFUNDED','PARTIALLY_REFUNDED') DEFAULT 'PENDING',
  `shipping_status` enum('PENDING','SHIPPED','DELIVERED','RETURNED') DEFAULT 'PENDING',
  `subtotal` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shipping_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'VND',
  `shipping_address` text DEFAULT NULL,
  `billing_address` text DEFAULT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `customer_id` (`customer_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORDER-1751655583103',4,2,'2025-07-04 11:59:43','PENDING','PENDING','PENDING',6178856.00,0.00,0.00,0.00,6178856.00,'VND','Sư đoàn 9, Hồ Chí Minh, Vietnamese 700000, Vietnam','Sư đoàn 9, Hồ Chí Minh, Vietnamese 700000, Vietnam','standard',NULL,'','2025-07-01 18:31:28','2025-07-01 18:31:28'),(2,'ORD-79192CA2',4,2,'2025-07-06 08:48:13','PENDING','PENDING','PENDING',1151392.00,0.00,0.00,0.00,1151392.00,'VND','rdrdf, Hồ Chí Minh, Vietnamese 700000','rdrdf, Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-05 03:03:05','2025-07-05 03:03:05'),(3,'CART-3',5,3,'2025-07-05 08:48:11','CART','PENDING','PENDING',0.00,0.00,0.00,0.00,0.00,'VND',NULL,NULL,NULL,NULL,NULL,'2025-07-05 08:48:11','2025-07-05 08:48:11'),(4,'CART-2',4,2,'2025-07-06 15:48:23','CART','PENDING','PENDING',0.00,0.00,0.00,0.00,0.00,'VND',NULL,NULL,NULL,NULL,NULL,'2025-07-06 15:48:23','2025-07-10 11:41:00'),(5,'ORD-00716DD1',4,2,'2025-07-06 08:55:37','PROCESSING','PENDING','PENDING',1151392.00,0.00,0.00,0.00,1151392.00,'VND','rdrdf, Hồ Chí Minh, Vietnamese 700000','rdrdf, Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-06 15:55:37','2025-07-07 11:07:10'),(6,'ORD-CE963B45',4,2,'2025-07-06 09:13:52','DELIVERED','PENDING','PENDING',9413665.00,0.00,0.00,0.00,9413665.00,'VND','21, 1212, 121 121','21, 1212, 121 121','free',NULL,'','2025-07-06 16:13:52','2025-07-07 11:09:02'),(7,'ORD-E29129D2',4,2,'2025-07-09 14:16:44','PENDING','PENDING','PENDING',1580000.00,0.00,0.00,0.00,1580000.00,'VND','dsd, Hồ Chí Minh, Vietnamese 700000','dsd, Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-09 14:16:44','2025-07-09 14:16:44'),(8,'ORD-400D0675',4,2,'2025-07-09 14:16:56','PENDING','PENDING','PENDING',1580000.00,0.00,0.00,0.00,1580000.00,'VND','dsd, Hồ Chí Minh, Vietnamese 700000','dsd, Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-09 14:16:56','2025-07-09 14:16:56'),(9,'ORD-57F3FC01',4,2,'2025-07-09 14:42:07','PENDING','PENDING','PENDING',5950000.00,0.00,0.00,0.00,5950000.00,'VND','434, Hồ Chí Minh, Vietnamese 700000','434, Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-09 14:42:07','2025-07-09 14:42:07'),(10,'ORD-F71CCCD6',4,2,'2025-07-09 14:49:35','PENDING','PENDING','PENDING',850000.00,0.00,0.00,0.00,850000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:49:35','2025-07-09 14:49:35'),(11,'ORD-2DC93B29',4,2,'2025-07-09 14:49:50','PENDING','PENDING','PENDING',850000.00,0.00,0.00,0.00,850000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:49:50','2025-07-09 14:49:50'),(12,'ORD-DECD618D',4,2,'2025-07-09 14:54:23','PENDING','PENDING','PENDING',232.00,0.00,0.00,0.00,232.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:54:23','2025-07-09 14:54:23'),(13,'ORD-17D1961B',4,2,'2025-07-09 14:58:07','PENDING','PENDING','PENDING',1190000.00,0.00,0.00,0.00,1190000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:58:07','2025-07-09 14:58:07'),(14,'ORD-CD9A7FA0',4,2,'2025-07-10 11:40:59','PENDING','PENDING','PENDING',5150000.00,0.00,0.00,0.00,5150000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-10 11:40:59','2025-07-10 11:40:59');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `payment_method` enum('CASH','BANK_TRANSFER','CREDIT_CARD','PAYPAL','MOMO','ZALOPAY','VNPAY') NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'VND',
  `status` enum('PENDING','COMPLETED','FAILED','CANCELLED','REFUNDED') DEFAULT 'PENDING',
  `gateway_response` text DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `resource` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'product:read','View products','product','read','2025-06-29 07:57:42'),(2,'product:write','Create/Update products','product','write','2025-06-29 07:57:42'),(3,'product:delete','Delete products','product','delete','2025-06-29 07:57:42'),(4,'order:read','View orders','order','read','2025-06-29 07:57:42'),(5,'order:write','Create/Update orders','order','write','2025-06-29 07:57:42'),(6,'order:delete','Delete orders','order','delete','2025-06-29 07:57:42'),(7,'order:process','Process orders','order','process','2025-06-29 07:57:42'),(8,'customer:read','View customers','customer','read','2025-06-29 07:57:42'),(9,'customer:write','Create/Update customers','customer','write','2025-06-29 07:57:42'),(10,'customer:delete','Delete customers','customer','delete','2025-06-29 07:57:42'),(11,'user:read','View users','user','read','2025-06-29 07:57:42'),(12,'user:write','Create/Update users','user','write','2025-06-29 07:57:42'),(13,'user:delete','Delete users','user','delete','2025-06-29 07:57:42'),(14,'category:read','View categories','category','read','2025-06-29 07:57:42'),(15,'category:write','Create/Update categories','category','write','2025-06-29 07:57:42'),(16,'category:delete','Delete categories','category','delete','2025-06-29 07:57:42'),(17,'report:read','View reports','report','read','2025-06-29 07:57:42'),(18,'report:write','Generate reports','report','write','2025-06-29 07:57:42'),(19,'system:admin','System administration','system','admin','2025-06-29 07:57:42');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (2,2,'/uploads/products/2/1751302620948_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,1,1,'2025-06-30 16:57:00'),(3,2,'/uploads/products/2/1751306194367_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,2,0,'2025-06-30 17:56:34'),(4,2,'/uploads/products/2/1751306203423_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,3,0,'2025-06-30 17:56:43'),(5,3,'/uploads/products/3/1751306226656_untitled_session0156_c644f3db69f74052bef5b087ebe22e2e.jpg',NULL,1,1,'2025-06-30 17:57:06'),(13,13,'/uploads/products/13/1751383774919_untitled_session0086_294407cbb3e84ecd9c8908341f2913f2.jpg',NULL,1,1,'2025-07-01 15:29:34'),(14,14,'/uploads/products/14/1751384338896_untitled_session0229_24aced36451748d0bfad88b68ff088d1.jpg',NULL,1,1,'2025-07-01 15:38:58'),(15,15,'/uploads/products/15/1751384460997_hd_t6.jpg',NULL,1,1,'2025-07-01 15:41:01'),(16,16,'/uploads/products/16/1751385294717_khan2_49fd68354ca04168bf8bd280c8ff4b17.jpg',NULL,1,1,'2025-07-01 15:54:54'),(17,10,'/uploads/products/10/1751790964632_untitled_session0229_24aced36451748d0bfad88b68ff088d1.jpg',NULL,1,1,'2025-07-06 08:36:04'),(20,1,'/uploads/products/1/1752175755059_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,1,1,'2025-07-10 12:29:15'),(21,9,'/uploads/products/9/1752175811984_dsc04515_4dab82fb55504989b747f7afbe3dcbf6.webp',NULL,1,1,'2025-07-10 12:30:11'),(22,12,'/uploads/products/12/1752175885486_hd_t6.jpg',NULL,1,1,'2025-07-10 12:31:25'),(23,8,'/uploads/products/8/1752175913928_dsc04922_6cf0c5a347484e5c912d6c6eea10b3a5.jpg',NULL,1,1,'2025-07-10 12:31:53'),(24,7,'/uploads/products/7/1752175925897_pandemos0035_1_ca386ec176374735ba6f8d8102bc49b7.jpg',NULL,1,1,'2025-07-10 12:32:05'),(25,6,'/uploads/products/6/1752175949967_hades_0078_1_73938f7dbb4c4d1392f17ad8d8c85d06.jpg',NULL,1,1,'2025-07-10 12:32:29'),(27,4,'/uploads/products/4/1752175983521_untitled_session0180_f974bb45041f460abe23315dfafbef97.jpg',NULL,1,1,'2025-07-10 12:33:03'),(28,5,'/uploads/products/5/1752176007905_khan2_49fd68354ca04168bf8bd280c8ff4b17.jpg',NULL,1,1,'2025-07-10 12:33:27');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `title` varchar(200) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `product_reviews_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `min_stock_level` int(11) DEFAULT 10,
  `max_stock_level` int(11) DEFAULT 1000,
  `category_id` bigint(20) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `material` varchar(100) DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_code` (`product_code`),
  UNIQUE KEY `slug` (`slug`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'HADES001','HADES SPLICE POLO - BROWN','hades-splice-polo-brown','Premium polo shirt with unique splice design',NULL,521000.00,300000.00,NULL,50,10,1000,2,NULL,NULL,NULL,NULL,NULL,1,'2025-06-30 17:49:43','2025-07-05 10:15:50'),(2,'HADES002','HADES CHAMPION TANK TOP - BLACK','hades-champion-tank-top-black','Athletic tank top for champions',NULL,420000.00,200000.00,NULL,75,10,1000,2,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-05 10:15:50'),(3,'HADES003','HADES COZY STRIPE POLO SWEATER - RED','hades-cozy-stripe-polo-sweater-red','Warm and cozy striped sweater',NULL,1150000.00,600000.00,NULL,28,10,1000,2,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-05 10:15:50'),(4,'HADES004','HADES ROCK SOLID ZIP HOODIE','hades-rock-solid-zip-hoodie','Durable zip-up hoodie',NULL,850000.00,450000.00,NULL,38,10,1000,4,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-09 14:49:50'),(5,'HADES005','HADES DISTRICT 1 CAP','hades-district-1-cap','Stylish cap with District 1 design',NULL,320000.00,150000.00,NULL,100,10,1000,7,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-05 10:15:50'),(6,'HADES006','HADES BLACK WAX BIKER JACKET','hades-black-wax-biker-jacket','Classic biker jacket with wax finish',NULL,1190000.00,700000.00,NULL,14,10,1000,4,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-10 11:40:59'),(7,'HADES007','HADES RUGGED LEOPARD SHORTS','hades-rugged-leopard-shorts','Rugged shorts with leopard print',NULL,620000.00,350000.00,NULL,60,10,1000,3,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-05 10:15:50'),(8,'HADES008','HADES VOID DRIFTER PANTS','hades-void-drifter-pants','Comfortable drifting pants',NULL,790000.00,400000.00,NULL,39,10,1000,3,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-10 11:40:59'),(9,'HADES009','HADES VOID DRIFTER ZIP HOODIE','hades-void-drifter-zip-hoodie','Matching zip hoodie for drifters',NULL,850000.00,450000.00,NULL,35,10,1000,7,'HADES','Black',NULL,'Cotton','hoodie,drifter,matching',1,'2025-06-29 07:57:42','2025-07-10 12:30:11'),(10,'HADES010','HADES CLASSIC KNICKERS - BLACK','hades-classic-knickers-black','Classic underwear in black',NULL,190000.00,80000.00,NULL,200,10,1000,7,NULL,NULL,NULL,NULL,NULL,0,'2025-06-29 07:57:42','2025-07-10 11:51:50'),(12,'HADES012','HADES Y-BACK SPORTS SHOCK - WHITE','hades-y-back-sports-bra-white','Supportive sports bra',NULL,290000.00,120000.00,NULL,88,10,1000,7,'HADES','White',NULL,'Polyester','sports-bra,supportive,active',1,'2025-06-29 07:57:42','2025-07-10 12:51:20'),(13,'12345','ao Bao','sdd','',NULL,2344555.00,2323232.00,NULL,47,1,10,4,NULL,NULL,NULL,NULL,NULL,1,'2025-07-01 15:29:34','2025-07-05 10:15:50'),(14,'434343','quan Bao','54','',NULL,4454.00,5454545.00,NULL,100,0,0,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-01 15:38:58','2025-07-01 15:38:58'),(15,'123232','sdsd','sdsd','',NULL,32323.00,32323.00,NULL,3232,0,0,NULL,NULL,NULL,NULL,NULL,NULL,1,'2025-07-01 15:41:00','2025-07-05 10:15:50'),(16,'3232','baaaaagfg','323','32',NULL,232.00,3232.00,NULL,309,0,0,2,NULL,NULL,NULL,NULL,NULL,1,'2025-07-01 15:54:54','2025-07-09 14:54:23');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(2,1),(2,4),(2,5),(2,7),(2,8),(2,9),(2,14),(3,1),(3,4),(3,5),(4,1),(4,2),(4,4),(4,5),(4,7),(4,8),(4,9),(4,14),(4,15),(4,17),(4,18);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN','System Administrator','2025-06-29 07:57:42'),(2,'SALES','Sales Representative','2025-06-29 07:57:42'),(3,'CUSTOMER','Customer','2025-06-29 07:57:42'),(4,'MANAGER','Store Manager','2025-06-29 07:57:42'),(5,'USER','Default user role','2025-07-05 07:20:08');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (2,1),(3,5),(4,5);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `phone_verified` tinyint(1) NOT NULL DEFAULT 0,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'admin','admin@gmail.com','$2a$10$DprJ.CR8y68L6gt0Wqw3P.VZFhZO/Bhse5nHS3DTzsKO5CcwOw.vS','Admin','User',NULL,NULL,1,1,0,'2025-07-10 11:43:59','2025-06-29 11:12:37','2025-07-10 11:43:59'),(3,'bao','quocbao01651@gmail.com','$2a$10$1P019yJ.V/Yty229kQ9c6OL3GpnA2pOo5kqlk5dJa9BzDvW1zFhuu','Nguyễn','Bảo',NULL,NULL,1,0,0,'2025-07-05 01:46:37','2025-07-05 07:20:08','2025-07-05 07:20:08'),(4,'lam','quocbao0165sddsfd@gmail.com','$2a$10$0bhFWBJI4Y49YXcgcJyJIudecIAgFI8/1b.eb01plrQjSA0vnpL.S','lam','lam',NULL,NULL,1,0,0,NULL,'2025-07-10 11:43:16','2025-07-10 11:43:16');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-11  2:57:25
