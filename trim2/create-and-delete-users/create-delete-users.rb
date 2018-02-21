#!/usr/bin/ruby


if `whoami`.rstrip != "root"
  puts "El script debe ejecutarse con el usuario #{root}"
  exit
end

nombrefichero = ARGV[0]
if not File.exists?(nombrefichero)
  puts "El fichero no existe"
  exit
end

if ARGV.size !=1
  puts "Falta fichero de texto de usuario o argumento"
  exit
else
  lista_usuarios    = ARGV[0]
  contenido         = `cat #{lista_usuarios}`
  separar_linea  = contenido.split("\n")
  separar_linea.each do |usuario|
    separar_usuario = usuario.split(":")
    id_usuario = system("id #{separar_usuario[0]} &> /dev/null")
    if separar_usuario[4] == "add"
      if  id_usuario == true
        puts "El usuario #{separar_usuario[0]} ya existe"
      else
        system("useradd -m #{separar_usuario[0]} &> /dev/null")
        puts "El usuario #{separar_usuario[0]} fue creado correctamente"
      end
    elsif separar_usuario[4] == "del"
      if  id_usuario == true
        system("userdel -fr #{separar_usuario[0]} &> /dev/null")
        puts "El usuario #{separar_usuario[0]} fue eliminado correctamente"
      else
        puts "El usuario #{separar_usuario[0]} no existe"
      end
    else
      puts "La opción no es correctamente"
    end
  end
end
