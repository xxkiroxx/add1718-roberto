# Acceso remoto SSH

- [](#id1)

- [](#id2)

- [](#id3)

- [](#id4)

- [](#id5)


# Preparativos


## Servidor SSH<a name="id1"></a>

Ya tenemos una instalación de OpenSuSe, pero primero tenemos que preparla antes de realizar la instalación de ssh-server.

### Configuración IP <a name="id2"></a>

Tenemos que establecer una dirección IP estática.

![image](img/001.png)

### Cambio de Nombre ssh-server22 <a name="id3"></a>

Para cambiar el nombre de la máquina solo debemos escribir el siguiente comando.

- `sudo nano /etc/hostname`

- `sudo nano /etc/hosts`

Comprobamos que el nombre esta cambiado.

![image](img/002.png)


### Añadir los Equipos al fichero hosts <a name="id4"></a>

Para crear un DNS con el fichero hosts.

`sudo nano /etc/hosts`

Solo debemos escribir el

`Dirección IP   NombreEquipo`

Fijate en la siguiente imagen.

![image](img/003.png)


### Comprobación de los siguientes comandos <a name="id5"></a>

- ip a  #Comprobar IP y máscara

![image](img/004.png)

- route -n           #Comprobar puerta de enlace

![image](img/005.png)

- ping 8.8.4.4 -i 2  #Comprobar conectividad externa

![image](img/014.png)

- host www.google.es #Comprobar el servidor DNS

![image](img/015.png)

- ping ssh-clientXXa #Comprobar conectividad con cliente A

![image](img/006.png)

- ping ssh-clientXXb #Comprobar conectividad con cliente B

![image](img/0010.png)

- lsblk              #Consultar particiones

![image](img/007.png)

- blkid              #Consultar UUID de la instalación

![image](img/008.png)

### Creación de los siguientes usuarios <a name="id6"></a>

- hernandez1
- hernandez2
- hernandez3
- hernandez4

La creación de usuarios se realizo mediante la herramienta de yast.

Comprobación de los usuarios creados.

![image](img/009.png)

## Cliente OpenSuSe

### Configuración de la dirección IP estática

Tenemos que configurar una dirección IP estática


### Nombre del Equipo y fichero hosts

Escribimos en el fichero `hosts y hostname`, el nombre del Equipo.

En el fichero `hosts` también escribimos las siguientes IP, para crear un DNS simple.

![image](img/015.png)

### Realizar ping a ssh-server22 y ssh-client22b

![image](img/017.png)

## Cliente Windows 7

### Configuración de la dirección IP estática

![image](img/012.png)

### Configuración de Nombre Equipos

![image](img/013.png)

### Configuración fichero hosts

La ruta es `c:\windows\system32\drivers\etc\hosts`

![image](img/011.png)

### Realizar ping a ssh-server22 y ssh-client22a

![image](img/017.png)


## Instalación de Servicio openssh

Primero tenemos que comprobar si tenemos instalado el servicio.

![image](img/020.png)

Para instalar el servicio solo tenemos que escribir `sudo zypper install openssh`


![image](img/021.png)

### Comprobación del Servicio ssh

Tenemos que escribir el siguiente comando para ver su status `sudo systemctl status sshd`

![image](img/022.png)

También podemos comprobar el servicio con el siguiente comando. `sudo ps -ef | grep sshd`


![image](img/023.png)

Para habilitar en el inicio del sistema escribimos el siguiente comando.

`sudo systemctl enable sshd`

![image](img/025.png)

Para saber que el servidor esta escuchando el puerto 22 de ssh.

![image](img/024.png)

## Primera conexión SSH desde ssh-client22a

Primero realizamos una comprobación con le ping para ver si se comunican.

![image](img/026.png)

### Comprobación del Puerto SSH abierto en el ssh-server22

Primero necesitamos instalar el nmap.`sudo zypper in nmap`

Escribimos el siguiente comando para ver los puerto de ssh habilitados al ssh-server22.

![image](img/027.png)

### Conexión desde ssh-client22a al ssh-server22

Para la conexión solo tenemos que escribir el siguiente comando para conectarnos al ssh-server22

![image](img/028.png)

Una vez dentro del ssh-server22.

![image](img/029.png)

Salimos fuera de la conexión.

### Fichero de la clave de identificador ssh sha2

![image](img/030.png)
