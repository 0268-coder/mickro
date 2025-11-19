-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 19, 2025 at 03:55 PM
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
-- Database: `micro-8.3`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_new_user` (IN `p_username` VARCHAR(50), IN `p_password` VARCHAR(255), IN `p_fname` VARCHAR(50), IN `p_lname` VARCHAR(50), IN `p_email` VARCHAR(255), IN `p_phoneNumber` VARCHAR(20), IN `p_dateOfBirth` DATE, IN `p_address` VARCHAR(255))   BEGIN
    DECLARE v_user_id INT;

    -- 1) Insert personal info into user table
    INSERT INTO user (Fname, Lname, Email, PhoneNumber, DOB, Address)
    VALUES (p_fname, p_lname, p_email, p_phoneNumber, p_dateOfBirth, p_address);

    SET v_user_id = LAST_INSERT_ID();

    -- 2) Insert login with hashed password into login table
    -- NOTE: This uses SHA-256 at DB level. Make sure login.Password is VARBINARY(32) or similar.
    INSERT INTO login (Username, Password, Status, User_ID)
    VALUES (
        p_username,
        p_password,  -- hash password
        'user',
        v_user_id
    );
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `Login_ID` int NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varbinary(100) NOT NULL,
  `Status` varchar(50) DEFAULT 'user',
  `User_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`Login_ID`, `Username`, `Password`, `Status`, `User_ID`) VALUES
(100, 'mick01', 0xf417a02f054a11f5e0cde99f518dba8fe1dc5b3a37a19f0dfb34a5d2acd0c1dd, 'admin', 1),
(101, 'pop01', 0x81018792caf3ad6f7882b701494e2fa3c492b4ef60dcef49da20aac2a65198b9, 'seller', 2),
(102, 'ping01', 0x4b7201735c980845dfea505bd3cb694ea4c56c1e378e4be3333f41c4e4342398, 'user', 3),
(103, 'peppo01', 0xbb244c9456c9b934d0d36d541a7314fea0099871163ad97fea85f8139ce4d6c0, 'user', 4),
(104, 'yew01', 0xadca8cafa3caab6e11fb222d68d4c3c09df64864fbad2881ebcf2b9877f020ba, 'user', 5),
(105, 'peppo', 0x243262243133246f6d4d4e4a316941762e4e4c572e4f37336d32466b757957414b654a333439566d76394e70426a3952364f5a736850776445353053, 'admin', 32),
(106, 'MW', 0x2432622431332439454d32376f78484c6e6456712e6f4649587861636547655a6636416c3952695077773548456c72706c4e6258797732457a356965, 'user', 33),
(107, 'sixty', 0x243262243133246376623931334f626a6d6a5a2f50614b4a412f337a755a6e5a375a7353776376614e797771664e6978394a4d777a39456b63434b79, 'user', 34);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `OrderItem_ID` bigint NOT NULL,
  `Order_ID` bigint NOT NULL,
  `Product_ID` int NOT NULL,
  `Quantity` int NOT NULL,
  `Unit_Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`OrderItem_ID`, `Order_ID`, `Product_ID`, `Quantity`, `Unit_Price`) VALUES
(1, 1, 2, 11, 75.00);

--
-- Triggers `orderitems`
--
DELIMITER $$
CREATE TRIGGER `trg_orderitems_after_insert_update_totals` AFTER INSERT ON `orderitems` FOR EACH ROW BEGIN
    DECLARE v_subtotal DECIMAL(10,2);

    -- Calculate subtotal
    SELECT SUM(Quantity * Unit_Price)
    INTO v_subtotal
    FROM orderitems
    WHERE Order_ID = NEW.Order_ID;

    IF v_subtotal IS NULL THEN 
        SET v_subtotal = 0;
    END IF;

    -- Update the orders table
    UPDATE orders
    SET 
        Order_Subtotal = v_subtotal,
        Order_Total = v_subtotal + Delivery_Fee
    WHERE Order_ID = NEW.Order_ID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Order_ID` bigint NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Order_Subtotal` decimal(10,2) NOT NULL,
  `Delivery_Fee` decimal(10,2) NOT NULL,
  `Order_Total` decimal(10,2) NOT NULL,
  `Full_Name` varchar(255) NOT NULL,
  `Address` text NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Payment_Method` int NOT NULL,
  `Order_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Order_ID`, `User_ID`, `Order_Subtotal`, `Delivery_Fee`, `Order_Total`, `Full_Name`, `Address`, `Phone`, `Payment_Method`, `Order_Date`) VALUES
(1, 33, 825.00, 15.00, 840.00, 'Phinnawat Yaemsanguan', 'KUY', '0661427227', 2, '2025-11-19 22:38:35');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `Payment_Method_ID` int NOT NULL,
  `Method_Type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Cash'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `Product_ID` int NOT NULL,
  `Product_Name` varchar(100) NOT NULL,
  `Product_Price` decimal(10,2) NOT NULL,
  `Length` decimal(5,2) DEFAULT NULL,
  `Height` decimal(5,2) DEFAULT NULL,
  `Width` decimal(5,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Product_ID`, `Product_Name`, `Product_Price`, `Length`, `Height`, `Width`, `image`) VALUES
