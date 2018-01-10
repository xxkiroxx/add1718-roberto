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

### 1.3 Máquina Virtual cliente1 (Windows 7)

- Nombre de Equipo: `cli2alu22`
- IP estática: `172.18.22.102`
- Dominio: `curso1718`

```console


```
