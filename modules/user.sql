-- 1. Create the user matching your .env (DB_USER)
CREATE USER IF NOT EXISTS 'app_user'@'localhost' IDENTIFIED BY 'User123!';

-- 2. Grant Basic Usage
GRANT USAGE ON . TO 'app_user'@'localhost';

-- 3. Grant Read Access (SELECT) to the WHOLE database
-- This allows the user to view Products, Payment Methods, etc.
GRANT SELECT ON micro-8.3.* TO 'app_user'@'localhost';

-- 4. Grant Specific Write Permissions (INSERT, UPDATE)
-- Focusing only on micro-8.3 tables:

GRANT INSERT, UPDATE ON micro-8.3.login TO 'app_user'@'localhost';

GRANT INSERT ON micro-8.3.orderitems TO 'app_user'@'localhost';

GRANT INSERT ON micro-8.3.orders TO 'app_user'@'localhost';

GRANT INSERT ON micro-8.3.review TO 'app_user'@'localhost';

GRANT INSERT, UPDATE ON micro-8.3.user TO 'app_user'@'localhost';

GRANT EXECUTE ON PROCEDURE micro-8.3.register_new_user TO 'app_user'@'localhost';

-- 5. Save Changes
FLUSH PRIVILEGES;