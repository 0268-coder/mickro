CREATE TABLE IF NOT EXISTS `Claim` (
  `User_ID` int NOT NULL,
  `Coupon_ID` int NOT NULL,
  `time_used` int DEFAULT NULL,
  PRIMARY KEY (`User_ID`,`Coupon_ID`),
  KEY `Coupon_ID` (`Coupon_ID`)
);



INSERT INTO `Claim` (`User_ID`, `Coupon_ID`, `time_used`) VALUES
(2, 2, 2),
(3, 1, 1),
(4, 4, 1),
(5, 3, 1),
(5, 5, 1);

ALTER TABLE `Claim`
  ADD CONSTRAINT `claim_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `claim_ibfk_2` FOREIGN KEY (`Coupon_ID`) REFERENCES `Coupon` (`Coupon_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
