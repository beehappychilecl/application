truncate dat_organizations cascade;

insert into dat_organizations (sys_user, idf_organization, txt_organization, num_unique_rol, txt_check_digit, txt_address, idf_country, idf_region, idf_province, idf_commune, num_postal_code, txt_location) values
(0, 1001, 'Comunidad Bee', 50111555, 'K', 'Avenida Las Abejas 9900', 56, 13, 131, 13120, 7750000, 'https://goo.gl/maps/JkZQ6csGbzi2zEix7'),
(0, 1002, 'Edificios Happy', 50222666, '5', 'Avenida De La Felicidad 8877', 56, 13, 131, 13120, 7750000, 'https://goo.gl/maps/JkZQ6csGbzi2zEix7'),
(0, 1003, 'Comunidad Tranquila', 50333777, '0', 'Calle Tranquilidad 6655', 56, 13, 131, 13120, 7750000, 'https://goo.gl/maps/JkZQ6csGbzi2zEix7'),
(0, 1004, 'Condominio Feliz', 50444888, '6', 'Calle Tranquilidad 4433', 56, 13, 131, 13120, 7750000, 'https://goo.gl/maps/JkZQ6csGbzi2zEix7');