# Samba con OpenSUSE

![img](img/000.png)




## 1. Servidor Samba (MV1)
### 1.1 Preparativos

Configurar el servidor OpenSUSE.

- Nombre de equipo: smb-server22

```console

roberto@smb-server22:~> hostname -a
smb-server22
roberto@smb-server22:~> hostname -d
curso1718
roberto@smb-server22:~>


```


- Añadir en /etc/hosts los equipos smb-cli22a y smb-cli22b

```console

roberto@smb-server22:~> sudo cat /etc/hosts | grep -e smb-server22 -e smb-client22
root's password:
127.0.0.1       smb-server22
172.18.22.31    smb-server22.curso1718	smb-server22
172.18.22.32	smb-client22a
172.18.22.11	smb-client22b
roberto@smb-server22:~>


```

Capturar salida de los comandos siguientes en el servidor:

- hostname -f

```console

roberto@smb-server22:~> hostname -f
smb-server22.curso1718

```
- ip a

```console

roberto@smb-server22:~> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:b9:f7:e9 brd ff:ff:ff:ff:ff:ff
    inet 172.18.22.31/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feb9:f7e9/64 scope link
       valid_lft forever preferred_lft forever


```
- lsblk

``` console

roberto@smb-server22:~> lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0   15G  0 disk
├─sda1   8:1    0    2G  0 part [SWAP]
└─sda2   8:2    0   13G  0 part /var/spool
sr0     11:0    1  4,1G  0 rom  

```
- sudo blkid

```console

roberto@smb-server22:~> sudo blkid
root's password:
/dev/sda1: UUID="9fec4fe4-2a8f-4893-b111-66a8285d645d" TYPE="swap" PARTUUID="000ca8c8-01"
/dev/sda2: UUID="c8b48f30-4767-4fac-8501-1e8163fb1918" UUID_SUB="22a11a88-9f87-476e-b602-3e67873fe10c" TYPE="btrfs" PTTYPE="dos" PARTUUID="000ca8c8-02"
/dev/sr0: UUID="2016-11-09-10-39-11-00" LABEL="openSUSE-Leap-42.2-DVD-x86_64028" TYPE="iso9660" PTUUID="135a2181" PTTYPE="dos"


```


### 1.2 Usuarios locales


Vamos a OpenSUSE, y creamos los siguientes grupos y usuarios:

- Crear los grupos piratas, soldados y todos.

```console

roberto@smb-server22:~> sudo groupadd piratas; sudo groupadd soldados; sudo groupadd todos
root's password:
roberto@smb-server22:~> sudo cat /etc/group | grep -e soldados -e piratas -e todos
piratas:x:1001:
soldados:x:1002:
todos:x:1003:


```

- Crear el usuario smbguest.
- Vamos a modificar este usuario y le ponemos como shell /bin/false.

```console

roberto@smb-server22:~> sudo useradd smbguest -m
root's password:
roberto@smb-server22:~> sudo nano /etc/passwd
roberto@smb-server22:~> sudo cat /etc/passwd | grep smbguest
smbguest:x:1005:100::/home/smbguest:/bin/false
roberto@smb-server22:~> sudo passwd smbguest
Nueva contraseña:
Vuelva a escribir la nueva contraseña:
passwd: contraseña actualizada correctamente


```

- Creación de los usuarios de soldado1,soldado2,pirata1,pirata2,supersamba


```console

roberto@smb-server22:~> sudo useradd pirata1 -m;sudo useradd pirata2 -m;sudo useradd supersamba -m;sudo useradd soldado1 -m;sudo useradd soldado2 -m
roberto@smb-server22:~> sudo cat /etc/passwd | grep -e pirata -e soldado -e supersamba
pirata1:x:1006:100::/home/pirata1:/bin/bash
pirata2:x:1007:100::/home/pirata2:/bin/bash
supersamba:x:1008:100::/home/supersamba:/bin/bash
soldado1:x:1009:100::/home/soldado1:/bin/bash
soldado2:x:1010:100::/home/soldado2:/bin/bash


```

