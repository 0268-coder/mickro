CREATE TABLE IF NOT EXISTS `Order_Transaction` (
  `Transaction_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int DEFAULT NULL,
  `Coupon_ID` int DEFAULT NULL,
  `Payment_Method_ID` int DEFAULT NULL,
  `Order_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `Total_price` decimal(10,2) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Pending',
  PRIMARY KEY (`Transaction_ID`),
  KEY `User_ID` (`User_ID`),
  KEY `Coupon_ID` (`Coupon_ID`),
  KEY `Payment_Method_ID` (`Payment_Method_ID`)
);

INSERT INTO `Order_Transaction` (`Transaction_ID`, `User_ID`, `Coupon_ID`, `Payment_Method_ID`, `Order_Date`, `Total_price`, `Status`) VALUES
(1, 3, 1, 1, '2025-11-07 12:00:03', 89.00, 'Pending'),
(2, 2, 2, 2, '2025-11-07 12:00:03', 55.00, 'Pending'),
(3, 5, 3, 1, '2025-11-07 12:00:03', 0.00, 'Delivered'),
(4, 4, 4, 2, '2025-11-07 12:00:03', 15.00, 'Pending'),
(5, 5, 5, 1, '2025-11-07 12:00:03', 190.00, 'Pending'),
(6, 3, 3, 1, '2025-11-07 12:02:58', 89.00, 'Pending');

ALTER TABLE `Order_Transaction`
  ADD CONSTRAINT `order_transaction_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_transaction_ibfk_2` FOREIGN KEY (`Coupon_ID`) REFERENCES `Coupon` (`Coupon_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_transaction_ibfk_3` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE SET NULL ON UPDATE CASCADE;
