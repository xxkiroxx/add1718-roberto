# Puppet

![](img/000.png)

## ¿Qué es Puppet?

Según Wikipedia, Puppet es una herramienta diseñada para administrar la configuración de sistemas Unix-like y de Microsoft Windows de forma declarativa. El usuario describe los recursos del sistema y sus estados, ya sea utilizando el lenguaje declarativo de Puppet o un DSL (lenguaje específico del dominio) de Ruby.

Existen varias herramientas para realizar instalaciones desde un punto central, como Chef, Ansible, CFEngine, etc. En este ejemplo, vamos a usar Puppet.

Enlaces de interés:

- Vídeo en inglés [LINUX: Installing the Puppet Master on openSUSE" by TheUrbanPenguin](https://www.youtube.com/watch?v=8jBlUKimPVc&feature=youtu.be)"
- Vídeo en inglés ["LINUX: The Puppet Client and basic site.pp" by por TheUrbanPenguin](https://www.youtube.com/watch?v=KLF1-i8RzGU&feature=youtu.be)
- [Puppetcookbook](http://www.puppetcookbook.com/posts/show-resources-with-ralsh.html)
- Vídeo sin audio (14 minutos) sobre [Puppet en Debian](https://www.youtube.com/watch?v=kPyaI--iAcA&feature=youtu.be)
- [Vídeo en inglés](https://www.youtube.com/watch?v=Hiu_ui2nZa0&feature=youtu.be)minuto 15, 36 minutos de duración.

## 1. Configuración de las Máquinas Virtuales

Antes de comenzar con la configuración de los nombres de equipos, usuarios y dominio, deben estar en minúscula.

### 1.1 Máquina Virtual Master (OpenSUSE)

- Nombre de Equipo: `master22`
- IP estática: `172.18.22.100`
- Dominio: `curso1718`

```console
roberto@master22:~> hostname
master22
roberto@master22:~> hostname -d
curso1718
roberto@master22:~> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:b9:f7:e9 brd ff:ff:ff:ff:ff:ff
    inet 172.18.22.100/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feb9:f7e9/64 scope link
       valid_lft forever preferred_lft forever
roberto@master22:~>
```
#### 1.1.1 Comprobación de la Máquina Virtual(Master22)

```console
roberto@master22:~> date
jue ene 11 09:27:11 WET 2018
roberto@master22:~> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:b9:f7:e9 brd ff:ff:ff:ff:ff:ff
    inet 172.18.22.100/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feb9:f7e9/64 scope link
       valid_lft forever preferred_lft forever
roberto@master22:~> sudo route -n
root's password:
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         172.18.0.1      0.0.0.0         UG    0      0        0 eth0
172.18.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth0
roberto@master22:~> host www.google.es
www.google.es has address 216.58.201.131
www.google.es has IPv6 address 2a00:1450:4003:804::2003
roberto@master22:~> hostname -a
master22
roberto@master22:~> hostname -f
master22.curso1718
roberto@master22:~> hostname -d
curso1718
roberto@master22:~> tail -n 5 /etc/hosts
ff02::2         ipv6-allrouters
ff02::3         ipv6-allhosts
172.18.22.100   master22.curso1718 master22
172.18.22.101	cli1alu22.curso1718	cli1alu22
172.18.22.102	cli2alu22
roberto@master22:~> ping master22
PING master22.curso1718 (127.0.0.2) 56(84) bytes of data.
64 bytes from master22.curso1718 (127.0.0.2): icmp_seq=1 ttl=64 time=0.024 ms
64 bytes from master22.curso1718 (127.0.0.2): icmp_seq=2 ttl=64 time=0.029 ms
64 bytes from master22.curso1718 (127.0.0.2): icmp_seq=3 ttl=64 time=0.031 ms
^C
--- master22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.024/0.028/0.031/0.003 ms
roberto@master22:~> ping master22.curso1718
PING master22.curso1718 (127.0.0.2) 56(84) bytes of data.
64 bytes from master22.curso1718 (127.0.0.2): icmp_seq=1 ttl=64 time=0.023 ms
64 bytes from master22.curso1718 (127.0.0.2): icmp_seq=2 ttl=64 time=0.035 ms
64 bytes from master22.curso1718 (127.0.0.2): icmp_seq=3 ttl=64 time=0.039 ms
^C
--- master22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.023/0.032/0.039/0.008 ms
roberto@master22:~> ping cli1alu22
PING cli1alu22.curso1718 (172.18.22.101) 56(84) bytes of data.
64 bytes from cli1alu22.curso1718 (172.18.22.101): icmp_seq=1 ttl=64 time=0.389 ms
64 bytes from cli1alu22.curso1718 (172.18.22.101): icmp_seq=2 ttl=64 time=0.325 ms
64 bytes from cli1alu22.curso1718 (172.18.22.101): icmp_seq=3 ttl=64 time=0.267 ms
^C
--- cli1alu22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2000ms
rtt min/avg/max/mdev = 0.267/0.327/0.389/0.049 ms
roberto@master22:~> ping cli1alu22.curso1718
PING cli1alu22.curso1718 (172.18.22.101) 56(84) bytes of data.
64 bytes from cli1alu22.curso1718 (172.18.22.101): icmp_seq=1 ttl=64 time=0.271 ms
64 bytes from cli1alu22.curso1718 (172.18.22.101): icmp_seq=2 ttl=64 time=0.319 ms
64 bytes from cli1alu22.curso1718 (172.18.22.101): icmp_seq=3 ttl=64 time=0.319 ms
^C
--- cli1alu22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 0.271/0.303/0.319/0.022 ms
roberto@master22:~> ping cli2alu22
PING cli2alu22 (172.18.22.102) 56(84) bytes of data.
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=22 ttl=128 time=0.247 ms
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=23 ttl=128 time=0.344 ms
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=24 ttl=128 time=0.352 ms
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=25 ttl=128 time=0.355 ms
^C
--- cli2alu22 ping statistics ---
25 packets transmitted, 4 received, 84% packet loss, time 24164ms
rtt min/avg/max/mdev = 0.247/0.324/0.355/0.048 ms
roberto@master22:~>

```
### 1.2 Máquina Virtual cliente1 (OpenSUSE)

- Nombre de Equipo: `cli1alu22`
- IP estática: `172.18.22.101`
- Dominio: `curso1718`

```console
roberto@cli1alu22:~> hostname
cli1alu22
roberto@cli1alu22:~> hostname -d
curso1718
roberto@cli1alu22:~> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:66:f7:12 brd ff:ff:ff:ff:ff:ff
    inet 172.18.22.101/16 brd 172.18.255.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe66:f712/64 scope link
       valid_lft forever preferred_lft forever
roberto@cli1alu22:~>

```
#### 1.2.1 Comprobación de la Máquina Virtual(cli1alu22)

```console
roberto@cli1alu22:~/Escritorio> date
jue ene 11 09:35:18 WET 2018
roberto@cli1alu22:~/Escritorio> ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:66:f7:12 brd ff:ff:ff:ff:ff:ff
    inet 172.18.22.101/16 brd 172.18.255.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe66:f712/64 scope link
       valid_lft forever preferred_lft forever
roberto@cli1alu22:~/Escritorio> sudo route -n
root's password:
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         172.18.0.1      0.0.0.0         UG    0      0        0 eth1
172.18.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth1
roberto@cli1alu22:~/Escritorio> host www.google.es
hwww.google.es has address 216.58.214.163
www.google.es has IPv6 address 2a00:1450:4003:804::2003
oroberto@cli1alu22:~/Escritorio> hostname -a
cli1alu22
roberto@cli1alu22:~/Escritorio> hostname -f
cli1alu22.curso1718
roberto@cli1alu22:~/Escritorio> hostname -d
curso1718
roberto@cli1alu22:~/Escritorio> tail -n 5 /etc/hosts
ff02::2         ipv6-allrouters
ff02::3         ipv6-allhosts
172.18.22.101   cli1alu22.curso1718	cli1alu22
172.18.22.100	master22.curso1718	master22
172.18.22.102	cli2alu22
roberto@cli1alu22:~/Escritorio> ping master22
PING master22.curso1718 (172.18.22.100) 56(84) bytes of data.
64 bytes from master22.curso1718 (172.18.22.100): icmp_seq=1 ttl=64 time=0.289 ms
64 bytes from master22.curso1718 (172.18.22.100): icmp_seq=2 ttl=64 time=0.305 ms
^C
--- master22.curso1718 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 999ms
rtt min/avg/max/mdev = 0.289/0.297/0.305/0.008 ms
roberto@cli1alu22:~/Escritorio> ping master22.curso1718
PING master22.curso1718 (172.18.22.100) 56(84) bytes of data.
64 bytes from master22.curso1718 (172.18.22.100): icmp_seq=1 ttl=64 time=0.279 ms
64 bytes from master22.curso1718 (172.18.22.100): icmp_seq=2 ttl=64 time=0.299 ms
64 bytes from master22.curso1718 (172.18.22.100): icmp_seq=3 ttl=64 time=0.322 ms
^C
--- master22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.279/0.300/0.322/0.017 ms
roberto@cli1alu22:~/Escritorio> ping cli1alu22
PING cli1alu22.curso1718 (127.0.0.2) 56(84) bytes of data.
64 bytes from cli1alu22.curso1718 (127.0.0.2): icmp_seq=1 ttl=64 time=0.016 ms
64 bytes from cli1alu22.curso1718 (127.0.0.2): icmp_seq=2 ttl=64 time=0.025 ms
64 bytes from cli1alu22.curso1718 (127.0.0.2): icmp_seq=3 ttl=64 time=0.025 ms
^C
--- cli1alu22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.016/0.022/0.025/0.004 ms
roberto@cli1alu22:~/Escritorio> ping cli1alu22.curso1718
PING cli1alu22.curso1718 (127.0.0.2) 56(84) bytes of data.
64 bytes from cli1alu22.curso1718 (127.0.0.2): icmp_seq=1 ttl=64 time=0.013 ms
64 bytes from cli1alu22.curso1718 (127.0.0.2): icmp_seq=2 ttl=64 time=0.023 ms
64 bytes from cli1alu22.curso1718 (127.0.0.2): icmp_seq=3 ttl=64 time=0.026 ms
^C
--- cli1alu22.curso1718 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.013/0.020/0.026/0.007 ms
roberto@cli1alu22:~/Escritorio> ping cli2alu22
PING cli2alu22 (172.18.22.102) 56(84) bytes of data.
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=1 ttl=128 time=0.451 ms
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=2 ttl=128 time=0.334 ms
64 bytes from cli2alu22 (172.18.22.102): icmp_seq=3 ttl=128 time=0.356 ms
^C
--- cli2alu22 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 0.334/0.380/0.451/0.053 ms
roberto@cli1alu22:~/Escritorio>

```
### 1.3 Máquina Virtual cliente1 (Windows 7)

- Nombre de Equipo: `cli2alu22`
- IP estática: `172.18.22.102`
- Dominio: `curso1718`

```console
C:\Windows\System32\drivers\etc>hostname
cli2alu22

C:\Windows\System32\drivers\etc>ipconfig

Configuración IP de Windows


Adaptador de Ethernet Conexión de área local:

   Sufijo DNS específico para la conexión. . :
   Vínculo: dirección IPv6 local. . . : fe80::1036:42a:63e0:b9b%11
   Dirección IPv4. . . . . . . . . . . . . . : 172.18.22.102
   Máscara de subred . . . . . . . . . . . . : 255.255.0.0
   Puerta de enlace predeterminada . . . . . : 172.18.0.1

Adaptador de túnel isatap.{EDAC9220-24B4-4EBD-BF38-DB29514CDEB7}:

   Estado de los medios. . . . . . . . . . . : medios desconectados
   Sufijo DNS específico para la conexión. . :

C:\Windows\System32\drivers\etc>

```

#### 1.3.1 Comprobación de la Máquina Virtual(cli2alu22)

```console
C:\Windows\System32\drivers\etc>date
La fecha actual es: 11/01/2018
Escriba la nueva fecha: (dd-mm-aa)

C:\Windows\System32\drivers\etc>ipconfig

Configuración IP de Windows


Adaptador de Ethernet Conexión de área local:

   Sufijo DNS específico para la conexión. . :
   Vínculo: dirección IPv6 local. . . : fe80::1036:42a:63e0:b9b%11
   Dirección IPv4. . . . . . . . . . . . . . : 172.18.22.102
   Máscara de subred . . . . . . . . . . . . : 255.255.0.0
   Puerta de enlace predeterminada . . . . . : 172.18.0.1

Adaptador de túnel isatap.{EDAC9220-24B4-4EBD-BF38-DB29514CDEB7}:

   Estado de los medios. . . . . . . . . . . : medios desconectados
   Sufijo DNS específico para la conexión. . :

C:\Windows\System32\drivers\etc>route print
===========================================================================
ILista de interfaces
 11...08 00 27 c4 71 26 ......Adaptador de escritorio Intel(R) PRO/1000 MT
  1...........................Software Loopback Interface 1
 12...00 00 00 00 00 00 00 e0 Adaptador ISATAP de Microsoft
===========================================================================

IPv4 Tabla de enrutamiento
===========================================================================
Rutas activas:
Destino de red        Máscara de red   Puerta de enlace   Interfaz  Métrica
          0.0.0.0          0.0.0.0       172.18.0.1    172.18.22.102    266
        127.0.0.0        255.0.0.0      En vínculo         127.0.0.1    306
        127.0.0.1  255.255.255.255      En vínculo         127.0.0.1    306
  127.255.255.255  255.255.255.255      En vínculo         127.0.0.1    306
       172.18.0.0      255.255.0.0      En vínculo     172.18.22.102    266
    172.18.22.102  255.255.255.255      En vínculo     172.18.22.102    266
   172.18.255.255  255.255.255.255      En vínculo     172.18.22.102    266
        224.0.0.0        240.0.0.0      En vínculo         127.0.0.1    306
        224.0.0.0        240.0.0.0      En vínculo     172.18.22.102    266
  255.255.255.255  255.255.255.255      En vínculo         127.0.0.1    306
  255.255.255.255  255.255.255.255      En vínculo     172.18.22.102    266
===========================================================================
Rutas persistentes:
  Dirección de red  Máscara de red  Dirección de puerta de enlace  Métrica
          0.0.0.0          0.0.0.0       172.18.0.1  Predeterminada
===========================================================================

IPv6 Tabla de enrutamiento
===========================================================================
Rutas activas:
 Cuando destino de red métrica      Puerta de enlace
  1    306 ::1/128                  En vínculo
 11    266 fe80::/64                En vínculo
 11    266 fe80::1036:42a:63e0:b9b/128
                                    En vínculo
  1    306 ff00::/8                 En vínculo
 11    266 ff00::/8                 En vínculo
===========================================================================
Rutas persistentes:
  Ninguno

C:\Windows\System32\drivers\etc>nslookup www.google.es
Servidor:  google-public-dns-a.google.com
Address:  8.8.8.8

Respuesta no autoritativa:
Nombre:  www.google.es
Addresses:  2a00:1450:4003:801::2003
          216.58.211.227


C:\Windows\System32\drivers\etc>ping master22

Haciendo ping a master22.curso1718 [172.18.22.100] con 32 bytes de datos:
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64

Estadísticas de ping para 172.18.22.100:
    Paquetes: enviados = 4, recibidos = 4, perdidos = 0
    (0% perdidos),
Tiempos aproximados de ida y vuelta en milisegundos:
    Mínimo = 0ms, Máximo = 0ms, Media = 0ms

C:\Windows\System32\drivers\etc>ping master22.curso1718

Haciendo ping a master22.curso1718 [172.18.22.100] con 32 bytes de datos:
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.100: bytes=32 tiempo<1m TTL=64

Estadísticas de ping para 172.18.22.100:
    Paquetes: enviados = 4, recibidos = 4, perdidos = 0
    (0% perdidos),
Tiempos aproximados de ida y vuelta en milisegundos:
    Mínimo = 0ms, Máximo = 0ms, Media = 0ms

C:\Windows\System32\drivers\etc>ping cli1alu22.curso1718

Haciendo ping a cli1alu22.curso1718 [172.18.22.101] con 32 bytes de datos:
Respuesta desde 172.18.22.101: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.101: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.101: bytes=32 tiempo<1m TTL=64
Respuesta desde 172.18.22.101: bytes=32 tiempo<1m TTL=64

Estadísticas de ping para 172.18.22.101:
    Paquetes: enviados = 4, recibidos = 4, perdidos = 0
    (0% perdidos),
Tiempos aproximados de ida y vuelta en milisegundos:
    Mínimo = 0ms, Máximo = 0ms, Media = 0ms

C:\Windows\System32\drivers\etc>ping cli2alu22.curso1718
La solicitud de ping no pudo encontrar el host cli2alu22.curso1718. Compruebe el
 nombre y
vuelva a intentarlo.

C:\Windows\System32\drivers\etc>ping cli2alu22

Haciendo ping a cli2alu22 [127.0.0.2] con 32 bytes de datos:
Respuesta desde 127.0.0.2: bytes=32 tiempo<1m TTL=128
Respuesta desde 127.0.0.2: bytes=32 tiempo<1m TTL=128
Respuesta desde 127.0.0.2: bytes=32 tiempo<1m TTL=128
Respuesta desde 127.0.0.2: bytes=32 tiempo<1m TTL=128

Estadísticas de ping para 127.0.0.2:
    Paquetes: enviados = 4, recibidos = 4, perdidos = 0
    (0% perdidos),
Tiempos aproximados de ida y vuelta en milisegundos:
    Mínimo = 0ms, Máximo = 0ms, Media = 0ms

C:\Windows\System32\drivers\etc>type hosts
    # Copyright (c) 1993-2009 Microsoft Corp.
    #
    # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
    #
    # This file contains the mappings of IP addresses to host names. Each
    # entry should be kept on an individual line. The IP address should
    # be placed in the first column followed by the corresponding host name.
    # The IP address and the host name should be separated by at least one
    # space.
    #
    # Additionally, comments (such as these) may be inserted on individual
    # lines or following the machine name denoted by a '#' symbol.
    #
    # For example:
    #
    #      102.54.94.97     rhino.acme.com          # source server
    #       38.25.63.10     x.acme.com              # x client host

    # localhost name resolution is handled within DNS itself.
    #       127.0.0.1       localhost
    #       ::1             localhost
            127.0.0.2       cli2alu22
            172.18.22.102   cli2alu22
            172.18.22.101   cli1alu22.curso1718     cli1alu22
            172.18.22.100   master22.curso1718      master22
C:\Windows\System32\drivers\etc>
```
## 2. Instalación de Puppet en OpenSUSE - Master22

Tenemos que escribir en la terminal el siguiente comando.

- `zypper install rubygem-puppet-master`

```console
roberto@master22:~> sudo zypper install rubygem-puppet-master
root's password:
Cargando datos del repositorio...
Leyendo los paquetes instalados...
Resolviendo dependencias de paquete...

Los siguientes 13 paquetes NUEVOS van a ser instalados:
  make ruby2.1-rubygem-facter ruby2.1-rubygem-hiera ruby2.1-rubygem-json_pure
  ruby2.1-rubygem-puppet ruby2.1-rubygem-ruby-shadow rubygem-facter
  rubygem-hiera rubygem-puppet rubygem-puppet-master rubygem-puppet-vim
  site-config virt-what

Se seleccionó automáticamente el siguiente paquete recomendado:
  ruby2.1-rubygem-ruby-shadow

13 nuevos paquetes a instalar.
Tamaño total de descarga: 5,1 MiB. Ya en caché: 0 B. Después de la operación, se
utilizarán 11,7 MiB adicionales.
¿Desea continuar? [s/n/? mostrar todas las opciones] (s): s
```

- Estos son los comandos para parar, reiniciar, el servicio.
    - `systemctl status puppetmaster`: Consultar el estado del servicio.
    - `systemctl enable puppetmaster`: Permitir que el servicio se inicie automáticamente en el inicio de la máquina.
    - `systemctl start puppetmaster`: Iniciar el servicio.
    - `systemctl status puppetmaster`: Consultar el estado del servicio.

Establecemos el siguiente orden de comandos para tener activado el servicio de `puppetmaster` cada vez que inicie openSUSE.

```console
roberto@master22:~> sudo systemctl start puppetmaster.service
roberto@master22:~> sudo systemctl status puppetmaster.service
● puppetmaster.service - Puppet master
   Loaded: loaded (/usr/lib/systemd/system/puppetmaster.service; disabled; vendor preset: disabled)
   Active: active (running) since jue 2018-01-11 09:59:45 WET; 2s ago
 Main PID: 3416 (puppet)
    Tasks: 2 (limit: 512)
   CGroup: /system.slice/puppetmaster.service
           └─3416 /usr/bin/ruby.ruby2.1 /usr/bin/puppet master --no-daemonize...

ene 11 09:59:45 master22 systemd[1]: Started Puppet master.
roberto@master22:~> sudo systemctl enable puppetmaster.service
Created symlink from /etc/systemd/system/multi-user.target.wants/puppetmaster.service to /usr/lib/systemd/system/puppetmaster.service.
roberto@master22:~>
```
### 2.1 Primera versión del fichero pp

Tenemos que ir a la siguiente ruta `/etc/puppet` y debemos crear los siguientes directorios y ficheros.

```console
mkdir /etc/puppet/files
touch /etc/puppet/files/readme.txt
mkdir /etc/puppet/manifests
touch /etc/puppet/manifests/site.pp
mkdir /etc/puppet/manifests/classes
touch /etc/puppet/manifests/classes/hostlinux1.pp
```

Comprobamos con el comando `tree` el resultado de los directorios y ficheros creados.

```console
roberto@master22:/etc/puppet> tree
.
├── auth.conf
├── files
│   └── readme.txt
├── fileserver.conf
├── manifests
│   ├── classes
│   │   └── hostlinux1.pp
│   └── site.pp
├── puppet.conf
└── tagmail.conf

3 directories, 7 files
```
### 2.2 readme.txt

Los ficheros que se guardan en `/etc/puppet/files` se pueden descargar desde el resto de máquinas cliente puppet.

    Contenido para readme.txt: "¡Al abordaje!".

![](img/001.png)

### 2.3 site.pp

- `/etc/puppet/manifests/site.pp` es el fichero principal de configuración de órdenes para los agentes/nodos puppet.

- Contenido de nuestro site.pp:

```console
import "classes/*"

node default {
  include hostlinux1
}
```
![](img/002.png)

- Esta configuración significa:

    - Todos los ficheros de configuración del directorio classes se añadirán a este fichero.
    - Todos los nodos/clientes van a usar la configuración hostlinux1

### 2.4 hostlinux1.pp

Como podemos tener muchas configuraciones, vamos a separarlas en distintos ficheros para organizarnos mejor, y las vamos a guardar en la ruta `/etc/puppet/manifests/classes`

- Vamos a crear una primera configuración para máquina estándar GNU/Linux.

    - Contenido para /etc/puppet/manifests/classes/hostlinux1.pp:

```console
class hostlinux1 {
  package { "tree": ensure => installed }
  package { "traceroute": ensure => installed }
  package { "geany": ensure => installed }
}
```

![](img/003.png)

- `tree /etc/puppet`, consultar los ficheros/directorios que tenemos creado.

![](img/003.png)

- Comprobar que tenemos los permisos adecuados en la ruta `/var/lib/puppet`. Esto es, usuario puppet y grupo puppet.

```console
roberto@master22:/etc/puppet> sudo ls -l /var/lib/puppet/
total 0
drwxr-x--- 1 puppet puppet   0 ene 11 09:59 bucket
drwxr-xr-x 1 root   root     0 ene 11 09:59 facts.d
drwxr-xr-x 1 root   root     0 ene 11 09:59 lib
drwxr-x--- 1 puppet puppet   0 ene 11 09:59 preview
drwxr-x--- 1 puppet puppet   0 ene 11 09:59 reports
drwxr-x--- 1 puppet puppet   0 ene 11 09:59 rrd
drwxr-x--- 1 puppet puppet   0 ene 11 09:59 server_data
drwxrwx--x 1 puppet puppet 128 ene 11 09:59 ssl
drwxr-xr-t 1 root   root     0 ene 11 09:59 state
drwxr-x--- 1 puppet puppet   0 ene 11 09:59 yaml
roberto@master22:/etc/puppet>

```
- Reiniciamos el servicio systemctl restart puppetmaster.

```console
roberto@master22:/etc/puppet> sudo systemctl restart puppetmaster.service
```

- Comprobamos que el servicio está en ejecución de forma correcta.
    - `systemctl status puppetmaster`

```console
roberto@master22:/etc/puppet> sudo systemctl status puppetmaster.service
● puppetmaster.service - Puppet master
   Loaded: loaded (/usr/lib/systemd/system/puppetmaster.service; enabled; vendor preset: disabled)
   Active: active (running) since jue 2018-01-11 10:27:02 WET; 10s ago
 Main PID: 4397 (puppet)
    Tasks: 3 (limit: 512)
   CGroup: /system.slice/puppetmaster.service
           └─4397 /usr/bin/ruby.ruby2.1 /usr/bin/puppet master --no-daemonize...

ene 11 10:27:02 master22 systemd[1]: Stopped Puppet master.
ene 11 10:27:02 master22 systemd[1]: Started Puppet master.
ene 11 10:27:03 master22 puppet[4397]: Notice: Starting Puppet master versi....7
Hint: Some lines were ellipsized, use -l to show in full.
roberto@master22:/etc/puppet>
```
    - `netstat -ntap | grep ruby`

```console
roberto@master22:/etc/puppet> sudo netstat -ntap | grep ruby
tcp        0      0 0.0.0.0:8140            0.0.0.0:*               LISTEN      4397/ruby.ruby2.1   
roberto@master22:/etc/puppet>
```
- Consultamos log por si hay errores: `tail /var/log/puppet/*.log`

```console
roberto@master22:/etc/puppet> sudo tail /var/log/puppet/*.log
tail: no se puede abrir '/var/log/puppet/*.log' para lectura: No existe el fichero o el directorio
roberto@master22:/etc/puppet>
```

No existe el fichero porque el servicio `puppet` no ha tenido errores.

- Abrir el cortafuegos para el servicio. Tenemos que ir a `Yast -> cortafuegos`

    - Vamos a servicios autorizados y agregamos los servicio de `Puppet`

![](img/005.png)

## 3. Instalación y configuración del cliente1

Vamos a instalar y configurar en el cliente1 el `puppet agente`

- `sudo zypper install rubygem-puppet`

```console
roberto@cli1alu22:~> sudo zypper install rubygem-puppet
root's password:
Cargando datos del repositorio...
Leyendo los paquetes instalados...
Resolviendo dependencias de paquete...

Los siguientes 12 paquetes NUEVOS van a ser instalados:
  make ruby2.1-rubygem-facter ruby2.1-rubygem-hiera ruby2.1-rubygem-json_pure
  ruby2.1-rubygem-puppet ruby2.1-rubygem-ruby-shadow rubygem-facter
  rubygem-hiera rubygem-puppet rubygem-puppet-vim site-config virt-what

Se seleccionó automáticamente el siguiente paquete recomendado:
  ruby2.1-rubygem-ruby-shadow

12 nuevos paquetes a instalar.
Tamaño total de descarga: 5,1 MiB. Ya en caché: 0 B. Después de la operación, se
utilizarán 11,7 MiB adicionales.
¿Desea continuar? [s/n/? mostrar todas las opciones] (s): s
Recuperando paquete make-4.0-5.54.x86_64
                                    (1/12), 381,3 KiB (  1,0 MiB desempaquetado)
Recuperando: make-4.0-5.54.x86_64.rpm .................[terminado (333,4 KiB/s)]
```

- Tenemos que modificar el siguiente fichero de configuración de `puppet` en el cliente1.
- La ruta del fichero es: `/etc/puppet/puppet.conf`

![](img/006.png)

- Comprobar que tenemos los permisos adecuados en la ruta /var/lib/puppet.

    - `systemctl status puppet`: Ver el estado del servicio puppet.

```console
roberto@cli1alu22:~> sudo systemctl status puppet
● puppet.service - Puppet agent
   Loaded: loaded (/usr/lib/systemd/system/puppet.service; disabled; vendor preset: disabled)
   Active: active (running) since jue 2018-01-11 10:43:11 WET; 4s ago
 Main PID: 3454 (puppet)
    Tasks: 2 (limit: 512)
   CGroup: /system.slice/puppet.service
           └─3454 /usr/bin/ruby.ruby2.1 /usr/bin/puppet agent --no-daemonize

ene 11 10:43:11 cli1alu22 systemd[1]: Started Puppet agent.

```
    - `systemctl enable puppet`: Activar el servicio en cada reinicio de la máquina.

```console
roberto@cli1alu22:~> sudo systemctl enable puppet
Created symlink from /etc/systemd/system/multi-user.target.wants/puppet.service to /usr/lib/systemd/system/puppet.service.
roberto@cli1alu22:~>

    - `systemctl start puppet`: Iniciar el servicio puppet.

```console
roberto@cli1alu22:~> sudo systemctl start puppet
```
