#Crear un menú con 4 opciones:
def mostrar_menu
  puts '  -------------------------------------------------------------------------------------'
  puts ' |                                   MENU                                              |'
  puts '  -------------------------------------------------------------------------------------'
  puts ' |Opción 1 - Generar un archivo con el nombre de cada alumno y el promedio de sus notas|'
  puts ' |Opción 2 - Contar la cantidad de inasistencias totales y mostrarlas en pantalla      |'
  puts ' |Opción 3 - Mostrar los nombres de los alumnos aprobados                              |'
  puts ' |Opción 4 - Salir                                                                     |' 
  puts "  -------------------------------------------------------------------------------------\n\n"
end

def validar_opcion(opcion)
  while opcion < 1 || opcion > 4
    system('clear')
    puts "\nLa opción ingresada no es válida"
    puts "Ingrese una opcion entre 1 y 4\n\n"
    mostrar_menu
    opcion = gets.chomp.to_i
  end
  opcion
end


#Opción 1: Debe generar un archivo con el nombre de cada alumno y el
#promedio de sus notas.

# DUDA !!!!!!!! Ausente = 0 o Ausente = 1 ??? 
def promedio_notas(filename)
  arr_alumnos = []
  arr_notas = []
  file = File.open(filename, 'r')
  arr = file.readlines.map(&:chomp)
  file.close
  arr.each do |e|
    arr_notas.push(e.split(', '))
  end
  # Guardamos en arr_alumnos los nombres y dejamos las notas en arr_notas
  arr_notas.each { |e| arr_alumnos.push(e.shift) }
  # Pasamos de string a int en arr_notas
  arr_notas = arr_notas.map{|e| e.map(&:to_i)}
  # Promedio
  promedio = arr_notas.map{|e| e.inject(:+)/5.to_f}
  # Guardar promedio dentro de otro archivo
  file = File.open('promedios.csv', 'w')
  arr_alumnos.each_index do |i|
    file.puts "#{arr_alumnos[i]}, #{promedio[i]}"
  end
  file.close
  puts "Archivo promedios.csv ha sido creado"
end
#Se puede leer el archivo completo o ir leyendo y procesando
#por línea, ambas opciones son válidas.
#Opción 2: Debe contar la cantidad de inasistencias totales y mostrarlas en
#pantalla.
def contar_inasistencias(filename)
  arr_alumnos = []
  arr_notas = []
  file = File.open(filename, 'r')
  arr = file.readlines.map(&:chomp)
  file.close
  arr.each do |e|
    arr_notas.push(e.split(', '))
  end
  # Guardamos en arr_alumnos los nombres y dejamos las notas en arr_notas
  arr_notas.each { |e| arr_alumnos.push(e.shift) }
  # Contar inasistencias por alumno
  arr = arr_notas.map { |e| e.count('A') }
  puts "\nInasistencias por alumno:"
  arr_alumnos.each_index do |i|
    puts "#{arr_alumnos[i]}: #{arr[i]}" if arr[i] > 0
  end
  puts "Total de inasistencias: #{arr.inject(:+)}"
end
#Opción 3: Debe mostrar los nombres de los alumnos aprobados. Para eso
#se debe crear un método que reciba -como argumento- la nota necesaria pa
#aprobar, por defecto esa nota debe ser 5.
def alumnos_aprobados(filename, nota = 5)
  alumnos = []
  file = File.open(filename, 'r')
  arr = file.readlines.map(&:chomp)
  file.close
  arr.each do |e|
    alumnos.push(e.split(', '))
  end
  puts "\nAlumnos aprobados:"
  alumnos.each do |alumno|
    puts "#{alumno[0]}: #{alumno[1]}" if alumno[1].to_i >= nota
  end
end
#Opción 4: Debe terminar el programa.

# main

system('clear')
puts "Bienvenido\n"
opcion = 0
while opcion != 4
  mostrar_menu
  puts "\nIngrese una opcion"
  opcion = gets.chomp.to_i
  opcion = validar_opcion(opcion)
  system('clear')
  case opcion
  when 1
    puts "Opción 1 - Generar un archivo con el nombre de cada alumno y el promedio de sus notas"
    promedio_notas('alumnos.csv')
  when 2
    puts "Opción 2 - Contar la cantidad de inasistencias totales y mostrarlas en pantalla"
    contar_inasistencias('alumnos.csv')
  when 3
    puts "Opción 3 - Mostrar los nombres de los alumnos aprobados"
    puts "Ingrese nota de aprovación:"
    nota = gets.chomp.to_i
    alumnos_aprobados('promedios.csv', nota)
  end
end

system('clear')
puts 'Fin del programa'