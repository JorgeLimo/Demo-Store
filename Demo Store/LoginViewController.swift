//
//  LoginViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 22/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import SwiftyJSON


class LoginViewController: UIViewController {

    
    @IBOutlet weak var lblusuario: UITextField!
    
    @IBOutlet weak var lblcontrasenia: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ActionDoLogin(_ sender: UIButton) {
        
        let usuarioIngresado = lblusuario.text
        let passIngresado = lblcontrasenia.text
        
        if (usuarioIngresado != "" && passIngresado != "") {
        
            print(usuarioIngresado!)
            print(passIngresado!)
            
            itemsWebService.loginUsuarios(usuario: usuarioIngresado!, pass: passIngresado!, completion: { (resultado) in
                
                if  (resultado.usuario == nil ) {
                    
                    let alert = UIAlertController(title: "Mensaje", message: "Datos incorrectos", preferredStyle : UIAlertControllerStyle.alert)
                    let action = UIAlertAction (title: "Intentar de nuevo", style: UIAlertActionStyle.default, handler:{ (action) in
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: {
                    })
                
                }else{
                   /*let nombre = resultado.nomCompleto
                    print(nombre!)*/
                    self.performSegue(withIdentifier: "acceso", sender: sender)
                }
            
            })
            
           /**
             
             itemsWebService.loginUsuarios(usuario: usuarioIngresado!,pass: passIngresado!) {(resultado) in
                print(resultado)
            }**/
            
        
        }else{
        
            //print("Ingresa algun dato perro!!!!")
            let alert = UIAlertController(title: "Aviso !", message: "No ha completado los campos", preferredStyle : UIAlertControllerStyle.alert)
            let action = UIAlertAction (title: "OK", style: UIAlertActionStyle.default, handler:{ (action) in
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: {
            })
            
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
