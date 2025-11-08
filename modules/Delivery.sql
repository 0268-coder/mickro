CREATE TABLE IF NOT EXISTS `Delivery` (
  `Delivery_ID` int NOT NULL AUTO_INCREMENT,
  `Delivery_address` varchar(255) DEFAULT NULL,
  `Delivered_time` datetime DEFAULT NULL,
  PRIMARY KEY (`Delivery_ID`)
);

INSERT INTO `Delivery` (`Delivery_ID`, `Delivery_address`, `Delivered_time`) VALUES
(1, 'Bangkok – Chatuchak', '2025-11-06 09:30:00'),
(2, 'Bangkok – Thonglor', '2025-11-06 11:15:00'),
(3, 'Chiang Mai – Nimman', '2025-11-07 10:00:00'),
(4, 'Khon Kaen – City', '2025-11-07 13:45:00'),
(5, 'Phuket – Patong', '2025-11-08 08:50:00');