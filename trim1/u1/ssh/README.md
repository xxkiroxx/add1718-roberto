# Acceso remoto SSH

- [Servidor SSH](#id1)

    - [Configuración IP](#id2)

    - [Cambio de Nombre ssh-server22](#id3)

    - [Añadir los Equipos al fichero hosts](#id4)

    - [Comprobación de los siguientes comandos](#id5)

    - [Creación de los siguientes usuarios](#id6)

- [Cliente OpenSuSe](#id7)

    - [Configuración de la dirección IP estática](#id8)

    - [Nombre del Equipo y fichero hosts](#id9)

    - [Realizar ping a ssh-server22 y ssh-client22b](#id10)

- [Cliente Windows 7](#id11)

    - [Configuración de la dirección IP estática](#id12)

    - [Configuración de Nombre Equipos](#id13)

    - [Configuración fichero hosts](#id14)

    - [Realizar ping a ssh-server22 y ssh-client22a](#id15)

    - [Instalación de herramienta putty para la conexion ssh](#id16)

- [Instalación de Servicio openssh](#id17)

    - [Comprobación del Servicio ssh](#id18)

- [Primera conexión SSH desde ssh-client22a](#id19)

    - [Comprobación del Puerto SSH abierto en el ssh-server22](#id20)

    - [Conexión desde ssh-client22a al ssh-server22](#id21)

    - [Fichero de la clave de identificador ssh sha2](#id22)

- [Primera conexión ssh-client22b al ssh-server22](#id23)

    - [Comprobación de la clave de conexión](#id24)

- [Cambiar las claves del servidor](#id25)

- [Regenerar Claves RSA nuevas en SSH](#id26)

- [Comprobación en los Equipos ssh-client22a y ssh-client22b las claves RSA](#id27)

- [Personalización del prompt del BASH](#id28)

    - [Creación de alias](#id29)

- [Autenticación mediante claves públicas](#id30)

- [Uso de SSH como túnel para X](#id31)

    - [Instalación geany en el ssh-server22](#id32)

    - [Configuración del fichero sshd_config](#id33)

    - [Ejecutar aplicación desde ssh-server22 en ssh-client22a](#id34)

- [Aplicaciones Windows nativas](#id35)

- [Restricciones de uso para el Usuario hernandez2](#id36)

- [Restricción sobre una aplicación](#id37)


![image](img/000.png)




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

- ping ssh-client22a #Comprobar conectividad con cliente A

![image](img/006.png)

- ping ssh-client22b #Comprobar conectividad con cliente B

![image](img/010.png)

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

## Cliente OpenSuSe<a name="id7"></a>

### Configuración de la dirección IP estática<a name="id8"></a>

Tenemos que configurar una dirección IP estática


### Nombre del Equipo y fichero hosts<a name="id9"></a>

Escribimos en el fichero `hosts y hostname`, el nombre del Equipo.

En el fichero `hosts` también escribimos las siguientes IP, para crear un DNS simple.

![image](img/015.png)

### Realizar ping a ssh-server22 y ssh-client22b<a name="id10"></a>

![image](img/017.png)

## Cliente Windows 7<a name="id11"></a>

### Configuración de la dirección IP estática <a name="id12"></a>

![image](img/012.png)

### Configuración de Nombre Equipos<a name="id13"></a>

![image](img/013.png)

### Configuración fichero hosts<a name="id14"></a>

La ruta es `c:\windows\system32\drivers\etc\hosts`

![image](img/011.png)

### Realizar ping a ssh-server22 y ssh-client22a<a name="id15"></a>

![image](img/017.png)

### Instalación de herramienta putty para la conexion ssh<a name="id16"></a>

Solo tenemos que ir a la página Web putty y descargar su aplicación.


![image](img/031.png)

## Instalación de Servicio openssh<a name="id17"></a>

Primero tenemos que comprobar si tenemos instalado el servicio.

![image](img/020.png)

Para instalar el servicio solo tenemos que escribir `sudo zypper install openssh`


![image](img/021.png)

### Comprobación del Servicio ssh<a name="id18"></a>

Tenemos que escribir el siguiente comando para ver su status `sudo systemctl status sshd`

![image](img/022.png)

También podemos comprobar el servicio con el siguiente comando. `sudo ps -ef | grep sshd`


![image](img/023.png)

Para habilitar en el inicio del sistema escribimos el siguiente comando.

`sudo systemctl enable sshd`

![image](img/025.png)

Para saber que el servidor esta escuchando el puerto 22 de ssh.

![image](img/024.png)

## Primera conexión SSH desde ssh-client22a<a name="id19"></a>

Primero realizamos una comprobación con le ping para ver si se comunican.

![image](img/026.png)

### Comprobación del Puerto SSH abierto en el ssh-server22<a name="id20"></a>

Primero necesitamos instalar el nmap.`sudo zypper in nmap`

Escribimos el siguiente comando para ver los puerto de ssh habilitados al ssh-server22.

![image](img/027.png)

### Conexión desde ssh-client22a al ssh-server22<a name="id21"></a>

Para la conexión solo tenemos que escribir el siguiente comando para conectarnos al ssh-server22

![image](img/028.png)

Una vez dentro del ssh-server22.

![image](img/029.png)

Salimos fuera de la conexión.

### Fichero de la clave de identificador ssh sha2<a name="id22"></a>

![image](img/030.png)

## Primera conexión ssh-client22b al ssh-server22<a name="id23"></a>

Tenemos que abrir la aplicación de PuTTy.

![image](img/031.png)

Para conectarnos solo tenemos que escribir el nombre del servidor o la dirección IP.

![image](img/032.png)

Solo tenemos que escribir el usuario de conexión del servidor y la contraseña.

![image](img/034.png)

![image](img/035.png)

### Comprobación de la clave de conexión<a name="id24"></a>

![image](img/033.png)


## Cambiar las claves del servidor.<a name="id25"></a>

Primero tenemos que ver en qué ruta están las claves. `ls -l /etc/ssh/`

![image](img/036.png)

Tenemos que modificar el fichero `sshd_config`.

Primero realizo una copia de seguridad del fichero de configuración.

![image](img/037.png)

Abrimos con nano el fichero de configuración `sshd_config` y solo tenemos que quitar la línea que esta comentada.

![image](img/038.png)

### Regenerar Claves RSA nuevas en SSH<a name="id26"></a>

Solo tenemos que escribir el siguiente comando. `sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key`

Cuando pide una contraseña, en esté caso no escribimos ninguna contraseña.

Esto genera una claves rsa nuevas, Privadas y Públicas.

![image](img/039.png)

Solo nos faltas reiniciar el servicio de sshd

![image](img/040.png)

### Comprobación en los Equipos ssh-client22a y ssh-client22b las claves RSA<a name="id27"></a>

- ssh-client22a

Cuando iniciamos un ssh al ssh-server22, nos sale el siguiente mensaje.

![image](img/041.png)

Tenemos que borrar desde la máquina cliente ssh-client22a el fichero `known_hosts`.

![image](img/042.png)

Cuando volvemos a conectarnos mediante ssh al ssh-server22, nos sale la nuevas claves RSA.

![image](img/043.png)


- ssh-client22b

Abrimos la aplicación de PuTTy y escribimos de nuevo en el host el nombre del servidor ssh-server22.

![image](img/044.png)

Se comprueba que al iniciar ssh nos dice la nuevas claves RSA.

Inicia correctamente el ssh

![image](img/045.png)

## Personalización del prompt del BASH<a name="id28"></a>

Tenemos que ir a la máquina ssh-server22 y buscar el siguiente fichero del usuario hernandez1 `.bashrc`.

![image](img/047.png)

![image](img/046.png)

Solo tenemos que escribir los siguientes parámetros para cambiar el color al prompt del usuario `hernandez1`.

Nos conectamos desde un equipo ssh-client22a y ssh-client22b al ssh-server.

![image](img/049.png)

![image](img/050.png)

### Creación de alias.<a name="id29"></a>

Tenemos que estar en la ruta home del usuario hernandez1 y creamos un fichero oculto llamado `.alias`.

![image](img/048.png)

## Autenticación mediante claves públicas<a name="id30"></a>

El objetivo de la práctia es lograr con el usuario hernandez4 acceder desde ssh sin contraseña, mediante las claves públicas y privadas.

En el client22a vamos a generar una par de claves.

![image](img/051.png)

Como se comprueba en la siguiente imagen.

![image](img/052.png)

El siguiente proceso es subir la clave pública al servidor ssh-server22, solo tenemos que escribir el siguiente comando, primero ' `ssh-copy-id "usuariodelserver"@"nombreservidor o IP"`

![image](img/053.png)

Comprobación que el usuario hernandez4 tiene la clave pública


![image](img/054.png)

Comprobar que ahora al acceder remotamente vía SSH
- Desde ssh-client22a, NO se pide password.

![image](img/055.png)

- Desde ssh-client22b, SI se pide el password.

![image](img/056.png)


## Uso de SSH como túnel para X<a name="id31"></a>

Comprobamos que en el equipo ssh-client22a no tiene instalado el geany.

![image](img/057.png)

### Instalación geany en el ssh-server22<a name="id32"></a>

![image](img/058.png)

### Configuración del fichero sshd_config<a name="id33"></a>

solo tenemos que estar en el servidor ssh-server22 y modificar el fichero `sshd_config`

![image](img/059.png)

Tenemos que tener descomentada la línea `X11Forwarding yes`

### Ejecutar aplicación desde ssh-server22 en ssh-client22a<a name="id34"></a>

Solo tenemos que escribir el siguiente comando, ssh -X hernandez1@ssh-server22

![image](img/060.png)

Escribimos el comando geany y se ejecuta.

## Aplicaciones Windows nativas<a name="id35"></a>

Instalación de la aplicación `Wine` en el servidor ssh-server22.

![image](img/061.png)

Abrimos desde la terminal del ssh-client22a y nos conectamos remoto al ssh-server22.

Ejecutamos la siguiente aplicación. `wine notepad` desde el ssh-client22a

![image](img/062.png)

Vemos como se guarda el fichero

![image](img/063.png)

Ejecutamos la aplicación `wine notepad` desde el ssh-server22.

![image](img/064.png)

## Restricciones de uso para el Usuario hernandez2<a name="id36"></a>

Creamos una restricción para un usuario, hernandez2.

Solo tenemos que ir al fichero de configuración de `sshd_config`


![image](img/065.png)

Comprobamos desde el equipo ssh-client22a con el usuario hernandez2 y siempre nos pide la contraseña, no podemos acceder vía ssh.

![image](img/066.png)


Comprobamos la restricción al acceder desde los clientes con el usuario hernandez2 y no inicia.


## Restricción sobre una aplicación<a name="id37"></a>

Vamos a crear una restricción de permisos sobre determinadas aplicaciones.

- Crear grupo remoteapps

![image](img/067.png)

- Incluir al usuario hernandez4 en el grupo remoteapps.

![image](img/068.png)

Localizar el programa APP1. Posiblemente tenga permisos 755.

![image](img/069.png)

![image](img/070.png)

Poner al programa APP1 el grupo propietario a remoteapps.

![image](img/071.png)

Poner los permisos del ejecutable de APP1 a 750. Para impedir que los usuarios que no pertenezcan al grupo puedan ejecutar el programa.

![image](img/072.png)


Comprobamos el funcionamiento en el servidor.

![image](img/073.png)

Comprobamos el funcionamiento desde el cliente.

Si iniciamos el SSH con el usuario hernandez4
podemos abrir el geany

![image](img/074.png)

Si iniciamos el SSH con el usuario hernandez1 no podemos abrir el geany.

![image](img/075.png)
