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
        
    }
}
