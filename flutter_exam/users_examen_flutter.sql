-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Sep 08, 2023 at 02:06 PM
-- Server version: 5.7.34
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `users_examen_flutter`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `userName` varchar(30) NOT NULL,
  `userPassword` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `userName`, `userPassword`) VALUES
(2, 'Adil07', '12345678'),
(3, 'Simo09', '87654321'),
(4, 'Chico89', '12345678'),
(5, 'Riko00', '12345678'),
(6, 'Tiens88', '12345678'),
(7, 'Test88', '12345678'),
(8, 'Test99', '12345678'),
(999, 'Moro120', '12345678'),
(1000, 'Moro100', '12345678'),
(1001, 'Moro100', '12345678'),
(1002, 'ninho00', '12345678'),
(1003, 'Ninho121', '12345678'),
(1004, 'Testo77', '12345678'),
(1005, 'Obama77', '12345678'),
(1006, 'PA999', '12345678'),
(1007, 'Shlappa11', '12345678'),
(1008, 'PNL1234', '12345678'),
(10010, 'Adil001', '12345678'),
(9999999, 'Adil', '12345678');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