(1, 'Thai Jasmine Rice 5kg', 189.00, 40.00, 10.00, 30.00, 'images/product/1.png'),
(2, 'Cage-Free Eggs (10 pcs)', 75.00, 30.00, 8.00, 20.00, 'images/product/2.png'),
(3, 'Morning Glory (Pak Boong) 500g', 25.00, 35.00, 5.00, 10.00, 'images/product/3.png'),
(4, 'Pork Loin 1kg', 165.00, 25.00, 8.00, 15.00, 'images/product/4.png'),
(5, 'Seabass Cleaned 800g', 220.00, 30.00, 8.00, 12.00, 'images/product/product.5.jpeg'),
(6, 'mick', 999999.00, 1.00, 1.00, 100.00, 'images/product/product.6.JPG'),
(7, 'jhbkn', 99.00, 0.05, 0.02, 0.02, 'images/product/image-1763526860919-587701839.jpeg'),
(8, 'jhgkhj', 777.00, 0.02, 0.02, 0.02, 'images/product/image-1763527050793-363785141.png'),
(9, '3rrgne23ngop23', 111.00, 9.00, 9.00, 9.00, 'images/product/product.9.jpg'),
(10, 'mick secret', 12345.00, 2.00, 3.00, 4.00, 'images/product/image-1763567561723-134831359.png');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `Review_No` int NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Review_date` datetime DEFAULT NULL,
  `Review_text` text,
  `Rating` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(8, NULL, '2025-11-16 22:09:42', 'haha xd', 3),
(9, NULL, '2025-11-17 12:05:00', '', 5),
(10, NULL, '2025-11-17 13:11:57', 'diocweoc;ioevqiovqb;vui kuy', 4),
(11, NULL, '2025-11-17 21:51:18', '', 3),
(12, NULL, '2025-11-17 22:10:44', 'kuy', 5),
(13, NULL, '2025-11-17 22:27:26', 'qwbfuclibDevf;ueDB:VUbpwe heheheh', 5),
(14, NULL, '2025-11-17 22:33:12', 'anewqcnopqwj[wqjf[oqwjp[qfwj', 5),
(15, NULL, '2025-11-18 11:50:05', '', 5),
(16, NULL, '2025-11-18 13:36:56', 'dee makk', 5),
(17, 33, '2025-11-19 11:01:30', '12345', 4),
(18, 32, '2025-11-19 11:05:47', 'ljhldtaeszdfghujikol', 4),
(19, 33, '2025-11-19 11:14:44', 'hee kuy tad', 1),
(20, 33, '2025-11-19 11:43:12', '12rtyhgfdgkxsdkyildliyxy', 3),
(21, 33, '2025-11-19 12:03:37', '', 5),
(22, 33, '2025-11-19 22:38:45', 'emfpofmneopnf2opn3opfn2opnfop32nfop23nfnop23f', 5);

--
-- Triggers `review`
--
DELIMITER $$
CREATE TRIGGER `trg_review_before_insert_set_date` BEFORE INSERT ON `review` FOR EACH ROW BEGIN
    IF NEW.Review_Date IS NULL THEN
        SET NEW.Review_Date = NOW();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID` int NOT NULL,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `Fname`, `Lname`, `Address`, `DOB`, `Email`, `PhoneNumber`) VALUES
(1, 'Mick', 'Wolff', 'Bangkok', '2001-05-14', 'mick@example.com', NULL),
(2, 'Pop', 'Chan', 'Chiang Mai', '2000-11-22', 'pop@example.com', NULL),
(3, 'Ping', 'LeeFam', 'Phuket', '2002-03-08', 'ping@example.com', NULL),
(4, 'Peppo', 'Rob', 'Khon Kaen', '1999-12-05', 'peppo@example.com', NULL),
(5, 'Yew', 'Tia', 'Tak', '2003-06-15', 'yew@example.com', NULL),
(32, 'Ratchanon', 'Wongwitutai', 'อยู่ในใจมิ๊ก', '2025-10-29', '6622780268@ggez', '0985848369'),
(33, 'Mick', 'Wolff', 'KUY', '2025-10-26', 'MW@gmail.cum', '0999999999'),
(34, 'fourty', 'fifty', 'siit', '2025-11-05', 'seventy@gmail.com', '0987654432');

--
-- Indexes for dumped tables
--

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
  ADD PRIMARY KEY (`Order_ID`),
  ADD KEY `fk_orders_user` (`User_ID`),
  ADD KEY `Payment_Method` (`Payment_Method`);

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
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `Login_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `OrderItem_ID` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `Payment_Method_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Product_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `Review_No` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `fk_login_user` FOREIGN KEY (`User_ID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`),
  ADD CONSTRAINT `orderitems_ibfk_3` FOREIGN KEY (`OrderItem_ID`) REFERENCES `orders` (`Order_ID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`User_ID`) REFERENCES `user` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Payment_Method`) REFERENCES `payment_method` (`Payment_Method_ID`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
