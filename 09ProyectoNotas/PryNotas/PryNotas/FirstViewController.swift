//
//  FirstViewController.swift
//  PryNotas
//
//  Created by Henry Antonio Ambicho Trujillo on 7/23/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tablaNotas: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        tablaNotas.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ========== Implementacion de los Metodos Tablas
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return ObjetoAdmin.notas.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: "prueba")
    
        cell.text = ObjetoAdmin.notas[indexPath.row].s_nombre
        cell.detailTextLabel.text = ObjetoAdmin.notas[indexPath.row].s_descrip
    
        return cell
    }
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            println("Eliminar nota")
            ObjetoAdmin.notas.removeAtIndex(indexPath.row)
            tablaNotas.reloadData()
        }
    }

    
}

