# ULUR
INFO DEL PROYECTO

INTEGRANTES:

ESTUDIANTE 1:
Jhoan Stiven Cardona Galeano - jscardonag@eafit.edu.co 

ESTUDIANTE 2:
Alejandra Martinez Vega - amartinezv@eafit.edu.co

ESTUDIANTE 3:
Jorge Luis Herrera Chamat - jlherrerac@eafit.edu.co



APLICACIÓN SELECCIONADA:

WordPress


DOMINIO EN EL DCA:

proyecto08.dis.eafit.edu.co



IP EN EL DCA:

192.168.10.227


DOMINIO EN AMAZON EMPLEADO:

ulur2020.ml


DISEÑO DEL QA PERFORMANCE

Para este atributo de calidad no tenemos en cuenta aspectos como patrones de diseño o clean code ya que, al trabajar con una instancia de Wordpress instalada por medio de Docker, no tocamos el código fuente de la aplicación, así que nos centramos en la infraestructura y el diseño de la solución desde lo externo a la aplicación en sí misma y las best practices para trabajar Wordpress en aws.
Como consideraciones importantes y aspectos a tener en cuenta, definimos puntos importantes para el rendimiento de una aplicación en nube usando Wordpress, entre estos se encuentran la velocidad de entrega de contenido, la forma en la que se reciben y manejan múltiples peticiones en poco tiempo, la escalabilidad para hacer uso de más recursos, entre otros.

·         Velocidad de entrega de contenido

Para el aspecto de entrega de contenido, implementamos medidas como un cache CDN global para atender peticiones de forma no centralizada y poder entregar al menos una vista no funcional en caché del software en caso de que haya una caída de las instancias o alguna falla de servidores. Para implementar esto, utilizaremos el servicio Cloudfront de AWS, con origen en nuestro dominio ulur2020.ml 

·         Recepción de peticiones

Hay varias formas de tratar este punto, para este proyecto planteamos implementar servidores queue que simulen el comportamiento de frameworks como Node js en cuanto al manejo de peticiones y ganar la habilidad de manejar más de una petición a la vez. Al final se decidió dejar esto en manos de uno o más balanceadores de carga que cumplen una función similar y nos sirven para cumplir a la vez con el QA disponibilidad. 

·         Escalabilidad

En este aspecto, además de pensar en la escalabilidad horizontal para cumplir con la cantidad de usuarios que utilicen el servicio, también pensamos en la escalabilidad vertical para el uso de recursos adicionales en caso de ser necesario. Esto se configura por medio de aws con los servicios de Ec2, autoscaling y cloudwatch. 
Dentro del mundo de wordpress, hicimos uso de plugins instalables como W3TC y Redis para el manejo de caché, reduciendo el tamaño de archivos html, css y js hasta en un 10%. Además, W3TC hace manejo de caché para reducir significativamente los tiempos de carga de Wordpress.

Además de estos aspectos y como algo más general en el ámbito del QA rendimiento, aplicaremos testing al software utilizando Jmeter, con esto probaremos los tiempos de respuesta, realizaremos pruebas de estrés y demás para definir la calidad del software y la cantidad de instancias y balanceadores que necesitaremos para cumplir con la cantidad esperada de usuarios. Dependiendo de los resultados de estas pruebas, tomaremos decisiones de infraestructura y diseño evaluando en retorno a la inversión de cambios como la base de datos o replanteamientos sobre el uso de Docker.
Aplicando gráficamente las herramientas utilizadas que clasifican como diseño e infraestructura, se puede plantear un diagrama del QA performance como este:



DISEÑO DEL QA DISPONIBILIDAD

Con este QA se pretende que el periodo de tiempo de nuestro servicio esté disponible para su uso en un alto porcentaje de tiempo, así como el tiempo que necesita nuestro sistema para responder a una solicitud realizada por un usuario sea el mínimo. Para esto se diseñó una infraestructura donde se asegura un sistema redundante para que pueda ayudar en caso de una interrupción del servicio en el sistema principal.

