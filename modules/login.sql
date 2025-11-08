CREATE TABLE IF NOT EXISTS `Login` (
  `Login_ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varbinary(100) NOT NULL,
  `Status` varchar(50) DEFAULT 'user',
  `User_ID` int DEFAULT NULL,
  PRIMARY KEY (`Login_ID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `fk_login_user` (`User_ID`)
);

INSERT INTO `Login` (`Login_ID`, `Username`, `Password`, `Status`, `User_ID`) VALUES
(100, 'mick01', 0xf417a02f054a11f5e0cde99f518dba8fe1dc5b3a37a19f0dfb34a5d2acd0c1dd, 'admin', 1),
(101, 'pop01', 0x81018792caf3ad6f7882b701494e2fa3c492b4ef60dcef49da20aac2a65198b9, 'seller', 2),
(102, 'ping01', 0x4b7201735c980845dfea505bd3cb694ea4c56c1e378e4be3333f41c4e4342398, 'user', 3),
(103, 'peppo01', 0xbb244c9456c9b934d0d36d541a7314fea0099871163ad97fea85f8139ce4d6c0, 'user', 4),
(104, 'yew01', 0xadca8cafa3caab6e11fb222d68d4c3c09df64864fbad2881ebcf2b9877f020ba, 'user', 5);

ALTER TABLE `Login`
  ADD CONSTRAINT `fk_login_user` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
