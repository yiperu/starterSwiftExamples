//
//  AdministradorNotas.swift
//  PryNotas
//
//  Created by Henry Antonio Ambicho Trujillo on 7/23/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//
// Aqui crearemos las clases que van a almacenar los Datos

import UIKit

// Creamos una clases de la misma clase creada
var ObjetoAdmin: AdministradorNotas = AdministradorNotas()

struct notaStruct{
    var s_nombre  = "Por defecto"
    var s_descrip = "Por defecto"
}

class AdministradorNotas: NSObject {
    
    var notas = notaStruct[]()
    func agregarNotas(nombre: String, descripcion: String){
        notas.append(notaStruct(s_nombre: nombre, s_descrip: descripcion ))
    }
   
}
