-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 04, 2025 at 01:45 PM
-- Server version: 8.0.40
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `MicroOnlineMarket_Group1_Section8`
--

-- --------------------------------------------------------

--
-- Table structure for table `Cash`
--

CREATE TABLE `Cash` (
  `Payment_Method_ID` int NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Cash`
--

INSERT INTO `Cash` (`Payment_Method_ID`, `amount`) VALUES
(1, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `Claim`
--

CREATE TABLE `Claim` (
  `User_ID` int NOT NULL,
  `Coupon_ID` int NOT NULL,
  `time_used` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Claim`
--

INSERT INTO `Claim` (`User_ID`, `Coupon_ID`, `time_used`) VALUES
(2, 2, 2),
(3, 1, 1),
(4, 4, 1),
(5, 3, 1),
(5, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Coupon`
--

CREATE TABLE `Coupon` (
  `Coupon_ID` int NOT NULL,
  `Coupon_Name` varchar(50) NOT NULL,
  `Discount_Value` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Coupon`
--

INSERT INTO `Coupon` (`Coupon_ID`, `Coupon_Name`, `Discount_Value`) VALUES
(1, 'FRESH100', 100),
(2, 'VEG20', 20),
(3, 'SEAFOOD50', 50),
(4, 'NEWBASKET150', 150),
(5, 'FREEDELIVERY', 30);

-- --------------------------------------------------------

--
-- Table structure for table `Credit_Card`
--

CREATE TABLE `Credit_Card` (
  `Payment_Method_ID` int NOT NULL,
  `Card_Number` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Credit_Card`
--

INSERT INTO `Credit_Card` (`Payment_Method_ID`, `Card_Number`) VALUES
(2, '1111222233334444');

-- --------------------------------------------------------

--
-- Table structure for table `Deliver`
--

CREATE TABLE `Deliver` (
  `Delivery_ID` int NOT NULL,
  `Product_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Deliver`
--

INSERT INTO `Deliver` (`Delivery_ID`, `Product_ID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Delivery`
--

CREATE TABLE `Delivery` (
  `Delivery_ID` int NOT NULL,
  `Delivery_address` varchar(255) DEFAULT NULL,
  `Delivered_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Delivery`
--

INSERT INTO `Delivery` (`Delivery_ID`, `Delivery_address`, `Delivered_time`) VALUES
(1, 'Bangkok – Chatuchak', '2025-11-06 09:30:00'),
(2, 'Bangkok – Thonglor', '2025-11-06 11:15:00'),
(3, 'Chiang Mai – Nimman', '2025-11-07 10:00:00'),
(4, 'Khon Kaen – City', '2025-11-07 13:45:00'),
(5, 'Phuket – Patong', '2025-11-08 08:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `Login`
--

CREATE TABLE `Login` (
  `Login_ID` int NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varbinary(100) NOT NULL,
  `Status` varchar(50) DEFAULT 'user',
  `User_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Login`
--

INSERT INTO `Login` (`Login_ID`, `Username`, `Password`, `Status`, `User_ID`) VALUES
(100, 'mick01', 0xf417a02f054a11f5e0cde99f518dba8fe1dc5b3a37a19f0dfb34a5d2acd0c1dd, 'admin', 1),
(101, 'pop01', 0x81018792caf3ad6f7882b701494e2fa3c492b4ef60dcef49da20aac2a65198b9, 'seller', 2),
(102, 'ping01', 0x4b7201735c980845dfea505bd3cb694ea4c56c1e378e4be3333f41c4e4342398, 'user', 3),
(103, 'peppo01', 0xbb244c9456c9b934d0d36d541a7314fea0099871163ad97fea85f8139ce4d6c0, 'user', 4),
(104, 'yew01', 0xadca8cafa3caab6e11fb222d68d4c3c09df64864fbad2881ebcf2b9877f020ba, 'user', 5);

-- --------------------------------------------------------

--
-- Table structure for table `Order_Transaction`
--

CREATE TABLE `Order_Transaction` (
  `Transaction_ID` int NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Coupon_ID` int DEFAULT NULL,
  `Payment_Method_ID` int DEFAULT NULL,
  `Order_Date` date DEFAULT NULL,
  `Total_price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Order_Transaction`
--

INSERT INTO `Order_Transaction` (`Transaction_ID`, `User_ID`, `Coupon_ID`, `Payment_Method_ID`, `Order_Date`, `Total_price`) VALUES
(1, 3, NULL, 1, '2025-11-06', 89.00),
(2, 2, NULL, 2, '2025-11-06', 55.00),
(3, 5, NULL, 1, '2025-11-07', 0.00),
(4, 4, NULL, 2, '2025-11-07', 15.00),
(5, 5, NULL, 1, '2025-11-08', 190.00);

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `Payment_ID` int NOT NULL,
  `Order_ID` int NOT NULL,
  `Payment_Method_ID` int NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Status` enum('pending','paid','failed','refunded') NOT NULL DEFAULT 'paid',
  `Paid_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`Payment_ID`, `Order_ID`, `Payment_Method_ID`, `Amount`, `Status`, `Paid_At`) VALUES
(1, 1, 1, 89.00, 'paid', '2025-11-06 09:40:00'),
(2, 2, 2, 55.00, 'paid', '2025-11-06 11:25:00'),
(3, 3, 1, 0.00, 'paid', '2025-11-07 10:10:00'),
(4, 4, 2, 15.00, 'paid', '2025-11-07 13:55:00'),
(5, 5, 1, 190.00, 'paid', '2025-11-08 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `Payment_Card_Detail`
--

CREATE TABLE `Payment_Card_Detail` (
  `Payment_ID` int NOT NULL,
  `Card_Number` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Payment_Card_Detail`
--

INSERT INTO `Payment_Card_Detail` (`Payment_ID`, `Card_Number`) VALUES
(2, '5544332211998877'),
(4, '4111111111111111');

-- --------------------------------------------------------

--
-- Table structure for table `Payment_Method`
--

CREATE TABLE `Payment_Method` (
  `Payment_Method_ID` int NOT NULL,
  `Method_Type` enum('Cash','Credit_card') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Payment_Method`
--

INSERT INTO `Payment_Method` (`Payment_Method_ID`, `Method_Type`) VALUES
(1, 'Cash'),
(2, 'Credit_card');

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `Product_ID` int NOT NULL,
  `Product_Name` varchar(100) NOT NULL,
  `Product_Price` decimal(10,2) NOT NULL,
  `Length` decimal(5,2) DEFAULT NULL,
  `Height` decimal(5,2) DEFAULT NULL,
  `Width` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Product`
--

INSERT INTO `Product` (`Product_ID`, `Product_Name`, `Product_Price`, `Length`, `Height`, `Width`) VALUES
(1, 'Thai Jasmine Rice 5kg', 189.00, 40.00, 10.00, 30.00),
(2, 'Cage-Free Eggs (10 pcs)', 75.00, 30.00, 8.00, 20.00),
(3, 'Morning Glory (Pak Boong) 500g', 25.00, 35.00, 5.00, 10.00),
(4, 'Pork Loin 1kg', 165.00, 25.00, 8.00, 15.00),
(5, 'Seabass Cleaned 800g', 220.00, 30.00, 8.00, 12.00);

-- --------------------------------------------------------

--
-- Table structure for table `Review`
--

CREATE TABLE `Review` (
  `Review_No` int NOT NULL,
  `Product_ID` int DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  `Review_date` datetime DEFAULT NULL,
  `Review_text` text,
  `Rating` int DEFAULT NULL
) ;

--
-- Dumping data for table `Review`
--

INSERT INTO `Review` (`Review_No`, `Product_ID`, `User_ID`, `Review_date`, `Review_text`, `Rating`) VALUES
(1, 1, 3, '2025-11-06 10:05:00', 'Rice is fragrant and fresh. Good price.', 5),
(2, 2, 2, '2025-11-06 12:00:00', 'Eggs were intact and very fresh.', 4),
(3, 3, 5, '2025-11-07 10:30:00', 'Crisp morning glory, perfect for stir-fry.', 5),
(4, 4, 4, '2025-11-07 14:10:00', 'Pork loin was clean and tender.', 5),
(5, 5, 5, '2025-11-08 09:20:00', 'Seabass was fresh; would buy again.', 4);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `ID` int NOT NULL,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`ID`, `Fname`, `Lname`, `Address`, `DOB`, `Email`) VALUES
(1, 'Mick', 'Wolff', 'Bangkok', '2001-05-14', 'mick@example.com'),
(2, 'Pop', 'Chan', 'Chiang Mai', '2000-11-22', 'pop@example.com'),
(3, 'Ping', 'LeeFam', 'Phuket', '2002-03-08', 'ping@example.com'),
(4, 'Peppo', 'Rob', 'Khon Kaen', '1999-12-05', 'peppo@example.com'),
(5, 'Yew', 'Tia', 'Tak', '2003-06-15', 'yew@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Cash`
--
ALTER TABLE `Cash`
  ADD PRIMARY KEY (`Payment_Method_ID`);

--
-- Indexes for table `Claim`
--
ALTER TABLE `Claim`
  ADD PRIMARY KEY (`User_ID`,`Coupon_ID`),
  ADD KEY `Coupon_ID` (`Coupon_ID`);

--
-- Indexes for table `Coupon`
--
ALTER TABLE `Coupon`
  ADD PRIMARY KEY (`Coupon_ID`);

--
-- Indexes for table `Credit_Card`
--
ALTER TABLE `Credit_Card`
  ADD PRIMARY KEY (`Payment_Method_ID`);

--
-- Indexes for table `Deliver`
--
ALTER TABLE `Deliver`
  ADD PRIMARY KEY (`Delivery_ID`,`Product_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `Delivery`
--
ALTER TABLE `Delivery`
  ADD PRIMARY KEY (`Delivery_ID`);

--
-- Indexes for table `Login`
--
ALTER TABLE `Login`
  ADD PRIMARY KEY (`Login_ID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD KEY `fk_login_user` (`User_ID`);

--
-- Indexes for table `Order_Transaction`
--
ALTER TABLE `Order_Transaction`
  ADD PRIMARY KEY (`Transaction_ID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Coupon_ID` (`Coupon_ID`),
  ADD KEY `Payment_Method_ID` (`Payment_Method_ID`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `idx_payment_order` (`Order_ID`),
  ADD KEY `idx_payment_method` (`Payment_Method_ID`);

--
-- Indexes for table `Payment_Card_Detail`
--
ALTER TABLE `Payment_Card_Detail`
  ADD PRIMARY KEY (`Payment_ID`);

--
-- Indexes for table `Payment_Method`
--
ALTER TABLE `Payment_Method`
  ADD PRIMARY KEY (`Payment_Method_ID`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `Review`
--
ALTER TABLE `Review`
  ADD PRIMARY KEY (`Review_No`),
  ADD KEY `Product_ID` (`Product_ID`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Coupon`
--
ALTER TABLE `Coupon`
  MODIFY `Coupon_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Delivery`
--
ALTER TABLE `Delivery`
  MODIFY `Delivery_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Login`
--
ALTER TABLE `Login`
  MODIFY `Login_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `Order_Transaction`
--
ALTER TABLE `Order_Transaction`
  MODIFY `Transaction_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `Payment_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Payment_Method`
--
ALTER TABLE `Payment_Method`
  MODIFY `Payment_Method_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `Product_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Review`
--
ALTER TABLE `Review`
  MODIFY `Review_No` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Cash`
--
ALTER TABLE `Cash`
  ADD CONSTRAINT `cash_ibfk_1` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Claim`
--
ALTER TABLE `Claim`
  ADD CONSTRAINT `claim_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `claim_ibfk_2` FOREIGN KEY (`Coupon_ID`) REFERENCES `Coupon` (`Coupon_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Credit_Card`
--
ALTER TABLE `Credit_Card`
  ADD CONSTRAINT `credit_card_ibfk_1` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Deliver`
--
ALTER TABLE `Deliver`
  ADD CONSTRAINT `deliver_ibfk_1` FOREIGN KEY (`Delivery_ID`) REFERENCES `Delivery` (`Delivery_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliver_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Login`
--
ALTER TABLE `Login`
  ADD CONSTRAINT `fk_login_user` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Order_Transaction`
--
ALTER TABLE `Order_Transaction`
  ADD CONSTRAINT `order_transaction_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_transaction_ibfk_2` FOREIGN KEY (`Coupon_ID`) REFERENCES `Coupon` (`Coupon_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_transaction_ibfk_3` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Payment`
--
ALTER TABLE `Payment`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_order` FOREIGN KEY (`Order_ID`) REFERENCES `Order_Transaction` (`Transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Payment_Card_Detail`
--
ALTER TABLE `Payment_Card_Detail`
  ADD CONSTRAINT `fk_pc_payment` FOREIGN KEY (`Payment_ID`) REFERENCES `Payment` (`Payment_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Review`
--
ALTER TABLE `Review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
