#!/usr/bin/ruby

if ARGV.size !=1
  puts "Falta fichero de texto de usuario o argumento"
else
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
end
