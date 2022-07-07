-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2022 at 12:01 AM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(11) NOT NULL,
  `checkIn` datetime NOT NULL,
  `checkOut` datetime NOT NULL,
  `late` int(11) NOT NULL DEFAULT '0',
  `early` int(11) NOT NULL DEFAULT '0',
  `overtime` int(11) NOT NULL DEFAULT '0',
  `empID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `checkIn`, `checkOut`, `late`, `early`, `overtime`, `empID`) VALUES
(10, '2022-07-07 02:32:19', '2022-07-07 20:14:40', 8, 4, 4, 1),
(11, '2022-07-07 20:16:51', '2022-07-07 20:20:10', 676, 0, 200, 4),
(12, '2022-07-07 20:20:15', '2022-07-07 20:20:16', 680, 0, 200, 4),
(13, '2022-07-07 20:20:17', '2022-07-07 20:20:18', 680, 0, 200, 4),
(14, '2022-07-07 20:20:19', '2022-07-07 20:20:20', 680, 0, 200, 4),
(15, '2022-07-07 20:20:21', '2022-07-07 20:20:21', 680, 0, 200, 4),
(16, '2022-07-07 20:20:22', '2022-07-07 20:20:23', 680, 0, 200, 4),
(17, '2022-07-07 20:20:23', '0000-00-00 00:00:00', 680, 0, 0, 4),
(18, '2022-07-07 20:20:39', '2022-07-07 20:20:40', 680, 0, 200, 1),
(19, '2022-07-07 20:20:40', '2022-07-07 20:20:41', 680, 0, 200, 1),
(20, '2022-07-07 20:20:42', '2022-07-07 20:20:43', 680, 0, 200, 1),
(21, '2022-07-07 20:20:45', '2022-07-07 20:20:46', 680, 0, 200, 1),
(22, '2022-07-07 20:20:47', '2022-07-07 20:20:48', 680, 0, 200, 1),
(24, '2022-07-07 20:28:12', '2022-07-07 20:29:07', 688, 0, 209, 1),
(33, '2022-07-07 20:31:29', '2022-07-07 21:31:25', 691, 0, 271, 1),
(34, '2022-07-07 21:38:23', '2022-07-07 21:38:27', 758, 0, 278, 3),
(35, '2022-07-07 22:30:55', '2022-07-07 22:32:34', 810, 0, 332, 3),
(36, '2022-07-07 22:39:59', '2022-07-07 22:41:52', 819, 0, 341, 3),
(37, '2022-07-07 22:42:18', '2022-07-07 22:44:43', 822, 0, 344, 3),
(38, '2022-07-07 22:45:04', '2022-07-07 22:45:15', 825, 0, 345, 3),
(39, '2022-07-07 23:23:56', '2022-07-07 23:23:58', 863, 0, 383, 3);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'user',
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `username`, `password`, `type`, `email`) VALUES
(1, 'sayed', '123', 'user', 'sa1377618@gmail.com'),
(2, 'Ahmed', '111', 'user', 'ahmed@gmail.com'),
(3, 'ali', 'ali', 'user', 'ali@gmail.com'),
(4, 'mohamed', 'moh', 'user', 'moh@gmail.com'),
(5, 'ola', 'ola', 'user', 'ola@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_empId` (`empID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `FK_empId` FOREIGN KEY (`empID`) REFERENCES `employees` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
