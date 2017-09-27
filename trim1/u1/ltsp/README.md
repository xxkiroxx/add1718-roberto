# LTSP/Xubuntu

- [Configuración Máquina Virtual Server Xubuntu 16.04.1](#id1)

    - [Instalación Xubuntu 16.04.1](#id2)

    - [Configuración de las Tarjetas de red](#id3)

    - [Creación de usuarios](#id4)

    - [Instalación el servicio LTSP](#id5)

    - [Configuración de servicio DHCP en LTSP](#id6)


- [Preparar MV Cliente](#id7)

- [Video del proceso de funcionamiento del Servidor ltsp con el cliente](#id8)


![imagen](img/ltsp.png)


## Configuración Máquina Virtual Server Xubuntu 16.04.1 <a name="id1"></a>

Creamos primero una nueva máquina virtual en el VirtualBox. Es necesario crear dos tarjetas de red.

![imagen](img/ltspmaquina.png)

* Tarjeta de Red Adaptador Puente

![imagen](img/redexterna.png)


* Tarjeta de Red Interna

![imagen](img/redinterna.png)


    * La dirección IP 192.168.67.1 /24


### Instalación Xubuntu 16.04.1 <a name="id2"></a>
Ejecutamos la iso de Xubuntu en el VirtualBox. Instalamos el Xubuntu y configuramos todos por defecto.

![imagen](img/001.png)

Configuración del usuario y nombre de Equipo.

![imagen](img/002.png)

### Configuración de las Tarjetas de red <a name="id3"></a>
*  Tarjeta de Red Externa

![imagen](img/003.png)

* Tarjeta de Red Interna

![imagen](img/004.png)

Comprobación de la instalación de Xubuntu con las configuraciones especificas

![imagen](img/005.png)

![imagen](img/006.png)

### Creación de usuarios <a name="id4"></a>
Para crear nuevos usuarios escribimos el comando adduser "Nombre-Usuario"

![imagen](img/008.png)

Confirmación de los usuarios creados

![imagen](img/007.png)

### Instalación el servicio LTSP <a name="id5"></a>

Primero tenemos que instalar el servicio ssh, para permitir acceso remoto a la máquina.
> * apt-get install ssh

Modificamos el fichero /etc/ssh/sshd_config y permitimos
> * PermitRootLogin Yes

![imagen](img/010.png)

Comenzamos con la instalacion del LTSP
> * apt-get install ltsp-server-standalone

Termina de instalarse el ltsp. Procesamos en crear una imagen del SO.

> *  ltsp-build-client

![imagen](img/009.png)

Ejecutamos el siguiente comando para verificar la información

> * ltsp-info

![imagen](img/011.png)

### Configuración de servicio DHCP en LTSP <a name="id6"></a>

Consultamos el fichero /etc/ltsp/dhcpd.conf

![imagen](img/013.png)

> Nota para actualizar la imagen

>![imagen](img/015.png)

Comprobamos que el servicio esta corriendo.
> dhcpd

> >![imagen](img/012.png)

> tftp

> >![imagen](img/014.png)



    32 bits o 64 bits

    Si el servidor es de 64-bits pero los clientes tienen
    arquitectura de 32-bits entonces usar el comando siguiente
    ltsp-build-client --arch i386 para crear una imagen de 32 bits.

    Ejecutar ltsp-info, para consultar información.

    NOTA

    En el caso de tenemos problemas con la imagen, estos son
    los comandos LTSP para volver a actualizar la imagen.

        * ltsp-update-kernel
        * ltsp-update-sshkeys
        * ltsp-update-image





## Preparar MV Cliente <a name="id7"></a>

Creamos una máquina virtual en VirtualBox:

    * Sin disco duro y sin unidad de DVD.
    * Sólo tiene RAM, floppy
    * Tarjeta de red PXE en modo "red interna".

![imagen](img/016.png)

Se comprueba que inicia en el equipo cliente el sistema operativo del servidor ltsp.


![imagen](img/019.png)

> Nota:
> > En las máquinas virtuales tiene que habilitar la siguiente configuración:

![imagen](img/020.png)

Comprobación de los siguientes comando para ver información de los usuarios, el sistema y las conexiones.

    * whoami        # Muestra el usuario actual
    * who           # Muestra los usuarios conectados al sistema
    * arp           # Muestra la tabla ARP (Asociaciones de IP con MAC)
    * netstat -ntap # Muestras las conexiones con el exterior

![imagen](img/018.png)

## Video del proceso de funcionamiento del Servidor ltsp con el cliente.<a name="id8"></a>



[![Video de Xubuntu-LTSP](img/021.png)](https://www.youtube.com/watch?v=WlBchDqvVLQ)
