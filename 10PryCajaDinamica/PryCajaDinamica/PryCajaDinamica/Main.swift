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
    var cajaRoja: UIView? // Adicionamos una caja Roja
    
    // Declaramos la variables que daran los comportamientos fisicos
    var animador: UIDynamicAnimator?
    var gravedad: UIGravityBehavior?
    // Variable para la base donde hara la colision
    var colision: UICollisionBehavior?
    
    // declaramos la variable para trabajar con los gestos y lo agregaremos a nuestra caja
    var panGesture: UIPanGestureRecognizer?
    
    // Creamos la variable para el rebote de los lados
    var attach: UIAttachmentBehavior?
    
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
        
        // Implementamos la caja roja
        self.cajaRoja = UIView();
        self.cajaRoja!.backgroundColor = UIColor.redColor();
        self.cajaRoja!.frame = CGRectMake(CGRectGetMidX(self.view.frame)-50, CGRectGetMidY(self.view.frame) + 150, 100, 40);
        self.view.addSubview(self.cajaRoja);
        // ---------------
        
        
        // Instanciar el animador
        self.animador = UIDynamicAnimator(referenceView: self.view);
        
        // Instanciar el comportamiento de la gravedad y asignar la caja a esto:
        self.gravedad = UIGravityBehavior(items: [self.cajaAzul!]);
        
        // Instanciamos el comportamiento de la colision y asignamos la caja a este
        self.colision = UICollisionBehavior(items: [self.cajaAzul!, self.cajaRoja!]);
        self.colision!.translatesReferenceBoundsIntoBoundary = true;
        
        /*
        // Aqui vamos (Esto hara que la caja caiga y choque en el suelo)
        // Esto le da el comportamiento de gravedad a la caja azul
        self.animador!.addBehavior(self.gravedad);
        // Esto le da el comportamientos de colicion a la base
        self.animador!.addBehavior(self.colision);
        */
        
        // Instanciamos el detector de gestos y lo adicionamos a nuestra caja
        self.panGesture = UIPanGestureRecognizer(target: self, action:"panning:");
        self.cajaAzul!.addGestureRecognizer(panGesture);
        
    }
    
    func panning(pan: UIPanGestureRecognizer){
        println("Nuestra caja es panning ");
        var locacion = pan.locationInView(self.view);
        var touchLocacion = pan.locationInView(self.cajaAzul);
        
        if pan.state == UIGestureRecognizerState.Began {
            // Hacer las configuraciones iniciales aqui:
            
            // Remover todos los comportamientos adjuntados al animador por ahora
            self.animador!.removeAllBehaviors();
            
            var offset = UIOffsetMake(touchLocacion.x - CGRectGetMidX(self.cajaAzul!.bounds), touchLocacion.y - CGRectGetMidY(self.cajaAzul!.bounds));
            self.attach = UIAttachmentBehavior(item: self.cajaAzul, offsetFromCenter: offset, attachedToAnchor: locacion);
            self.animador!.addBehavior(self.attach);
            
            // Estableceremos el centro de la caja para el valor de la locacion
            //self.cajaAzul!.center = locacion;
            
        } else if pan.state == UIGestureRecognizerState.Changed {
            //self.cajaAzul!.center = locacion;
            self.attach!.anchorPoint = locacion;
            
        } else if pan.state == UIGestureRecognizerState.Ended {
            
            self.animador!.removeAllBehaviors();
            
            var itemBehavior = UIDynamicItemBehavior(items: [self.cajaAzul!]);
            itemBehavior.addLinearVelocity(pan.velocityInView(self.view), forItem: self.cajaAzul)
            itemBehavior.angularResistance = 0;
            itemBehavior.elasticity = 0.8;
            self.animador!.addBehavior(itemBehavior);
            
            
            // Manejo de lo que deveira pasar si la caja es relanzada
            self.animador!.addBehavior(self.gravedad);
            self.animador!.addBehavior(self.colision);
        }
    }
    
    
    
    
    
}
