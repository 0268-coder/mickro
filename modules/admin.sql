-- Create the user defined in your .env
CREATE USER IF NOT EXISTS 'app_admin'@'localhost' IDENTIFIED BY 'Admin123!';

-- Grant Usage
GRANT USAGE ON . TO 'app_admin'@'localhost';

-- Grant Read Access to the whole database
GRANT SELECT ON micro-8.3.* TO 'app_admin'@'localhost';

-- Grant Write Permissions (Consolidated)
GRANT INSERT, UPDATE ON micro-8.3.login TO 'app_admin'@'localhost';
GRANT INSERT ON micro-8.3.orderitems TO 'app_admin'@'localhost';
GRANT INSERT ON micro-8.3.orders TO 'app_admin'@'localhost';
GRANT INSERT, UPDATE, DELETE ON micro-8.3.payment_method TO 'app_admin'@'localhost';
GRANT INSERT, UPDATE, DELETE ON micro-8.3.product TO 'app_admin'@'localhost';
GRANT INSERT ON micro-8.3.review TO 'app_admin'@'localhost';
GRANT INSERT, UPDATE ON micro-8.3.user TO 'app_admin'@'localhost';

-- Save
FLUSH PRIVILEGES;