- Dentro del grupo piratas incluir a los usuarios pirata1, pirata2 y supersamba.

- Dentro del grupo soldados incluir a los usuarios soldado1 y soldado2 y supersamba.

- Dentro del grupo todos, poner a todos los usuarios soldados, pitatas, supersamba y a smbguest.

```console

roberto@smb-server22:~> sudo usermod -a -G piratas pirata1
roberto@smb-server22:~> sudo usermod -a -G piratas pirata2
roberto@smb-server22:~> sudo usermod -a -G piratas supersamba
roberto@smb-server22:~> sudo usermod -a -G soldados supersamba
roberto@smb-server22:~> sudo usermod -a -G soldados soldado1
roberto@smb-server22:~> sudo usermod -a -G soldados soldado2
roberto@smb-server22:~> sudo usermod -a -G todos pirata1
roberto@smb-server22:~> sudo usermod -a -G todos pirata2
roberto@smb-server22:~> sudo usermod -a -G todos supersamba
roberto@smb-server22:~> sudo usermod -a -G todos smbguest
roberto@smb-server22:~> sudo usermod -a -G todos soldado1
roberto@smb-server22:~> sudo usermod -a -G todos soldado2
roberto@smb-server22:~> sudo cat /etc/group | grep -e piratas -e soldados -e todos
piratas:x:1001:pirata1,pirata2,supersamba
soldados:x:1002:supersamba,soldado1,soldado2
todos:x:1003:pirata1,pirata2,supersamba,smbguest,soldado1,soldado2
roberto@smb-server22:~>


```
### 1.3 Crear las carpetas para los futuros recursos compartidos

Vamos a crear las carpetas de los recursos compartidos con los permisos siguientes:

- /srv/samba22/public.d
    - Usuario propietario supersamba.
    - Grupo propietario todos.
    - Poner permisos 775.

```console
roberto@smb-server22:~> sudo mkdir -p /srv/samba22/public.d
roberto@smb-server22:~> sudo chown -R supersamba:todos /srv/samba22/public.d/  
roberto@smb-server22:~> sudo chmod -R 775 /srv/samba22/public.d/



```

- /srv/samba22/castillo.d
    - Usuario propietario supersamba.
    - Grupo propietario soldados.
    - Poner permisos 770.

    ```console

    roberto@smb-server22:~> sudo mkdir -p /srv/samba22/castillo.d
    roberto@smb-server22:~> sudo chown -R supersamba:soldados /srv/samba22/castillo.d/
    roberto@smb-server22:~> sudo chmod -R 770 /srv/samba22/castillo.d/

    ```

- /srv/samba22/barco.d
    - Usuario propietario supersamba.
    - Grupo propietario piratas.
    - Poner permisos 770.

    ```console

    roberto@smb-server22:~> sudo mkdir -p /srv/samba22/barco.d
    roberto@smb-server22:~> sudo chown -R supersamba:piratas /srv/samba22/barco.d/
    roberto@smb-server22:~> sudo chmod -R 770 /srv/samba22/barco.d/

    ```

- Comprobamos el resultado final de las carpeta creadas con sus permisos y grupos.

```console

roberto@smb-server22:~> ls -l /srv/samba22/
total 0
drwxrwx--- 1 supersamba piratas  0 oct 26 09:37 barco.d
drwxrwx--- 1 supersamba soldados 0 oct 26 09:37 castillo.d
drwxrwxr-x 1 supersamba todos    0 oct 26 09:37 public.d


```
### 1.4 Instalar Samba Server

Comprobamos que tenemos instalado el samba en nuestro OpenSUSE.

```console

roberto@smb-server22:~> sudo zypper se yast2-samba-server
Cargando datos del repositorio...
Leyendo los paquetes instalados...

E | Nombre             | Resumen                                   | Tipo   
--+--------------------+-------------------------------------------+--------
i | yast2-samba-server | YaST2: configuración de un servidor Samba | paquete


```

