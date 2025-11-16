CREATE TABLE IF NOT EXISTS `Coupon` (
  `Coupon_ID` int NOT NULL AUTO_INCREMENT,
  `Coupon_Name` varchar(50) NOT NULL,
  `Discount_Value` int NOT NULL,
  PRIMARY KEY (`Coupon_ID`)
);

INSERT INTO `Coupon` (`Coupon_ID`, `Coupon_Name`, `Discount_Value`) VALUES
(1, 'FRESH100', 100),
(2, 'VEG20', 20),
(3, 'SEAFOOD50', 50),
(4, 'NEWBASKET150', 150),
(5, 'FREEDELIVERY', 30);