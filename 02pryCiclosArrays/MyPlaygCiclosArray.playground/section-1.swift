// Playground - noun: a place where people can play

import UIKit
// Arreglos de numeros enteros
var numero = [1,2,3,4,5,6]
//Arreglo de strings
var cadenas = ["Henry","Antonio","Ambicho","Trujillo","Peru","Chile","EEUU"]
// Ciclo for : Para iterar por cada arreglo
for cad in cadenas{
    println("Hola, \(cad)!")
}
// con 3 puntos toma el ultimo numero numero
for index in 1...5 {
    println("\(index) veces 5 es \(index * 5)")
}

// Si no necesiamos saber el valor del iterados podemos obviar con guion bajo
let base = 3
let exponente = 10
var resultado = 1
for _ in 1...exponente {
    resultado *= base
}
println("\(base) al exponente de \(exponente) es \(resultado)")

// Sacar caracteres de una cadena
for caracter in "Cadena" {
    println(caracter)
}
// Y el clasifo FOR (Notar que no es necesario los parentesis)
for var index=0; index < 3; index++ {
    println("El index es = \(index)")
}
// Ahora los while y do-while
var incremento1=0
while(incremento1 < 3){
    println(incremento1)
    incremento1++
}

var incremento2=0
do {
    println(incremento2)
    incremento2++
} while(incremento2 < 3)
// Sentencias Condicionales
var temperatura = 90
if temperatura <= 32 {
    println("Hace mucho frio")
} else if temperatura >= 86 {
    println(" Hace mucho calor")
} else {
    println("No hace mucho calor")
}
// Permancen los simbolo de comprobaciones
// y= && , o = || , >, <, >=, <=, etc

// Los switch ya no necesita los break
let unCaracter: Character = "e"
switch unCaracter {
    case "a", "e", "i", "o", "u":
        println("\(unCaracter) es una vocal")
    case "b", "c", "d", "f", "g", "h":
        println("\(unCaracter) es una consonante")
    default:
        println("\(unCaracter) no es una letra")
}
// Tambien podemos porner rangos para analizar en los case
//let count = 3_000_000_000_000
let count = 3_000
let cosasContadas = "inician en el Milky Way"
var contadorNatural: String

switch count {
case 0:
    contadorNatural = "no"
case 1...3:
    contadorNatural = "no"
case 4...9:
    contadorNatural = "no"
default:
    contadorNatural = "diez de dieces"
}
println("Hay \(contadorNatural) \(cosasContadas).")