- Vamos a hacer una copia de seguridad del fichero de configuración existente cp `/etc/samba/smb.conf /etc/samba/smb.conf.000.`

```console

roberto@smb-server22:~> sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.000
root's password:
roberto@smb-server22:~> ls -l /etc/samba/
total 16
-rw-r--r-- 1 root root  249 oct 19  2016 lmhosts
-rw-r--r-- 1 root root 1238 oct 19  2016 smb.conf
-rw-r--r-- 1 root root 1238 oct 26 09:53 smb.conf.000
-rw-r--r-- 1 root root  379 oct 19  2016 smbusers

```

Podemos usar comandos o el entorno gráfico para instalar y configurar el servicio Samba. Como estamos en OpenSUSE vamos a usar Yast.

- Yast -> Samba Server

![img](img/001.png)


- Workgroup: mar1718

![img](img/002.png)

- Sin controlador de dominio.

![img](img/003.png)

En la pestaña de Inicio definimos

- Iniciar el servicio durante el arranque de la máquina.

![img](img/004.png)

- Ajustes del cortafuegos -> Abrir puertos

![img](img/005.png)

### 1.5 Configurar el servidor Samba

Configuración de los recursos compartido del servidor Samba.

Podemos hacerlo modificando el fichero de configuración `/etc/samba/smb.conf` o por entorno gráfico con Yast.

Capturar imágenes del proceso.

- `Yast -> Samba Server -> Recursos compartidos`

Tenemos que montar una configuración como la siguiente:

será un recurso compartido accesible para todos los usuarios en modo lectura.
cdrom, es el recurso dispositivo cdrom de la máquina donde está instalado el servidor samba.

- [global]
  - netbios name = smb-serverXX
  - workgroup = mar1617
  - server string = Servidor de nombre-alumno-XX
  - security = user
  - map to guest = bad user
  - guest account = smbguest

- [cdrom]
  - path = /dev/cdrom
  - guest ok = yes
  - read only = yes

 ![img](006.png)

- [public]
  - path = /srv/samba22/public.d
  - guest ok = yes
  - read only = yes

![img](007.png)

- [castillo]
  - path = /srv/samba22/castillo.d
  - read only = no
  - valid users = @soldados

 ![img](008.png)

- [barco]
  - path = /srv/sambaXX/piratas.d
  - read only = no
  - valid users = pirata1, pirata2

 ![img](009.png)

- Resultado final desde gráfico.

![img](010.png)


Abrimos una consola para comprobar los resultados.

```console

roberto@smb-server22:~> sudo cat /etc/samba/smb.conf
root's password:
# smb.conf is the main Samba configuration file. You find a full commented
# version at /usr/share/doc/packages/samba/examples/smb.conf.SUSE if the
# samba-doc package is installed.
[global]
	workgroup = mar1718
	passdb backend = tdbsam
	printing = cups
	printcap name = cups
	printcap cache time = 750
	cups options = raw
	map to guest = Bad User
	include = /etc/samba/dhcp.conf
	logon path = \\%L\profiles\.msprofile
	logon home = \\%L\%U\.9xprofile
	logon drive = P:
	usershare allow guests = No
	add machine script = /usr/sbin/useradd  -c Machine -d /var/lib/nobody -s /bin/false %m$
	domain logons = No
	domain master = No
	security = user
[homes]
	comment = Home Directories
	valid users = %S, %D%w%S
	browseable = No
	read only = No
	inherit acls = Yes
[profiles]
	comment = Network Profiles Service
	path = %H
	read only = No
	store dos attributes = Yes
	create mask = 0600
	directory mask = 0700
[users]
	comment = All users
	path = /home
	read only = No
	inherit acls = Yes
	veto files = /aquota.user/groups/shares/
[groups]
	comment = All groups
	path = /home/groups
	read only = No
	inherit acls = Yes
[printers]
	comment = All Printers
	path = /var/tmp
	printable = Yes
	create mask = 0600
	browseable = No
[print$]
	comment = Printer Drivers
	path = /var/lib/samba/drivers
	write list = @ntadmin root
	force group = ntadmin
	create mask = 0664
	directory mask = 0775

## Share disabled by YaST
# [netlogon]

[barco]
	comment = file boat
	inherit acls = Yes
	path = /srv/samba22/barco.d
	read only = No
	valid users = pirata1, pirata2
	vfs objects =

[castillo]
	comment = file castle
	inherit acls = Yes
	path = /srv/samba22/castillo.d
	read only = No
	valid users = @soldados
	vfs objects =

[cdrom]
	comment = CDROM
	guest ok = Yes
	inherit acls = Yes
	path = /dev/cdrom
	read only = Yes
	vfs objects =

[public]
	comment = file public
	guest ok = Yes
	inherit acls = Yes
	path = /srv/samba22/public.d
	read only = Yes
	vfs objects =

```
Utilizamos el siguiente comando en la terminal `testparm`

