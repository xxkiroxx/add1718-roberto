# VNC en Windows y OpenSuse

- [Instalación VNC en OpenSuse](#id1)

    - [Configuración de VNC-SERVER](#id2)

    - [Comprobar el funcionamiento en el Equipo](#id3)

    - [Comprobación con el comando netstat ](#id4)

- [Instalación de VNC en Windows](#id5)

    - [Equipo Cliente acceder al Servidor-VNC](#id6)

        - [Comprobación con el comando netstat](#id7)


- [Comprobación que se conecta mediante VNC de OpenSuse a Windows 7](#id8)

    - [Comprobación con el comando netstat](#id9)



![imagen](img/vnc.png)

## Instalación de VNC en OpenSuse<a name="id1"></a>

El opensuse por defecto viene instalado el vnc, solo tenemos que ir a:

    yast/vnc

![imagen](img/001.png)

Ejecutamos el administración de remoto.(VNC)

![imagen](img/002.jpg)

Marcamos las opciones como tenemos en la imagen.
Se instalaran unos paquetes necesarios.

![imagen](img/003.jpg)

### Configuración de VNC-SERVER<a name="id2"></a>
Escribimos en la línea de comando vncserver y establecemos unas contraseñas de administrador.

![imagen](img/013.jpg)

### Comprobar el funcionamiento en el Equipo<a name="id3"></a>

En el equipo que es cliente, ejecutamos el siguiente comando y accedemos al escritorio mediante VNC.

![imagen](img/014.jpg)

Muestra la siguiente ventana y debemos escribir la dirección IP.

![imagen](img/015.jpg)

### Comprobación con el comando netstat<a name="id4"></a>

Escribimos en la terminal el comando.

![imagen](img/016.jpg)


## Instalación de VNC en Windows<a name="id5"></a>

Tenemos que buscar el programa TightVNC y lo descargamos de la página oficial.

![imagen](img/005.jpg)

Le damos ejecutar y seguimos el proceso de instalación.

![imagen](img/006.jpg)

Cuando termine la instalación pide unas configuraciones, son las constraseñas del administrador.

![imagen](img/008.jpg)


### Equipo Cliente acceder al Servidor-VNC<a name="id6"></a>

Ejecutamos el programa llamado TightVNC-Viewer, escribimos la contraseña.

![imagen](img/009.jpg)

Nos pide la contraseña que configuramos después de la instalación del VNC en le servidor.

![imagen](img/010.jpg)

Se comprueba que se conecta correctamente del cliente al servidor VNC.

![imagen](img/011.jpg)

### Comprobación con el comando netstat<a name="id7"></a>

Escribimos en la línea de comando el siguiente comando.

![imagen](img/012.jpg)

## Comprobación que se conecta mediante VNC de OpenSuse a Windows 7<a name="id8"></a>

En OpenSuse escribimos en la línea de comando vncviewer, nos pedirá la dirección IP del servidor VNC, luego nos pedirá la contraseña de sesión.

![imagen](img/017.jpg)

### Comprobación con el comando netstat<a name="id9"></a>

Escribimos en la línea de comando el siguiente comando.

![imagen](img/018.jpg)


## DISPLAY 0 en GNU/Linux<a name="id10"></a>

[Enlace de interés](https://wiki.archlinux.org/index.php/TigerVNC_)

Cuando queremos ejecutar vncserver para controlar directamente la pantalla local usaremos x0vncserver de tigervnc.

    x0vncserver -display :0 -passwordfile ~/.vnc/passwd

Para más información, véase man x0vncserver
