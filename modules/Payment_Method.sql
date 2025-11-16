CREATE TABLE IF NOT EXISTS `Payment_Method` (
  `Payment_Method_ID` int NOT NULL AUTO_INCREMENT,
  `Method_Type` enum('Cash','Credit_card') NOT NULL,
  PRIMARY KEY (`Payment_Method_ID`)
);

INSERT INTO `Payment_Method` (`Payment_Method_ID`, `Method_Type`) VALUES
(1, 'Cash'),
(2, 'Credit_card');