```console

roberto@smb-server22:~> testparm
Load smb config files from /etc/samba/smb.conf
rlimit_max: increasing rlimit_max (1024) to minimum Windows limit (16384)
Can't find include file /etc/samba/dhcp.conf
Processing section "[homes]"
Processing section "[profiles]"
Processing section "[users]"
Processing section "[groups]"
Processing section "[printers]"
Processing section "[print$]"
Processing section "[barco]"
Processing section "[castillo]"
Processing section "[cdrom]"
Processing section "[public]"
Loaded services file OK.
Server role: ROLE_STANDALONE

Press enter to see a dump of your service definitions

# Global parameters
[global]
	workgroup = MAR1718
	domain master = No
	add machine script = /usr/sbin/useradd -c Machine -d /var/lib/nobody -s /bin/false %m$
	logon drive = P:
	logon home = \\%L\%U\.9xprofile
	logon path = \\%L\profiles\.msprofile
	printcap name = cups
	map to guest = Bad User
	security = USER
	idmap config * : backend = tdb
	include = /etc/samba/dhcp.conf
	cups options = raw


[homes]
	comment = Home Directories
	browseable = No
	inherit acls = Yes
	read only = No
	valid users = %S %D%w%S


[profiles]
	comment = Network Profiles Service
	path = %H
	store dos attributes = Yes
	create mask = 0600
	directory mask = 0700
	read only = No


[users]
	comment = All users
	path = /home
	veto files = /aquota.user/groups/shares/
	inherit acls = Yes
	read only = No


[groups]
	comment = All groups
	path = /home/groups
	inherit acls = Yes
	read only = No


[printers]
	comment = All Printers
	path = /var/tmp
	browseable = No
	printable = Yes
	create mask = 0600


[print$]
	comment = Printer Drivers
	path = /var/lib/samba/drivers
	create mask = 0664
	directory mask = 0775
	force group = ntadmin
	write list = @ntadmin root


[barco]
	comment = file boat
	path = /srv/samba22/barco.d
	inherit acls = Yes
	read only = No
	valid users = pirata1 pirata2


[castillo]
	comment = file castle
	path = /srv/samba22/castillo.d
	inherit acls = Yes
	read only = No
	valid users = @soldados


[cdrom]
	comment = CDROM
	path = /dev/cdrom
	guest ok = Yes
	inherit acls = Yes


[public]
	comment = file public
	path = /srv/samba22/public.d
	guest ok = Yes
	inherit acls = Yes
```


### 1.6 Usuarios Samba

Tenemos que añadir los usuarios locales a samba.

- `smbpasswd -a nombreusuario`

