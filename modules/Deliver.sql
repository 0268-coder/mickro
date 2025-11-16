CREATE TABLE IF NOT EXISTS `Deliver` (
  `Delivery_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  PRIMARY KEY (`Delivery_ID`,`Product_ID`),
  KEY `Product_ID` (`Product_ID`)
);

INSERT INTO `Deliver` (`Delivery_ID`, `Product_ID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

ALTER TABLE `Deliver`
  ADD CONSTRAINT `deliver_ibfk_1` FOREIGN KEY (`Delivery_ID`) REFERENCES `Delivery` (`Delivery_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliver_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
