#!/usr/bin/ruby

numberos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

puts ""
puts "Versión con for y array"
puts ""

for number in(numberos)
  mult = number * 7
  puts "7 X #{number} = #{mult}"
end

puts ""
puts "Versión de Iteradores y array"
puts ""

numberos.each do |number|
  mult = number * 7
  puts "7 X #{number} = #{mult}"
end
