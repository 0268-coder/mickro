-- 1. Create the user matching your .env (DB_STAFFUSER)
CREATE USER IF NOT EXISTS 'app_staff'@'localhost' IDENTIFIED BY 'Staff123!';

-- 2. Grant Basic Usage
GRANT USAGE ON . TO 'app_staff'@'localhost';

-- 3. Grant Read Access (SELECT) to the WHOLE database
GRANT SELECT ON micro-8.3.* TO 'app_staff'@'localhost';

-- 4. Grant Specific Write Permissions (INSERT, UPDATE, DELETE)
-- Focusing only on micro-8.3 tables:

GRANT INSERT, UPDATE ON micro-8.3.login TO 'app_staff'@'localhost';

GRANT INSERT ON micro-8.3.orderitems TO 'app_staff'@'localhost';

GRANT INSERT ON micro-8.3.orders TO 'app_staff'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON micro-8.3.product TO 'app_staff'@'localhost';

GRANT INSERT ON micro-8.3.review TO 'app_staff'@'localhost';

GRANT INSERT, UPDATE ON micro-8.3.user TO 'app_staff'@'localhost';

-- 5. Save Changes
FLUSH PRIVILEGES;