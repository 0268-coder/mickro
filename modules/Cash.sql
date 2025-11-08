CREATE TABLE IF NOT EXISTS `Cash` (
  `Payment_Method_ID` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Payment_Method_ID`)
);

INSERT INTO `Cash` (`Payment_Method_ID`, `amount`) VALUES
(1, 0.00);

ALTER TABLE `Cash`
  ADD CONSTRAINT `cash_ibfk_1` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE CASCADE ON UPDATE CASCADE;