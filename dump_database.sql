-- --------------------------------------------------------
-- Servidor:                     192.168.10.10
-- Versão do servidor:           5.7.27-0ubuntu0.18.04.1 - (Ubuntu)
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura para tabela selecaoPerfectpay.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identification_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identification_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela selecaoPerfectpay.customers: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`, `name`, `identification_type`, `identification_number`, `email`, `created_at`, `updated_at`) VALUES
	(1, 'Dr. Juvenal Daniel', 'cpf', '184', 'rlockman@example.com', '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(2, 'Dr. Ernesto Williamson', 'cpf', '0', 'edna.renner@example.org', '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(3, 'Edythe Rowe DDS', 'cpf', '480391', 'delilah.wolf@example.org', '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(4, 'Clinton McGlynn', 'cpf', '52845673', 'barney.skiles@example.org', '2020-01-24 19:50:09', '2020-01-24 19:50:09');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Copiando estrutura para tabela selecaoPerfectpay.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela selecaoPerfectpay.migrations: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2020_01_24_174416_create_customers_table', 1),
	(2, '2020_01_24_174440_create_products_table', 1),
	(3, '2020_01_24_174655_create_sales_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Copiando estrutura para tabela selecaoPerfectpay.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela selecaoPerfectpay.products: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`) VALUES
	(1, 'PefectCaps', 'A enim necessitatibus at numquam quis quia possimus.', 200.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(2, 'NatureCaps', 'Blanditiis accusamus quisquam sit qui consequatur est.', 100.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(3, 'Produto 3', 'Pariatur animi et distinctio quaerat.', 84.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(4, 'Produto 4', 'Assumenda itaque est nobis ullam.', 54.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(5, 'Produto 5', 'Sint dolorum iusto aliquam aut vel.', 97.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(6, 'Produto 6', 'Non ut exercitationem sed dolorem.', 44.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(7, 'Produto 7', 'Ratione molestias a sint qui eligendi ad non corrupti.', 75.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(8, 'Produto 8', 'Id sit et sunt sit.', 30.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(9, 'Produto 9', 'Minus placeat atque saepe corrupti iste.', 30.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09'),
	(10, 'Produto 10', 'Earum eum repellat facilis dolorem.', 34.00, '2020-01-24 19:50:09', '2020-01-24 19:50:09');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Copiando estrutura para tabela selecaoPerfectpay.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `discount` double(5,2) DEFAULT NULL,
  `sale_amount` double(8,2) DEFAULT NULL,
  `status` enum('SOLD','CANCELED','DEVOLUTION') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sales_product_id_foreign` (`product_id`),
  KEY `sales_customer_id_foreign` (`customer_id`),
  CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `sales_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela selecaoPerfectpay.sales: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` (`id`, `product_id`, `customer_id`, `quantity`, `discount`, `sale_amount`, `status`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 1, 0.00, 200.00, 'SOLD', '2020-01-22 16:55:00', '2020-01-25 06:24:18'),
	(2, 2, 2, 2, 10.00, 180.00, 'SOLD', '2020-01-23 19:57:43', '2020-01-23 19:57:43'),
	(3, 2, 4, 2, 10.00, 180.00, 'CANCELED', '2020-01-24 19:57:54', '2020-01-24 19:57:54'),
	(4, 2, 1, 1, 10.00, 90.00, 'DEVOLUTION', '2020-01-23 19:57:58', '2020-01-23 16:55:02'),
	(5, 7, 1, 2, 0.00, 150.00, 'SOLD', '2020-01-22 19:58:02', '2020-01-25 05:40:03'),
	(6, 5, 1, 1, 0.00, 97.00, 'SOLD', '2020-01-22 16:55:00', '2020-01-25 05:46:00'),
	(7, 2, 3, 2, 0.00, 180.00, 'DEVOLUTION', '2020-01-20 16:55:00', '2020-01-25 05:40:24'),
	(8, 1, 4, 2, 0.00, 180.00, 'SOLD', '2020-01-24 16:55:00', '2020-01-24 16:55:02');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
