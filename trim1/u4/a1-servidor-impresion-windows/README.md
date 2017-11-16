# Servidor de Impresión en Windows

Con el Sistema Operativo Windows vamos a crear un servicio de impresión para gestionar la cola de impresión y sus prioridades.

![](img/000.png)

## 1. Impresora compartida

### 1.1 Rol impresión

Tenemos que instalar el rol de `administración de servidor -> agregar nuevos roles` y tenemos que buscar el rol de `administración de impresión`.

![](img/002.png)

![](img/003.png)

![](img/004.png)

![](img/008.png)

![](img/009.png)

![](img/010.png)

![](img/011.png)

![](img/012.png)

![](img/013.png)

El resultado de la instalación de la administración de impresión

![](img/014.png)



### 1.2 Instalar impresora

Tenemos que instalar una impresora lógica al servidor en este caso vamos a crear una impresora mediante pdfcreator.

Tenemos que instalar la impresora mediante el software de `pdfcreator`

![](img/001.png)

El resultado de la instalación del pdfcreator.

![](img/016.png)


Comprobamos que la impresora está en dispositivos en Windows.

![](img/018.png)

En esté caso la impresora se llamada pdfcreator. Está impresora fue creada por el software de pdfcreator.

Realizamos una prueba desde el Servidor y se imprime un documento a pdf.

![](img/020.png)

- Nos sale una ventana  en el servidor del pdfcreator para guardar el doc a pdf.

![](img/021.png)



### 1.3 Compartir por red

Para compartir la impresora de pdfcreator en la red debemos realizar el siguiente paso:

Solo tenemos que dar a propiedades de impresora y vamos a la pestaña de compartir y escribimos en el recurso de red `pdfroberto22`.

![](img/018.png)

![](img/019.png)

- Después de tener la impresora compartida en red, vamos al equipo cliente windows y buscamos la impresora por la red, debemos ir `panel de control -> agregar impresora` o escribimos en el navegador `\\hernandez22s\` nos sale un mensaje para autenticar la conexión. Solo tenemos que agregar la impresora a nuestro equipo cliente.

- Agregando desde los dispositivos de impresora.

![](img/027.png)

![](img/028.png)

![](img/029.png)

![](img/030.png)

- En este caso vamos a imprimir la página de prueba desde el cliente.

![](img/031.png)

- Se comprueba que desde el cliente envía al Servidor de impresión la impresión y muestra un mensaje el pdfcreator para guardar la impresión.

![](img/032.png)

- Se comprueba que imprime correctamente.

En el caso de introducir en el navegador `\\hernandez22s` solo tenemos que darle doble clic al recurso de la impresora.

![](img/022.png)

Con instalar la confianza en la impresora. Ya la tenemos agregada.

Comprobamos que en nuestro equipo cliente tenemos la impresora de pdfcreator.

![](img/033.png)


## 2. Acceso Web y configuración de impresión

Tenemos que tener instalado el rol de adminstración de impresión, que ya lo instalamos pero tenemos que instalar una opción para que sea por navegador web y por lo tanto debe instalar también el `IIS`.

La opción nueva o caracteristica se llama `impresión en Internet`

![](img/015.png)

Solo tenemos que darle siguiente y nos dirá que tiene que instalar el servicio de IIS.


### 2.1 Comprobación desde el navegador del cliente.

![](img/034.png)
![](img/035.png)
![](img/036.png)
![](img/037.png)
![](img/038.png)
![](img/039.png)



Vamos a realizar seguidamente una prueba sencilla en tu impresora de red a través del navegador pausa todos los trabajos en la impresora. Luego envía a imprimir en tu impresora compartida un documento del Bloc de notas. La siguiente pantalla muestra que la impresora esta en pausa y con el trabajo en cola de impresión.


Finalmente pulsa en reanudar el trabajo para que tu documento se convierta a PDF. Comprobar que se puede imprimir desde un cliente Windows.

Si tenemos problemas para acceder a la impresora de red desde el cliente Windows:

Revisar la configuración de red de la máquina (Incluido la puerta de enlace)
Reiniciar el servidor Windows Server que contiene la impresora compartida de red.
## 3. Servidor de impresión en el servidor

Activar rol/característica de servidor impresión
Configurar colas
