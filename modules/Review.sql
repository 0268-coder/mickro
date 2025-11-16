
CREATE TABLE IF NOT EXISTS `Review` (
  `Review_No` int NOT NULL AUTO_INCREMENT,
  `Product_ID` int DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  `Review_date` datetime DEFAULT NULL,
  `Review_text` text,
  `Rating` int DEFAULT NULL,
  PRIMARY KEY (`Review_No`),
  KEY `Product_ID` (`Product_ID`),
  KEY `User_ID` (`User_ID`)
);

INSERT INTO `Review` (`Review_No`, `Product_ID`, `User_ID`, `Review_date`, `Review_text`, `Rating`) VALUES
(1, 1, 3, '2025-11-06 10:05:00', 'Rice is fragrant and fresh. Good price.', 5),
(2, 2, 2, '2025-11-06 12:00:00', 'Eggs were intact and very fresh.', 4),
(3, 3, 5, '2025-11-07 10:30:00', 'Crisp morning glory, perfect for stir-fry.', 5),
(4, 4, 4, '2025-11-07 14:10:00', 'Pork loin was clean and tender.', 5),
(5, 5, 5, '2025-11-08 09:20:00', 'Seabass was fresh; would buy again.', 4),
(6, 1, 3, '2025-11-07 11:17:26', 'Very tasty rice!', 5),
(7, 1, 3, '2025-11-07 11:25:55', 'not good but not bad rice!', 3),
(8, 3, 4, '2025-11-07 11:38:42', 'Fresh and high quality!', 4);

DELIMITER $$
CREATE TRIGGER `update_product_rating` AFTER INSERT ON `Review` FOR EACH ROW BEGIN
  DECLARE avg_rating DECIMAL(3,2);

  -- calculate the new average rating for this product
  SELECT AVG(Rating)
  INTO avg_rating
  FROM Review
  WHERE Product_ID = NEW.Product_ID;

  -- update the product table with the new average
  UPDATE Product
  SET Avg_Rating = avg_rating
  WHERE Product_ID = NEW.Product_ID;
END
$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `update_product_rating_after_update` AFTER UPDATE ON `Review` FOR EACH ROW BEGIN
    DECLARE avg_rating DECIMAL(3,2);

    -- calculate the new average rating for this product
    SELECT AVG(Rating)
    INTO avg_rating
    FROM Review
    WHERE Product_ID = NEW.Product_ID;

    -- update product table with new average
    UPDATE Product
    SET Avg_Rating = avg_rating
    WHERE Product_ID = NEW.Product_ID;
END
$$
DELIMITER ;

ALTER TABLE `Review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `User` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;