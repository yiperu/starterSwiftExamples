//
//  Main.swift
//  PryCajaDinamica
//
//  Created by Henry Antonio Ambicho Trujillo on 8/3/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

//import Foundation
import UIKit

class Main: UIViewController {
    
    // Declaracion del view Caja
    var cajaAzul: UIView?
    
    // Declaramos la variables que daran los comportamientos fisicos
    var animador: UIDynamicAnimator?
    var gravedad: UIGravityBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instanciamos el view de la caja
        self.cajaAzul = UIView();
        
        // Hacer esto Azul
        self.cajaAzul!.backgroundColor = UIColor.blueColor();
        
        // Poner esto en el centro de nuestro screen
        self.cajaAzul!.frame = CGRectMake(CGRectGetMidX(self.view.frame)-50, CGRectGetMidY(self.view.frame)-50, 100, 100);
        
        // Agregar a la vista principal
        self.view.addSubview(self.cajaAzul);
        
        // Instanciar el animador
        self.animador = UIDynamicAnimator(referenceView: self.view);
        
        // Instanciar el comportamiento de la gravedad y asignar la caja a esto:
        self.gravedad = UIGravityBehavior(items: [self.cajaAzul!]);
        
        // Aqui vamos
        // Esto le da el comportamiento de gravedad a la caja azul
        self.animador!.addBehavior(self.gravedad);
        
    }
}