El diseño consiste en dos zonas de disponibilidad A y B cada una de ellas contiene una capa de servidor web y un RDS, en el caso de las capas web, contienen la aplicación en sí y está replicada en las dos zonas, mientras que los RDS, uno de ellos es la base de datos primaria y en la zona B se encuentra la base de datos secundaria que es una réplica de la primaria que se mantiene en latencia, es decir que está en reposo hasta que la base de datos primaria comienza a saturarse. Frente a las dos zonas se encuentra un balanceador de carga.

Además la capas de servidor web se encuentran en modo de auto escalabilidad, es decir, que en cuanto el tráfico y las peticiones se vuelvan más demandantes, se crearán máquinas nuevas que contengan la misma aplicación y las peticiones se distribuirán a las nuevas instancias creadas.

Hay varios componentes que cuidadosamente fueron tomados en consideración para implementar la alta disponibilidad en la práctica. Mucho más que una implementación de software, por que la alta disponibilidad depende más de factores como:

·      Entorno: los servidores están ubicados en diferentes área geográfica, porque en caso de una condición ambiental como un terremoto o una inundación puede hacer que todo el sistema se venga abajo. Tener servidores redundantes en diferentes centros de datos y áreas geográficas aumentará la fiabilidad.

·   Software: toda el arreglo de software, incluyendo el sistema operativo y la propia aplicación, debe estar preparada para manejar fallos inesperados que podrían requerir, por ejemplo, un reinicio del sistema.

·       Datos:la pérdida de datos y la inconsistencia pueden deberse a varios factores, y no se limita a los fallos del disco duro. Los sistemas de alta disponibilidad deben tener en cuenta la seguridad de los datos en caso de fallo.

·       Red: las interrupciones imprevistas de la red representan otro posible punto de fallo para los sistemas de alta disponibilidad. Por esto es importante que exista una estrategia de red redundante para posibles fallos.


DISEÑO DEL QA SEGURIDAD

Con el fin de reducir en una gran medida las vulnerabilidades, amenazas y riesgos a las cuales podría estar expuesto nuestro CMS hemos decidido implementar las siguientes tácticas para maximizar la seguridad de nuestro sistema: (Nota: Esto es sólo la punta del iceberg para garantizar la mínima seguridad de nuestro sistema, por lo que aún hay muchas más tácticas que se podrían implementar para reducir al mínimo las vulnerabilidades, amenazas y riesgos a las cuales está expuesta nuestra aplicación web, pero por el momento solo se desea cumplir con estas tácticas y en un futuro se podría maximizar la seguridad añadiendo o mejorando algunas de las técnicas aquí implementadas)

Implementación de certificados SSL: Con el fin de evitar los ataques conocidos como “man in the middle” en donde los atacantes aprovechan que todo el tráfico que pasa por una sesión HTTP no está cifrado para acceder fácilmente a todos los datos que los usuarios comparten con nuestra aplicación y viceversa, a través de sus sesiones http. 

Por esto se decidió usar cloudflare para obtener un certificado SSL, que nos permitiera dos grandes cosas, primero poder certificar a los usuarios de nuestra aplicación que la web que están visitando es legítima y en segundo lugar, para poder mantener la integridad y la privacidad de los datos a través del cifrado HTTPS, donde cada conexión HTTP se envía sobre una capa SSL para garantizar el correcto cifrado de la sesión HTTPS. Cloudflare nos emite el certificado para nuestro dominio, y este mismo certificado lo usamos en nuestro balanceador de cargas para recibir el tráfico https proveniente del DNS de Cloudflare y enrutarlo al tráfico HTTP de las instancias.
Nota: No se decidió incluir una backend-certification entre el ELB y las instancias de EC2 ya que consideramos que el tráfico que transcurre por las redes de AWS en nuestra VPC es lo bastante seguro para este proyecto, en un futuro para garantizar una mayor seguridad se podría implementar esto añadiendo los certificados también en nuestros EC2.

