#!/usr/bin/ruby

numbero1=ARGV[0].to_i
operador=ARGV[1]
numbero2=ARGV[2].to_i


if operador == "+"
  suma = numbero1 + numbero2
  puts "------------------------------------"
  puts "-----------Mi Calculdadora----------"
  puts "#{numbero1} + #{numbero2} = #{suma}"
  elsif operador == "-"
    resta = numbero1 - numbero2
    puts "------------------------------------"
    puts "-----------Mi Calculdadora----------"
    puts "#{numbero1} - #{numbero2} = #{resta}"
  elsif operador == "x"
    multi = numbero1 * numbero2
    puts "------------------------------------"
    puts "-----------Mi Calculdadora----------"
    puts "#{numbero1} x #{numbero2} = #{multi}"
  elsif operador == "/"
    division = numbero1 / numbero2
    puts "------------------------------------"
    puts "-----------Mi Calculdadora----------"
    puts "#{numbero1} / #{numbero2} = #{division}"
  else
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
end