```console

roberto@smb-server22:~> sudo smbpasswd -a soldado1
New SMB password:
Retype new SMB password:
Added user soldado1.
roberto@smb-server22:~> sudo smbpasswd -a soldado2
New SMB password:
Retype new SMB password:
Added user soldado2.
roberto@smb-server22:~> sudo smbpasswd -a pirata1
New SMB password:
Retype new SMB password:
Added user pirata1.
roberto@smb-server22:~> sudo smbpasswd -a pirata2
New SMB password:
Retype new SMB password:
Added user pirata2.
roberto@smb-server22:~> sudo smbpasswd -a smbguest
New SMB password:
Retype new SMB password:
Added user smbguest.
roberto@smb-server22:~> sudo smbpasswd -a supersamba
New SMB password:
Retype new SMB password:
Added user supersamba.
roberto@smb-server22:~>

```

- `pdbedit -L`, para comprobar la lista de usuarios Samba.

``` console

roberto@smb-server22:~> sudo pdbedit -L
soldado1:1009:
pirata1:1006:
smbguest:1005:
soldado2:1010:
pirata2:1007:
supersamba:1008:
roberto@smb-server22:~>

```


### 1.7 Reiniciar

Tenemos que reiniciar el servicio de samba.

- Servicio smb
    - systemctl stop smb
    - systemctl start smb
    - systemctl status smb

```console
roberto@smb-server22:~> sudo systemctl stop smb
roberto@smb-server22:~> sudo systemctl start smb
roberto@smb-server22:~> sudo systemctl status smb
● smb.service - Samba SMB Daemon
   Loaded: loaded (/usr/lib/systemd/system/smb.service; enabled; vendor preset: disabled)
   Active: active (running) since jue 2017-10-26 10:38:15 WEST; 2s ago
  Process: 8471 ExecStartPre=/usr/share/samba/update-apparmor-samba-profile (code=exited, status=0/SUCCESS)
 Main PID: 8482 (smbd)
   Status: "smbd: ready to serve connections..."
    Tasks: 4 (limit: 512)
   CGroup: /system.slice/smb.service
           ├─8482 /usr/sbin/smbd -D
           ├─8483 /usr/sbin/smbd -D
           ├─8484 /usr/sbin/smbd -D
           └─8486 /usr/sbin/smbd -D

oct 26 10:38:15 smb-server22 systemd[1]: Starting Samba SMB Daemon...
oct 26 10:38:15 smb-server22 systemd[1]: smb.service: Supervising process 8482 which is not our child. We'll most likel...exits.
oct 26 10:38:15 smb-server22 smbd[8482]: [2017/10/26 10:38:15.408331,  0] ../lib/util/become_daemon.c:124(daemon_ready)
oct 26 10:38:15 smb-server22 systemd[1]: Started Samba SMB Daemon.
oct 26 10:38:15 smb-server22 smbd[8482]:   STATUS=daemon 'smbd' finished starting up and ready to serve connections
Hint: Some lines were ellipsized, use -l to show in full.

```

- Servicio nmb
    - systemctl stop nmb
    - systemctl start nmb
    - systemctl status nmb


```console

roberto@smb-server22:~> sudo systemctl stop nmb
roberto@smb-server22:~> sudo systemctl start nmb
roberto@smb-server22:~> sudo systemctl status nmb
● nmb.service - Samba NMB Daemon
   Loaded: loaded (/usr/lib/systemd/system/nmb.service; enabled; vendor preset: disabled)
   Active: active (running) since jue 2017-10-26 10:39:16 WEST; 5s ago
 Main PID: 8507 (nmbd)
   Status: "nmbd: ready to serve connections..."
    Tasks: 1 (limit: 512)
   CGroup: /system.slice/nmb.service
           └─8507 /usr/sbin/nmbd -D

oct 26 10:39:16 smb-server22 systemd[1]: Starting Samba NMB Daemon...
oct 26 10:39:16 smb-server22 systemd[1]: nmb.service: Supervising process 8507 which is not our child. We'll most likel...exits.
oct 26 10:39:16 smb-server22 systemd[1]: Started Samba NMB Daemon.
oct 26 10:39:16 smb-server22 nmbd[8507]: [2017/10/26 10:39:16.440900,  0] ../lib/util/become_daemon.c:124(daemon_ready)
oct 26 10:39:16 smb-server22 nmbd[8507]:   STATUS=daemon 'nmbd' finished starting up and ready to serve connections
Hint: Some lines were ellipsized, use -l to show in full.

```



