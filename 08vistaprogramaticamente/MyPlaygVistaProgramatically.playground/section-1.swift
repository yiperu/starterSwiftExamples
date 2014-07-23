// Playground - noun: a place where people can play

import UIKit

var miVista = UIView(frame:CGRectMake(0, 0, 320, 480))
var miBoton = UIButton(frame: CGRectMake(miVista.frame.width/2, miVista.frame.height/2, 100, 35))

miBoton.setTitle("Bienvenido", forState: UIControlState.Normal)
miBoton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)

miVista.addSubview(miBoton)
