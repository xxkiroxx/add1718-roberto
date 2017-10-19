
# Remote Desktop Protocol Windows Server 2012

- [Instalación de RDP (Remote Desktop Protocol) en Windows Server 2012](#1)

- [2. Comprobación en el Servidor si funciona por Acceso a Web el Escritorio remoto y RemotoAPP](#2)

    - [2.1 Conexión Remota al Escritorio de Windows 7](#3)

        - [2.1.1 Comprobación en el Servidor que establece conexión el Cliente Windows 7](#4)

- [3. Creación de Usuario para RDP](#5)

- [4. Establecer aplicaciones para el RemoteAPP](#6)

    - [Instalación de aplicación NotePad++](#7)

    - [4.2 Publicar Aplicación en el RemotoAPP](#8)

- [5. Conexión RemotaAPP desde Windows 7 -> NotePad++](#9)








## 1. Instalación de RDP (Remote Desktop Protocol) en Windows Server 2012.<a name="1"></a>

Lo primero que tenemos que realizar es crear un directorio activo. Es obligatorio para utilizar el RDP de Windows Server 2012.
Tenemos ya instalado un directorio Activo.

Para la instalación de RDP solo tenemos que ir `administrador de servidor -> administrar -> agregar nuevos roles`

![imagen](img/001.png)

Le damos siguiente y seguimos el asistente.

![imagen](img/002.png)

Debemos seleccionar `instalación de servicios de Escritorio Remoto`

![imagen](img/003.png)

seleccionamos `inicio rápido`

![imagen](img/004.png)

seleccionamos `implementación de escritior basado en sesión`

![imagen](img/005.png)

Por defecto ya nos debe establecer nuestro servidor.

![imagen](img/006.png)

Le damos siguiente y comienza el proceso de instalación.

![imagen](img/007.png)

El servidor se reiniciará varias veces.

![imagen](img/008.png)

![imagen](img/009.png)

El proceso de instalación termino.

## 2. Comprobación en el Servidor si funciona por Acceso a Web el Escritorio remoto y RemotoAPP.<a name="2"></a>

Solo tenemos que escribir en nuestro navegador el siguiente link `https://hernandez22s.skynet.edu/rdweb` o `https://172.18.22.21/rdweb`

![imagen](img/010.png)

Tenemos que marcar vaya a este sitio Web, esto ocurre porque no tenemos un certificado digital validado en un entidad certificadora.

![imagen](img/011.png)

Solo escribimos nuestro dominio `skynet\administrador` y su `contraseña`.

![imagen](img/012.png)

Comprobamos que tenemos varias aplicaciones disponibles para utilizar, las que vienen por defecto en la instalación del RDP.

Ejecutamos una aplicación.

![imagen](img/013.png)

### 2.1 Conexión Remota al Escritorio de Windows 7<a name="3"></a>

Solo tenemos que ir a la pestaña de conectarse a un equipo remoto. Nos pedirá `usuario y contraseña`.

![imagen](img/014.png)

Le damos a conectar.

![imagen](img/015.png)

![imagen](img/021.png)

Establecemos conexión.

> Todos lo Sistemas Operativos Windows  tienen instalado por defecto la aplicación de cliente rdp por lo tanto con una dirección IP o el dominio correspondiente podemos conectarnos al Servidor mediante conexión remota.

#### 2.1.1 Comprobación en el Servidor que establece conexión el Cliente Windows 7<a name="4"></a>

Utilizamos en el servidor desde una línea de comando el siguiente comando. `netstat`

![imagen](img/022.png)


## 3. Creación de Usuario para RDP<a name="5"></a>

Tenemos que ir a `usuario y equipos del directorio activo -> user -> crear nuevo usuario`

![imagen](img/018.png)

![imagen](img/019.png)

## 4. Establecer aplicaciones para el RemoteAPP<a name="6"></a>

Tenemos que abrir el `administrador de servidor -> servicio de escritorio remoto`.

![imagen](img/016.png)

![imagen](img/024.png)

Tenemos que dar clic al `QuickSession -> Tareas -> Editar`

![imagen](img/026.png)

Podemos agregar grupos y usuarios para que dichas aplicaciones solo puedan utilizarlas los usuarios y grupos agregados.

![imagen](img/027.png)
![imagen](img/028.png)
![imagen](img/029.png)
![imagen](img/030.png)


### 4.1 Instalación de aplicación NotePad++<a name="7"></a>

Solo tenemos que instalar la aplicación en el servidor.

![imagen](img/025.png)

### 4.2 Publicar Aplicación en el RemotoAPP.<a name="8"></a>

Tenemos que dar clic al `QuickSession -> Tareas -> Publicar programas RemotoAPP`

![imagen](img/031.png)

Seleccionamos en el servidor el programa instalado.

![imagen](img/032.png)

![imagen](img/033.png)

Confirmamos la aplicación.

Se comprueba que ya tenemos agregado la nueva aplicación.

![imagen](img/034.png)

## 5. Conexión RemotaAPP desde Windows 7 -> NotePad++<a name="9"></a>

Establecemos la IP del servidor en el navegador del Equipo de Windows 7.

![imagen](img/035.png)

Escribimos el `dominio\usuario y contraseña`

![imagen](img/036.png)

Ejecutamos la aplicación.

![imagen](img/037.png)

Le damos conectar.

![imagen](img/038.png)

Tenemos nuestra aplicación NotePad++ en nuestro Windows 7.

![imagen](img/039.png)