Autenticación con terceros: Gracias a la proliferación de los micro-servicios, hoy en día podemos hacer uso de los robustos servicios que nos ofrecen algunas compañías para obtener una mayor calidad en el servicio que ofrecemos, en este caso, podemos hacer uso de los servicios de autenticación de compañías como Google, Facebook, Twitter, Instagram, etc, lo que nos permite brindarle una alternativa mucho más amigable, eficiente y segura al usuario a la hora de autenticarse en nuestra página web, ya que de esta manera el usuario no tendría que registrarse en nuestra página web para poder ser autenticado, sino que podría hacer uso de sus credenciales en alguna de las aplicaciones mencionadas anteriormente para facilitar este proceso, además, todo este proceso de autenticación lo realizan estos terceros, lo que nos permite hacer uso de sus sistemas a través de una simple API, con la cual garantizamos los mismos niveles de robustez y seguridad que estos sistemas manejan a la hora de autentificar sus usuarios.
Logramos implementar esto en el wordpress con el plug-in de Social Login.

Autenticación de doble factor: Una de las formas de aumentar la seguridad en nuestro sitio web es implementar una verificación en dos pasos para escalar y optimizar la autenticación de nuestros usuarios, de manera que si alguno de los datos de acceso de nuestros usuarios llega a caer en manos de personas no autorizadas estas mismas no puedan acceder al sistema ya que necesitan de la segunda autenticación para poder entrar, el cual puede ser un código de seguridad que se manda por SMS, un código QR, un email de verificación, etc.
Logramos implementar esto en el wordpress con el plug-in de Two-Factor Authentication.

Implementación de una NAT-Gateway: Adicional a esto se planeaba incrementar la seguridad de nuestro sistema mediante la implementación de dos nuevas subnets privadas en nuestro diagrama de despliegue, cada una de estas estaría ubicada en una de las dos zonas de disponibilidad de la aplicación.

Todo esto se deseaba implementar con el fin de seguir las recomendaciones de best practices para el despliegue de wordpress en la plataforma aws, en donde lo ideal sería ubicar en las subnets privadas todo lo equivalente a nuestra aplicación y los datos, con el fin de que ninguna persona no autorizada pueda acceder públicamente a nuestras instancias de ec2 que contienen wordpress o a la misma base de datos en rds.

Para lograr esto era necesario mover las instancias EC2 de wordpress a una subnet privada y ubicar en la subnet pública una NAT Gateway que se encarga del enrutamiento de todo el tráfico entre el Internet Gateway que llega a la subnet pública con las instancias de EC2, con la finalidad de tener un firewall que sólo permita el tráfico por el puerto 80 y 443 entre nuestras instancias y el internet, además de esto se iba a implementar un Bastion Host que nos permitiera acceder mediante el puerto 22 a las instancias en caso de que tuviéramos que realizar algún tipo de mantenimiento o configuración adicional en estas instancias.

Sin embargo esto no se pudo implementar porque el uso de las NAT Gateway está prohibido con la cuenta Educate de AWS y la alternativa gratuita (NAT Instance) nos funcionó hasta cierto punto, ya que se logró configurar totalmente la instancia para redirigir el tráfico a las instancias EC2 en la subnet privada pero esto requería de la configuración manual de todo el ruteo de las iptables de la NAT Instance, y para esto requerimos conocer la IP Privada de nuestras instancias de EC2 a la cual íbamos a enrutar el tráfico, algo que logramos con una sola instancia pero que no logramos adecuar para que cada que el auto-scaling crea o destruye una nueva instancia esto se vea automáticamente reflejado en el ruteo de la NAT Instance para no experimentar ninguna caída o error en el servicio de la aplicación
