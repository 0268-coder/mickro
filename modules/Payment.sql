CREATE TABLE IF NOT EXISTS `Payment` (
  `Payment_ID` int NOT NULL AUTO_INCREMENT,
  `Order_ID` int NOT NULL,
  `Payment_Method_ID` int NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Status` enum('pending','paid','failed','refunded') NOT NULL DEFAULT 'paid',
  `Paid_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Payment_ID`),
  KEY `idx_payment_order` (`Order_ID`),
  KEY `idx_payment_method` (`Payment_Method_ID`)
);

INSERT INTO `Payment` (`Payment_ID`, `Order_ID`, `Payment_Method_ID`, `Amount`, `Status`, `Paid_At`) VALUES
(1, 1, 1, 89.00, 'paid', '2025-11-06 09:40:00'),
(2, 2, 2, 55.00, 'paid', '2025-11-06 11:25:00'),
(3, 3, 1, 0.00, 'paid', '2025-11-07 10:10:00'),
(4, 4, 2, 15.00, 'paid', '2025-11-07 13:55:00'),
(5, 5, 1, 190.00, 'paid', '2025-11-08 09:00:00');

ALTER TABLE `Payment`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`Payment_Method_ID`) REFERENCES `Payment_Method` (`Payment_Method_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_order` FOREIGN KEY (`Order_ID`) REFERENCES `Order_Transaction` (`Transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
