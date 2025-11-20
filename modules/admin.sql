GRANT USAGE ON *.* TO `app_admin`@`localhost`;

GRANT SELECT ON `micro-8.3`.* TO `app_admin`@`localhost`;

GRANT SELECT, INSERT, UPDATE ON `micro-8.2`.`login` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT ON `micro-8.2`.`orderitems` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT ON `micro-8.2`.`orders` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT, UPDATE, DELETE ON `micro-8.2`.`payment_method` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT, UPDATE, DELETE ON `micro-8.2`.`product` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT ON `micro-8.2`.`review` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT, UPDATE ON `micro-8.2`.`user` TO `app_admin`@`localhost`;

GRANT INSERT, UPDATE ON `micro-8.3`.`login` TO `app_admin`@`localhost`;

GRANT INSERT ON `micro-8.3`.`orderitems` TO `app_admin`@`localhost`;

GRANT INSERT ON `micro-8.3`.`orders` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT, UPDATE, DELETE ON `micro-8.3`.`payment_method` TO `app_admin`@`localhost`;

GRANT SELECT, INSERT, UPDATE, DELETE ON `micro-8.3`.`product` TO `app_admin`@`localhost`;

GRANT INSERT ON `micro-8.3`.`review` TO `app_admin`@`localhost`;

GRANT INSERT, UPDATE ON `micro-8.3`.`user` TO `app_admin`@`localhost`;