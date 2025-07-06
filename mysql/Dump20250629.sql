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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'SHOP ALL','shop-all','All products',NULL,NULL,1,1,'2025-06-29 07:57:42'),(2,'TOPS','tops','T-shirts, polo shirts, tank tops',NULL,NULL,2,1,'2025-06-29 07:57:42'),(3,'BOTTOMS','bottoms','Pants, shorts, jeans',NULL,NULL,3,1,'2025-06-29 07:57:42'),(4,'OUTERWEARS','outerwears','Jackets, hoodies, sweaters',NULL,NULL,4,1,'2025-06-29 07:57:42'),(5,'UNDERWEARS','underwears','Underwear, socks',NULL,NULL,5,1,'2025-06-29 07:57:42'),(6,'BAGS','bags','Backpacks, bags, accessories',NULL,NULL,6,1,'2025-06-29 07:57:42'),(7,'ACCESSORIES','accessories','Caps, belts, jewelry',NULL,NULL,7,1,'2025-06-29 07:57:42'),(8,'SALE','sale','Discounted products',NULL,NULL,8,1,'2025-06-29 07:57:42');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'CUST001',NULL,'Tech Solutions Inc','John Smith','john@techsolutions.com','0123456789','123 Tech Street','Ho Chi Minh City','District 1',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(2,'CUST002',NULL,'Fashion Retail Co','Jane Doe','jane@fashionretail.com','0987654321','456 Fashion Ave','Ha Noi','Dong Da',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(3,'CUST003',NULL,'Book Store Plus','Bob Wilson','bob@bookstore.com','0111222333','789 Book Lane','Da Nang','Hai Chau',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42');
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
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
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
  `status` enum('PENDING','CONFIRMED','PROCESSING','SHIPPED','DELIVERED','CANCELLED','REFUNDED') DEFAULT 'PENDING',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
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
  `weight` decimal(8,2) DEFAULT 0.00,
  `dimensions` varchar(100) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `material` varchar(100) DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_virtual` tinyint(1) DEFAULT 0,
  `requires_shipping` tinyint(1) DEFAULT 1,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_code` (`product_code`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `sku` (`sku`),
  UNIQUE KEY `barcode` (`barcode`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'HADES001','HADES SPLICE POLO - BROWN','hades-splice-polo-brown','Premium polo shirt with unique splice design','Comfortable and stylish polo shirt',520000.00,300000.00,NULL,50,10,1000,0.00,NULL,NULL,NULL,2,'HADES',NULL,'Brown',NULL,'Cotton','polo,premium,comfortable',1,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(2,'HADES002','HADES CHAMPION TANK TOP - BLACK','hades-champion-tank-top-black','Athletic tank top for champions','Perfect for workouts and casual wear',420000.00,200000.00,NULL,75,10,1000,0.00,NULL,NULL,NULL,2,'HADES',NULL,'Black',NULL,'Polyester','tank-top,athletic,workout',1,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(3,'HADES003','HADES COZY STRIPE POLO SWEATER - RED','hades-cozy-stripe-polo-sweater-red','Warm and cozy striped sweater','Perfect for cold weather',1150000.00,600000.00,NULL,30,10,1000,0.00,NULL,NULL,NULL,4,'HADES',NULL,'Red',NULL,'Wool','sweater,warm,cozy',1,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(4,'HADES004','HADES ROCK SOLID ZIP HOODIE','hades-rock-solid-zip-hoodie','Durable zip-up hoodie','Rock solid quality for everyday wear',850000.00,450000.00,NULL,40,10,1000,0.00,NULL,NULL,NULL,4,'HADES',NULL,'Black',NULL,'Cotton','hoodie,zip-up,durable',1,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(5,'HADES005','HADES DISTRICT 1 CAP','hades-district-1-cap','Stylish cap with District 1 design','Represent your district in style',320000.00,150000.00,NULL,100,10,1000,0.00,NULL,NULL,NULL,7,'HADES',NULL,'Black',NULL,'Cotton','cap,district-1,stylish',1,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(6,'HADES006','HADES BLACK WAX BIKER JACKET','hades-black-wax-biker-jacket','Classic biker jacket with wax finish','Timeless style with modern comfort',1190000.00,700000.00,NULL,25,10,1000,0.00,NULL,NULL,NULL,4,'HADES',NULL,'Black',NULL,'Leather','jacket,biker,classic',1,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(7,'HADES007','HADES RUGGED LEOPARD SHORTS','hades-rugged-leopard-shorts','Rugged shorts with leopard print','Wild style for adventurous souls',620000.00,350000.00,NULL,60,10,1000,0.00,NULL,NULL,NULL,3,'HADES',NULL,'Leopard',NULL,'Cotton','shorts,leopard,rugged',0,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(8,'HADES008','HADES VOID DRIFTER PANTS','hades-void-drifter-pants','Comfortable drifting pants','Perfect for urban exploration',790000.00,400000.00,NULL,45,10,1000,0.00,NULL,NULL,NULL,3,'HADES',NULL,'Black',NULL,'Cotton','pants,drifter,comfortable',0,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(9,'HADES009','HADES VOID DRIFTER ZIP HOODIE','hades-void-drifter-zip-hoodie','Matching zip hoodie for drifters','Complete your drifting look',850000.00,450000.00,NULL,35,10,1000,0.00,NULL,NULL,NULL,4,'HADES',NULL,'Black',NULL,'Cotton','hoodie,drifter,matching',0,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(10,'HADES010','HADES CLASSIC KNICKERS - BLACK','hades-classic-knickers-black','Classic underwear in black','Comfortable everyday wear',190000.00,80000.00,NULL,200,10,1000,0.00,NULL,NULL,NULL,5,'HADES',NULL,'Black',NULL,'Cotton','underwear,classic,comfortable',0,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(11,'HADES011','HADES CLASSIC KNICKERS - WHITE','hades-classic-knickers-white','Classic underwear in white','Clean and comfortable',190000.00,80000.00,NULL,200,10,1000,0.00,NULL,NULL,NULL,5,'HADES',NULL,'White',NULL,'Cotton','underwear,classic,clean',0,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(12,'HADES012','HADES Y-BACK SPORTS BRA - WHITE','hades-y-back-sports-bra-white','Supportive sports bra','Perfect for active lifestyle',290000.00,120000.00,NULL,80,10,1000,0.00,NULL,NULL,NULL,5,'HADES',NULL,'White',NULL,'Polyester','sports-bra,supportive,active',0,1,0,1,0.00,'2025-06-29 07:57:42','2025-06-29 07:57:42');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN','System Administrator','2025-06-29 07:57:42'),(2,'SALES','Sales Representative','2025-06-29 07:57:42'),(3,'CUSTOMER','Customer','2025-06-29 07:57:42'),(4,'MANAGER','Store Manager','2025-06-29 07:57:42');
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
INSERT INTO `user_roles` VALUES (2,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'admin','admin@gmail.com','$2a$10$4TEH1SHUROpw58Ka.Cw..uzhqoZzyjtiEwZUP0ukB/VKw73ldedPq','Admin','User',NULL,NULL,1,1,0,NULL,'2025-06-29 11:12:37','2025-06-29 11:12:37');
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

-- Dump completed on 2025-06-29 23:54:10
