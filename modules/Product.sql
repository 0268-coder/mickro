
CREATE TABLE `Product` (
  `Product_ID` int NOT NULL,
  `Product_Name` varchar(100) NOT NULL,
  `Product_Price` decimal(10,2) NOT NULL,
  `Length` decimal(5,2) DEFAULT NULL,
  `Height` decimal(5,2) DEFAULT NULL,
  `Width` decimal(5,2) DEFAULT NULL
);

INSERT INTO `Product` (`Product_ID`, `Product_Name`, `Product_Price`, `Length`, `Height`, `Width`) VALUES
(1, 'Thai Jasmine Rice 5kg', 189.00, 40.00, 10.00, 30.00),
(2, 'Cage-Free Eggs (10 pcs)', 75.00, 30.00, 8.00, 20.00),
(3, 'Morning Glory (Pak Boong) 500g', 25.00, 35.00, 5.00, 10.00),
(4, 'Pork Loin 1kg', 165.00, 25.00, 8.00, 15.00),
(5, 'Seabass Cleaned 800g', 220.00, 30.00, 8.00, 12.00);