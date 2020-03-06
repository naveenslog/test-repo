-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_menu`
--

DROP TABLE IF EXISTS `admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_menu`
--

LOCK TABLES `admin_menu` WRITE;
/*!40000 ALTER TABLE `admin_menu` DISABLE KEYS */;
INSERT INTO `admin_menu` VALUES (1,0,1,'Dashboard','fa-bar-chart','/',NULL,NULL,NULL),(2,0,2,'Admin','fa-tasks','',NULL,NULL,NULL),(3,2,3,'Users','fa-users','auth/users',NULL,NULL,NULL),(4,2,4,'Roles','fa-user','auth/roles',NULL,NULL,NULL),(5,2,5,'Permission','fa-ban','auth/permissions',NULL,NULL,NULL),(6,2,6,'Menu','fa-bars','auth/menu',NULL,NULL,NULL),(7,2,7,'Operation log','fa-history','auth/logs',NULL,NULL,NULL);
/*!40000 ALTER TABLE `admin_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_operation_log`
--

DROP TABLE IF EXISTS `admin_operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_operation_log_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_operation_log`
--

LOCK TABLES `admin_operation_log` WRITE;
/*!40000 ALTER TABLE `admin_operation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_operation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_permissions`
--

DROP TABLE IF EXISTS `admin_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`),
  UNIQUE KEY `admin_permissions_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_permissions`
--

LOCK TABLES `admin_permissions` WRITE;
/*!40000 ALTER TABLE `admin_permissions` DISABLE KEYS */;
INSERT INTO `admin_permissions` VALUES (1,'All permission','*','','*',NULL,NULL),(2,'Dashboard','dashboard','GET','/',NULL,NULL),(3,'Login','auth.login','','/auth/login\r\n/auth/logout',NULL,NULL),(4,'User setting','auth.setting','GET,PUT','/auth/setting',NULL,NULL),(5,'Auth management','auth.management','','/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs',NULL,NULL);
/*!40000 ALTER TABLE `admin_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role_menu`
--

DROP TABLE IF EXISTS `admin_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role_menu`
--

LOCK TABLES `admin_role_menu` WRITE;
/*!40000 ALTER TABLE `admin_role_menu` DISABLE KEYS */;
INSERT INTO `admin_role_menu` VALUES (1,2,NULL,NULL);
/*!40000 ALTER TABLE `admin_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role_permissions`
--

DROP TABLE IF EXISTS `admin_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role_permissions`
--

LOCK TABLES `admin_role_permissions` WRITE;
/*!40000 ALTER TABLE `admin_role_permissions` DISABLE KEYS */;
INSERT INTO `admin_role_permissions` VALUES (1,1,NULL,NULL);
/*!40000 ALTER TABLE `admin_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role_users`
--

DROP TABLE IF EXISTS `admin_role_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_role_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role_users`
--

LOCK TABLES `admin_role_users` WRITE;
/*!40000 ALTER TABLE `admin_role_users` DISABLE KEYS */;
INSERT INTO `admin_role_users` VALUES (1,1,NULL,NULL);
/*!40000 ALTER TABLE `admin_role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_roles`
--

DROP TABLE IF EXISTS `admin_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_name_unique` (`name`),
  UNIQUE KEY `admin_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_roles`
--

LOCK TABLES `admin_roles` WRITE;
/*!40000 ALTER TABLE `admin_roles` DISABLE KEYS */;
INSERT INTO `admin_roles` VALUES (1,'Administrator','administrator','2020-02-27 11:30:23','2020-02-27 11:30:23');
/*!40000 ALTER TABLE `admin_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_user_permissions`
--

DROP TABLE IF EXISTS `admin_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_user_permissions` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_user_permissions`
--

