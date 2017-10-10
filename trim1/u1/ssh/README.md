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



- host www.google.es #Comprobar el servidor DNS



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




## Cliente Windows 7

### Configuración de la dirección IP estática

![image](img/012.png)

### Configuración de Nombre Equipos

![image](img/013.png)

### Configuración fichero hosts

La ruta es `c:\windows\system32\drivers\etc\hosts`

![image](img/011.png)
