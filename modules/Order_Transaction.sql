CREATE TABLE IF NOT EXISTS `Order_Transaction` (
  `Transaction_ID` int NOT NULL,
  `User_ID` int DEFAULT NULL,
  `Coupon_ID` int DEFAULT NULL,
  `Payment_Method_ID` int DEFAULT NULL,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `Total_price` decimal(10,2) DEFAULT NULL
);

INSERT INTO `Order_Transaction` (`Transaction_ID`, `User_ID`, `Coupon_ID`, `Payment_Method_ID`, `Total_price`) VALUES
(1, 3, NULL, 1, 89.00),
(2, 2, NULL, 2, 55.00),
(3, 5, NULL, 1, 0.00),
(4, 4, NULL, 2, 15.00),
(5, 5, NULL, 1, 190.00);