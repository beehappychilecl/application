truncate dat_expressions cascade;

insert into dat_expressions (idf_expression, txt_expression) values
(0, '*BeeBee (Asistente Virtual)*'),

(1010, 'Hola%0! soy BeeBee, tu asistente virtual, en que te ayudo?'),
(1010, 'Hola%0, como estas? Soy BeeBee, puedo ayudarte en algo?'),
(1010, 'Como estas%0? Como puedo ayudarte hoy dia?'),
(1010, 'Todo bien%0? Mi nombre es BeeBee, y estoy aca para ayudarte'),

(1020, 'Si%0!!! Asi me llamo, en que te puedo ayudar?'),
(1020, 'Esa soy yo, y estoy aca para ayudarte. Dime%0?'),
(1020, 'Me gusta que me llamen por mi nombre!!! En que te ayudo%0?'),

(1030, 'Hola%0, puedo ayudarte con esto:'),
(1030, 'Hola%0, creo que podria asesorarte con:'),
(1030, 'Sabes%0?, puedo ayudarte con esto:'),
(1030, 'Tal vez%0, podria servirte esto:'),

(1040, 'Para eso estamos! Que tengas un buen dia!'),
(1040, 'Espero haberte ayudado, disfruta lo que queda de dia!'),
(1040, 'Que tengas un buen dia! Espero haberte ayudado!'),

(1050, 'Lamento no poder entenderte%0. Podria ayudarte con:'),
(1050, 'Lo siento%0, no te entiendo. Tal vez te interese:'),
(1050, 'No comprendo lo que me pides%0. Quizas quieras saber sobre:'),

(1060, 'Ups!!! No te reconozco. Quizas quieras saber como:'),

(2010, 'Hola%0, tu perfil de acceso es:'),

(2020, 'Hola%0, el correo del area de ventas es:' || chr (10) || '*%1*' || chr (10) || 'Y si quieres que hablemos, llamanos al: *%2*' || chr (10) || 'Conversemos?'),

(2030, 'Hola%0, el correo de la plataforma de soporte es:' || chr (10) || '*%1*' || chr (10) || 'Esperamos tu ticket!'),

(3011, 'Hola%0, la comunidad por la cual puedes consultar es:'),
(3012, 'Hola%0, las comunidades por las cuales puedes consultar son:'),

(3020, 'Hola%0, tu ejecutivo administrador es:' || chr (10) || '*%1*'  || chr (10) || 'su correo es: *%2*' || chr (10) || 'y su telefono es *%3*'),

(3030, 'Hola%0, tu mayordomo es:' || chr (10) || '*%1*'  || chr (10) || 'su correo es: *%2*' || chr (10) || 'y su telefono es *%3*'),

(3040, 'Hola%0, el conserje de turno es:'),

(3050, 'Hola%0, las ultimas novedades en tu comunidad son las siguientes:'),

(4010, 'Hola%0, tu gasto comun es:'),

(5010, 'Hola%0, el incidente que tienes abierto es:'),
(5010, 'Hola%0, los incidentes que tienes abiertos son:' || chr (10) || '%1' || chr (10) || 'Para seleccionar una incidente ingresa: ```incidente codigo```'),

(5010, 'Hola%0, los incidentes que tienes abiertos son:' || chr (10) || '%1' || chr (10) || 'Para seleccionar una incidente ingresa: ```incidente codigo```'),

(9010, '*BeeBee Chatbot / Virtual Assistant*' || chr (10) || '%1 V.%2' || chr (10) || '%3' || chr (10) || '(c) Copyright 2021 BeeHappy Chile' || chr (10) || '*https://beehappychile.cl*'),

(9020, 'Hola%0, en estos momentos no puedo atenderte.' || chr (10) || 'Me encuentro en mantencion.' || chr (10) ||'Intentalo mas tarde, ok?'),

(11223301, 'Hola%0, tu comunidad seleccionada es *Edificio Brown Norte 230*, comuna de *Nunoa*'),
(11223302, 'Hola%0, segun mis registros el monto de tu ultimo gasto es de *$162.354*, con vencimiento el *24/05/2021*, y se encuentra *Pagado*'),
(11223303, 'Hola%0, las ultimas novedades en tu comunidad son:' || chr (10) || '1. Inicio del proceso de cambio de administracion' || chr (10) || '2. Implementacion de protocolo covid fase 2' || chr (10) ||'3. Mantencion no programada a electrogeno')

;