Demonios Samba y servicios relacionados
Capturar imagen de los siguientes comando de comprobación:

    - sudo testparm     # Verifica la sintaxis del fichero de configuración del servidor Samba

```console

roberto@smb-server22:~> sudo testparm
Load smb config files from /etc/samba/smb.conf
rlimit_max: increasing rlimit_max (1024) to minimum Windows limit (16384)
Can't find include file /etc/samba/dhcp.conf
Processing section "[homes]"
Processing section "[profiles]"
Processing section "[users]"
Processing section "[groups]"
Processing section "[printers]"
Processing section "[print$]"
Processing section "[barco]"
Processing section "[castillo]"
Processing section "[cdrom]"
Processing section "[public]"
Loaded services file OK.
Server role: ROLE_STANDALONE

Press enter to see a dump of your service definitions

# Global parameters
[global]
	workgroup = MAR1718
	domain master = No
	add machine script = /usr/sbin/useradd -c Machine -d /var/lib/nobody -s /bin/false %m$
	logon drive = P:
	logon home = \\%L\%U\.9xprofile
	logon path = \\%L\profiles\.msprofile
	printcap name = cups
	map to guest = Bad User
	security = USER
	idmap config * : backend = tdb
	include = /etc/samba/dhcp.conf
	cups options = raw


[homes]
	comment = Home Directories
	browseable = No
	inherit acls = Yes
	read only = No
	valid users = %S %D%w%S


[profiles]
	comment = Network Profiles Service
	path = %H
	store dos attributes = Yes
	create mask = 0600
	directory mask = 0700
	read only = No


[users]
	comment = All users
	path = /home
	veto files = /aquota.user/groups/shares/
	inherit acls = Yes
	read only = No


[groups]
	comment = All groups
	path = /home/groups
	inherit acls = Yes
	read only = No


[printers]
	comment = All Printers
	path = /var/tmp
	browseable = No
	printable = Yes
	create mask = 0600


[print$]
	comment = Printer Drivers
	path = /var/lib/samba/drivers
	create mask = 0664
	directory mask = 0775
	force group = ntadmin
	write list = @ntadmin root


[barco]
	comment = file boat
	path = /srv/samba22/barco.d
	inherit acls = Yes
	read only = No
	valid users = pirata1 pirata2


[castillo]
	comment = file castle
	path = /srv/samba22/castillo.d
	inherit acls = Yes
	read only = No
	valid users = @soldados


[cdrom]
	comment = CDROM
	path = /dev/cdrom
	guest ok = Yes
	inherit acls = Yes


[public]
	comment = file public
	path = /srv/samba22/public.d
	guest ok = Yes
	inherit acls = Yes


```
    - sudo netstat -tap # Vemos que el servicio SMB/CIF está a la escucha
Comprobar CORTAFUEGOS

```console

roberto@smb-server22:~> sudo netstat -tap
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name   
tcp        0      0 *:5801                  *:*                     LISTEN      1475/xinetd         
tcp        0      0 *:netbios-ssn           *:*                     LISTEN      8482/smbd           
tcp        0      0 *:5901                  *:*                     LISTEN      1470/vncmanager     
tcp        0      0 *:ssh                   *:*                     LISTEN      1498/sshd           
tcp        0      0 smb-server22.curso1:ipp *:*                     LISTEN      1460/cupsd          
tcp        0      0 *:microsoft-ds          *:*                     LISTEN      8482/smbd           
tcp        0      0 *:netbios-ssn           *:*                     LISTEN      8482/smbd           
tcp        0      0 *:5901                  *:*                     LISTEN      1470/vncmanager     
tcp        0      0 *:ssh                   *:*                     LISTEN      1498/sshd           
tcp        0      0 localhost:ipp           *:*                     LISTEN      1460/cupsd          
tcp        0      0 localhost:smtp          *:*                     LISTEN      1750/master         
tcp        0      0 *:microsoft-ds          *:*                     LISTEN      8482/smbd       

```

