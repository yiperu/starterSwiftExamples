// Playground - noun: a place where people can play

import UIKit

var numeroEntero = 25
var numeroDecimal = 7.83
var nombre = "Henry"

var resultadoEntero = Int(numeroDecimal)
var resultadoDecimal = Double(numeroEntero)
var resultadoString1 = String(numeroDecimal)
var resultadoString2 = String(numeroEntero)

// Ahora veremos los Diccionaarios:

var diccionarioPaises = ["Continente" : "America", "Pais" : "Peru", "Ciudad" : "Ucayali"]
println(diccionarioPaises)
diccionarioPaises["Pais"] = "Chile"
println(diccionarioPaises["Pais"])