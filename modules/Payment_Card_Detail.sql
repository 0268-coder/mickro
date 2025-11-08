CREATE TABLE IF NOT EXISTS `Payment_Card_Detail` (
  `Payment_ID` int NOT NULL,
  `Card_Number` varchar(16) NOT NULL,
  PRIMARY KEY (`Payment_ID`)
);

INSERT INTO `Payment_Card_Detail` (`Payment_ID`, `Card_Number`) VALUES
(2, '5544332211998877'),
(4, '4111111111111111');

ALTER TABLE `Payment_Card_Detail`
  ADD CONSTRAINT `fk_pc_payment` FOREIGN KEY (`Payment_ID`) REFERENCES `Payment` (`Payment_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
