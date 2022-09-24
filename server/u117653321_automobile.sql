-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 24, 2022 at 09:38 AM
-- Server version: 10.5.15-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u117653321_automobile`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fcmtoken` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminid`, `username`, `email`, `mobile`, `fcmtoken`, `image`, `password`, `role`, `name`) VALUES
('ad62e164b8a6fc4', 'aniket4897', 'aniket4897@gmail.com', '9833672690', NULL, NULL, '25d55ad283aa400af464c76d713c07ad', 'admin', 'Aniket Yadav'),
('ad62f71ab0b8504', 'nikhilgharate307401', 'nikhilgharate307401@gmail.com', '0839049906', NULL, 'https://automobileservice.tech/api/images/ad62f71ab0b8504.jpeg', 'f1cd466d3f10655e96fcf5ddb556f93c', 'admin', 'Nikhil Jagadish Gharate'),
('ad6328c218b93cb', 'vishalshevale571', 'vishalshevale571@gmail.com', '8830861682', NULL, NULL, '73d6d5c8cf509a1a4a81bbe6b18be60b', 'admin', 'Vishal shevale ');

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `admindelete` AFTER DELETE ON `admin` FOR EACH ROW DELETE FROM users WHERE userid=OLD.adminid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `admininsert` AFTER INSERT ON `admin` FOR EACH ROW INSERT INTO users(userid,username,password,role)VALUES(NEW.adminid,NEW.username,NEW.password,"admin")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `adminupdate` AFTER UPDATE ON `admin` FOR EACH ROW UPDATE users SET password=NEW.password where userid = OLD.adminid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customerid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fcmtoken` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customerid`, `name`, `username`, `email`, `mobile`, `address`, `city`, `district`, `pincode`, `latitude`, `longitude`, `fcmtoken`, `image`, `password`, `role`) VALUES
('cu62d988badcff9', 'Aniket Yadav', 'aniket.y', 'aniket.y@somaiya.edu', '9773972829', 'Jagdale niwas kisan nagar', 'Thane', 'Thane', '400604', NULL, NULL, NULL, 'https://automobileservice.tech/api/images/cu62d988badcff9.jpeg', 'cbb83c80477eb1c5df5ef80aa6f2a09c', 'customer'),
('cu62f71bc010f04', 'nikhil gharate', 'nikhilgharate365', 'nikhilgharate365@gmail.com', '8329706961', 'pune', 'pune', 'pune', '424001', NULL, NULL, NULL, 'https://automobileservice.tech/api/images/cu62f71bc010f04.jpeg', '4c5534ee5bb98897c152be0be1d99f0f', 'customer'),
('cu632b418a6ddc6', 'Ajay Koli', 'shevalevishal735', 'shevalevishal735@gmail.com', '8600717116', 'Pune', 'Pune', 'Pune', '424001', NULL, NULL, NULL, NULL, '59f429ad9b2d0d9792f0cb2e9dbe7335', 'customer');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `customerdelete` AFTER DELETE ON `customers` FOR EACH ROW DELETE FROM users WHERE userid=OLD.customerid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `customerinsert` AFTER INSERT ON `customers` FOR EACH ROW INSERT INTO users(userid,username,password,role)VALUES(NEW.customerid,NEW.username,NEW.password,"customer")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `customerupdate` AFTER UPDATE ON `customers` FOR EACH ROW UPDATE users SET password=NEW.password where userid =OLD.customerid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedbackid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`feedbackid`, `comment`, `author`, `rate`, `date`, `email`) VALUES
('fd62d993cbae0f4', 'some features does not look complete', 'Aniket Yadav', '3', '2022-07-21T23:28', 'aniket.y@somaiya.edu'),
('fd62dd8a7d4943b', '', 'Aniket Yadav', '5', '2022-07-24T23:37', 'anikety@somaiya.edu'),
('fd62f71cb9d5adc', 'nice service', 'nikhil gharate', '2', '2022-08-13T09:08', 'nikhilgharate365@gmail.com'),
('fd62f74d7ec244e', 'nice service', 'nikhil gharate', '3', '2022-08-13T12:36', 'nikhilgharate365@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `managerid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `servicecenterid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manager'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `managers`
--

INSERT INTO `managers` (`managerid`, `name`, `email`, `mobile`, `username`, `servicecenterid`, `image`, `password`, `role`) VALUES
('ma62d82dba47cb7', 'Aniket Yadav', 'anikety@somaiya.edu', '9883683682', 'anikety', 'cen62d8d18d96fe1', NULL, 'ecf887fc286089351f268f1c2baf14ff', 'manager'),
('ma62f68aa0904f1', 'tanay', 'tanay.surve.ts@gmail.com', '8552527286', 'tanay.surve.ts', 'cen62d8d18d96fe1', '', '8f1bfa574507d254194168014202bd83', 'manager'),
('ma62f7220c13b62', 'Shubham', 'witemek218@kingspc.com', '8390499064', 'witemek218', 'cen62f7371555582', NULL, 'dcba30563c4331f342324a77e4ebae28', 'manager'),
('ma6329ed493f380', 'Ajay Prajay', 'pomejah768@revtxt.com', '9923127521', 'pomejah768', 'cen6329eca42e6e9', 'https://automobileservice.tech/api/images/ma6329ed493f380.jpeg', '8a5f62ae92cafe1bbf22b222a24aac7d', 'manager');

--
-- Triggers `managers`
--
DELIMITER $$
CREATE TRIGGER `managerdelete` AFTER DELETE ON `managers` FOR EACH ROW DELETE FROM users WHERE userid=OLD.managerid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `managerinsert` AFTER INSERT ON `managers` FOR EACH ROW INSERT INTO users(userid,username,password,role)VALUES(NEW.managerid,NEW.username,NEW.password,"manager")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `managerupdate` AFTER UPDATE ON `managers` FOR EACH ROW UPDATE users SET password=NEW.password WHERE userid = OLD.managerid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `reportid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customerid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `servicecenterid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `services` varchar(5000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payable` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentstatus` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `center` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`reportid`, `customerid`, `servicecenterid`, `services`, `payable`, `paymentstatus`, `center`, `status`, `paymentid`, `customer`) VALUES
('or62dd45f1b8186', 'cu62d988badcff9', 'cen62d8d18d96fe1', '[{\"charge\":\"1200\",\"name\":\"Preventive Maintenance Service\",\"serviceid\":\"ser62dc0e625c26c\"},{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"},{\"charge\":\"1000\",\"name\":\"Body Repair\",\"serviceid\":\"ser62dc0e8db2bd9\"}]', '2700', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62d82dba47cb7\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'complete', 'pay62dd7773760bb', '{\"address\":\"Jagdale niwas kisan nagar\",\"city\":\"Thane\",\"customerid\":\"cu62d988badcff9\",\"district\":\"Thane\",\"email\":\"aniket.y@somaiya.edu\",\"image\":\"https://automobileservice.tech/api/images/cu62d988badcff9.jpeg\",\"mobile\":\"9773972829\",\"name\":\"Aniket Yadav\",\"password\":\"cbb83c80477eb1c5df5ef80aa6f2a09c\",\"pincode\":\"400604\",\"role\":\"customer\",\"username\":\"aniket.y\"}'),
('or62de0a53793a4', 'cu62d988badcff9', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"},{\"charge\":\"1000\",\"name\":\"Body Repair\",\"serviceid\":\"ser62dc0e8db2bd9\"}]', '1500', 'unpaid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62d82dba47cb7\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'confirm', NULL, '{\"address\":\"Jagdale niwas kisan nagar\",\"city\":\"Thane\",\"customerid\":\"cu62d988badcff9\",\"district\":\"Thane\",\"email\":\"aniket.y@somaiya.edu\",\"image\":\"https://automobileservice.tech/api/images/cu62d988badcff9.jpeg\",\"mobile\":\"9773972829\",\"name\":\"Aniket Yadav\",\"password\":\"cbb83c80477eb1c5df5ef80aa6f2a09c\",\"pincode\":\"400604\",\"role\":\"customer\",\"username\":\"aniket.y\"}'),
('or62de58432368f', 'cu62d988badcff9', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'unpaid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62d82dba47cb7\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'confirm', NULL, '{\"address\":\"Jagdale niwas kisan nagar\",\"city\":\"Thane\",\"customerid\":\"cu62d988badcff9\",\"district\":\"Thane\",\"email\":\"aniket.y@somaiya.edu\",\"image\":\"https://automobileservice.tech/api/images/cu62d988badcff9.jpeg\",\"mobile\":\"9773972829\",\"name\":\"Aniket Yadav\",\"pincode\":\"400604\",\"role\":\"customer\"}'),
('or62f68421309b0', 'cu62f683dae6592', 'cen62d8d18d96fe1', '[{\"charge\":\"1200\",\"name\":\"Preventive Maintenance Service\",\"serviceid\":\"ser62dc0e625c26c\"}]', '1200', 'unpaid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62d82dba47cb7\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'booked', NULL, '{\"customerid\":\"cu62f683dae6592\",\"email\":\"nikhilgharate307401@gmail.com\",\"mobile\":\"8390499064\",\"name\":\"Nikhil Gharate\",\"role\":\"customer\"}'),
('or62f6854ea3c4a', 'cu62f683dae6592', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62d82dba47cb7\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'complete', 'pay62f6864e24c5a', '{\"customerid\":\"cu62f683dae6592\",\"email\":\"nikhilgharate307401@gmail.com\",\"mobile\":\"8390499064\",\"name\":\"Nikhil Gharate\",\"role\":\"customer\"}'),
('or62f68c666c3bf', 'cu62d988badcff9', 'cen62e02f9b6b0f0', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'unpaid', '{\"address\":\"Pradhikaran nigadi pune\",\"centerid\":\"cen62e02f9b6b0f0\",\"city\":\"pune\",\"district\":\"pune\",\"latitude\":\"null\",\"longitude\":\"null\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Ajay services\",\"pincode\":\"411001\"}', 'booked', NULL, '{\"address\":\"Jagdale niwas kisan nagar\",\"city\":\"Thane\",\"customerid\":\"cu62d988badcff9\",\"district\":\"Thane\",\"email\":\"aniket.y@somaiya.edu\",\"image\":\"https://automobileservice.tech/api/images/cu62d988badcff9.jpeg\",\"mobile\":\"9773972829\",\"name\":\"Aniket Yadav\",\"password\":\"cbb83c80477eb1c5df5ef80aa6f2a09c\",\"pincode\":\"400604\",\"role\":\"customer\",\"username\":\"aniket.y\"}'),
('or62f68d2ec9bed', 'cu62d988badcff9', 'cen62e02f9b6b0f0', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'unpaid', '{\"address\":\"Pradhikaran nigadi pune\",\"centerid\":\"cen62e02f9b6b0f0\",\"city\":\"pune\",\"district\":\"pune\",\"latitude\":\"null\",\"longitude\":\"null\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Ajay services\",\"pincode\":\"411001\"}', 'booked', NULL, '{\"address\":\"Jagdale niwas kisan nagar\",\"city\":\"Thane\",\"customerid\":\"cu62d988badcff9\",\"district\":\"Thane\",\"email\":\"aniket.y@somaiya.edu\",\"image\":\"https://automobileservice.tech/api/images/cu62d988badcff9.jpeg\",\"mobile\":\"9773972829\",\"name\":\"Aniket Yadav\",\"password\":\"cbb83c80477eb1c5df5ef80aa6f2a09c\",\"pincode\":\"400604\",\"role\":\"customer\",\"username\":\"aniket.y\"}'),
('or62f71c391db65', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62d82dba47cb7\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'complete', 'pay62f71c76ee774', '{\"customerid\":\"cu62f71bc010f04\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"role\":\"customer\"}'),
('or62f73605dfbbe', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'complete', 'pay62f73647e489f', '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or62f746667de34', 'cu62f71bc010f04', 'cen62f7371555582', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'paid', '{\"address\":\"pujarir1721gmail.com\",\"centerid\":\"cen62f7371555582\",\"city\":\"pune\",\"district\":\"pune\",\"latitude\":\"18.64059324458262\",\"longitude\":\"73.95563956350088\",\"managerid\":\"ma62f7220c13b62\",\"name\":\"Rushi service center\",\"pincode\":\"424001\"}', 'complete', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or62f74c58f326e', 'cu62f71bc010f04', 'cen62f7371555582', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'paid', '{\"address\":\"pujarir1721gmail.com\",\"centerid\":\"cen62f7371555582\",\"city\":\"pune\",\"district\":\"pune\",\"latitude\":\"18.64059324458262\",\"longitude\":\"73.95563956350088\",\"managerid\":\"ma62f7220c13b62\",\"name\":\"Rushi service center\",\"pincode\":\"424001\"}', 'complete', 'pay62f74d5478235', '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or62f74d1e77705', 'cu62f71bc010f04', 'cen62f7371555582', '[{\"charge\":\"1000\",\"name\":\"Body Repair\",\"serviceid\":\"ser62dc0e8db2bd9\"}]', '1000', 'unpaid', '{\"address\":\"pujarir1721gmail.com\",\"centerid\":\"cen62f7371555582\",\"city\":\"pune\",\"district\":\"pune\",\"latitude\":\"18.64059324458262\",\"longitude\":\"73.95563956350088\",\"managerid\":\"ma62f7220c13b62\",\"name\":\"Rushi service center\",\"pincode\":\"424001\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or62f7dd295cde4', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"1200\",\"name\":\"Preventive Maintenance Service\",\"serviceid\":\"ser62dc0e625c26c\"}]', '1200', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'complete', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6309bbd70a45e', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"900\",\"name\":\"Interior Upholstery Clean\",\"serviceid\":\"ser62dc0f003d9e6\"}]', '900', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'complete', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6309bf95687e1', 'cu62f71bc010f04', 'cen62f7371555582', '[{\"charge\":\"1800\",\"name\":\"Wax polish\",\"serviceid\":\"ser62dc0f10724eb\"}]', '1800', 'paid', '{\"address\":\"pujarir1721gmail.com\",\"centerid\":\"cen62f7371555582\",\"city\":\"Mumbai\",\"district\":\"Aundh\",\"latitude\":\"18.64059324458262\",\"longitude\":\"73.95563956350088\",\"managerid\":\"ma62f7220c13b62\",\"name\":\"Rushi service center\",\"pincode\":\"424001\"}', 'complete', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6326c6ed4d279', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'confirm', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6326ce2dce939', 'cu62f71bc010f04', 'cen62f7371555582', '[{\"charge\":\"1000\",\"name\":\"Body Repair\",\"serviceid\":\"ser62dc0e8db2bd9\"}]', '1000', 'unpaid', '{\"address\":\"pujarir1721gmail.com\",\"centerid\":\"cen62f7371555582\",\"city\":\"Mumbai\",\"district\":\"Aundh\",\"latitude\":\"18.64059324458262\",\"longitude\":\"73.95563956350088\",\"managerid\":\"ma62f7220c13b62\",\"name\":\"Rushi service center\",\"pincode\":\"424001\",\"image\":\"https://automobileservice.tech/api/images/cen62f7371555582.jpeg\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6326f1924a4da', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"1200\",\"name\":\"Preventive Maintenance Service\",\"serviceid\":\"ser62dc0e625c26c\"}]', '1200', 'confirm', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6326f51341ec0', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"1000\",\"name\":\"Body Repair\",\"serviceid\":\"ser62dc0e8db2bd9\"}]', '1000', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or63270b0adfda3', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"},{\"charge\":\"1000\",\"name\":\"danting\",\"serviceid\":\"ser62e13a60e3118\"}]', '1500', 'confirm', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or63270f0a214f4', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'complete', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or632713da2fa41', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'complete', 'pay632714ed67659', '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6327484fba64e', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"1200\",\"name\":\"Preventive Maintenance Service\",\"serviceid\":\"ser62dc0e625c26c\"}]', '1200', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'complete', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6327498e69f15', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'unpaid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6328be9e2ec1a', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '500', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'confirm', 'pay6328bf9bc1ba9', '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or6329ef07b1243', 'cu62d988badcff9', 'cen6329eca42e6e9', '[{\"charge\":\"1000\",\"name\":\"Body Repair\",\"serviceid\":\"ser62dc0e8db2bd9\"}]', '1000', 'paid', '{\"address\":\"Sakri Road Dhule\",\"centerid\":\"cen6329eca42e6e9\",\"city\":\"Dhule\",\"district\":\"Dhule\",\"latitude\":\"20.905946062499172\",\"longitude\":\"74.7781366109848\",\"managerid\":\"ma6329ed493f380\",\"name\":\"Rahul Service center\",\"pincode\":\"424001\"}', 'complete', NULL, '{\"address\":\"Jagdale niwas kisan nagar\",\"city\":\"Thane\",\"customerid\":\"cu62d988badcff9\",\"district\":\"Thane\",\"email\":\"aniket.y@somaiya.edu\",\"image\":\"https://automobileservice.tech/api/images/cu62d988badcff9.jpeg\",\"mobile\":\"9773972829\",\"name\":\"Aniket Yadav\",\"password\":\"cbb83c80477eb1c5df5ef80aa6f2a09c\",\"pincode\":\"400604\",\"role\":\"customer\",\"username\":\"aniket.y\"}'),
('or6329f6074d747', 'cu62f71bc010f04', 'cen6329eca42e6e9', '[{\"charge\":\"490\",\"name\":\"Engine Flush Treatment\",\"serviceid\":\"ser62dc0f2ebe7db\"}]', '490', 'paid', '{\"address\":\"Sakri Road Dhule\",\"centerid\":\"cen6329eca42e6e9\",\"city\":\"Dhule\",\"district\":\"Dhule\",\"latitude\":\"20.905946062499172\",\"longitude\":\"74.7781366109848\",\"managerid\":\"ma6329ed493f380\",\"name\":\"Rahul Service center\",\"pincode\":\"424001\"}', 'complete', 'pay6329f65de3323', '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"image\":\"https://automobileservice.tech/api/images/cu62f71bc010f04.jpeg\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or632ad71543fe1', 'cu62f71bc010f04', 'cen62d8d18d96fe1', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'unpaid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'confirm', NULL, '{\"address\":\"pune\",\"city\":\"pune\",\"customerid\":\"cu62f71bc010f04\",\"district\":\"pune\",\"email\":\"nikhilgharate365@gmail.com\",\"image\":\"https://automobileservice.tech/api/images/cu62f71bc010f04.jpeg\",\"mobile\":\"8329706961\",\"name\":\"nikhil gharate\",\"pincode\":\"424001\",\"role\":\"customer\"}'),
('or632b4286a3f36', 'cu632b418a6ddc6', 'cen62d8d18d96fe1', '[{\"charge\":\"100\",\"name\":\"oiling\",\"serviceid\":\"ser62d769f8ef62a\"}]', '100', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'complete', 'pay632b43e191835', '{\"customerid\":\"cu632b418a6ddc6\",\"email\":\"shevalevishal735@gmail.com\",\"mobile\":\"8600717116\",\"name\":\"Ajay Koli\",\"role\":\"customer\"}'),
('or632bcb4cc1b18', 'cu632b418a6ddc6', 'cen62d8d18d96fe1', '[{\"charge\":\"1200\",\"name\":\"Preventive Maintenance Service\",\"serviceid\":\"ser62dc0e625c26c\"},{\"charge\":\"500\",\"name\":\"Running Repair\",\"serviceid\":\"ser62dc0e741bb9e\"}]', '1700', 'paid', '{\"address\":\"road no 16\",\"centerid\":\"cen62d8d18d96fe1\",\"city\":\"thane\",\"district\":\"thane\",\"latitude\":\"18.57291503685524\",\"longitude\":\"74.14423774927855\",\"managerid\":\"ma62f68aa0904f1\",\"name\":\"Om repair\",\"pincode\":\"400604\",\"phone\":\"9883683682\",\"image\":\"https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg\"}', 'complete', NULL, '{\"address\":\"Pune\",\"city\":\"Pune\",\"customerid\":\"cu632b418a6ddc6\",\"district\":\"Pune\",\"email\":\"shevalevishal735@gmail.com\",\"mobile\":\"8600717116\",\"name\":\"Ajay Koli\",\"pincode\":\"424001\",\"role\":\"customer\"}');

-- --------------------------------------------------------

--
-- Table structure for table `servicecenter`
--

CREATE TABLE `servicecenter` (
  `centerid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `managerid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `servicecenter`
--

INSERT INTO `servicecenter` (`centerid`, `name`, `managerid`, `address`, `city`, `district`, `pincode`, `latitude`, `longitude`, `phone`, `image`) VALUES
('cen62d8d18d96fe1', 'Om repair', 'ma62f68aa0904f1', 'road no 16', 'thane', 'thane', '400604', '18.57291503685524', '74.14423774927855', '9883683682', 'https://automobileservice.tech/api/images/cen62d8d18d96fe1.jpeg'),
('cen62f7371555582', 'Rushi service center', 'ma62f7220c13b62', 'pujarir1721gmail.com', 'Mumbai', 'Aundh', '424001', '18.64059324458262', '73.95563956350088', NULL, 'https://automobileservice.tech/api/images/cen62f7371555582.jpeg'),
('cen6329eca42e6e9', 'Rahul Service center', 'ma6329ed493f380', 'Sakri Road Dhule', 'Dhule', 'Dhule', '424001', '20.905946062499172', '74.7781366109848', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `serviceid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`serviceid`, `name`, `charge`) VALUES
('ser62d769f8ef62a', 'oiling', '100'),
('ser62dc0e625c26c', 'Preventive Maintenance Service', '1200'),
('ser62dc0e741bb9e', 'Running Repair', '500'),
('ser62dc0e8db2bd9', 'Body Repair', '1000'),
('ser62dc0e9d0076b', 'Air conditioning system', '700'),
('ser62dc0f003d9e6', 'Interior Upholstery Clean', '900'),
('ser62dc0f10724eb', 'Wax polish', '1800'),
('ser62dc0f2ebe7db', 'Engine Flush Treatment', '490'),
('ser62dc0f4b288d8', 'AC Disinfectant Treatment', '1290'),
('ser62dc0f6ced12d', 'Wheel Care', '1300'),
('ser62e13a60e3118', 'danting', '1000');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `username`, `password`, `role`) VALUES
('ad62e164b8a6fc4', 'aniket4897', '25d55ad283aa400af464c76d713c07ad', 'admin'),
('ad62f71ab0b8504', 'nikhilgharate307401', 'f1cd466d3f10655e96fcf5ddb556f93c', 'admin'),
('ad6328c218b93cb', 'vishalshevale571', '73d6d5c8cf509a1a4a81bbe6b18be60b', 'admin'),
('cu62d988badcff9', 'aniket.y', 'cbb83c80477eb1c5df5ef80aa6f2a09c', 'customer'),
('cu62f71bc010f04', 'nikhilgharate365', '4c5534ee5bb98897c152be0be1d99f0f', 'customer'),
('cu632b418a6ddc6', 'shevalevishal735', '59f429ad9b2d0d9792f0cb2e9dbe7335', 'customer'),
('ma62d82dba47cb7', 'anikety', 'ecf887fc286089351f268f1c2baf14ff', 'manager'),
('ma62f68aa0904f1', 'tanay.surve.ts', '8f1bfa574507d254194168014202bd83', 'manager'),
('ma62f7220c13b62', 'witemek218', 'dcba30563c4331f342324a77e4ebae28', 'manager'),
('ma6329ed493f380', 'pomejah768', '8a5f62ae92cafe1bbf22b222a24aac7d', 'manager');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedbackid`);

--
-- Indexes for table `managers`
--
ALTER TABLE `managers`
  ADD PRIMARY KEY (`managerid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`reportid`);

--
-- Indexes for table `servicecenter`
--
ALTER TABLE `servicecenter`
  ADD PRIMARY KEY (`centerid`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`serviceid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
