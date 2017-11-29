# Vagrant y VirtualBox

## 1. Introducción

Según Wikipedia:

    Vagrant es una herramienta para la creación y configuración de entornos
    de desarrollo virtualizados.

    Originalmente se desarrolló para VirtualBox y sistemas de configuración tales
    como Chef, Salt y Puppet. Sin embargo desde la versión 1.1 Vagrant es
    capaz de trabajar con múltiples proveedores, como VMware, Amazon EC2, LXC, DigitalOcean, etc.2

    Aunque Vagrant se ha desarrollado en Ruby se puede usar en multitud de
    proyectos escritos en otros lenguajes.

## 2. Instalar Vagrant

La instalación de vagrant en la máquina real.

Vamos a la página de vagrant y descargamos el paquete `vagrant.deb` y lo instalamos de la siguiente manera.

![](img/001.png)

Para ver la versión de `vagrant`.

``` console
kiro@vergil:~$ vagrant -v
Vagrant 2.0.1
kiro@vergil:~$
```
Necesitamos comprobar la version de `VirtualBox`.

```console
kiro@vergil:~$ VBoxManage -v
5.2.0r118431
kiro@vergil:~$

```
### 2.2 Proyecto

Creamos un directorio para nuestro proyecto `vagrant`

![](img/002.png)

Comprobamos que se creo el fichero `Vagrantfile`

```console
kiro@vergil:~/Documentos/mivagrant22$ ls -l
total 4
-rw-r--r-- 1 kiro kiro 3011 nov 29 12:43 Vagrantfile
kiro@vergil:~/Documentos/mivagrant22$
```
### 2.3 Imagen, Caja o Box

Tenemos que descargar una imagen(caja,box) de un sistema operativo. Vamos, por ejemplo, a conseguir una imagen de un `Ubuntu Precise de 32 bits:`

![](img/003.png)

En caso de eliminar una caja o box debemos introducir el siguiente comando.

- `vagrant box remove nombrecaja`

```console
kiro@vergil:~/Documentos/mivagrant22$ vagrant box remove micaja22_ubuntu_precise32
Removing box 'micaja22_ubuntu_precise32' (v0) with provider 'virtualbox'...
kiro@vergil:~/Documentos/mivagrant22$
```

Comprobamos que tenemos la caja descargada.

![](img/004.png)

Para realizar una caja determinada tenemos que modificar el fichero `vagrantfile`(dentro de la carpeta de nuestro proyecto mivagrant22)

Tenemos que configurar las líneas `config.vm.box = "base"` por `config.vm.box = "micaja22_ubuntu_precise32"`

Primero tenemos que copiar el fichero de configuración para tener un respaldo.

```console
kiro@vergil:~/Documentos/mivagrant22$ cp Vagrantfile Vagrantfile.bak
kiro@vergil:~/Documentos/mivagrant22$ ls -l
total 8
-rw-r--r-- 1 kiro kiro 3011 nov 29 12:43 Vagrantfile
-rw-r--r-- 1 kiro kiro 3011 nov 29 13:11 Vagrantfile.bak
kiro@vergil:~/Documentos/mivagrant22$
```
Modificamos el fichero de configuración `Vagrantfile`.

![](img/005.png)

### 2.4 Iniciar una nueva máquina.

Vamos a iniciar una máquina virtual nueva usando `Vagrant`

- Entramos en nuestro directorio de vagrant y ejecutamos el siguiente comando para ejecutar la máquina virtual.

![](img/006.png)

Si queremos conectarnos debemos utilizar el siguiente comando.

- `vagrant ssh` : Conectar/entrar en nuestra máquina.

Otros comando útiles de Vagrant son:

- `vagrant suspend`: Suspender la máquina virtual. Tener en cuenta que la MV en modo suspendido consume más espacio en disco debido a que el estado de la  máquina virtual que suele almacenarse en la RAM se pasa a disco.

- `vagrant resume` : Volver a despertar la máquina virtual.

