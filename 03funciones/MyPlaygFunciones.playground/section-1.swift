// Playground - noun: a place where people can play

import UIKit

// En este ejemplo veremos el uso de funciones:

func sumar2Enteros(a: Int, b: Int) -> Int {
    return a + b
}
func multi2Enteros(a: Int, b: Int) -> Int {
    return a * b
}

// Aqui veremos que podemos utilizarlos como si fuera una variable, al
// estilo js
var varFuncion = sumar2Enteros
var respuesta = varFuncion(3,6)

var funcion2: (Int, Int) -> Int

//func funcionEspecial(arg1: (Int, Int) -> Int, arg2: Int, arg3:Int){
//    println("Resultado \(arg1(arg2, arg3))")
//}
//funcionEspecial(sumar2Enteros, 3, 5)

// Aqui podemos ver como aplicar funciones como argumentos
func funcionEspecial(arg1: (Int, Int) -> Int, arg2: Int, arg3:Int) -> String{
    return("Resultado \(arg1(arg2, arg3))")
}

var resp1 = funcionEspecial(sumar2Enteros, 3, 5)
var resp2 = funcionEspecial(multi2Enteros, 3, 5)
// ------------------
// Ejemplo de funciones que retornan 2 valores
func calcularPersona() -> (String, Int){
    var nombre = "Henry"
    var apellido = "Ambicho"
    var edad = 30
    return ("La persona es \(nombre) - \(apellido)",edad)
}
var resp3 = calcularPersona()
println(resp3)
