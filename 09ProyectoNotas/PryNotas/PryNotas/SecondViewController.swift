//
//  SecondViewController.swift
//  PryNotas
//
//  Created by Henry Antonio Ambicho Trujillo on 7/23/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate  {
 
    @IBOutlet var txtNombre: UITextField!       // el ! no es necesario
    @IBOutlet var txtDescripcion: UITextField!  // el ! no es necesario
    
    @IBAction func btnAgregar(sender: UIButton) {
//        NSLog("Hizo Click ;-)")
//        println("Click con Println")
        ObjetoAdmin.agregarNotas(txtNombre.text, descripcion: txtDescripcion.text)
        self.view.endEditing(true)
        txtNombre.text = ""
        txtDescripcion.text = ""
        self.tabBarController.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }


}

