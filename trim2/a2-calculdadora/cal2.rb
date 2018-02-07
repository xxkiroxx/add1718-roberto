#!/usr/bin/ruby

if ARGV.size !=1
  puts "Ayuda para utilizar la calculadora"
  puts "Primer argumento tienes que ponder un número"
  puts "En el segundo argumento (+, -, /, x)"
  puts "El tercer argumento un número"
  puts "------------------------------------------------"
  puts "------------------ Ejemplo ---------------------"
  puts "---------- Ejemplo de Suma = 1 + 1--------------"
  puts "---------- Ejemplo de Resta = 1 - 1-------------"
  puts "----- Ejemplo de Multiplicación = 1 x 1---------"
  puts "---------- Ejemplo de División = 1 / 1----------"
  puts "------------------------------------------------"
else
  operaciones=ARGV[0]
  contenido=`cat #{operaciones}`
  separar_lineas=contenido.split("\n")

  separar_lineas.each do |separar_linea|
    elementos=separar_linea.split()
    num1=elementos[0].to_i
    operador=elementos[1]
    num2=elementos[2].to_i
    if operador == "+"
      suma = num1 + num2
      puts "#{num1} + #{num2} = #{suma}"
      elsif operador == "-"
        resta = num1 - num2
        puts "#{num1} - #{num2} = #{resta}"
      elsif operador == "x"
        multi = num1 * num2
        puts "#{num1} x #{num2} = #{multi}"
      elsif operador == "/"
        division = num1 / num2
        puts "#{num1} / #{num2} = #{division}"
    else
        puts "Error"
    end
end
end