LOCK TABLES `admin_user_permissions` WRITE;
/*!40000 ALTER TABLE `admin_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','$2y$10$sneGjEcWBbBiP7I/cdWF1.Xm.NPQdp.0uGLMdAxwp6ROuBnM9lMBi','Administrator',NULL,NULL,'2020-02-27 11:30:23','2020-02-27 11:30:23');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_enquiry`
--

DROP TABLE IF EXISTS `admission_enquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_enquiry` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schoolprofile_id` int(11) NOT NULL,
  `age` varchar(225) DEFAULT NULL,
  `course` varchar(225) DEFAULT NULL,
  `application_status` varchar(225) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `phone` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_enquiry`
--

LOCK TABLES `admission_enquiry` WRITE;
/*!40000 ALTER TABLE `admission_enquiry` DISABLE KEYS */;
INSERT INTO `admission_enquiry` VALUES (1,1,'20','BC','accepted','2020-02-26 16:46:57',1,'9540150666'),(2,9,'12','8th','accepted','2020-02-26 16:37:07',37,'9876543210'),(3,9,'12','7th','accepted','2020-02-26 16:42:15',37,'876543290'),(4,12,'0','0','pending','2020-02-26 05:23:15',1,'0'),(5,16,'0','0','pending','2020-02-26 06:08:05',7,'0'),(6,16,'0','0','pending','2020-02-26 06:08:59',7,'0'),(7,16,'0','0','pending','2020-02-26 06:09:09',7,'0'),(8,16,'0','0','pending','2020-02-26 06:09:13',7,'0'),(9,16,'0','0','pending','2020-02-26 06:09:44',7,'0'),(10,16,'0','0','pending','2020-02-26 06:11:47',7,'0'),(11,16,'0','0','pending','2020-02-26 06:11:48',7,'0'),(12,15,'12','11th','pending','2020-02-26 15:48:29',37,'9876543210'),(13,9,'0','0','accepted','2020-02-26 16:52:53',7,'0'),(14,9,'0','0','rejected','2020-02-26 17:08:20',8,'0'),(15,9,'0','0','accepted','2020-02-26 17:09:43',8,'0'),(16,9,'0','0','rejected','2020-02-27 05:03:02',7,'0'),(17,17,'20','Some test cource','pending','2020-03-01 06:58:01',1,'9540150666'),(18,17,'20','Some test cource','pending','2020-03-01 07:15:40',2,'9540150666'),(19,17,'20','Some test cource','pending','2020-03-01 07:15:43',3,'9540150666'),(20,17,'20','Some test cource','pending','2020-03-01 07:15:47',4,'9540150666'),(21,17,'20','Some test cource','pending','2020-03-01 07:15:51',5,'9540150666'),(22,17,'20','Some test cource','pending','2020-03-01 07:16:58',17,'9540150666'),(23,17,'20','Some test cource','pending','2020-03-01 07:17:15',18,'9540150666'),(24,18,'20','Some test cource','pending','2020-03-01 12:20:15',18,'9540150666'),(25,18,'20','Some test cource','rejected','2020-03-02 08:46:49',1,'9540150666'),(26,18,'20','Some test cource','pending','2020-03-01 12:20:26',17,'9540150666');
/*!40000 ALTER TABLE `admission_enquiry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(6,'2016_06_01_000004_create_oauth_clients_table',1),(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(8,'2019_08_19_000000_create_failed_jobs_table',1),(9,'2016_01_04_173148_create_admin_tables',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('0020ac4b8415084c9520b51da20154d1ab546759d1e0a1fff053d8c43d04257255ce468b81053e7d',41,3,'MyApp','[]',0,'2020-03-04 08:16:35','2020-03-04 08:16:35','2021-03-04 08:16:35'),('002d46e56670ed441fed0be17e8409a0c1efb445f46ee199dba766487139cf93e397e4c7f962f82a',7,3,'MyApp','[]',0,'2020-03-01 08:49:36','2020-03-01 08:49:36','2021-03-01 08:49:36'),('0124466aa59d54fd9804851cacf68ebdd3d886e203dd365bb5552f4c6a235b3a56df036a016e1793',8,3,'MyApp','[]',0,'2020-02-29 11:33:38','2020-02-29 11:33:38','2021-03-01 17:03:38'),('02b20259c7ba2470607c76b7c305af84e00324d1d7106165e6a49cd7b198c427c71bbadef21b99ed',8,1,'MyApp','[]',0,'2020-02-25 14:43:45','2020-02-25 14:43:45','2021-02-25 14:43:45'),('02cd1be69cdfeca5f14667b85ce0f065c65e18292324e3fe86113668c072aff2a5627837223de44d',41,3,'MyApp','[]',0,'2020-03-03 17:25:32','2020-03-03 17:25:32','2021-03-03 17:25:32'),('08d5318125024760bae986f596eee55001ede5efa50c0b688a0deb667e467112a0c03e4b7eed848d',25,1,'MyApp','[]',0,'2020-02-23 15:14:46','2020-02-23 15:14:46','2021-02-23 15:14:46'),('09c3f1b6b0ec2cb9f9c423fdbf9cc18204014f4385b719b1de4f4aefc4ec70826c95975b123aa914',5,1,'MyApp','[]',0,'2020-02-21 00:55:27','2020-02-21 00:55:27','2021-02-21 06:25:27'),('0afc433d47ce0015b392245d1dabe5b27015d8e3439beb0487299fc11ae8dd69d4a35715bc8cea27',43,3,'MyApp','[]',0,'2020-03-01 19:24:26','2020-03-01 19:24:26','2021-03-01 19:24:26'),('0ba81f9b21bf84c67c9d911776200bc2c3cd961c5fec8367a5fe19d3ba682d65ca4beaa82b9ad506',41,3,'MyApp','[]',0,'2020-03-01 12:06:12','2020-03-01 12:06:12','2021-03-01 12:06:12'),('0c37cb249bb0a78d88b0710383d255a34904172af18dbf71ac9d320164c1d7a57a67df0a4cc52af8',38,3,'MyApp','[]',0,'2020-03-01 07:13:27','2020-03-01 07:13:27','2021-03-01 07:13:27'),('0cb910fdaaa64d3876c5289535b49b1c5d0fb2162cd30b0bc95ef162e2ed88a09ae4f3c9f26383f8',7,1,'MyApp','[]',0,'2020-02-26 18:04:19','2020-02-26 18:04:19','2021-02-26 18:04:19'),('0d60dec4a750b799429bc82ae76604408a78d375a7590c05d0dc3435a6d3bbd38bbdf32ebf06ad6d',39,3,'MyApp','[]',0,'2020-03-05 07:53:15','2020-03-05 07:53:15','2021-03-05 07:53:15'),('0d6497b263c2d8b354b784230c9aa071eb11bce829e621d0b1e77f8fd233ae13990b4161da316b3a',7,1,'MyApp','[]',0,'2020-02-26 05:52:02','2020-02-26 05:52:02','2021-02-26 05:52:02'),('0d9ee6608c4215c2f04dcdd3b19d805b1c3fd008b199f5ef4aa62dd32a7fee5cab3bacd8a7140a5b',40,3,'MyApp','[]',0,'2020-03-02 11:27:09','2020-03-02 11:27:09','2021-03-02 11:27:09'),('0f3eddcd6d58ca9d4f5bbf688b39c2904770db25ee379013334d8f285b9a64d2a91426ae6d6cf239',41,3,'MyApp','[]',0,'2020-03-06 09:47:50','2020-03-06 09:47:50','2021-03-06 09:47:50'),('0f5ea99901f5625ba89f86ff41a0af8e4d4ab32461174e0cf35d87e5766582d6378a4c5257e94188',46,3,'MyApp','[]',0,'2020-03-05 05:38:45','2020-03-05 05:38:45','2021-03-05 05:38:45'),('1051c1354c731c88920d86e33bf0d5fd4ce12f1dd6bc507ae87d95beaa5591d1105c04ca8d3f3255',39,3,'MyApp','[]',0,'2020-03-03 19:38:13','2020-03-03 19:38:13','2021-03-03 19:38:13'),('1168a3399f9505cb9a5aff18490aa466a843241838909f7eb100d1e8d83864937eeb0c520262bf22',37,1,'MyApp','[]',0,'2020-02-26 05:07:57','2020-02-26 05:07:57','2021-02-26 05:07:57'),('122c35a5dd768e3a2014bebe50850657af1aaf305e006a93c93c24031ab3c130857a1458a43a9127',39,3,'MyApp','[]',0,'2020-03-01 08:09:59','2020-03-01 08:09:59','2021-03-01 08:09:59'),('12de228fd6d77a7cb10e54e65d504d24b72626205592a8d4bce1acb38ab295219d24664c320a645c',8,1,'MyApp','[]',0,'2020-02-26 05:25:47','2020-02-26 05:25:47','2021-02-26 05:25:47'),('1395a1a5e2359545341b408a2837cf33031066704367f6841570cda82bb39aa83195ec10ff85901d',59,3,'MyApp','[]',0,'2020-03-05 17:06:27','2020-03-05 17:06:27','2021-03-05 17:06:27'),('13b0fec0ec01e926a55bb9e3e3aa35b5ff73db2074fc0635b4a723437da230015feef0f4b6613954',20,1,'MyApp','[]',0,'2020-02-23 14:45:20','2020-02-23 14:45:20','2021-02-23 14:45:20'),('14ff3bf09c47de839c3f6042fb33adc305a8a8aeb8aa8921cb33453ba6e30c3c6c8688537f5806d4',5,1,'MyApp','[]',0,'2020-02-22 11:17:03','2020-02-22 11:17:03','2021-02-22 16:47:03'),('1514ac473f2b9e461ab3ad8d8ae4efe1868999eca7d6675326479b9d18afde86945a9a8723a6b476',40,3,'MyApp','[]',0,'2020-03-02 07:25:57','2020-03-02 07:25:57','2021-03-02 07:25:57'),('15d840535c47329744ca2357f0ecc5f9148f1241542e5db3c013cca55962b2aae563d2eb71176aed',8,1,'MyApp','[]',0,'2020-02-26 18:12:55','2020-02-26 18:12:55','2021-02-26 18:12:55'),('15e70d12864321525ba2e0eef578a88c8ee572b99f291b48194de9eb23222d4da1c3e4f92b602f48',8,1,'MyApp','[]',0,'2020-02-23 11:47:04','2020-02-23 11:47:04','2021-02-23 11:47:04'),('165832112abfed3313c96f81173ed89a875dd5b125f23e24e6ef13ec903f07f7b815a13f83a0d337',37,1,'MyApp','[]',0,'2020-02-26 04:34:26','2020-02-26 04:34:26','2021-02-26 04:34:26'),('170a54a9e12c431d9dc56798a2d29cb6b4504d1670d9972f85b98c27c9142a61aab11cc6e0db4eb2',7,3,'MyApp','[]',0,'2020-03-01 07:04:56','2020-03-01 07:04:56','2021-03-01 07:04:56'),('1717d126519494280fc9f0bbea607ea34e4d041924e0a21a847e55ee48f45f398d90e9eba1208258',41,3,'MyApp','[]',0,'2020-03-03 19:49:37','2020-03-03 19:49:37','2021-03-03 19:49:37'),('1a8959029cab0f8d9a15c8972fff14947998c405829f47c55987880746bac9684a5445989b1aaa42',46,3,'MyApp','[]',0,'2020-03-05 07:49:47','2020-03-05 07:49:47','2021-03-05 07:49:47'),('1b35390cfc883f3226fda4de48c864240a8ace43945f9ceb302cd3208ea3632e8e99063936610ed6',39,3,'MyApp','[]',0,'2020-03-01 08:09:03','2020-03-01 08:09:03','2021-03-01 08:09:03'),('1bfc4e368579cdb94d690c8a375bb3c4a42d8d3669165bbca11a5d06390d53a4f02702cedf535026',41,3,'MyApp','[]',0,'2020-03-04 08:18:31','2020-03-04 08:18:31','2021-03-04 08:18:31'),('1cb33db9199c546b63008bceb3d323cc305384cc359cfdb8825667f73b71cc51ee13af5bc78af393',8,1,'MyApp','[]',0,'2020-02-23 11:48:27','2020-02-23 11:48:27','2021-02-23 11:48:27'),('1d63f9ea6f96eafa2608394e5329536751305d2bc78cd2d185bd2565e599a4f9704082578cadda89',40,3,'MyApp','[]',0,'2020-03-02 07:34:09','2020-03-02 07:34:09','2021-03-02 07:34:09'),('1e4ab280b905281a051e3ee1bffc088b9e1982f730c5a3d9b3b3a9459aac3fb394b5eb2389e563e1',44,3,'MyApp','[]',0,'2020-03-01 19:07:48','2020-03-01 19:07:48','2021-03-01 19:07:48'),('2035ded9e9c1870934eeb0f1fca73cd3e04387f60f4e3d120113669e2a7c04d67971cc3580527aea',8,1,'MyApp','[]',0,'2020-02-25 15:59:30','2020-02-25 15:59:30','2021-02-25 15:59:30'),('2162b6d3d76ae802c8f76dab9bbcacc09469f6af698389ada752eec8e8d6133f3e8314f291919b24',42,3,'MyApp','[]',0,'2020-03-01 18:53:40','2020-03-01 18:53:40','2021-03-01 18:53:40'),('21d9723ec124d3b57dc89aa2e517a106c959808dee4a3765d8f0e614ad90fbedc1279689342ebb8d',7,1,'MyApp','[]',0,'2020-02-26 18:21:05','2020-02-26 18:21:05','2021-02-26 18:21:05'),('23e4fd60f3cba7a69e3ec074476d7b34c48387c712c18910918f474507ac480057fc20603bea932b',8,1,'MyApp','[]',0,'2020-02-25 13:21:25','2020-02-25 13:21:25','2021-02-25 13:21:25'),('2456009195a29f51caf674e645f5f9b16e37b685f768bfa8c0036d84980778bab0620ec36a947a66',38,3,'MyApp','[]',0,'2020-03-01 14:41:06','2020-03-01 14:41:06','2021-03-01 14:41:06'),('2555976d3bf0f8cd8c658556da1986f9ffb5831207e0dc107a95afa80a875569e358c967fedb0f56',6,1,'MyApp','[]',0,'2020-02-22 21:27:21','2020-02-22 21:27:21','2021-02-22 21:27:21'),('255f5669d7f9806e775a39505d1fc14c7666ef5dae419d4b3b4194ac1347d9579e7439c186901122',7,1,'MyApp','[]',0,'2020-02-26 16:47:43','2020-02-26 16:47:43','2021-02-26 16:47:43'),('2667ec262df65b8621880601c7d3f72d2481d1dc444175fefdbb1b7f9b4f29f997942a93c380fd10',38,3,'MyApp','[]',0,'2020-03-01 12:34:11','2020-03-01 12:34:11','2021-03-01 12:34:11'),('27bd0c8e4cb2e4e01ce97131c527317a2f626a0ec00c40d3eb4f016b1b6fcceb5fd09fde8bbb795f',7,1,'MyApp','[]',0,'2020-02-26 05:52:02','2020-02-26 05:52:02','2021-02-26 05:52:02'),('280d9f66725eafa71c41169e6a93932c7ee6cda322837fe06258ee2784c4774b3ba0c518406a35a5',8,3,'MyApp','[]',0,'2020-02-29 11:28:59','2020-02-29 11:28:59','2021-03-01 16:58:59'),('283408c19a377d6096b6ebed06ee82e5caffacccb8333d4c03c8bebb36b1ec517f6944307538ae58',8,1,'MyApp','[]',0,'2020-02-23 11:41:51','2020-02-23 11:41:51','2021-02-23 11:41:51'),('2925c3aad758c4c037a0339ef88ecd97d0a110b4c19f0454c9eb3e35d619e8e678ba122c41b49a4f',8,3,'MyApp','[]',0,'2020-02-29 11:36:22','2020-02-29 11:36:22','2021-03-01 17:06:22'),('2a9af22aaa5f9e90f6e5acd2402a80fb54216d35e0c46c9f513defaaba5e5e97093617ea66e82553',8,1,'MyApp','[]',0,'2020-02-23 11:54:40','2020-02-23 11:54:40','2021-02-23 11:54:40'),('2af8339b316874f85ed93bfbbcc2b400fa44f6ba7a1471de400d53b76bc9befc397ebe8206b0a84e',7,1,'MyApp','[]',0,'2020-02-23 06:48:10','2020-02-23 06:48:10','2021-02-23 06:48:10'),('2bc3e99d8af4ce4e2733f64cbca19514715abb4ddec316bbb78467d5c47d3583d5c2ab5f1b63369d',8,1,'MyApp','[]',0,'2020-02-25 19:30:26','2020-02-25 19:30:26','2021-02-25 19:30:26'),('2cd45e95a5a714eda516171b370042bbf0b1616b8ba816585a5beb50b69d1d823b0c6df44d0c0f7d',8,1,'MyApp','[]',0,'2020-02-26 06:15:16','2020-02-26 06:15:16','2021-02-26 06:15:16'),('2ee630940bd4ca390a86231a342c2d73e6c42f81e12c0aecefab901391f82ba068f655dd80854a78',38,3,'MyApp','[]',0,'2020-03-01 07:49:07','2020-03-01 07:49:07','2021-03-01 07:49:07'),('2f4ba1178c9818be6863cd1d49d98373b2dd0cd99c90f5739c58eb843846d9374652280047f97d3a',46,3,'MyApp','[]',0,'2020-03-02 11:36:11','2020-03-02 11:36:11','2021-03-02 11:36:11'),('2fd75b90e0ffbabb1cfb2dcfa035f67f20ce0bfc2d92f9325d1bc53736459532da63c1cbef61ea4c',41,3,'MyApp','[]',0,'2020-03-05 17:09:34','2020-03-05 17:09:34','2021-03-05 17:09:34'),('3124c77a2d7cfba9e875f222e48315eb0d02ce06ed4b000e8ecc751b199d8e5c4749e182392e52ae',38,3,'MyApp','[]',0,'2020-03-01 01:43:25','2020-03-01 01:43:25','2021-03-01 01:43:25'),('3177d526008440fdc4a0f1e06f6aa9adebebc5c63ea22c044b3f074df42a296e65fffbdf6fe73cbd',37,1,'MyApp','[]',0,'2020-02-26 05:06:38','2020-02-26 05:06:38','2021-02-26 05:06:38'),('31a2bebef58de6eeacdaae653bea1fde92e97d76dc0793a6095e74d8ff80b0b4d0082b3a974fa411',41,3,'MyApp','[]',0,'2020-03-03 19:52:36','2020-03-03 19:52:36','2021-03-03 19:52:36'),('31fa236cc4d4d00c15e32fe78913be40cde371990367a1e0bc34895d6fc0cbf497319de857f4c0b5',41,3,'MyApp','[]',0,'2020-03-04 13:33:41','2020-03-04 13:33:41','2021-03-04 13:33:41'),('347e7a55936baa96be5ce80919394d7d0eaa9da80a5204d2160183be8310bab56c49cfde4ef64698',37,3,'MyApp','[]',0,'2020-03-02 12:44:29','2020-03-02 12:44:29','2021-03-02 12:44:29'),('370af2d2e923dbe3c917767fc431574dd6384384f649b0bf7829a1cc753b33141b4e9ea65fe6bae8',8,1,'MyApp','[]',0,'2020-02-25 08:58:39','2020-02-25 08:58:39','2021-02-25 08:58:39'),('37f5afd70d66bc1d0a8d6f619f4f03e23fc0eb00d38342ba0bdb56e9a4220cd919923a4ebaf06255',40,3,'MyApp','[]',0,'2020-03-02 06:20:57','2020-03-02 06:20:57','2021-03-02 06:20:57'),('381d66b21160733581601c8cefe61a507ec6f31aff2da6c3b98331142869f261af8dd7cb006fc5e4',41,3,'MyApp','[]',0,'2020-03-03 17:43:33','2020-03-03 17:43:33','2021-03-03 17:43:33'),('386710400f3a3961a404fc741c4c2e4b67dbe1cf372f524d7ac2520da3d3e292c7885b0f5267adc0',7,1,'MyApp','[]',0,'2020-02-24 06:30:04','2020-02-24 06:30:04','2021-02-24 06:30:04'),('38c6bea896d5a6b48274c09ca0d7b548266a1d2defd2f015257706c732df9f9d55df3b8d7ff55e71',10,1,'MyApp','[]',0,'2020-02-23 08:41:31','2020-02-23 08:41:31','2021-02-23 08:41:31'),('38d8c981badb98ed45efc28c6eccfc0baf1caac186b96d57e4b05c7867181a406cb10e4baae750f9',49,3,'MyApp','[]',0,'2020-03-02 18:33:49','2020-03-02 18:33:49','2021-03-02 18:33:49'),('3a1061e86b2812a480ef71b025d0c073714e2e32eed7ff5dd8c9059266f071154ea9cd5a1e0d6165',31,1,'MyApp','[]',0,'2020-02-25 07:02:31','2020-02-25 07:02:31','2021-02-25 07:02:31'),('3bfe12556392a3ae91e31f3c0afe6950adbed22a7bd9134926bf6bee0a3b414aac423b4fd6b983e0',40,3,'MyApp','[]',0,'2020-03-01 11:53:02','2020-03-01 11:53:02','2021-03-01 11:53:02'),('3c1ce4867cb65a44ffd9b4191ae00506d3f0608ef9cdcd6333132ebaf6364fa038bd6b3b14873703',45,3,'MyApp','[]',0,'2020-03-05 09:46:34','2020-03-05 09:46:34','2021-03-05 09:46:34'),('3d95bed2e399a409946314c1ba8554843623534a3e47f90240bcf5886679f59559dcb2ba532ef0b6',7,1,'MyApp','[]',0,'2020-02-23 06:53:17','2020-02-23 06:53:17','2021-02-23 06:53:17'),('3dd92c5d637aa0aca967b871f213bf02f04c4f11e0a0973452fd19ac6e392eede77ed69ed7f52bed',6,1,'MyApp','[]',0,'2020-02-25 11:26:13','2020-02-25 11:26:13','2021-02-25 11:26:13'),('3e3bb7fe4c03c36feed17563f49116b939c2c5ccdf5f8dc3965221907dda032f648270a6c51f4cbe',41,3,'MyApp','[]',0,'2020-03-04 09:42:18','2020-03-04 09:42:18','2021-03-04 09:42:18'),('40b94326279f742d002ce2ff894fb841bf8a5202f8d3981ad8323227579e7e28f92751f948307fb8',6,1,'MyApp','[]',0,'2020-02-25 11:33:56','2020-02-25 11:33:56','2021-02-25 11:33:56'),('42ee2308be5da6b7614577efd8d7c6a4bee6f55fddbfd3fe5f8f522f5d915d90a2eabc2d8a87cdf9',8,3,'newToken','[]',0,'2020-02-29 11:08:43','2020-02-29 11:08:43','2021-03-01 16:38:43'),('439b28f4c4250d2c3ca05479477cdd08ef281653a547312c438a4b2ede6b8a41a5e6830b998be19c',45,3,'MyApp','[]',0,'2020-03-02 09:14:15','2020-03-02 09:14:15','2021-03-02 09:14:15'),('4427623f8e0e7b7a18747c6fbadc2edb40176074d2417df7df3347028e812e2c86eff56c0b12a753',7,1,'MyApp','[]',0,'2020-02-23 07:14:39','2020-02-23 07:14:39','2021-02-23 07:14:39'),('4486c514c04ccdf3bb37fbe5bf2ed77b1f9066c6610f8f2124bb997938db64e42a6331895ae3d23f',8,3,'MyApp','[]',0,'2020-02-29 11:28:49','2020-02-29 11:28:49','2021-03-01 16:58:49'),('44f29eb08cc2b23d7f631acc4e1e9678870fc84cbb23565916d13942fdc8c84c20959402a2954746',45,3,'MyApp','[]',0,'2020-03-06 09:44:47','2020-03-06 09:44:47','2021-03-06 09:44:47'),('45319237ba631482a5931dc6565010f53e513141fc831c57cf9faf1ce1e6a3769c0e35502bbdb674',41,3,'MyApp','[]',0,'2020-03-05 05:20:27','2020-03-05 05:20:27','2021-03-05 05:20:27'),('457a4fcc5a84f4a364173bd48b9053e9e660875152628b834145fc736476eb2bbac65d0fe037d153',8,1,'MyApp','[]',0,'2020-02-25 05:56:44','2020-02-25 05:56:44','2021-02-25 05:56:44'),('47841eeec0e2cbc5508c1a82be0b42dbfa97852ac7593e1d7ac2f0d94ef3c905dafc88df339d5ef2',7,1,'MyApp','[]',0,'2020-02-26 16:16:28','2020-02-26 16:16:28','2021-02-26 16:16:28'),('483f38e0ae0eff5e01ad6844b6d620e4097cb697c6680c1a248452be9ca497500c71146d7e3b44fb',45,3,'MyApp','[]',0,'2020-03-03 19:44:41','2020-03-03 19:44:41','2021-03-03 19:44:41'),('487600ea893d29ad54cc31d0b9362c615bf4d664efde8fcba2a628897b8ad521bb3017261c38970a',8,1,'MyApp','[]',0,'2020-02-23 11:38:10','2020-02-23 11:38:10','2021-02-23 11:38:10'),('49b3fc9232a61157624addfe3c819fcd8e347e8e4ed9aad671690a8112535e306cbf4b4fe453aeaf',7,1,'MyApp','[]',0,'2020-02-26 16:15:52','2020-02-26 16:15:52','2021-02-26 16:15:52'),('4a38a69f068ba7d56595de7706615e4750aa4911711a85e1ba25a5cb25b0c169617e2e32bc1c7f3b',23,1,'MyApp','[]',0,'2020-02-23 15:02:46','2020-02-23 15:02:46','2021-02-23 15:02:46'),('4c06cf9368c37bb193bf9a30a46f8eb109f53dfcd22d64c0932f57d3213b0cc26ecd02f99dad0249',7,1,'MyApp','[]',0,'2020-02-26 16:22:32','2020-02-26 16:22:32','2021-02-26 16:22:32'),('4c5419502e7fa1b7bfc1dbd67642eebbc8f1b3eb731b86b1032b1687021ddbdd6aa94b910b848ae0',46,3,'MyApp','[]',0,'2020-03-02 13:30:06','2020-03-02 13:30:06','2021-03-02 13:30:06'),('4c8ef1c59ce016fa3ea71ba90ab422f6627a186b68654d6d301c2c75bc80c7ceeb32597cfa428436',14,1,'MyApp','[]',0,'2020-02-23 08:44:00','2020-02-23 08:44:00','2021-02-23 08:44:00'),('4cfed6316e0f65718bc86aa2d47c480910b9b09c35f9bdc89f0858c6cacd1c228fe2d802c97ec360',38,3,'MyApp','[]',0,'2020-03-01 06:17:01','2020-03-01 06:17:01','2021-03-01 06:17:01'),('4e68ba6e0f31541261e592300c00405e8dfef2f6a4fea653ce66c876d27194595ec6430964f21566',7,1,'MyApp','[]',0,'2020-02-26 05:51:28','2020-02-26 05:51:28','2021-02-26 05:51:28'),('4f8e055f80e783b00e687ce2c06c32f52c2a8c77fad30ae1bccf533fe08631f16295ce202bfa298b',5,1,'MyApp','[]',0,'2020-02-22 21:18:53','2020-02-22 21:18:53','2021-02-22 21:18:53'),('53532adec6fa6b9acac7a78b2640a66be8275c2a44ed8ec92b80ad908fce22b245c8b17e30e5b93d',47,3,'MyApp','[]',0,'2020-03-02 13:05:03','2020-03-02 13:05:03','2021-03-02 13:05:03'),('53eebbbec9dc845c105df62b365036e95755aec40dd3dd4f44f8220c5ff5067c95943d188d51826b',37,1,'MyApp','[]',0,'2020-02-26 16:04:25','2020-02-26 16:04:25','2021-02-26 16:04:25'),('557e53ddbf5d0ac0c1a8a8a591f4bb1250d078698590b337935485174b612e23050f4e6bbed7eb5a',29,1,'MyApp','[]',0,'2020-02-25 06:58:05','2020-02-25 06:58:05','2021-02-25 06:58:05'),('5722031fc2d8aa6a5a70fabc89985891270969fab317444257f95ba5483fae30c012e3631e6ede3f',33,1,'MyApp','[]',0,'2020-02-25 07:11:06','2020-02-25 07:11:06','2021-02-25 07:11:06'),('598a54430932bf7082e6daadc1b7691051bd645123abf0390dd8ef166d2f1fcc7611f03dd08c44d5',22,1,'MyApp','[]',0,'2020-02-23 15:00:34','2020-02-23 15:00:34','2021-02-23 15:00:34'),('5ad3b02248af9fa6d2a8521b75892ecced520965eb98b8517c04df5e0f331749aa6c0b41e2279971',41,3,'MyApp','[]',0,'2020-03-05 17:00:34','2020-03-05 17:00:34','2021-03-05 17:00:34'),('5b3f1021c0024223858986edd561aa3ab04d86856fb33208400e147997bd705b5754d68992b07388',8,1,'MyApp','[]',0,'2020-02-23 11:42:24','2020-02-23 11:42:24','2021-02-23 11:42:24'),('5b9f05f35fe7d9bd2cbda99fd56e73cde30fd09c5b67f25b288acbfa3fc4c960c48264777e744de7',8,3,'MyApp','[]',1,'2020-02-29 11:36:33','2020-02-29 11:36:33','2021-03-01 17:06:33'),('5ca5ffefb8c4bd17a53e039f62ed84878b12191f860a50f6f03402539ce346b18ea055de417dd1a3',59,3,'MyApp','[]',0,'2020-03-05 16:15:46','2020-03-05 16:15:46','2021-03-05 16:15:46'),('5d58bd3f2a0a9fd97f431357fe6e86c86e70faa84877cce6bbaa398bba8d2dd6b3205835fb554f0f',7,1,'MyApp','[]',0,'2020-02-26 06:04:31','2020-02-26 06:04:31','2021-02-26 06:04:31'),('5d75efc813ec1b427c622ca065ea61594b6438166dd1db8fb1f43c6d6f125ef32ee2185d075b6123',46,3,'MyApp','[]',0,'2020-03-02 12:24:15','2020-03-02 12:24:15','2021-03-02 12:24:15'),('5d8aeb978b0457d1827b40429462b60b0cd7eb99f16aefdb991c3c2a01ed816a7891ce38c66cf051',7,1,'MyApp','[]',0,'2020-02-23 07:10:56','2020-02-23 07:10:56','2021-02-23 07:10:56'),('5f5b52483423a72fdfad60d90441c6e759d551a4373b2e898215d0ae9792d3917a713b023c638755',37,1,'MyApp','[]',0,'2020-02-26 16:12:47','2020-02-26 16:12:47','2021-02-26 16:12:47'),('616d80b326088c696665c66aeb35c4c61d464dd9f8cbcee01109ddc04cecf8a5b397ab07ec095ff2',8,1,'MyApp','[]',0,'2020-02-27 16:39:18','2020-02-27 16:39:18','2021-02-27 16:39:18'),('61f2e4b607b596d7875b16c8b16c49cd689986542b0609abf109697bf597adac6b04fc546c3ce3cf',43,3,'MyApp','[]',0,'2020-03-01 18:57:27','2020-03-01 18:57:27','2021-03-01 18:57:27'),('62113afb8523f12e966170b7712e236afc6b23d966bfbdc426fc55288407d9fcfad3d6a425c08725',8,1,'MyApp','[]',0,'2020-02-23 11:41:35','2020-02-23 11:41:35','2021-02-23 11:41:35'),('625b128fbd4fae6511b312e615b4197b9fcddecd5099074e9659ba53c6360d70ba99ad5027108f39',7,1,'MyApp','[]',0,'2020-02-27 05:02:23','2020-02-27 05:02:23','2021-02-27 05:02:23'),('63a9a1b1b050dbdde97618de5525cbbe9a61ddc089211c85e25e0aba98104b6861d18671d89d442a',7,1,'MyApp','[]',0,'2020-02-26 06:00:10','2020-02-26 06:00:10','2021-02-26 06:00:10'),('6435a14fe7dcb82cbe9863112844d27ff465fff259757cb392dd54b5b6a631d5b728dace40846c2f',41,3,'MyApp','[]',0,'2020-03-04 15:54:49','2020-03-04 15:54:49','2021-03-04 15:54:49'),('65b1ac992f73d91f33ba76b504b664e9964d6044bb093cea626c3bb06ccfab76ef54626cd9767737',59,3,'MyApp','[]',0,'2020-03-05 16:09:47','2020-03-05 16:09:47','2021-03-05 16:09:47'),('66c700eeb803960fddfdf347fd86f52d01f7f51f0212c2d2d2e9d46fab0d4fa875e5035fd2948828',52,3,'MyApp','[]',0,'2020-03-03 14:56:48','2020-03-03 14:56:48','2021-03-03 14:56:48'),('676b428c04daa206b9b0f4b49299822217bbb4891dda5ecd73c9f851a6d6fa1206647ffa6bc6f681',7,1,'MyApp','[]',0,'2020-02-23 06:51:44','2020-02-23 06:51:44','2021-02-23 06:51:44'),('6788f75db5f74a0b85d95c7ba459d9b9fe390007616a0676857681c67106ddcd27b835925ba5a61f',7,1,'MyApp','[]',0,'2020-02-23 06:50:40','2020-02-23 06:50:40','2021-02-23 06:50:40'),('69c88a1acb3ef393be579ebdb2ed7a8c75922f9580b883f167c4842cff233dd2c5e07969eab83f76',54,3,'MyApp','[]',0,'2020-03-03 16:59:45','2020-03-03 16:59:45','2021-03-03 16:59:45'),('6a9337c7b6f34eb5f57fb230292e8a1ca3f2b43b037552ab0bf9266c02463f7ae024ca13f1c0ac18',41,3,'MyApp','[]',0,'2020-03-06 10:03:40','2020-03-06 10:03:40','2021-03-06 10:03:40'),('6ac16eae84a42f6a1b031417df2419c5817f866b167ae628db6fe15fa14cb9267dff95614de015a7',41,3,'MyApp','[]',0,'2020-03-05 17:01:18','2020-03-05 17:01:18','2021-03-05 17:01:18'),('6b2a9ed176ba1995b2742c026f635cb9884df19ccbfa036ffd9dc696e725601d0439b3c714372cd1',7,1,'MyApp','[]',0,'2020-02-26 05:58:34','2020-02-26 05:58:34','2021-02-26 05:58:34'),('6bfb4512a371ff68fbf78b624aa54a28125baafe443d54090ea1d0c2d454064399ce1246bc6cee40',7,1,'MyApp','[]',0,'2020-02-23 15:13:38','2020-02-23 15:13:38','2021-02-23 15:13:38'),('6dfea11e9cad885fc77cac1bb6310a2042d28596d950ec7c6ad13f27d7f286be8838e37b3bc61d72',8,1,'MyApp','[]',0,'2020-02-24 16:11:49','2020-02-24 16:11:49','2021-02-24 16:11:49'),('6f6617b8a85fb9816c5a5fc7489934a231857e55ce7343f710dd26c73205f94b95d4a50fa9d2506b',7,1,'MyApp','[]',0,'2020-02-23 07:10:17','2020-02-23 07:10:17','2021-02-23 07:10:17'),('7074b712e2c6f0a12d2a9c9b64e22a36911e1f6efec5cdd487a752707f3bb190af244a9f87a2960a',7,1,'MyApp','[]',0,'2020-02-26 04:51:43','2020-02-26 04:51:43','2021-02-26 04:51:43'),('730bad82feebc98b4bf4674cc154e15d4f5676ddc33d90cdec005468441be0139ffa6f883b4577e4',7,1,'MyApp','[]',0,'2020-02-26 06:02:31','2020-02-26 06:02:31','2021-02-26 06:02:31'),('782d71924afb690bd3072e0894443346551a713f8a08844bd6239d9197facc472d81c1caf9ab1e8a',30,1,'MyApp','[]',0,'2020-02-25 07:00:21','2020-02-25 07:00:21','2021-02-25 07:00:21'),('789cbac706184159d9f2e92b1f9e7ee56942eb5ad11b3c950307966f156a03a9f0ed5d18e47f8d05',7,1,'MyApp','[]',0,'2020-02-26 17:04:58','2020-02-26 17:04:58','2021-02-26 17:04:58'),('7ae19bf864a49f4e50db4d013a882bd555d89ba5ab14f6ad1955bfd592a6c4c787ddf2b53f9035d5',7,1,'MyApp','[]',0,'2020-02-23 11:13:16','2020-02-23 11:13:16','2021-02-23 11:13:16'),('7af1bdf5fea3a893d0369d7150a7d13ad1ef4a17d29fb393ef9e03cae0a1fe135015f106f413cacd',39,3,'MyApp','[]',0,'2020-03-01 14:46:56','2020-03-01 14:46:56','2021-03-01 14:46:56'),('7b36a03638e0587d3566c70433c7996abae0a7b4878e76a745cf06c85c964c9cd2956c78a9728749',4,1,'MyApp','[]',0,'2020-02-21 00:51:25','2020-02-21 00:51:25','2021-02-21 06:21:25'),('7bd5282a185d0b214de1d299c073ec6a91e21857a885ece7e4171dfda93ad95deb790af138e3d765',36,1,'MyApp','[]',0,'2020-02-26 04:15:12','2020-02-26 04:15:12','2021-02-26 04:15:12'),('7dc64e73d00567666e3abdde037162f4df330d538648d65ad69fa84876285d28ecd3c9bbe4ead658',8,1,'MyApp','[]',0,'2020-02-23 14:10:16','2020-02-23 14:10:16','2021-02-23 14:10:16'),('802477874fdd4e8478ec5a72f7d488421e60f97f5464cd00f69480270894e63096f8c748fae67a52',7,1,'MyApp','[]',0,'2020-02-23 14:46:39','2020-02-23 14:46:39','2021-02-23 14:46:39'),('80325f260e7b136f81e8d548efbf41235468cdc16c3fff69789ba075daaafedcb5effe71812e22fb',56,3,'MyApp','[]',0,'2020-03-05 09:30:02','2020-03-05 09:30:02','2021-03-05 09:30:02'),('804e33cc399850e2ff9ad0fe4878ae40cdfd3e780b80bc5345ababd756d505957961e376424d57d5',45,3,'MyApp','[]',0,'2020-03-02 11:07:51','2020-03-02 11:07:51','2021-03-02 11:07:51'),('8050e25f35b50547727b62c88fee6e97aa5e655e8d236713557295375d66181885b4a8164bf5d776',13,1,'MyApp','[]',0,'2020-02-23 08:41:02','2020-02-23 08:41:02','2021-02-23 08:41:02'),('80758912c73f44a270b95f158279b23c9034059a53d8e335bb2233a81781dd7932bccc8ee541e440',45,3,'MyApp','[]',0,'2020-03-02 12:04:38','2020-03-02 12:04:38','2021-03-02 12:04:38'),('80ee1e4a0ad6485f8885d8eec40ebaf2f5e2beb132cbf7fee47cff440e8adcec6d4e3183bec7a41c',46,3,'MyApp','[]',0,'2020-03-02 12:23:34','2020-03-02 12:23:34','2021-03-02 12:23:34'),('812cc27113bba22af71f7147c5ed3dfbb8af4ea0722e110cbeb175345c8832deb434c13d2f199d9b',46,3,'MyApp','[]',0,'2020-03-05 09:27:10','2020-03-05 09:27:10','2021-03-05 09:27:10'),('8199d339baf870fac070a01c57ae28f9d20b5e00c8415411d3e778d820f6cb9e0d4fd29b5bc7db23',37,1,'MyApp','[]',0,'2020-02-26 15:09:10','2020-02-26 15:09:10','2021-02-26 15:09:10'),('81c85e76e0a0f30acb8e0f08da2a04f985c26ed314838b629c5e8d6cd45e28b37f46612fa8028f38',40,3,'MyApp','[]',0,'2020-03-01 10:46:00','2020-03-01 10:46:00','2021-03-01 10:46:00'),('82fd62b0aef9f0b063c86f2b447e034c30bb4891f59d87a69e395c2e3e2bff7ae3bf927e62c25ef0',48,3,'MyApp','[]',1,'2020-03-02 16:13:55','2020-03-02 16:13:55','2021-03-02 16:13:55'),('856090676ff934d17fd922a7a6646dc2220b9fe0169f7b3a08ce5fe07f5f76c769348eff638e1532',24,1,'MyApp','[]',0,'2020-02-23 15:03:15','2020-02-23 15:03:15','2021-02-23 15:03:15'),('85c5e339a4ff400f8d2bd32bbbf7a185d4e237a61a4aef89786c95c335e0bed26046668a3ab2b697',8,3,'MyApp','[]',0,'2020-02-29 11:37:21','2020-02-29 11:37:21','2021-03-01 17:07:21'),('860c6b0b2c04be64bcf0cdff11715719a4b644a200669ec755d7ed5ccfc86a7cd69d17ebef0b1ae1',7,1,'MyApp','[]',0,'2020-02-26 18:04:35','2020-02-26 18:04:35','2021-02-26 18:04:35'),('86965b8e377d286db118d704935925baca42d21c5cb9745f810845b07f2a31f1736193e7054917df',35,1,'MyApp','[]',0,'2020-02-26 02:01:05','2020-02-26 02:01:05','2021-02-26 02:01:05'),('8778d767a044f9e4e94258d2986ac14ed2d547a6972535f31974dc8429dceb44df5e7e7c473de7e6',38,3,'MyApp','[]',0,'2020-03-01 02:48:05','2020-03-01 02:48:05','2021-03-01 02:48:05'),('881e29218d887a44da851e003dd73577ea15fd253990f64fcc11c5a1b2b7299f2c68b6e8c7cf90b0',7,1,'MyApp','[]',0,'2020-02-26 18:13:52','2020-02-26 18:13:52','2021-02-26 18:13:52'),('89a0225f73d2f7040d510f53a38c2cb5e80710e2a068c0744c4cd65b3c2ac18b42b9556b73dddd4a',41,3,'MyApp','[]',0,'2020-03-02 06:25:38','2020-03-02 06:25:38','2021-03-02 06:25:38'),('8a2d1d7eb7c763f5006e1df79cb88ae7f6cadce8fab6b9d636156d3772551a4d7868a10f970f3e9b',59,3,'MyApp','[]',0,'2020-03-05 16:16:11','2020-03-05 16:16:11','2021-03-05 16:16:11'),('8a3225978d64d9b1454e45929d44e6cc5887a6e14e0223539eef6cc333e4f677bc3b55818c93d063',21,1,'MyApp','[]',0,'2020-02-23 14:45:33','2020-02-23 14:45:33','2021-02-23 14:45:33'),('8b5a74dfce0a3c23037293b2748fbe3b3bdcbd6f79361d13f43cc2e556fc2b8c86bc49b6a3af4068',33,3,'MyApp','[]',0,'2020-03-01 09:38:42','2020-03-01 09:38:42','2021-03-01 09:38:42'),('8bc0bd4d8f6fe51ebf54df42021dd6167de69e1515503a6e7c75c2db52c8635bcb38c5c635bda4c7',37,1,'MyApp','[]',0,'2020-02-26 16:54:01','2020-02-26 16:54:01','2021-02-26 16:54:01'),('8bdbaf98e2eec67aaa5715faf3e1df7d2d2e4da750b1aa4271e1605c098c4e5329ca9ea7a99cfcf7',38,3,'MyApp','[]',0,'2020-03-01 08:09:29','2020-03-01 08:09:29','2021-03-01 08:09:29'),('8c60abe9ddc87866c1b76c2465771f1ea737fc5357e56c75be40d0861328f4e6b1dc64ad02684136',34,1,'MyApp','[]',0,'2020-02-25 07:11:36','2020-02-25 07:11:36','2021-02-25 07:11:36'),('8d344029ac460f1cd6d479c6f76beb046cf00fce9a0485c4398995a23cd96c41bd5ac9b0de5d5ba7',41,3,'MyApp','[]',0,'2020-03-03 19:52:00','2020-03-03 19:52:00','2021-03-03 19:52:00'),('8e49a415e602a81c607340b3590e5537079d0cb07277067c62a9043eb8783fd0baa27139c68adff1',45,3,'MyApp','[]',0,'2020-03-02 09:30:46','2020-03-02 09:30:46','2021-03-02 09:30:46'),('92751cbda17ee2097bbe26d5c796170770785e77ec5df32ace49b09a6011defcc32981f347b9cf10',39,3,'MyApp','[]',0,'2020-03-01 14:52:51','2020-03-01 14:52:51','2021-03-01 14:52:51'),('92b5a391a6abf03598de019c249a57db94178b1bbfa6ec194eafb9d6add51a1bcfe13cc7fc269a81',8,1,'MyApp','[]',0,'2020-02-26 03:08:53','2020-02-26 03:08:53','2021-02-26 03:08:53'),('94115abca5c394d312999001e2cafe2d8fe25cdccaebd9702dd0776c0665e361748620ec6f4ff9f0',5,1,'MyApp','[]',0,'2020-02-22 11:11:32','2020-02-22 11:11:32','2021-02-22 16:41:32'),('94f46e2576183aaec61c40a446397ed0f6cc097a138d332758d20e00d3a3faa0ede7b3f05dfb7493',38,3,'MyApp','[]',0,'2020-03-01 11:43:22','2020-03-01 11:43:22','2021-03-01 11:43:22'),('95e57ff29de5b462fc47da01980a754b8d3fbd659a36b9c00b7c0e6d0c1cc4ae4d8212afa03aca08',8,3,'MyApp','[]',0,'2020-02-29 11:16:25','2020-02-29 11:16:25','2021-03-01 16:46:25'),('969434105fc24b266e95cba12ef9661e9efb7f6736b26efead55d37fccff0288038c5ede94ca56a6',38,3,'MyApp','[]',0,'2020-03-01 06:15:47','2020-03-01 06:15:47','2021-03-01 06:15:47'),('9697a40c3f559fcd076914374ce671d8fd48e3752ff4e506e1d0475687474ccc9caab0e7e02e8fe9',6,1,'MyApp','[]',0,'2020-02-23 08:10:13','2020-02-23 08:10:13','2021-02-23 08:10:13'),('96e94af3f45ac355541bdb59841f4a232ab9d6415e63d1cc65f14459a0dfc6d172a8ff49f6ba0e28',8,3,'MyApp','[]',0,'2020-02-29 11:20:04','2020-02-29 11:20:04','2021-03-01 16:50:04'),('993304d4050e481ce7a56dcdd6f0eb443a801f84ab56dc90198f7370d7d3755fdd8bdbc3c729822f',27,1,'MyApp','[]',0,'2020-02-25 05:54:40','2020-02-25 05:54:40','2021-02-25 05:54:40'),('993c6d44d73072dd62035d9a9f9fc9b39edb079dbb32b53be07c6c4330a63c27e9ec9cbd3b4eb4f3',39,3,'MyApp','[]',0,'2020-03-06 06:57:29','2020-03-06 06:57:29','2021-03-06 06:57:29'),('99ae3136f25b4ec48522778245a7616fb07e6a83daf3ceb042bb955695ad73c9e84ae9e0738d2f4e',8,1,'MyApp','[]',0,'2020-02-26 16:28:07','2020-02-26 16:28:07','2021-02-26 16:28:07'),('9c13b2f495949c8d7fa0e757c9fd1bc1b45ba880b7c1668c0cc38b75a7ba3117e5926d112ef75d7a',40,3,'MyApp','[]',0,'2020-03-01 09:36:02','2020-03-01 09:36:02','2021-03-01 09:36:02'),('9e215e320f004ce21becef7fe46b2fcb216b518071b8f32c623ed92f93eb5b18a964999e2d0a9431',8,1,'MyApp','[]',0,'2020-02-23 07:39:29','2020-02-23 07:39:29','2021-02-23 07:39:29'),('9eb154128c23db102440439d4f0c5a021760afcf426327e82d83cec0cf67fcfd72260284e209a91a',7,1,'MyApp','[]',0,'2020-02-26 05:57:35','2020-02-26 05:57:35','2021-02-26 05:57:35'),('a2339bf96877ae5e87f3e71eb4db33a195c032c02a9db871f7a5d8c94ac4e0bc15efb681e1d39198',8,1,'MyApp','[]',0,'2020-02-27 02:29:48','2020-02-27 02:29:48','2021-02-27 02:29:48'),('a23d4f031ef9b8e4910ad0c6c23448bb5b9e05fdad5d14bbea360a40d270113a2de4239d5c67a3bd',38,3,'MyApp','[]',0,'2020-03-01 02:31:29','2020-03-01 02:31:29','2021-03-01 02:31:29'),('a34f75c17fe0b240737330f856d4c3a9b6b05c5dde3c706d1c60b3907fe17a024abee5acd8b185fa',40,3,'MyApp','[]',0,'2020-03-01 11:56:39','2020-03-01 11:56:39','2021-03-01 11:56:39'),('a3bf42889f709f54c12aa4dfd21e9e0244f37e35d52bb6a6421139cf2315efab8de8e68fc2ce4d7b',8,1,'MyApp','[]',0,'2020-02-23 11:42:11','2020-02-23 11:42:11','2021-02-23 11:42:11'),('a6018f02e999d4bf317112aed1bc42d4f9ba6d41ec9c328d8143433f651d03ee8d306e20702498f4',7,1,'MyApp','[]',0,'2020-02-26 18:21:41','2020-02-26 18:21:41','2021-02-26 18:21:41'),('a91590bbebf88c9ec8f81423ffec9691b14acda46e678878e0cc2a79ccf99815ce457ea46ed942d8',32,1,'MyApp','[]',0,'2020-02-25 07:07:27','2020-02-25 07:07:27','2021-02-25 07:07:27'),('a9b9f66047e778b58c66bb1d498627adc38acf19ad6af50ecbc8823c907d499f94f5554bd7f085cd',15,1,'MyApp','[]',0,'2020-02-24 16:09:07','2020-02-24 16:09:07','2021-02-24 16:09:07'),('aa0a0ff4404f7523689ae75743490a6f49ae310081ed8fa47ca83a91aeb23ba0e513a6187feebb44',40,3,'MyApp','[]',0,'2020-03-01 09:35:27','2020-03-01 09:35:27','2021-03-01 09:35:27'),('ac20c31e3c621241a7100d7184d978fb543e4d930f23fa15bc4e55294f61250d8c363eff3740b701',8,1,'MyApp','[]',0,'2020-02-26 17:39:20','2020-02-26 17:39:20','2021-02-26 17:39:20'),('ad4cd5a4ad9dc5cfb3e52aaad96ee5a56e0eccbbc0556df1aaa9750ed1c3bd813e43d90051a18c4c',58,3,'MyApp','[]',0,'2020-03-05 09:52:39','2020-03-05 09:52:39','2021-03-05 09:52:39'),('aea0bad4a3bca04182d28615f567d86a3836003c97835c37382eb97afd781d0b582207d6224835ca',45,3,'MyApp','[]',0,'2020-03-05 18:01:17','2020-03-05 18:01:17','2021-03-05 18:01:17'),('b07d4c56bc9fd17f0612517d67c994ea695feb3c6e87337132fbfaf76d30b4af7debd6b46a309407',46,3,'MyApp','[]',0,'2020-03-02 12:51:21','2020-03-02 12:51:21','2021-03-02 12:51:21'),('b0dc3af98d24ed5de9c29bbdff6c02ff483004615fc44e68f0fc16649232710c28d3c8aa0bed3c96',10,1,'MyApp','[]',0,'2020-02-23 08:20:01','2020-02-23 08:20:01','2021-02-23 08:20:01'),('b10abe9f7b243d8f224f42adfe641985e743bbd35b60a85182c20573a2fa9fe678925f0ed351f93b',6,1,'MyApp','[]',0,'2020-02-23 08:57:30','2020-02-23 08:57:30','2021-02-23 08:57:30'),('b11c9fa3942c5ab35080411bee7d810b84cf060e700516fae05a567cb76c500cb370b96ed1aeed98',7,1,'MyApp','[]',0,'2020-02-23 08:53:00','2020-02-23 08:53:00','2021-02-23 08:53:00'),('b21755a21203e1b44fb0b0b06ef037cf29aeea4fa8e7a95af85b9bd3284c144073cb8b7efaa80eb6',8,1,'MyApp','[]',0,'2020-02-26 05:51:03','2020-02-26 05:51:03','2021-02-26 05:51:03'),('b3957ab924d49015f5785c08628c3e19a0aee5834fd3773050e659c5258139e56686f7d1d6a813b8',5,1,'MyApp','[]',0,'2020-02-22 11:11:50','2020-02-22 11:11:50','2021-02-22 16:41:50'),('b52fe6ef2149d9f9af0fe7b2dfb4cc0df41219ee1aab264259ee897c8b08fb91800770c281ff7751',41,3,'MyApp','[]',0,'2020-03-02 16:20:51','2020-03-02 16:20:51','2021-03-02 16:20:51'),('b5c747b13bcc7159467b353768a11c304c376f335d0e36c636c9df57441d17e68458ba996b543298',37,1,'MyApp','[]',0,'2020-02-26 05:10:08','2020-02-26 05:10:08','2021-02-26 05:10:08'),('b6c6c62eae517416cc8a7a7c107280c76e0cbe614c379b7a5f4d82c050c1dba7673b18f41d6decd6',6,1,'MyApp','[]',0,'2020-02-22 21:20:44','2020-02-22 21:20:44','2021-02-22 21:20:44'),('b7745a306afd107b7d2759bc34a3a8985cbaaee2d74629660d4920df53c365226cbcb2d4ff16ca90',38,3,'MyApp','[]',0,'2020-03-01 02:41:57','2020-03-01 02:41:57','2021-03-01 02:41:57'),('b82a52dfa09235e51e64823a86b8b002a85e892f92838379ad981aa0583f8113ef7ee9ca44eb5c22',19,1,'MyApp','[]',0,'2020-02-23 14:44:44','2020-02-23 14:44:44','2021-02-23 14:44:44'),('b9448b9964ec092eabd1abc61f43c1f2d53aab693f175572eb6b31a480599a2606add6cb8a67ed1b',16,1,'MyApp','[]',0,'2020-02-23 14:39:33','2020-02-23 14:39:33','2021-02-23 14:39:33'),('bc590434db294b9f79bf3c79ddb91c236df0a530c645a75dfd4be7ad1cf154cdd3753e0b2a8ff6c4',8,1,'MyApp','[]',0,'2020-02-25 18:48:12','2020-02-25 18:48:12','2021-02-25 18:48:12'),('bd6e1cd16ff25809f10973de4520acc5bc285a00ab09359d0fb7b0de1d978f291bcebca3e6335c2c',46,3,'MyApp','[]',0,'2020-03-02 11:44:25','2020-03-02 11:44:25','2021-03-02 11:44:25'),('bdf8deaa9b854c3f2f3a827a0340629d1ded87e333e6e04dafdaf838252681c6212077a50bf0daf6',45,3,'MyApp','[]',0,'2020-03-05 05:19:57','2020-03-05 05:19:57','2021-03-05 05:19:57'),('be780967dc1641d885227882da853b6971c3db962b11b93293b44709c389c3d560ea90c87f6970f6',37,1,'MyApp','[]',0,'2020-02-27 05:03:35','2020-02-27 05:03:35','2021-02-27 05:03:35'),('bec82c26315c8814314cf8fee17122d2f297da36571b61604d7158677081d4ecfe6c996a37406ce9',48,3,'MyApp','[]',0,'2020-03-02 16:29:24','2020-03-02 16:29:24','2021-03-02 16:29:24'),('bfbd8baf7e5da379f0380433edba0760df962698c9b90aee0670ea5e870270118a8aad06edbbd902',15,1,'MyApp','[]',0,'2020-02-23 08:51:56','2020-02-23 08:51:56','2021-02-23 08:51:56'),('c08e3152c48ad9d988ee417b95570b5ebb466b0f098125910b29c2fa6c3b0f39de7fc87488524315',8,1,'MyApp','[]',0,'2020-02-26 15:17:46','2020-02-26 15:17:46','2021-02-26 15:17:46'),('c0d8796306158f87591658b10e354033d4fcb349667100081dd50a849ab9ad4393df893a319fb414',41,3,'MyApp','[]',0,'2020-03-05 17:18:59','2020-03-05 17:18:59','2021-03-05 17:18:59'),('c0ecb473b3350169db17a74c34ae3459c5f75c8d2b0e015f2cde96e7d92ee31a9993aef03b840f42',12,1,'MyApp','[]',0,'2020-02-23 08:26:36','2020-02-23 08:26:36','2021-02-23 08:26:36'),('c18faf8c81543cb0ab4753eb37cf9664334b4b48077497b167b35a44c40c4af5e9f846882754412c',8,1,'MyApp','[]',0,'2020-02-26 17:01:44','2020-02-26 17:01:44','2021-02-26 17:01:44'),('c1cc1add667aa595fce620c0c23c2d3166edc86187e63540a4a3cbf1ce223b59100085574b10fcc5',55,3,'MyApp','[]',0,'2020-03-04 16:56:52','2020-03-04 16:56:52','2021-03-04 16:56:52'),('c251f4aaa298737a77e34c21c860fcf8d1e9dcd500440ce2a09f9343819ee5054c3f98d68e3fcfd6',37,1,'MyApp','[]',0,'2020-02-26 15:19:01','2020-02-26 15:19:01','2021-02-26 15:19:01'),('c34097808b4e97b3a38d0a806a17c99c35775c9de72f287511f693bb8afdeeadbf78d7caaded91f7',46,3,'MyApp','[]',0,'2020-03-05 17:00:58','2020-03-05 17:00:58','2021-03-05 17:00:58'),('c4736d80e2f3059d4c4bf7f3f82b3980c0652a4657199c30ac6f11c96b6f7df08ba8a71b1ffac08a',8,1,'MyApp','[]',0,'2020-02-26 18:22:31','2020-02-26 18:22:31','2021-02-26 18:22:31'),('c5f75ef8647b2bba339dd01112c60cd4748bc3878480d2ffd2cf14684f05bb1f81aa3e074fd4da51',45,3,'MyApp','[]',0,'2020-03-02 09:29:41','2020-03-02 09:29:41','2021-03-02 09:29:41'),('c6d4589584c68080ec5cf8bd89393c1c90d2e25f4a16f647f71fae2c0d2451748a0c5c78a0ee9c6a',6,1,'MyApp','[]',0,'2020-02-25 11:26:19','2020-02-25 11:26:19','2021-02-25 11:26:19'),('c727913b253286646590646017cd750ad3dbfb858b3ba3c56181024d712ddcec9af2e5437299bb75',46,3,'MyApp','[]',0,'2020-03-02 13:30:05','2020-03-02 13:30:05','2021-03-02 13:30:05'),('c8edb73157fdb638e8f39b7c20a3943e0fbe768c3483011006403fa993236ebc3353f23ad56c4066',8,1,'MyApp','[]',0,'2020-02-26 09:18:38','2020-02-26 09:18:38','2021-02-26 09:18:38'),('c9893bc2d3cc71c1e9d6da17502fa5a2b5aa407bcc5d71405c38dee47c9f6e877afb16f3c977eef4',8,1,'MyApp','[]',0,'2020-02-23 11:47:41','2020-02-23 11:47:41','2021-02-23 11:47:41'),('cbd4b6d38a29e0bc36d393168b37c45ccfdfc68ac438010696180ca4a48e36b1d56f3f5ee4966564',8,1,'MyApp','[]',0,'2020-02-23 11:45:44','2020-02-23 11:45:44','2021-02-23 11:45:44'),('ce901cd5b504d448bac8ae7df634bf7074f8ec672fd8df50b56ff2815f0b5ef5b918a8dcf15282f4',45,3,'MyApp','[]',0,'2020-03-02 11:16:33','2020-03-02 11:16:33','2021-03-02 11:16:33'),('d098ac349986ee5d3af4d287e8e8df3c3655a30f18d09ec46710d2c8101e47c70f963f6dbb70f19d',7,1,'MyApp','[]',0,'2020-02-26 06:03:58','2020-02-26 06:03:58','2021-02-26 06:03:58'),('d0ecdac28d603a42ed44a5e5f6f0674d1344482fe6a0e8f280b3531f023382e9f9db585385b15b86',57,3,'MyApp','[]',0,'2020-03-05 09:32:42','2020-03-05 09:32:42','2021-03-05 09:32:42'),('d13e3676f2f64ff398621095cdc3a6492eb0d1f1b71ecdbc97a35ef23c7ff37ced243820d44eafd3',41,3,'MyApp','[]',0,'2020-03-04 13:32:27','2020-03-04 13:32:27','2021-03-04 13:32:27'),('d1a17eea4d7768701add2b6aef8005c28aafafbcd2d32859ccf699f39a9b2d7350f6fe1bd7f0d593',46,3,'MyApp','[]',0,'2020-03-02 13:40:23','2020-03-02 13:40:23','2021-03-02 13:40:23'),('d364ca442a46552c047a4f4e6337615e97b5ea885d29676647a92ba930dff4c0d29cc126772a892d',7,1,'MyApp','[]',0,'2020-02-23 09:16:02','2020-02-23 09:16:02','2021-02-23 09:16:02'),('d3dcde690fdc2dc8f27db32b9b167e5199ab3989b5bf11a56e0a8e7d0346b615ebad81f68edee34c',8,1,'MyApp','[]',0,'2020-02-25 19:50:41','2020-02-25 19:50:41','2021-02-25 19:50:41'),('d457e4348608f21790662b10ab46eec72b299204db804a2b6386593263b5504a4be445a293c2190e',45,3,'MyApp','[]',1,'2020-03-02 11:05:29','2020-03-02 11:05:29','2021-03-02 11:05:29'),('d5587972afa6e9e1bbac9429df62b7eef2d3988949db3cac49a5c2518a460be8bbb069d2b764b9a0',38,3,'MyApp','[]',0,'2020-03-01 09:39:57','2020-03-01 09:39:57','2021-03-01 09:39:57'),('d5def393549d9a947cfd78ded5df58410680658173215b5320d16078a51843de77c2082f637c873a',37,1,'MyApp','[]',0,'2020-02-26 15:47:55','2020-02-26 15:47:55','2021-02-26 15:47:55'),('d67429a699da3f7b7554ca5361fffb8bf0ed60d4cc1ccbb18324c5fc812040ae92efab3d439e684b',8,3,'MyApp','[]',1,'2020-02-29 11:03:43','2020-02-29 11:03:43','2021-03-01 16:33:43'),('d6f4d707101ea4f3ef30d522cfee8f49f44e9c5eace9f1dae3b1a0510b03eaa9b19aa1d9ae1efafa',61,3,'MyApp','[]',0,'2020-03-05 17:44:55','2020-03-05 17:44:55','2021-03-05 17:44:55'),('d7763fcf6924527a62de922ea56369d490bef9b6d186314f76f4d0bb4520598380708ca7481a176f',8,1,'MyApp','[]',0,'2020-02-26 05:25:06','2020-02-26 05:25:06','2021-02-26 05:25:06'),('d91b0420ec2c4c8a768808a66d04e9deeb769907e54009462023032821f65228b9c8f263e0e48fb6',8,1,'MyApp','[]',0,'2020-02-24 07:54:48','2020-02-24 07:54:48','2021-02-24 07:54:48'),('d98baf427e960ec028f770690d11b983ac2ceca20c18813d65897aef20090a41588ad6fc2389ef74',1,1,'MyApp','[]',0,'2020-02-21 00:58:01','2020-02-21 00:58:01','2021-02-21 06:28:01'),('db3d0fc3b53abfe34cba53be3d1b2311745546f29557c38327cd2fbba814cfcff7ba398c06f95e9f',45,3,'MyApp','[]',0,'2020-03-02 09:33:15','2020-03-02 09:33:15','2021-03-02 09:33:15'),('db44ff2d465ce2ff96cc9a47cd323a8e6a6222bcfbe358a57ca5dca9f5630c3c5e6e8d067b3d2247',26,1,'MyApp','[]',0,'2020-02-23 15:24:28','2020-02-23 15:24:28','2021-02-23 15:24:28'),('dc4e2b55fd7ff935e3f3f8fe5ef44d6c03dfc12ea16da3a08fb4eb395f9ba4b2cc5c743e588367e5',59,3,'MyApp','[]',0,'2020-03-06 06:41:48','2020-03-06 06:41:48','2021-03-06 06:41:48'),('dc8f3ce464c886e2ff3011c4f641f6d6b9b10df90f8d2eba7037b73b53ed531d7c551d821ae4eeb5',8,1,'MyApp','[]',0,'2020-02-23 11:46:39','2020-02-23 11:46:39','2021-02-23 11:46:39'),('dccd074e4beb9b9fb6df54587047ab7c80a0e1bdd607d33755ce9c4dfd8990bf745d79caccc7cf4b',41,3,'MyApp','[]',0,'2020-03-04 17:55:42','2020-03-04 17:55:42','2021-03-04 17:55:42'),('dde8cc7ef08ab840e7f74567d653aa83d13f44168626e81c8d1c636a78524bb3fbdc6e030870b0e3',40,3,'MyApp','[]',0,'2020-03-01 09:34:33','2020-03-01 09:34:33','2021-03-01 09:34:33'),('de97e32b376b1060ef32f99610f737c0099eb704cbfc8720f0c0440bfacdd5f6832a8b2a20963fd0',41,3,'MyApp','[]',0,'2020-03-04 07:20:09','2020-03-04 07:20:09','2021-03-04 07:20:09'),('dedef3d0764209ac32c02cdffde4cee0c64dd148670be7656e1efd280df6894c8d3dd96095e56cd1',7,3,'MyApp','[]',0,'2020-03-01 10:09:58','2020-03-01 10:09:58','2021-03-01 10:09:58'),('e089392f552fae717a2b644b934e36fdd7020f696281a67f678bfb207086fe62457833b197a3a0a2',41,3,'MyApp','[]',0,'2020-03-03 04:00:03','2020-03-03 04:00:03','2021-03-03 04:00:03'),('e0a5858f9ee93d5de25e516805c314395270c95e7ee9406815e2f5dddec2abfa375dd67569932cb0',40,3,'MyApp','[]',0,'2020-03-02 06:25:02','2020-03-02 06:25:02','2021-03-02 06:25:02'),('e11f26f367614f25356dcbe21e2b07d22a84f1ce5c44c0db9a925413247fe57303f768023662f4fa',7,1,'MyApp','[]',0,'2020-02-23 07:56:04','2020-02-23 07:56:04','2021-02-23 07:56:04'),('e151fc63ce77be96092d41d1c97359b905eeb1941006e57a8579497ca7e7f5432b02902c46ee065f',41,3,'MyApp','[]',0,'2020-03-01 12:06:37','2020-03-01 12:06:37','2021-03-01 12:06:37'),('e192ee970c33d6e2626855f8a97540c540cd8e81e52fedb92aa440e2289472433649ad8541029364',7,1,'MyApp','[]',0,'2020-02-25 18:01:05','2020-02-25 18:01:05','2021-02-25 18:01:05'),('e198b8793f285c1d35d59f229261f1d3ec48291b96bbe13c0a9813eec729c87a9664befdc1ae5620',41,3,'MyApp','[]',0,'2020-03-05 17:01:10','2020-03-05 17:01:10','2021-03-05 17:01:10'),('e2baa882992fdc73547ff216528e76475464540612b1f5d8c6421648e9ee1cf5c7fa4d50066aca64',18,1,'MyApp','[]',0,'2020-02-23 14:43:42','2020-02-23 14:43:42','2021-02-23 14:43:42'),('e541d270f4829ab9f77f12f9c288e5e2409e32c0ee348f170aa4ff01f3b40b1cf264f748c85ad769',47,3,'MyApp','[]',0,'2020-03-02 13:43:01','2020-03-02 13:43:01','2021-03-02 13:43:01'),('e631737911cc4782e6ab95dc2cf22a90ba084cb71d4ad207347c391bcedc43b6bcf7b99bd2d24722',7,1,'MyApp','[]',0,'2020-02-26 16:53:25','2020-02-26 16:53:25','2021-02-26 16:53:25'),('e70c6d1c8f29c39229af4eda7e2e9f46dfbbeec1686f3762d8dbe1928c94cf83e1607a5a08f5243b',60,3,'MyApp','[]',0,'2020-03-05 17:43:34','2020-03-05 17:43:34','2021-03-05 17:43:34'),('e7430dd7b7738509cb319aba40048e11509c21d358019e041d45543291af3f7d155957d87276b8a8',17,1,'MyApp','[]',0,'2020-02-23 14:41:46','2020-02-23 14:41:46','2021-02-23 14:41:46'),('e7fc8696a29f9ff1f1ae2eaec3c72c93ddc2b34c575102f39dba44f90392a703bc265b630e1e4341',48,3,'MyApp','[]',0,'2020-03-02 16:28:51','2020-03-02 16:28:51','2021-03-02 16:28:51'),('e83cbf8c2c78fe40fd2d0c8ac883c3c5ad86c41ae3e210739b634f0d113793930e20a3941dbaf5f7',8,3,'MyApp','[]',0,'2020-02-29 00:35:58','2020-02-29 00:35:58','2021-03-01 06:05:58'),('e8ac2f463b2340ee4a437885d80f22bbbf19709eca954f247790d3f10684aa1e3d933f6ae5036cf1',38,3,'MyApp','[]',0,'2020-03-01 07:36:44','2020-03-01 07:36:44','2021-03-01 07:36:44'),('e8dbf86cf50165d8efced939c9a8f14f6ee4b44223e4bfb39e7d8cc109427543d82d1b23c6379f23',34,3,'MyApp','[]',0,'2020-03-01 14:56:15','2020-03-01 14:56:15','2021-03-01 14:56:15'),('e9933eb0ab6803ad7cf800616c4c2c014c80f0833223f0adb405482f70eca5c97ecf4f338e44f4b5',52,3,'MyApp','[]',0,'2020-03-03 16:58:43','2020-03-03 16:58:43','2021-03-03 16:58:43'),('ea07c360055a6ed43b6b3d34096c1ffeacb7527d1463efdbfe9a3e4252b334eb669b74384cf0c5b3',11,1,'MyApp','[]',0,'2020-02-23 08:23:54','2020-02-23 08:23:54','2021-02-23 08:23:54'),('eabe1727a9f1da061ce55ec638b7c7c7b71d5666194d57e07397198177301fed9b7063f5c5f906a3',28,1,'MyApp','[]',0,'2020-02-25 06:56:31','2020-02-25 06:56:31','2021-02-25 06:56:31'),('ec7b80d19fee2f1240adfeba9806c3b7247d46068f627f5f20fdd5924ca43aefc0dd12338b60588b',7,1,'MyApp','[]',0,'2020-02-26 06:01:45','2020-02-26 06:01:45','2021-02-26 06:01:45'),('ecc022a1d361c960579f9de6125ef2b939a040f0981374a1e563d5c6282c80e1346458a72b701965',39,3,'MyApp','[]',0,'2020-03-02 13:11:25','2020-03-02 13:11:25','2021-03-02 13:11:25'),('ee96888ad1f31a6255d9833646a63944bd86ce6a05d08ca15c4881cd56f62d78eb445b6266858b84',40,3,'MyApp','[]',0,'2020-03-02 09:12:03','2020-03-02 09:12:03','2021-03-02 09:12:03'),('ef4807fd222e5ab32a4046b76ed6a630db5a466d12e2b80b5708b73034a323dba3eb611b700616b5',46,3,'MyApp','[]',0,'2020-03-02 13:30:26','2020-03-02 13:30:26','2021-03-02 13:30:26'),('f09f9ce9e2185128c8923c85801953de96e75d9a28d00e6783a496b2de154c3f65fbc9dfcf4f4909',38,3,'MyApp','[]',0,'2020-03-01 14:41:19','2020-03-01 14:41:19','2021-03-01 14:41:19'),('f16aa55a94ee70f2b4b86679717755615da660e7ef0ef7e02fb62a756fadf7dc3c1b85a53f31decc',41,3,'MyApp','[]',0,'2020-03-05 17:01:08','2020-03-05 17:01:08','2021-03-05 17:01:08'),('f1ce415eab613d4b76ed2edf2500839e165b7404ad932172c5f0bd090fcbc5cb27bdd8d1fa34e5e1',39,3,'MyApp','[]',0,'2020-03-01 08:08:56','2020-03-01 08:08:56','2021-03-01 08:08:56'),('f20736b0a36afd693b35b2dde9d2cf65b959dd69cfa1d84fc9772c809950f4eda8147c24bdc1655f',62,3,'MyApp','[]',0,'2020-03-06 04:41:00','2020-03-06 04:41:00','2021-03-06 04:41:00'),('f27682cb0d45b8ab39d0caf203c5a47cf992ba3dc70dfa7e6410c3548fd21bfcb56abad43780fef8',15,1,'MyApp','[]',0,'2020-02-23 08:46:40','2020-02-23 08:46:40','2021-02-23 08:46:40'),('f347f9f6b173e9ae6e4b5d1d4c89b550d648c0c78a40f74c754a4aed3323e22fec7043cdf421de91',53,3,'MyApp','[]',0,'2020-03-03 15:04:55','2020-03-03 15:04:55','2021-03-03 15:04:55'),('f3d4c567ab3f7e3e650c30824fbea35398cdce5bfc42f5fb658565740d54a22a8a61f81da93f5d45',37,1,'MyApp','[]',0,'2020-02-26 16:11:21','2020-02-26 16:11:21','2021-02-26 16:11:21'),('f70ab6e42a8e79f1371330c72ca9bc441f42f9aca1ea633478471e2157b9ca9957fdf418f9bd5fc1',41,3,'MyApp','[]',0,'2020-03-01 12:07:23','2020-03-01 12:07:23','2021-03-01 12:07:23'),('f742fc688ce9abda07fc9a7b4d4c40d8fd99930424afb8abc4fb493dd9609d62520889e712a9bf6c',37,1,'MyApp','[]',0,'2020-02-26 16:05:20','2020-02-26 16:05:20','2021-02-26 16:05:20'),('f79eb110c8b5042d8b31972124dd8c07fc9f0b65e398a0d6da8df377ff360fabf56238e99307525b',41,3,'MyApp','[]',0,'2020-03-02 11:56:34','2020-03-02 11:56:34','2021-03-02 11:56:34'),('f7f0ff2374a491188883d07e7055db556a4cea112943f7d680731434f096f1d56e766df1dae2eb1d',40,3,'MyApp','[]',0,'2020-03-01 11:56:50','2020-03-01 11:56:50','2021-03-01 11:56:50'),('f88b93dc7bcf865b017280f59f028b4031c376fdc8b518856cde35285361564dd8d2d0efae4e6d39',6,1,'MyApp','[]',0,'2020-02-22 21:22:31','2020-02-22 21:22:31','2021-02-22 21:22:31'),('f96602b88d26d05e0e3f9cf8228db030af084b81e449097e9715d965d8399e477bef077b876924f3',8,1,'MyApp','[]',0,'2020-02-26 16:36:03','2020-02-26 16:36:03','2021-02-26 16:36:03'),('f9aaea83d2907736e8e139bdb7b94afe11c0ca555b0d89bec11aa8054a80f9f57b52baebecfa469e',46,3,'MyApp','[]',0,'2020-03-05 07:49:25','2020-03-05 07:49:25','2021-03-05 07:49:25'),('fa88b1eec23e35da9369c2505ff5de290abe9648a4c4217934bcdf859d6cbc873761620813248c25',15,1,'MyApp','[]',0,'2020-02-23 08:54:03','2020-02-23 08:54:03','2021-02-23 08:54:03'),('facd2014df72b6ced3dad9e7e69cdaebe410193c3ddb7b478fb594ca41c9cadc34d07a13436ccfbf',33,3,'MyApp','[]',0,'2020-03-01 09:38:27','2020-03-01 09:38:27','2021-03-01 09:38:27'),('fae9c7196d54d9efc1d8d30c7fdbbca13012ef76564a22f1177b1e31ad5f094ef41402d128bf8ba7',9,1,'MyApp','[]',0,'2020-02-23 07:53:06','2020-02-23 07:53:06','2021-02-23 07:53:06'),('fc3df4c13acc543465c0579ace4c100acbee8230aa21393b25009887a9e1b004879c2e9077d485b4',46,3,'MyApp','[]',0,'2020-03-02 12:59:47','2020-03-02 12:59:47','2021-03-02 12:59:47'),('fcd3e9a9e16b1227143056ead5d9221463e14eeb7b98ca8b3894568b41305291690f434ff6ab5ad7',1,1,'MyApp','[]',0,'2020-02-21 00:36:00','2020-02-21 00:36:00','2021-02-21 06:06:00'),('fe61b3999e0555b99712d62dd61d11ce42d8bd6f25fafe87426a492f7c4a4d7fbbb478130d93af3a',7,1,'MyApp','[]',0,'2020-02-23 10:36:48','2020-02-23 10:36:48','2021-02-23 10:36:48'),('ff55ac887534f7ed020cbbd68f909113fbf6e9fb948cf9d0c4f3d9872014f545207b8bc11e2d6b24',8,1,'MyApp','[]',0,'2020-02-23 14:46:13','2020-02-23 14:46:13','2021-02-23 14:46:13'),('ffa51f28440811fd8a06379b39ab59e14783428553ce10dc8cb02a9aef79738468480696b3ff2872',8,1,'MyApp','[]',0,'2020-02-26 16:51:00','2020-02-26 16:51:00','2021-02-26 16:51:00');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','LHGp3xWeWJD7lUyyVHHhqczv3Gi2gF7Lomoh2DsO','http://localhost',1,0,0,'2020-02-21 00:23:39','2020-02-21 00:23:39'),(2,NULL,'Laravel Password Grant Client','USlyUTZnMGvBGicUr2mipZP1H8n4h1FHg6v1dohM','http://localhost',0,1,0,'2020-02-21 00:23:39','2020-02-21 00:23:39'),(3,NULL,'Laravel Personal Access Client','2OALjy2I3bOPKGWLZ35sLpeQ5evm1wg3YbMsd7UG','http://localhost',1,0,0,'2020-02-29 00:27:15','2020-02-29 00:27:15'),(4,NULL,'Laravel Password Grant Client','3u8XyXsSfvc7HqMLkyEsDJlK1YvTIvV5oW8NYPPt','http://localhost',0,1,0,'2020-02-29 00:27:15','2020-02-29 00:27:15');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2020-02-21 00:23:39','2020-02-21 00:23:39'),(2,3,'2020-02-29 00:27:15','2020-02-29 00:27:15');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_plan`
--

DROP TABLE IF EXISTS `payment_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `amount` varchar(100) NOT NULL,
  `duration` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_plan`
--

LOCK TABLES `payment_plan` WRITE;
/*!40000 ALTER TABLE `payment_plan` DISABLE KEYS */;
INSERT INTO `payment_plan` VALUES (1,'BASIC','750','6 months'),(2,'GOLD PLAN','700','6 months'),(3,'PLATINUM PLAN','1000','6 months');
/*!40000 ALTER TABLE `payment_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_images`
--

DROP TABLE IF EXISTS `school_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) DEFAULT NULL,
  `schoolprofile_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_images`
--

LOCK TABLES `school_images` WRITE;
/*!40000 ALTER TABLE `school_images` DISABLE KEYS */;
INSERT INTO `school_images` VALUES (1,'1582993546.png',1,'other1'),(2,'1583135968.png',18,'other1'),(3,'1583136573.jpg',41,'other1'),(4,'1583144636.PNG',17,'other1'),(5,'1583260104.jpg',18,'other2'),(6,'1583260317.jpg',18,'other3'),(7,'1583338305.jpg',18,'other4'),(8,'1583429212.jpg',41,'other2'),(9,'1583430444.jpg',20,'other1'),(10,'1583431114.jpg',20,'other4');
/*!40000 ALTER TABLE `school_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schoolprofile`
--

DROP TABLE IF EXISTS `schoolprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schoolprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `about` text,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `admission` varchar(255) DEFAULT NULL,
  `add_line1` varchar(500) NOT NULL,
  `add_line2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `area_code` varchar(255) DEFAULT NULL,
  `created_date` varchar(255) DEFAULT NULL,
  `updated_date` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `scholarship` text,
  `fee_structure` text,
  `course_detail` text,
  `rating` int(11) DEFAULT '0',
  `popularity` int(11) DEFAULT '0',
  `admission_status` varchar(225) DEFAULT NULL,
  `school_location_url` text NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `banner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schoolprofile`
--

LOCK TABLES `schoolprofile` WRITE;
/*!40000 ALTER TABLE `schoolprofile` DISABLE KEYS */;
INSERT INTO `schoolprofile` VALUES (1,'pradip','fdafafasfaf','pradip.comat@appypiellp.com','6563636363',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,0,NULL,'','1582992840.png',NULL),(2,'DPS','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','pradipdsaff.comat@appypiellp.com','6563636363',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:',0,0,NULL,'',NULL,NULL),(3,'DPS','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','pradipdsaff.comat@appypiellp.com','6563636363',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:',4,0,NULL,'',NULL,NULL),(4,'DPS','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','pradipdsaff.comat@appypiellp.com','6563636363',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:',4,0,NULL,'',NULL,NULL),(5,'DPS','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','pradipdsaff.comat@appypiellp.com','54674747474',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:',4,0,NULL,'',NULL,NULL),(6,'DPS','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','pradipdsaff.comat@appypiellp.com','54674747474',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:',4,0,NULL,'',NULL,NULL),(7,'DPSdfafafasfs','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','pradipdsaff.comat@appypiellp.com','54674747474',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:','In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:',4,0,NULL,'',NULL,NULL),(8,'qwerty','sdfg','undefined','09876543',NULL,'undefined',NULL,NULL,NULL,NULL,NULL,NULL,NULL,8,'undefined','dsa','undefined',4,0,NULL,'',NULL,NULL),(9,'akash','Scool','akash@mail.com','9876543210',NULL,'\"\"',NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,'No scholarship','2000\n20000\n500\n22500','English,Hindi\nEnglish,Maths,Hindi,Science,SST\nEnglish,Maths,Hindi,Science,SST\nHistory,Economics,Political Science\nPhysics\nAccounts\nEnter subjects',4,0,NULL,'',NULL,NULL),(10,'Qwerty','\"a\"','aa@mail.com','\"a\"',NULL,'\"a\"',NULL,NULL,NULL,NULL,NULL,NULL,NULL,17,'\"a\"','\"a\"','\"a\"',0,0,NULL,'',NULL,NULL),(11,'Q','\"a\"','qqw@mail.com','\"a\"',NULL,'\"a\"',NULL,NULL,NULL,NULL,NULL,NULL,NULL,19,'\"a\"','\"a\"','\"a\"',0,0,NULL,'',NULL,NULL),(12,'Quy','\"\"','qqepw@mail.com','\"\"',NULL,'\"\"',NULL,NULL,NULL,NULL,NULL,NULL,NULL,21,'\"\"','\"\"','\"\"',0,0,NULL,'',NULL,NULL),(13,'Pk','Add a brief description about your school','pk@mail.com','911234567890',NULL,'Delhi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,23,'Add any scholarship offer (if available)','Add your school fee description','Add the list of courses that your school provides',0,0,NULL,'',NULL,NULL),(14,'Pkp','Add a brief description about your school','pkp@mail.com','911234567890',NULL,'Delhi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,24,'Add any scholarship offer (if available)','Add your school fee description','Add the list of courses that your school provides',0,0,NULL,'',NULL,NULL),(15,'Angels','Add a brief description about your school','angel@mail.com','911234567890',NULL,'Delhi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,25,'Add any scholarship offer (if available)','Add your school fee description','Add the list of courses that your school provides',4,0,NULL,'',NULL,NULL),(16,'Test','Add a brief description about your school dndnd','test@gmail.com','911234567890',NULL,'Delhi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,26,'Add any scholarship offer (if available)','Add your school fee description bxbdn','Add the list of courses that your school provides',4,0,NULL,'',NULL,NULL),(17,'Test school naveen','Some desc about the school','testschool@gmail.com','9540150666',NULL,'Noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,38,'No','na','na',5,0,NULL,'','1583314903.jpg',NULL),(18,'Qw','Add a brief description about your school','testschool@gmail.com','911234567890',NULL,'Delhi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,41,'Add any scholarship offer (if available)','Add your school fee description','Add the list of courses that your school provides',4,0,NULL,'','1583489819.jpg','1583338337.jpg'),(19,'akash school','undefined','akashm@mail.com','heyyy',NULL,'noida',NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'scholarship','yess','courses',3,0,NULL,'',NULL,NULL),(20,'Yess','Add a brief description about your school','testschool3@gmail.com','911234567890',NULL,'Delhi',NULL,NULL,NULL,NULL,NULL,NULL,NULL,61,'Add any scholarship offer (if available)','Add your school fee description','Add the list of courses that your school provides',4,0,NULL,'','1583430420.jpg',NULL);
/*!40000 ALTER TABLE `schoolprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentprofile`
--

DROP TABLE IF EXISTS `studentprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) NOT NULL,
  `profile_name` varchar(250) NOT NULL DEFAULT '',
  `mobile` varchar(100) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `admission` varchar(255) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentprofile`
--

LOCK TABLES `studentprofile` WRITE;
/*!40000 ALTER TABLE `studentprofile` DISABLE KEYS */;
INSERT INTO `studentprofile` VALUES (1,'9540150666','','','','pending','2020-02-26 00:00:00.000000','2020-02-26 00:00:00.000000',1),(2,'9876543210','','','','pending','2020-02-26 00:00:00.000000','2020-02-26 00:00:00.000000',37),(3,'0','','','','pending','2020-02-26 00:00:00.000000','2020-02-26 00:00:00.000000',7),(4,'0','','','','pending','2020-02-26 00:00:00.000000','2020-02-26 00:00:00.000000',8),(5,'9540150666','','','','pending','2020-03-01 00:00:00.000000','2020-03-01 00:00:00.000000',2),(6,'9540150666','','','','pending','2020-03-01 00:00:00.000000','2020-03-01 00:00:00.000000',3),(7,'9540150666','','','','pending','2020-03-01 00:00:00.000000','2020-03-01 00:00:00.000000',4),(8,'9540150666','','','','pending','2020-03-01 00:00:00.000000','2020-03-01 00:00:00.000000',5),(9,'9540150666','','','','pending','2020-03-01 00:00:00.000000','2020-03-01 00:00:00.000000',17),(10,'9540150666','','','','pending','2020-03-01 00:00:00.000000','2020-03-01 00:00:00.000000',18);
/*!40000 ALTER TABLE `studentprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentprofile_saved_school`
--

DROP TABLE IF EXISTS `studentprofile_saved_school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentprofile_saved_school` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentprofile_id` int(11) NOT NULL,
  `schoolprofile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentprofile_saved_school`
--

LOCK TABLES `studentprofile_saved_school` WRITE;
/*!40000 ALTER TABLE `studentprofile_saved_school` DISABLE KEYS */;
INSERT INTO `studentprofile_saved_school` VALUES (1,5,7);
/*!40000 ALTER TABLE `studentprofile_saved_school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_profile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_block` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=>No,1=>Yes',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=>No,1=>Yes',
  `is_verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=>No,1=>Yes',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Rahul','pradip.comat@appypiellp.com',NULL,'$2y$10$wOYQQxQ//ggjXKhJa.WCre6QCh.NE7.4wm3xpM79sAubODm3b9rrq',NULL,'2020-02-21 00:58:01','2020-02-21 00:58:01','student','',1,0,0),(5,'Rahul','pradip@appypiellp.com',NULL,'$2y$10$V.jxzDTL6ARNLdlOz8bMK.Ghde7CdhFekc7NHkA4OUUUVeRSF6JQO',NULL,'2020-02-22 11:11:32','2020-02-22 11:11:32','student','',1,0,0),(6,'Rahul','test@test.com',NULL,'$2y$10$28zdX8tbhygSqO2Va6rG.ePTbptIt1LDGpDlwgDYeF1XUbveRxHZW',NULL,'2020-02-22 21:20:44','2020-02-22 21:20:44','student','',0,0,0),(7,'akash','akkusingh0208@gmail.com',NULL,'$2y$10$aQAwCsLZJFV9hZDO32NZ2.lL1kfhwBbHZmv.6ABZ9Eu0igCuM3Av2',NULL,'2020-02-23 06:48:10','2020-03-02 09:04:00','student','',0,0,0),(8,'akash','akash@mail.com',NULL,'$2y$10$Q5CX6YyUUk86DtdUehEQOOvQRogvMVdJ054oKI/buQ4896S3JazY2',NULL,'2020-02-23 07:39:29','2020-03-02 09:10:44','school','',0,1,1),(9,'MD TARVEZ','ansaritarvez@gmail.com',NULL,'$2y$10$P3fKftunhs5y/mRosbybIutzdfAtIkeBQLeFUhDQifjUG6Yiqgcv6',NULL,'2020-02-23 07:53:06','2020-02-23 07:53:06','school','',0,0,0),(10,'MD TARVEZ','ansaritarvez1991@gmail.com',NULL,'$2y$10$9.rT9SGV4kq/gU9J9f1YIOTuLrUEOXdMVu6sNEkg87p7gm7uV9NGu',NULL,'2020-02-23 08:20:01','2020-02-23 08:20:01','school','',0,0,0),(11,'MD TARVEZ','ansaritarvez123@gmail.com',NULL,'$2y$10$yqJmxkFbi1I0llTZkUEppeNtVmGXZvFgOLi73VJh50VefTL/c3wWW',NULL,'2020-02-23 08:23:54','2020-02-23 08:23:54','school','',0,0,0),(12,'MD TARVEZ','ansaritarve2z@gmail.com',NULL,'$2y$10$Kwk79aUnt892aI7i30PfXuNJA2nF.uFeznZ/cwt8y4Wb5DQfXBp4y',NULL,'2020-02-23 08:26:36','2020-02-23 08:26:36','school','',0,0,0),(13,'MD TARVEZ','testing@gmail.com',NULL,'$2y$10$5WRFm9RaYGi01IRrDwEWfuAKLaABCqeNJTF45a0RZhMjvgLFDa68m',NULL,'2020-02-23 08:41:02','2020-02-23 08:41:02','school','',0,0,0),(14,'MD TARVEZ','testing123@gmail.com',NULL,'$2y$10$RKXG36FToW.9ViadzJQAiu6OMVS4RRiUZZwZfoZsCqLgrRKr8YO3y',NULL,'2020-02-23 08:44:00','2020-02-23 08:44:00','school','',0,0,0),(15,'MD TARVEZ','admin@gmail.com',NULL,'$2y$10$wW31V14F96uJfjCdXMs8c.zcVQK6Lesr.rFmOnGoZw8OvJTtArJUm',NULL,'2020-02-23 08:46:40','2020-02-23 08:46:40','school','',0,0,0),(16,'akash','ash@mail.com',NULL,'$2y$10$AWI5AyjJV5BQXZnU8lz/2.41zmt3fZ4.WhlHagZ7WXqDIQVaepdDe',NULL,'2020-02-23 14:39:33','2020-02-23 14:39:33','school','',0,0,0),(17,'Qwerty','aa@mail.com',NULL,'$2y$10$vHWJZhuus1FFZKHTU0gJHeJgmMcHzWnRPnDviFCmS7Ua61ZZf1tPO',NULL,'2020-02-23 14:41:46','2020-02-23 14:41:46','school','1583306906.jpg',0,0,1),(18,'Q','qq@mail.com',NULL,'$2y$10$6VcWm.dZdS27bvNeeEFwaOWuKq7vSdfUCS/r8R8Ej4eWk3FfKj/3a',NULL,'2020-02-23 14:43:42','2020-02-23 14:43:42','school','1583338570.jpg',0,0,0),(19,'Q','qqw@mail.com',NULL,'$2y$10$apUYfjn0DH8rKGv3geiiHOAdAiWPMtTJRbwqjhp8GVXp/fDY7.Eoa',NULL,'2020-02-23 14:44:44','2020-02-23 14:44:44','school','',0,0,1),(20,'Q','qqew@mail.com',NULL,'$2y$10$VH0uUmFe8Afrv/Bt0n7fuuedwgf6uSqWciVeFnf8S7Ji4mE8Co07.',NULL,'2020-02-23 14:45:20','2020-02-23 14:45:20','school','',0,0,0),(21,'Quy','qqepw@mail.com',NULL,'$2y$10$11q9JCH3oiYGQTMiJ1UoWeekgu7znCQzXgQGDND47OqXsYhyTcram',NULL,'2020-02-23 14:45:33','2020-02-23 14:45:33','school','',0,0,0),(22,'Pun','pun@mail.com',NULL,'$2y$10$/wkh.6QuJTFGkZ89oxkKteDq0QCeqAAmtamMuNWD/Jp2dsbEzA.Eu',NULL,'2020-02-23 15:00:34','2020-02-23 15:00:34','school','',0,0,0),(23,'Pk','pk@mail.com',NULL,'$2y$10$IBBz8TCHhu8YNYmRW./gluMLCzxOG3wsTe0JlsxmMEYsThePrBLOO',NULL,'2020-02-23 15:02:46','2020-02-23 15:02:46','school','',0,0,1),(24,'Pkp','pkp@mail.com',NULL,'$2y$10$sWCylX.al99uWBi1x5j5S.EXBPyKDUe3p6/M47n.hCH5zY0PxSc0O',NULL,'2020-02-23 15:03:15','2020-02-23 15:03:15','school','',0,0,0),(25,'Angels','angel@mail.com',NULL,'$2y$10$dX8CzFFUIROhbmr.eQX6M.qbs/yYkWsygc4i.veLJx4bSujJWv1dq',NULL,'2020-02-23 15:14:46','2020-02-23 15:14:46','school','',0,0,0),(26,'Test','test@gmail.com',NULL,'$2y$10$QXwUCL9K610u0ra5D1j4jO24h3IRXB7OIkbVnJLIEuwg/6WlH.JqW',NULL,'2020-02-23 15:24:28','2020-02-23 15:24:28','school','',0,0,0),(27,'rahul','rahul@mail.com',NULL,'$2y$10$JII67R1/DhCfZS8gALZjH.6oNeqEYmXw4/OErMfRlEdPCaVM4Dl6W',NULL,'2020-02-25 05:54:40','2020-02-25 05:54:40','school','',0,0,0),(28,'qq','qqwq@mail.com',NULL,'$2y$10$3JOqJqcwkpdoo2pOH5tw0.IDIkjtJNIPDH.nqdWUsxk5wDvpuDKkq',NULL,'2020-02-25 06:56:31','2020-02-25 06:56:31','school','',0,0,0),(29,'qq','qqqq@gmailc.om',NULL,'$2y$10$1/f31qEK5cNNDvu/2z2vu.2ODfup9goYlwBpCXDnvFJoLww9V0RNO',NULL,'2020-02-25 06:58:05','2020-02-25 06:58:05','school','',0,0,0),(30,'qwe','qwe@g.com',NULL,'$2y$10$N1F3GrLLo7.1VaKENYe3KO3clrZqOE4Cb3L61u6OvGTQTDLeO9nc2',NULL,'2020-02-25 07:00:21','2020-02-25 07:00:21','school','',0,0,0),(31,'qwerty','qwerty@qwe.com',NULL,'$2y$10$n16kQGhj4waqILoCjfy7fuUdxV5NNrI7qbktLcBMp4iPym9zo6GGK',NULL,'2020-02-25 07:02:31','2020-02-25 07:02:31','school','',0,0,0),(32,'qwerty','qwerty@qe.com',NULL,'$2y$10$syuua4k6Er0t9Sem.YqnVuzif9xSXqTj92aT4VrDFNIbuOdFxdGQy',NULL,'2020-02-25 07:07:27','2020-02-25 07:07:27','school','',0,0,0),(33,'akashqw','akasha@mail.com',NULL,'$2y$10$ZSf2r7AQSt4oH.jjxRhyyel3X.rQYPufXMbzUGmPMbFiYICvqKc1a',NULL,'2020-02-25 07:11:06','2020-03-01 15:35:30','student','',0,0,0),(34,'qwerty','qwerty@mail.com',NULL,'$2y$10$NJp6Ld67c1VLaHMBsjA8Ued2zuXp3DSL/jmOCJAf8X9e6mtT5Ue8W',NULL,'2020-02-25 07:11:36','2020-02-25 07:11:36','student','',0,0,0),(35,'Naveen Singh','na.singhall@gmail.com',NULL,'$2y$10$TtTTgCzWQ39j/i32m2ARQ.p6Y2hUBxXBAPU4Zh1YJKsVt1ggHzaom',NULL,'2020-02-26 02:01:05','2020-02-26 02:01:05','student','',0,0,0),(36,'ovais','ovais@mail.com',NULL,'$2y$10$HFfyiLqUuRAE/hTeolATHOcQ.Ao1zh7zSPV0w/4.8C0Bw/keT/1T6',NULL,'2020-02-26 04:15:12','2020-02-26 04:15:12','school','',0,0,0),(37,'ovais_student','ovaisstudent@mail.com',NULL,'$2y$10$1So4ApCz/eVWZGlIesIv4eLQ0GYR9FJOstII/VbSm4GwPUQI8Fp7O',NULL,'2020-02-26 04:34:26','2020-03-02 15:49:29','student','',0,0,0),(38,'Naveen Singh','naveen.singh@outlook.in',NULL,'$2y$10$D.Q6Gpx66TYjnydpZudn1ux2wZy.1GQP6D/xfHpuYB5PYdhQ0IRYy',NULL,'2020-03-01 01:43:25','2020-03-01 01:43:25','school',NULL,0,0,1),(39,'Naveen Singh','naveen.std@outlook.in',NULL,'$2y$10$jdZmOyV2JJZMu338sj8ZX.hjbYIh4nGrgTD2s0ThO9WH6v7oWGeRy',NULL,'2020-03-01 08:08:56','2020-03-01 08:08:56','student',NULL,0,0,0),(40,'akash','akashk@mail.com',NULL,'$2y$10$qV8LZxNG1O9EtzC2SXtDcOEmV/xo2WGP8GM2CsbkpcTzx4ffL7QZW',NULL,'2020-03-01 09:34:33','2020-03-01 09:34:33','school',NULL,0,0,0),(41,'Qwer','testschool@gmail.com',NULL,'$2y$10$EGSdxK/9/dGeVV1ZLUq9uudpvY8k2G6yPHnRi14ef0h56Oknnujjq',NULL,'2020-03-01 12:06:12','2020-03-01 12:06:12','school',NULL,0,1,1),(42,'SUN','sun.resolutionindia@gmail.com',NULL,'$2y$10$TENEo8XONS0.VzJGMlmQh.ldcQiPRSVOVdF7luKu2L5xXCY7C026G',NULL,'2020-03-01 18:53:40','2020-03-01 18:53:40','student',NULL,0,0,0),(43,'RESOLUTION','nehuu.g@gmail.com',NULL,'$2y$10$MInZuea0P/iFlf.FCx9AqubZGXJmb2.tXxRweTIYMsQKQzVcyn0KC',NULL,'2020-03-01 18:57:27','2020-03-01 18:57:27','school',NULL,0,0,0),(44,'Yes','yes@mail.com',NULL,'$2y$10$VzXVp4eU3IMy5Bhr4r6kmuBttuEiHMf9vUznZ466KpT9SV4httk/q',NULL,'2020-03-01 19:07:48','2020-03-01 19:07:48','student',NULL,0,0,0),(45,'Test','teststudent@gmail.com',NULL,'$2y$10$0Y1izzeb.BvuSKTNzJ2cNOv6eIDwsTPkv7o2ex8qUb0Bp1/dpfWgu',NULL,'2020-03-02 09:14:15','2020-03-02 11:07:51','student','1583385606.png',0,0,0),(46,'Admin','admin@admin.com',NULL,'$2y$10$UWD1iDu4lgtchMglqLWM0.ngYg6L2lj92vAIO9ITaa7ptA4nJgqTi',NULL,'2020-03-02 11:36:11','2020-03-02 11:36:11','student',NULL,0,0,0),(47,'Aditya Anshuli','adityaanshuli31@gmail.com',NULL,'$2y$10$xCqMizO47TmO6wdMGPFj9enuTjPCWC5LXF2hJcoB0O5IAg9FhLOVC',NULL,'2020-03-02 13:05:03','2020-03-02 13:05:03','student',NULL,0,0,0),(48,'Ovais','ovaiss@mail.com',NULL,'$2y$10$TRH620wziivG6VE0RjAGPueZc6OtRJHY6zVDqXZH0ZeWaa/GCrUZS',NULL,'2020-03-02 16:13:55','2020-03-02 16:28:51','student',NULL,0,0,0),(49,'ovau','ovaischool@mail.com',NULL,'$2y$10$KewOV4Xi4.KrFScnDIVQdOd.u3hN94We0TvR2WGudrjfdc1PsyG3y',NULL,'2020-03-02 18:33:49','2020-03-02 18:33:49','school',NULL,0,0,0),(50,'undefined','undefined',NULL,'$2y$10$6dHf6FzXFpwIkbd4rPKDkeF51N3btoD7ppUywOz96bskn8G4JwzGu',NULL,'2020-03-03 07:58:11','2020-03-03 07:58:11','school',NULL,0,0,0),(51,'akash school','akashm@mail.com',NULL,'$2y$10$Lgul7vuIWqIzEBFSp24zO.uh3DwXpbA8tlF43tusMzBGnxyzW.gJ2',NULL,'2020-03-03 08:04:46','2020-03-03 08:04:46','school',NULL,0,0,1),(52,'Rahul','rahulsingh@mail.com',NULL,'$2y$10$JW8KXK7KBbAFakHLQvPgl.T./h8lVD9dEdKaUt5x6WFdKxfVIcEw6',NULL,'2020-03-03 14:56:48','2020-03-03 14:56:48','student',NULL,0,0,0),(53,'rahul','rahulschool@mail.com',NULL,'$2y$10$5AB9JFww1ACCoOw6dEERcOmTh99Sq3flk9F1.GHAE9erTSgHxlabG',NULL,'2020-03-03 15:04:55','2020-03-03 15:04:55','school',NULL,0,0,0),(54,'dps','dpschool@mail.com',NULL,'$2y$10$iqhi.UGVRvYYDV5sOfhEi.eiDxGAzETGiUc3YKfeodF7TVezmp40O',NULL,'2020-03-03 16:59:45','2020-03-03 16:59:45','school',NULL,0,0,0),(55,'teststudent','teststudent@mail.com',NULL,'$2y$10$nJguPuguOUjKUd2nHOiqaeGIWZwC/DufJEPFK4zxsRAf2cpkBrLSS',NULL,'2020-03-04 16:56:52','2020-03-04 16:56:52','student','1583341465.jpg',0,0,0),(56,'Aditya Anshuli','adi@gmail.com',NULL,'$2y$10$OJXYu2PIoUjPsh3FcFx91.6.Bm9CPsSK1DyrKb60B38eDIJJSe/Te',NULL,'2020-03-05 09:30:02','2020-03-05 09:30:02','school',NULL,0,0,0),(57,'Aditya Anshuli','RAJU@gmail.com',NULL,'$2y$10$9yL2G4fCnmXbsiNCbC31xeB3n3qVpIyl7FKRj7ajWEGQtcuyR70vu',NULL,'2020-03-05 09:32:42','2020-03-05 09:32:42','student',NULL,0,0,0),(58,'ARVIND','arvind@gmail.com',NULL,'$2y$10$DVuGY3uC0JWkHXJOXCcxXuDNmTFjGruPZc.a4EnLEwwB2ez7w6JD6',NULL,'2020-03-05 09:52:39','2020-03-05 09:52:39','school',NULL,0,0,0),(59,'mi','mi@gmail.com',NULL,'$2y$10$XhZnqXsV7DdBKwSZJmM5CuNZ.Yy4.Oeh2Fr.Pbw6XfIHkoqMXA9qe',NULL,'2020-03-05 16:09:46','2020-03-05 16:09:46','student',NULL,0,0,0),(60,'Test','testschool2@gmail.com',NULL,'$2y$10$dYYsmvSq7ofttGX1P0E09OWzJV0Jqeg/nRCzmJBGVvKkolzYcgiTW',NULL,'2020-03-05 17:43:34','2020-03-05 17:43:34','school',NULL,0,0,0),(61,'Yess','testschool3@gmail.com',NULL,'$2y$10$D9nK0qLfL4qreTYc86AjJunruJ6PjQ.W1yfxUOT8i5kqgLLhGE0qa',NULL,'2020-03-05 17:44:55','2020-03-05 17:44:55','school',NULL,0,0,1),(62,'yop','yopm@mail.com',NULL,'$2y$10$CW9f53VljmkIiOKIhzyWv.I3o1xmqqUviC4z5LaYx3CWYvdF6FdKy',NULL,'2020-03-06 04:41:00','2020-03-06 04:41:00','student',NULL,0,0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-06 10:34:37
