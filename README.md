# yacimientoArqueol-gico
Diseño e implementación de una BASE DE DATOS para la gestión de un *Yacimiento Arqueológico*.

Para llevar a cabo un buen *diseño* de **base de datos**, son necesarios dos puntos muy importantes:
- Determinar el propósito de la base de datos
- Buscar y organizar correctamente la información necesaria

Con esto presente, expongo a continuación el escenario ficticio que he redactado como ejemplo para el **diseño** y **desarrollo** de una base de datos.

![image](https://user-images.githubusercontent.com/72009355/166812476-89b8f78e-f112-4f28-a0b7-1445f0822c00.png)

## Enunciado del Problema
Se desea diseñar una base de datos que administre y gestione las operaciones del equipo de arqueología involucrado en los recientes descubrimientos localizados en el sur de la península. La directiva encargada de toda la organización, ha ofrecido la siguiente información a los responsables del departamento de informática:
- El dispositivo puesto en marcha por el Ministerio de Cultura y Deporte, ha
decidido dividir el proyecto en diferentes **excavaciones** que se extenderán por
el sureste peninsular. Cada excavación estará identificada por un **código**,
**nombre**, la **provincia** en la cual se encuentra, el **número de arqueólogos** que la
excavan, la **fecha** de comienzo de la misma y si permite o no la **visita** de turistas.
- El proceso de contratación de personal, buscará dar la oportunidad de
participar a **arqueólogos** de cualquier parte del territorio nacional. Para facilitar
dicha decisión, los arqueólogos se asentarán en **campamentos**, en los cuales se
montarán numerosas **tiendas de campaña**. Se desea recoger el **DNI**, **nombre** y
**apellidos**, y **edad** de cada uno de los arqueólogos. Por otro lado, es necesario
identificar a cada campamento con un número de campamento y su nombre.
Consecuentemente, cada tienda debe identificarse por un **número** y recoger
información sobre su **capacidad** (*número de camas*).
- Para el estudio del terreno y arquitectura descubierta, los arqueólogos recrean
a escala el escenario en cuestión construyendo **maquetas**. Dichas maquetas
son creadas con sofisticados **escáneres 3D**, que usan software (**programas**)
específico para lograr el resultado deseado. Cada maqueta se identificará por
un **código**, **nombre** de la misma y **tamaño** en cm². Para el escáner,
recogeremos el **código** que lo identifica, así como su **precio**. De los programas
queremos conocer su **código**, **nombre** y una pequeña **descripción** que indique
la naturaleza de su uso.
- Aunque el proyecto esté encabezado por el ministerio mencionado (quién ha
proporcionado toda la documentación y procesos selectivos oportunos), se hace
necesario contar con **órganos financieros** que apoyen y respalden las
excavaciones mediante aportes económicos y de infraestructura. Se permitirá el
apoyo por parte tanto de **particulares** (gente de a pie que ofrezca donativos) o
**empresas privadas**. De cualquier forma, se recogerá como datos identificativos,
el **DNI/NIF** del organismo, el **nombre** del mismo y una breve **descripción** que
justifique la donación.

Finalmente, habrá que tener en cuenta lo siguiente:
- Algunas excavaciones podrán ser visitadas por **turistas**, de los cuales será
necesario recoger el **DNI**, **nombre** y **nacionalidad** (fines estadísticos).
- En cuanto a los arqueólogos, en cada excavación se han definido turnos que
permitan designar en cada jornada uno o varios representantes del resto.
Dichos arqueólogos cumplirán la función de dirigentes de la excavación,
además de realizar su labor principal.
- Los programas empleados por los escáneres 3D anteriormente mencionados,
han sido creados por personal informático, miembros por tanto del proyecto
tratado y de los que será necesario recoger datos, tales cómo su **DNI**, **nombre**,
**edad** y los **años de experiencia** del mismo.
- Las excavaciones pueden ser financiadas por varios órganos distintos, a la vez
que estos, podrán aportar sobre todas las que deseen.
- Los arqueólogos quedan designados a una sola excavación, evitando
así desplazamientos excesivos e innecesarios.
