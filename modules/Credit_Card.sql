CREATE TABLE IF NOT EXISTS `Credit_Card` (
  `Payment_Method_ID` int NOT NULL,
  `Card_Number` varchar(16) NOT NULL,
  PRIMARY KEY (`Payment_Method_ID`)
);

ALTER TABLE `Credit_Card`
  ADD CONSTRAINT `credit_card_ibfk_1` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE CASCADE ON UPDATE CASCADE;


INSERT INTO `Credit_Card` (`Payment_Method_ID`, `Card_Number`) VALUES
(2, '1111222233334444');