Para descartar un problema con el cortafuegos del servidor Samba.
Probamos el comando `nmap -Pn smb-server22` desde la máquina real, u otra máquina GNU/Linux. Deberían verse los puertos SMB/CIFS(139 y 445) abiertos.

```console

roberto@smb-server22:~> sudo nmap -Pn smb-server22

Starting Nmap 6.47 ( http://nmap.org ) at 2017-10-26 10:45 WEST
Nmap scan report for smb-server22 (127.0.0.1)
Host is up (0.0000030s latency).
Other addresses for smb-server22 (not scanned): 172.18.22.31
rDNS record for 127.0.0.1: smb-server22.curso1718
Not shown: 994 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
631/tcp  open  ipp
5801/tcp open  vnc-http-1
5901/tcp open  vnc-1

Nmap done: 1 IP address (1 host up) scanned in 1.56 seconds


```



## 2. Windows (MV3 smb-cli22b)
Configurar el cliente Windows.
Usar nombre smb-cliXXb y la IP que hemos establecido.
Configurar el fichero ...\etc\hosts de Windows.
En los clientes Windows el software necesario viene preinstalado.

### 2.1 Cliente Windows GUI

Desde un cliente Windows vamos a acceder a los recursos compartidos del servidor Samba.

samba-win7-cliente-gui

Comprobar los accesos de todas las formas posibles. Como si fuéramos:
un soldado
un pirata
y/o un invitado.
Después de cada conexión se quedan guardada la información en el cliente Windows (Ver comando net use).
net use * /d /y, para cerrar las conexión SMB/CIFS que se ha realizado desde el cliente al servidor.
Capturar imagen de los siguientes comandos para comprobar los resultados:
smbstatus, desde el servidor Samba.
netstat -ntap, desde el servidor Samba.
netstat -n, desde el cliente Windows.


###2.2 Cliente Windows comandos

En el cliente Windows, para consultar todas las conexiones/recursos conectados hacemos C:>net use.
Si hubiera alguna conexión abierta la cerramos.
net use * /d /y, para cerrar las conexiones SMB.
net use ahora vemos que NO hay conexiones establecidas.
Capturar imagen de los comandos siguientes:

Abrir una shell de windows. Usar el comando net use /?, para consultar la ayuda del comando.
Vamos a conectarnos desde la máquina Windows al servidor Samba usando el comando net.
Con el comando net view, vemos las máquinas (con recursos CIFS) accesibles por la red.
2.3 Montaje automático

El comando net use S: \\ip-servidor-samba\recurso /USER:clave establece una conexión del rescurso panaderos y lo monta en la unidad S.

Ahora podemos entrar en la unidad S ("s:") y crear carpetas, etc.

Capturar imagen de los siguientes comandos para comprobar los resultados:

smbstatus, desde el servidor Samba.
netstat -ntap, desde el servidor Samba.
netstat -n, desde el cliente Windows.
3 Cliente GNU/Linux (MV2 smb-cliXXa)
Configurar el cliente GNU/Linux.
Usar nombre smb-cliXXa y la IP que hemos establecido.
Configurar el fichero /etc/hosts de la máquina.
3.1 Cliente GNU/Linux GUI

Desde en entorno gráfico, podemos comprobar el acceso a recursos compartidos SMB/CIFS.

Estas son algunas herramientas:

Yast en OpenSUSE
Nautilus en GNOME
Konqueror en KDE
En Ubuntu podemos ir a "Lugares -> Conectar con el servidor..."
También podemos instalar "smb4k".
existen otras para otros entornos gráficos. Busca en tu GNU/Linux la forma de acceder vía GUI.
Ejemplo accediendo al recurso prueba del servidor Samba, pulsamos CTRL+L y escribimos smb://ip-del-servidor-samba:

linux-gui-client

En el momento de autenticarse para acceder al recurso remoto, poner en Dominio el nombre-netbios-del-servidor-samba.
Capturar imagen de lo siguiente:

Probar a crear carpetas/archivos en castillo y en barco.
Comprobar que el recurso public es de sólo lectura.
Capturar imagen de los siguientes comandos para comprobar los resultados:
smbstatus, desde el servidor Samba.
netstat -ntap, desde el servidor Samba.
netstat -n, desde el cliente.
3.2 Cliente GNU/Linux comandos

Capturar imagenes de todo el proceso.

Existen comandos (smbclient, mount , smbmount, etc.) para ayudarnos a acceder vía comandos al servidor Samba desde el cliente. Puede ser que con las nuevas actualizaciones y cambios de las distribuciones alguno haya cambiado de nombre. ¡Ya lo veremos!
Vamos a un equipo GNU/Linux que será nuestro cliente Samba. Desde este equipo usaremos comandos para acceder a la carpeta compartida.
Primero comprobar el uso de las siguientes herramientas:
sudo smbtree                       # Muestra todos los equipos/recursos de la red SMB/CIFS
                                   # Hay que abroir el cortafuegos para que funcione.
smbclient --list ip-servidor-samba # Muestra los recursos SMB/CIFS de un equipo concreto
Ahora crearemos en local la carpeta /mnt/sambaXX-remoto/corusant.
MONTAJE: Con el usuario root, usamos el siguiente comando para montar un recurso compartido de Samba Server, como si fuera una carpeta más de nuestro sistema: mount -t cifs //172.18.XX.55/castillo /mnt/sambaXX-remoto/castillo -o username=soldado1
En versiones anteriores de GNU/Linux se usaba el comando smbmount //smb-serverXX/public /mnt/remotoXX/public/ -o -username=smbguest.
COMPROBAR: Ejecutar el comando df -hT. Veremos que el recurso ha sido montado.
samba-linux-mount-cifs

Si montamos la carpeta de castillo, lo que escribamos en /mnt/remotoXX/castillo debe aparecer en la máquina del servidor Samba. ¡Comprobarlo!
Para desmontar el recurso remoto usamos el comando umount.
Capturar imagen de los siguientes comandos para comprobar los resultados:
smbstatus, desde el servidor Samba.
netstat -ntap, desde el servidor Samba.
netstat -n, desde el cliente Windows.
3.3 Montaje automático

Capturar imágenes del proceso.

Acabamos de acceder a los recursos remotos, realizando un montaje de forma manual (comandos mount/umount). Si reiniciamos el equipo cliente, podremos ver que los montajes realizados de forma manual ya no están (df -hT). Si queremos volver a acceder a los recursos remotos debemos repetir el proceso de montaje manual, a no ser que hagamos una configuración de montaje permanente o automática.

Para configurar acciones de montaje automáticos cada vez que se inicie el equipo, debemos configurar el fichero /etc/fstab. Veamos un ejemplo:
//smb-serverXX/public /mnt/remotoXX/public cifs username=soldado1,password=clave 0 0

Reiniciar el equipo y comprobar que se realiza el montaje automático al inicio.
Incluir contenido del fichero /etc/fstab en la entrega.
4. Preguntas para resolver
¿Las claves de los usuarios en GNU/Linux deben ser las mismas que las que usa Samba?
¿Puedo definir un usuario en Samba llamado soldado3, y que no exista como usuario del sistema?
¿Cómo podemos hacer que los usuarios soldado1 y soldado2 no puedan acceder al sistema pero sí al samba? (Consultar /etc/passwd)
Añadir el recurso [homes] al fichero smb.conf según los apuntes. ¿Qué efecto tiene?
