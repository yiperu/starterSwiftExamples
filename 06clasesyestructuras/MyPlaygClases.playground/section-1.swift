// Playground - noun: a place where people can play

import UIKit

class Continente{
    var continente = "Por defecto"
    var pais = "Por defecto"
    var ciudad = "Por defecto"
    
    func obtenerDetalles() -> String {
        return("Mi ubicacion actual es, Continente: \(continente), Pais: \(pais), ciudad: \(ciudad)")
    }
}


var miUbicacion = Continente()

miUbicacion.continente = "America"
miUbicacion.pais = "Peru"
miUbicacion.ciudad = "Ucayali"
miUbicacion.obtenerDetalles()
// veremos como generar Herencia de clases

class Persona: Continente {
    var id = "Por defecto"
    func obtenerId() -> String {
        return ("y su Id es = \(id)")
    }

}

class Edificio: Continente {
    var direccion = "Por defecto"
    func obtenerDireccion() -> String {
        return ("y su direccion es = \(direccion)")
    }
}

// Ahora creamos objetos de las clases heredadas:
var personaA = Persona()
personaA.continente = "America"
personaA.pais = "Chile"
personaA.id = "364543563"
personaA.obtenerDetalles()
personaA.obtenerId()

var edificioA = Edificio()
edificioA.obtenerDireccion()

// Para hacer un contructor usamos el metodo init
class Veiculo {
    var numeroDeLlantas: Int
    var maxPasajeros: Int
    func descripcion() -> String {
        return "\(numeroDeLlantas) wheels; up to \(maxPasajeros) passengers"
    }
    
    init() {
        numeroDeLlantas = 0
        maxPasajeros = 1
    }
}




// Ahora un ejemplo de estructura:
struct Resolucion {
    var ancho = 0
    var alto = 0
}

