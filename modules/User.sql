CREATE TABLE IF NOT EXISTS `User` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email` (`Email`)
);

INSERT INTO `User` (`ID`, `Fname`, `Lname`, `Address`, `DOB`, `Email`) VALUES
(1, 'Mick', 'Wolff', 'Bangkok', '2001-05-14', 'mick@example.com'),
(2, 'Pop', 'Chan', 'Chiang Mai', '2000-11-22', 'pop@example.com'),
(3, 'Ping', 'LeeFam', 'Phuket', '2002-03-08', 'ping@example.com'),
(4, 'Peppo', 'Rob', 'Khon Kaen', '1999-12-05', 'peppo@example.com'),
(5, 'Yew', 'Tia', 'Tak', '2003-06-15', 'yew@example.com');