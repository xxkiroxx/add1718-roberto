# Servidor LDAP - OpenSUSE

![](img/000.jpg)

## 1. Servidor LDAP

Existen varias herramientas que implementan el protocolo de `LDAP`, pero en esta guía vamos a instalar la aplicación de `OpenLDADP`.

### 1.1 Preparar la máquina

Con el OpenSUSE 42.2 vamos a configurar:

- Nombre Equipo

![](img/001.png)

- /etc/hosts

![](img/002.png)

### 1.2 Instalación del Servidor LDAP

Instalamos el modulo `sudo zypper in yast2-auth-server`

![](img/003.png)

- Tenemos que realizar los siguientes pasos:

    - `Yast -> Servidor de autenticación.`

    ![](img/004.png)

    - Se requiere, además, instalar los paquetes: openldap2, krb5-server y krb5-client.

    ![](img/005.png)

    - Iniciar servidor LDAP -> Sí

    ![](img/006.png)

    - Registrar dameon SLP -> No

    ![](img/007.png)

    - Puerto abierto en el cortafuegos -> Sí -> Siguiente

    ![](img/008.png)

    - Tipo de servidor -> autónomo -> Siguiente

    ![](img/009.png)

    - Configuración TLS -> NO habilitar -> Siguiente

    ![](img/010.png)

    - Tipo de BD -> hdb

    - DN base -> dc=roberto22,dc=curso1718.

    - DN administrador -> dn=Administrator

    - Añadir DN base -> Sí

    - Contraseña del administrador

    - Directorio de BD -> /var/lib/ldap

    - Usar esta BD predeterminada para clientes LDAP -> Sí -> Siguiente

    ![](img/011.png)
