//
//  DetailViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 25/03/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet weak var imagen1: UIImageView!
    
    @IBOutlet weak var lblnombre: UILabel!
    
    @IBOutlet weak var lbldescripcion: UILabel!
    
    @IBOutlet weak var lblprecio: UILabel!
    
    @IBOutlet weak var btnagregar: UIButton!
    
    var itemdetalle:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblnombre.text = itemdetalle.nombre
        lbldescripcion.text = itemdetalle.descripcion
        lblprecio.text = "S/. \(itemdetalle.precio!)"
        imagen1.image = itemdetalle.imagen
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnAccionAgregar(_ sender: UIButton) {
        
        if !cart.contains(itemdetalle){
            let alerta = UIAlertController(title: "Alerta", message: "Se cargo al carrito", preferredStyle: UIAlertControllerStyle.alert)
            let accionOkey = UIAlertAction(title: "Okey", style: UIAlertActionStyle.default, handler: nil)
            
            alerta.addAction(accionOkey)
            self.present(alerta, animated: true,completion: nil)
            
            cart.append(itemdetalle)
            
        }else{
            let alerta = UIAlertController(title: "Alerta", message: "ya existe en el carrito", preferredStyle: UIAlertControllerStyle.alert)
            let accionOkey = UIAlertAction(title: "Okey", style: UIAlertActionStyle.default, handler: nil)
            
            alerta.addAction(accionOkey)
            self.present(alerta, animated: true,completion: nil)
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
