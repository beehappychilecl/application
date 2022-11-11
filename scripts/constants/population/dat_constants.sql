truncate dat_constants cascade;

insert into dat_constants (idf_constant, txt_key, txt_value) values
(1001, 'website_landing', 'https://beehappychile.cl'),
(1002, 'website_staff', 'https://beehappychile.cl/staff/'),
(1003, 'timezone_difference', '-3'),
(1004, 'maintenance_mode', false),
(1011, 'deploy_datetime', null),
(1012, 'deploy_version', null),
(1021, 'sales_mail', 'hola@beehappychile.cl'),
(1022, 'sales_number', '+56 9 7800 8001'),
(1023, 'support_information', 'soporte@beehappychile.atlassian.com')
;