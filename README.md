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

