#!/usr/bin/ruby

lista_usuarios    = ARGV[0]
contenido         = `cat #{lista_usuarios}`
separar_usuarios  = contenido.split("\n")

separar_usuarios.each do |usuario|
id_usuario = system("id #{usuario} &> /dev/null")

  if  id_usuario == true
    system("userdel -fr #{usuario} &> /dev/null")
    puts "El usuario #{usuario} fue eliminado correctamente"
  else
    puts "El usuario #{usuario} no existe"
  end
end
