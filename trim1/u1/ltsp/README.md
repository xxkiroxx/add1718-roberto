# 1. LTSP/Xubuntu

## 1.1 Configuración Máquina Virtual Server Xubuntu 16.04.1

Creamos primero una nueva máquina virtual en el VirtualBox. Es necesario crear dos tarjetas de red.

![imagen](img/ltspmaquina.png)

* Tarjeta de Red Adaptador Puente

![imagen](img/redexterna.png)


* Tarjeta de Red Interna

![imagen](img/redinterna.png)


    * La dirección IP 192.168.67.1 /24


### 1.1.1 Instalación Xubuntu 16.04.1
Ejecutamos la iso de Xubuntu en el VirtualBox. Instalamos el Xubuntu y configuramos todos por defecto.

![imagen](img/001.png)

Configuración del usuario y nombre de Equipo.

![imagen](img/002.png)

### 1.1.2 Configuración de las Tarjetas de red
*  Tarjeta de Red Externa

![imagen](img/003.png)

* Tarjeta de Red Interna

![imagen](img/004.png)

Comprobación de la instalación de Xubuntu con las configuraciones especificas

![imagen](img/005.png)

![imagen](img/006.png)

### 1.1.3 Creación de usuarios
Para crear nuevos usuarios escribimos el comando adduser "Nombre-Usuario"

![imagen](img/008.png)

Confirmación de los usuarios creados

![imagen](img/007.png)

### 1.1.4 Instalación el servicio LTSP

Primero tenemos que instalar el servicio ssh, para permitir acceso remoto a la máquina.
* apt-get install ssh

Modificamos el fichero /etc/ssh/sshd_config y permitimos
* PermitRootLogin Yes

![imagen](img/010.png)

Comenzamos con la instalacion del LTSP
* apt-get install ltsp-server-standalone

Termina de instalarse el ltsp. Procesamos en crear una imagen del SO.

*   ltsp-build-client

![imagen](img/009.png)

Ejecutamos el siguiente comando para verificar la información

* ltsp-info

![imagen](img/011.png)

### 1.1.5 Configuración de servicio DHCP en LTSP

Consultamos el fichero /etc/ltsp/dhcpd.conf

![imagen](img/013.png)

> Nota para actualizar la imagen

>![imagen](img/015.png)

Comprobamos que el servicio esta corriendo.

![imagen](img/012.png)

![imagen](img/014.png)
