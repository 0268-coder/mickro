-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 17, 2025 at 10:09 AM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `micro-8.2`
--

-- --------------------------------------------------------

--
-- Table structure for table `cash`
--

CREATE TABLE `cash` (
  `Payment_Method_ID` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cash`
--

INSERT INTO `cash` (`Payment_Method_ID`, `amount`) VALUES
(1, '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `Coupon_ID` int(11) NOT NULL,
  `Coupon_Name` varchar(50) NOT NULL,
  `Discount_Value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `coupon`
--

INSERT INTO `coupon` (`Coupon_ID`, `Coupon_Name`, `Discount_Value`) VALUES
(1, 'FRESH100', 100),
(2, 'VEG20', 20),
(3, 'SEAFOOD50', 50),
(4, 'NEWBASKET150', 150),
(5, 'FREEDELIVERY', 30);

-- --------------------------------------------------------

--
-- Table structure for table `credit_card`
--

CREATE TABLE `credit_card` (
  `Payment_Method_ID` int(11) NOT NULL,
  `Card_Number` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `credit_card`
--

INSERT INTO `credit_card` (`Payment_Method_ID`, `Card_Number`) VALUES
(2, '1111222233334444');

-- --------------------------------------------------------

--
-- Table structure for table `deliver`
--

CREATE TABLE `deliver` (
  `Delivery_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deliver`
--

INSERT INTO `deliver` (`Delivery_ID`, `Product_ID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `Delivery_ID` int(11) NOT NULL,
  `Delivery_address` varchar(255) DEFAULT NULL,
  `Delivered_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`Delivery_ID`, `Delivery_address`, `Delivered_time`) VALUES
(1, 'Bangkok – Chatuchak', '2025-11-06 09:30:00'),
(2, 'Bangkok – Thonglor', '2025-11-06 11:15:00'),
(3, 'Chiang Mai – Nimman', '2025-11-07 10:00:00'),
(4, 'Khon Kaen – City', '2025-11-07 13:45:00'),
(5, 'Phuket – Patong', '2025-11-08 08:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `Login_ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varbinary(100) NOT NULL,
  `Status` varchar(50) DEFAULT 'user',
  `User_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`Login_ID`, `Username`, `Password`, `Status`, `User_ID`) VALUES
(100, 'mick01', 0xf417a02f054a11f5e0cde99f518dba8fe1dc5b3a37a19f0dfb34a5d2acd0c1dd, 'admin', 1),
(101, 'pop01', 0x81018792caf3ad6f7882b701494e2fa3c492b4ef60dcef49da20aac2a65198b9, 'seller', 2),
(102, 'ping01', 0x4b7201735c980845dfea505bd3cb694ea4c56c1e378e4be3333f41c4e4342398, 'user', 3),
(103, 'peppo01', 0xbb244c9456c9b934d0d36d541a7314fea0099871163ad97fea85f8139ce4d6c0, 'user', 4),
(104, 'yew01', 0xadca8cafa3caab6e11fb222d68d4c3c09df64864fbad2881ebcf2b9877f020ba, 'user', 5),
(105, 'peppo', 0x243262243133246f6d4d4e4a316941762e4e4c572e4f37336d32466b757957414b654a333439566d76394e70426a3952364f5a736850776445353053, 'admin', 32);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `OrderItem_ID` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Unit_Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`OrderItem_ID`, `Order_ID`, `Product_ID`, `Quantity`, `Unit_Price`) VALUES
(1, 1, 5, 1, '220.00'),
(2, 2, 5, 1, '220.00'),
(3, 3, 5, 1, '220.00'),
(4, 4, 5, 1, '220.00'),
(5, 5, 5, 3, '220.00'),
(6, 6, 5, 1, '220.00'),
(7, 7, 5, 1, '220.00'),
(8, 8, 2, 1, '75.00'),
(9, 9, 5, 1, '220.00'),
(10, 10, 2, 1, '75.00'),
(11, 10, 3, 1, '25.00'),
(12, 10, 4, 1, '165.00'),
(13, 11, 3, 1, '25.00'),
(14, 11, 2, 1, '75.00'),
(15, 11, 1, 1, '189.00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Order_ID` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Order_Subtotal` decimal(10,2) NOT NULL,
  `Delivery_Fee` decimal(10,2) NOT NULL,
  `Order_Total` decimal(10,2) NOT NULL,
  `Full_Name` varchar(255) NOT NULL,
  `Address` text NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Payment_Method` varchar(100) NOT NULL,
  `Order_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Order_ID`, `User_ID`, `Order_Subtotal`, `Delivery_Fee`, `Order_Total`, `Full_Name`, `Address`, `Phone`, `Payment_Method`, `Order_Date`) VALUES
(1, NULL, '220.00', '15.00', '235.00', 'asd', 'Sirindhorn International Institute of Technology', '123', '', '2025-11-16 13:09:27'),
(2, NULL, '220.00', '15.00', '235.00', 'asd', 'Sirindhorn International Institute of Technology', '123', '', '2025-11-16 13:11:04'),
(3, NULL, '220.00', '15.00', '235.00', 'asd', 'Sirindhorn International Institute of Technology', '123', '', '2025-11-16 13:13:29'),
(4, NULL, '220.00', '15.00', '235.00', 'Rangsimann Sattayasrom', 'Sirindhorn International Institute of Technology', '123123123123', '', '2025-11-16 13:28:32'),
(5, NULL, '660.00', '15.00', '675.00', 'Rangsdasd', 'Sirindhorn International Institute of Technology', '123123f', '', '2025-11-16 13:33:27'),
(6, NULL, '220.00', '15.00', '235.00', 'MickAuan', 'Sirindhorn International Institute of Technology', '978345', '', '2025-11-16 13:37:07'),
(7, NULL, '220.00', '15.00', '235.00', 'asd', 'Sirindhorn International Institute of Technology', 'asdasd', '', '2025-11-16 13:39:18'),
(8, NULL, '75.00', '15.00', '90.00', 'asdasd', 'Sirindhorn International Institute of Technology', 'asdasd', '', '2025-11-16 13:42:18'),
(9, NULL, '220.00', '15.00', '235.00', 'Lord Pepsi Coke', 'Sirindhorn International Institute of Technology', '123123123123', '', '2025-11-16 13:58:44'),
(10, 32, '265.00', '15.00', '280.00', 'Ratchanon Wongwitutai', 'อยู่ในใจมิ๊ก', '0985848369', 'Cash', '2025-11-16 22:02:35'),
(11, 32, '289.00', '15.00', '304.00', 'Ratchanon Wongwitutai', 'อยู่ในใจมิ๊ก', '0985848369', 'Cash', '2025-11-16 22:09:34');

-- --------------------------------------------------------

--
-- Table structure for table `order_transaction`
--

CREATE TABLE `order_transaction` (
  `Transaction_ID` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Coupon_ID` int(11) DEFAULT NULL,
  `Payment_Method_ID` int(11) DEFAULT NULL,
  `Order_Date` date DEFAULT NULL,
  `Total_price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_transaction`
--

INSERT INTO `order_transaction` (`Transaction_ID`, `User_ID`, `Coupon_ID`, `Payment_Method_ID`, `Order_Date`, `Total_price`) VALUES
(1, 3, 1, 1, '2025-11-06', '89.00'),
(2, 2, 2, 2, '2025-11-06', '55.00'),
(3, 5, 3, 1, '2025-11-07', '0.00'),
(4, 4, 4, 2, '2025-11-07', '15.00'),
(5, 5, 5, 1, '2025-11-08', '190.00');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `Payment_ID` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `Payment_Method_ID` int(11) NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Status` enum('pending','paid','failed','refunded') NOT NULL DEFAULT 'paid',
  `Paid_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`Payment_ID`, `Order_ID`, `Payment_Method_ID`, `Amount`, `Status`, `Paid_At`) VALUES
(1, 1, 1, '89.00', 'paid', '2025-11-06 09:40:00'),
(2, 2, 2, '55.00', 'paid', '2025-11-06 11:25:00'),
(3, 3, 1, '0.00', 'paid', '2025-11-07 10:10:00'),
(4, 4, 2, '15.00', 'paid', '2025-11-07 13:55:00'),
(5, 5, 1, '190.00', 'paid', '2025-11-08 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `payment_card_detail`
--

CREATE TABLE `payment_card_detail` (
  `Payment_ID` int(11) NOT NULL,
  `Card_Number` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_card_detail`
--

INSERT INTO `payment_card_detail` (`Payment_ID`, `Card_Number`) VALUES
(2, '5544332211998877'),
(4, '4111111111111111');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `Payment_Method_ID` int(11) NOT NULL,
  `Method_Type` enum('Cash','Credit_card') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`Payment_Method_ID`, `Method_Type`) VALUES
(1, 'Cash'),
(2, 'Credit_card');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Product_ID` int(11) NOT NULL,
  `Product_Name` varchar(100) NOT NULL,
  `Product_Price` decimal(10,2) NOT NULL,
  `Length` decimal(5,2) DEFAULT NULL,
  `Height` decimal(5,2) DEFAULT NULL,
  `Width` decimal(5,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Product_ID`, `Product_Name`, `Product_Price`, `Length`, `Height`, `Width`, `image`) VALUES
(1, 'Thai Jasmine Rice 5kg', '189.00', '40.00', '10.00', '30.00', NULL),
(2, 'Cage-Free Eggs (10 pcs)', '75.00', '30.00', '8.00', '20.00', NULL),
(3, 'Morning Glory (Pak Boong) 500g', '25.00', '35.00', '5.00', '10.00', NULL),
(4, 'Pork Loin 1kg', '165.00', '25.00', '8.00', '15.00', NULL),
(5, 'Seabass Cleaned 800g', '220.00', '30.00', '8.00', '12.00', NULL),
(8, 'John', '150.00', '50.00', '50.00', '50.00', 'paimeung tai'),
(9, 'Mick', '999999.00', '50.00', '170.00', '500.00', 'paimeung tai');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `Review_No` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Review_date` datetime DEFAULT NULL,
  `Review_text` text,
  `Rating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`Review_No`, `User_ID`, `Review_date`, `Review_text`, `Rating`) VALUES
(1, 3, '2025-11-06 10:05:00', 'Rice is fragrant and fresh. Good price.', 5),
(2, 2, '2025-11-06 12:00:00', 'Eggs were intact and very fresh.', 4),
(3, 5, '2025-11-07 10:30:00', 'Crisp morning glory, perfect for stir-fry.', 5),
(4, 4, '2025-11-07 14:10:00', 'Pork loin was clean and tender.', 5),
(5, 5, '2025-11-08 09:20:00', 'Seabass was fresh; would buy again.', 4),
(6, NULL, '2025-11-16 13:51:05', 'Mick Auan', 5),
(7, NULL, '2025-11-16 13:58:51', 'Mick Auan mak', 1),
(8, NULL, '2025-11-16 22:09:42', 'haha xd', 3);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID` int(11) NOT NULL,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `Fname`, `Lname`, `Address`, `DOB`, `Email`, `PhoneNumber`) VALUES
(1, 'Mick', 'Wolff', 'Bangkok', '2001-05-14', 'mick@example.com', NULL),
(2, 'Pop', 'Chan', 'Chiang Mai', '2000-11-22', 'pop@example.com', NULL),
(3, 'Ping', 'LeeFam', 'Phuket', '2002-03-08', 'ping@example.com', NULL),
(4, 'Peppo', 'Rob', 'Khon Kaen', '1999-12-05', 'peppo@example.com', NULL),
(5, 'Yew', 'Tia', 'Tak', '2003-06-15', 'yew@example.com', NULL),
(32, 'Ratchanon', 'Wongwitutai', 'อยู่ในใจมิ๊ก', '2025-10-29', '6622780268@ggez', '0985848369');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cash`
--
ALTER TABLE `cash`
  ADD PRIMARY KEY (`Payment_Method_ID`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`Coupon_ID`);

--
-- Indexes for table `credit_card`
--
ALTER TABLE `credit_card`
  ADD PRIMARY KEY (`Payment_Method_ID`);

--
-- Indexes for table `deliver`
--
ALTER TABLE `deliver`
  ADD PRIMARY KEY (`Delivery_ID`,`Product_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`Delivery_ID`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`Login_ID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD KEY `fk_login_user` (`User_ID`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`OrderItem_ID`),
  ADD KEY `Order_ID` (`Order_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Order_ID`);

--
-- Indexes for table `order_transaction`
--
ALTER TABLE `order_transaction`
  ADD PRIMARY KEY (`Transaction_ID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Coupon_ID` (`Coupon_ID`),
  ADD KEY `Payment_Method_ID` (`Payment_Method_ID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `idx_payment_order` (`Order_ID`),
  ADD KEY `idx_payment_method` (`Payment_Method_ID`);

--
-- Indexes for table `payment_card_detail`
--
ALTER TABLE `payment_card_detail`
  ADD PRIMARY KEY (`Payment_ID`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`Payment_Method_ID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`Review_No`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
  MODIFY `Coupon_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `Delivery_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `Login_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `OrderItem_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_transaction`
--
ALTER TABLE `order_transaction`
  MODIFY `Transaction_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `Payment_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `Payment_Method_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `Review_No` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cash`
--
ALTER TABLE `cash`
  ADD CONSTRAINT `cash_ibfk_1` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `payment_method` (`Payment_Method_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `credit_card`
--
ALTER TABLE `credit_card`
  ADD CONSTRAINT `credit_card_ibfk_1` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `payment_method` (`Payment_Method_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deliver`
--
ALTER TABLE `deliver`
  ADD CONSTRAINT `deliver_ibfk_1` FOREIGN KEY (`Delivery_ID`) REFERENCES `delivery` (`Delivery_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliver_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `fk_login_user` FOREIGN KEY (`User_ID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`);

--
-- Constraints for table `order_transaction`
--
ALTER TABLE `order_transaction`
  ADD CONSTRAINT `order_transaction_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_transaction_ibfk_2` FOREIGN KEY (`Coupon_ID`) REFERENCES `coupon` (`Coupon_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_transaction_ibfk_3` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `payment_method` (`Payment_Method_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `payment_method` (`Payment_Method_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_order` FOREIGN KEY (`Order_ID`) REFERENCES `order_transaction` (`Transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_card_detail`
--
ALTER TABLE `payment_card_detail`
  ADD CONSTRAINT `fk_pc_payment` FOREIGN KEY (`Payment_ID`) REFERENCES `payment` (`Payment_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