- `vagrant halt`: Apagarla la máquina virtual.

- `vagrant status`: Estado actual de la máquina virtual.

- `vagrant destroy`: Para eliminar la máquina virtual (No los ficheros de configuración).

Comprobamos y nos conectamos a la máquina virtual.

![](img/007.png)

## 3. Configuración del Entorno Virtual.
### 3.1 Carpetas sincronizadas

Primero tenemos que identificar las carpetas compartidas dentro del entorno virtual.

![](img/008.png)

### 3.2 Redireccionamiento de los puertos

Primero tenemos que instalar el apache en la maquina virtual.

- `vagrant ssh`

- `apt-get install apache2`

Proceso de instalación.

```console

kiro@vergil:~/Documentos/mivagrant22$ vagrant ssh
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

 * Documentation:  https://help.ubuntu.com/
New release '14.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Welcome to your Vagrant-built virtual machine.
Last login: Fri Sep 14 06:22:31 2012 from 10.0.2.2
vagrant@precise32:~$ ls /vagrant/
Vagrantfile  Vagrantfile.bak
vagrant@precise32:~$ apt-get install apache2
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?
vagrant@precise32:~$ sudo apt-get install apache2
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following extra packages will be installed:
  apache2-mpm-worker apache2-utils apache2.2-bin apache2.2-common libapr1 libaprutil1
  libaprutil1-dbd-sqlite3 libaprutil1-ldap ssl-cert
Suggested packages:
  www-browser apache2-doc apache2-suexec apache2-suexec-custom openssl-blacklist
The following NEW packages will be installed:
  apache2 apache2-mpm-worker apache2-utils apache2.2-bin apache2.2-common libapr1
  libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap ssl-cert
0 upgraded, 10 newly installed, 0 to remove and 66 not upgraded.
Need to get 1,829 kB of archives.
After this operation, 5,311 kB of additional disk space will be used.
Do you want to continue [Y/n]? y
Get:1 http://us.archive.ubuntu.com/ubuntu/ precise/main libapr1 i386 1.4.6-1 [91.3 kB]
Get:2 http://us.archive.ubuntu.com/ubuntu/ precise/main libaprutil1 i386 1.3.12+dfsg-3 [75.4 kB]
Get:3 http://us.archive.ubuntu.com/ubuntu/ precise/main libaprutil1-dbd-sqlite3 i386 1.3.12+dfsg-3 [10.2 kB]
Get:4 http://us.archive.ubuntu.com/ubuntu/ precise/main libaprutil1-ldap i386 1.3.12+dfsg-3 [7,962 B]
Get:5 http://us.archive.ubuntu.com/ubuntu/ precise/main apache2.2-bin i386 2.2.22-1ubuntu1 [1,317 kB]
Get:6 http://us.archive.ubuntu.com/ubuntu/ precise/main apache2-utils i386 2.2.22-1ubuntu1 [89.2 kB]
Get:7 http://us.archive.ubuntu.com/ubuntu/ precise/main apache2.2-common i386 2.2.22-1ubuntu1 [221 kB]
Get:8 http://us.archive.ubuntu.com/ubuntu/ precise/main apache2-mpm-worker i386 2.2.22-1ubuntu1 [2,290 B]
Get:9 http://us.archive.ubuntu.com/ubuntu/ precise/main apache2 i386 2.2.22-1ubuntu1 [1,496 B]
Get:10 http://us.archive.ubuntu.com/ubuntu/ precise-updates/main ssl-cert all 1.0.28ubuntu0.1 [12.3 kB]
Fetched 1,829 kB in 1s (1,277 kB/s)
Preconfiguring packages ...
Selecting previously unselected package libapr1.
(Reading database ... 29361 files and directories currently installed.)
Unpacking libapr1 (from .../libapr1_1.4.6-1_i386.deb) ...
Selecting previously unselected package libaprutil1.
Unpacking libaprutil1 (from .../libaprutil1_1.3.12+dfsg-3_i386.deb) ...
Selecting previously unselected package libaprutil1-dbd-sqlite3.
Unpacking libaprutil1-dbd-sqlite3 (from .../libaprutil1-dbd-sqlite3_1.3.12+dfsg-3_i386.deb) ...
Selecting previously unselected package libaprutil1-ldap.
Unpacking libaprutil1-ldap (from .../libaprutil1-ldap_1.3.12+dfsg-3_i386.deb) ...
Selecting previously unselected package apache2.2-bin.
Unpacking apache2.2-bin (from .../apache2.2-bin_2.2.22-1ubuntu1_i386.deb) ...
Selecting previously unselected package apache2-utils.
Unpacking apache2-utils (from .../apache2-utils_2.2.22-1ubuntu1_i386.deb) ...
Selecting previously unselected package apache2.2-common.
Unpacking apache2.2-common (from .../apache2.2-common_2.2.22-1ubuntu1_i386.deb) ...
Selecting previously unselected package apache2-mpm-worker.
Unpacking apache2-mpm-worker (from .../apache2-mpm-worker_2.2.22-1ubuntu1_i386.deb) ...
Selecting previously unselected package apache2.
Unpacking apache2 (from .../apache2_2.2.22-1ubuntu1_i386.deb) ...
Selecting previously unselected package ssl-cert.
Unpacking ssl-cert (from .../ssl-cert_1.0.28ubuntu0.1_all.deb) ...
Processing triggers for man-db ...
Processing triggers for ufw ...
Processing triggers for ureadahead ...
ureadahead will be reprofiled on next reboot
Setting up libapr1 (1.4.6-1) ...
Setting up libaprutil1 (1.3.12+dfsg-3) ...
Setting up libaprutil1-dbd-sqlite3 (1.3.12+dfsg-3) ...
Setting up libaprutil1-ldap (1.3.12+dfsg-3) ...
Setting up apache2.2-bin (2.2.22-1ubuntu1) ...
Setting up apache2-utils (2.2.22-1ubuntu1) ...
Setting up apache2.2-common (2.2.22-1ubuntu1) ...
Enabling site default.
Enabling module alias.
Enabling module autoindex.
Enabling module dir.
Enabling module env.
Enabling module mime.
Enabling module negotiation.
Enabling module setenvif.
Enabling module status.
Enabling module auth_basic.
Enabling module deflate.
Enabling module authz_default.
Enabling module authz_user.
Enabling module authz_groupfile.
Enabling module authn_file.
Enabling module authz_host.
Enabling module reqtimeout.
Setting up apache2-mpm-worker (2.2.22-1ubuntu1) ...
 * Starting web server apache2                                                           apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName
                                                                                  [ OK ]
Setting up apache2 (2.2.22-1ubuntu1) ...
Setting up ssl-cert (1.0.28ubuntu0.1) ...
Processing triggers for libc-bin ...
ldconfig deferred processing now taking place
vagrant@precise32:~$
```

- Modificamos el fichero `Vagrantfile` de modo que el puerto 4567 del sistema anfitrión sea enrutado al puerto 80 del ambiente virtualizado.

![](img/009.png)

- Tenemos que recargar o refrescar los cambios en el fichero `Vagrantfile`.

![](img/010.png)

Para confirmar que hay un servicio a la escucha en 4567, desde la máquina real podemos ejecutar los siguientes comandos:

- nmap -p 4500-4600 localhost, debe mostrar 4567/tcp open tram.

![](img/011.png)

- netstat -ntap, debe mostrar tcp 0.0.0.0:4567 0.0.0.0:* ESCUCHAR.

![](img/012.png)

- En la máquina real, abrimos el navegador web con el URL http://127.0.0.1:4567. En realidad estamos accediendo al puerto 80 de nuestro sistema virtualizado.

![](img/013.png)

## 4. Ejemplos de configuración Vagrantfile
