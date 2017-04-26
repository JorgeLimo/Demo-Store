//
//  LoginViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 22/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD

public var objeto = Usuario()

class LoginViewController: UIViewController {

    
    @IBOutlet weak var lblusuario: UITextField!
    
    @IBOutlet weak var lblcontrasenia: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtenerUsuarioDeCoreData()
        
        
        if objeto.usuario != nil {
            print("ya inicio sesion")
            //self.performSegue(withIdentifier: "acceso", sender: (Any).self)
            
        }
       
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
            
            let hud = MBProgressHUD(view: self.view)
            hud.show(animated:true)
            hud.label.text = "Iniciando Sesión"
            self.view.addSubview(hud)

            
            itemsWebService.loginUsuarios(usuario: usuarioIngresado!, pass: passIngresado!, completion: { (resultado) in
        
                hud.hide(animated: true)
                
                if  (resultado.usuario == nil ) {
                    
                    let alert = UIAlertController(title: "Mensaje", message: "Datos incorrectos", preferredStyle : UIAlertControllerStyle.alert)
                    let action = UIAlertAction (title: "Intentar de nuevo", style: UIAlertActionStyle.default, handler:{ (action) in
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: {
                    })
                
                }else{
                   /*let nombre = resultado.nomCompleto*/
                    self.registrarEnCoreData(listado: resultado)
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
    
    
    //COREDATA
    
     func obtenerUsuarioDeCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UsuarioCore")
        
        do {
            let resultado = try context.fetch(fetchRequest)
            for item in resultado {
                //convertirNSManagedObject a Publicacion
                
                objeto.usuario = item.value(forKey: "usuario") as! String
                objeto.nomCompleto = item.value(forKey: "nombreCompleto") as! String
                objeto.contraseña = item.value(forKey: "password") as! String
                objeto.idUsuario = item.value(forKey: "idusuario") as! Int
    
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
        
        
    }
    
    
    
    func registrarEnCoreData(listado: Usuario){
        
       
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //crear un contexto en donde se registrara nuetsra entidad
            let context = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "UsuarioCore", in: context)
            
            let userCore = NSManagedObject(entity: entity!, insertInto: context)
        
            userCore.setValue(listado.idUsuario , forKey: "idusuario")
            userCore.setValue(listado.nomCompleto , forKey: "nombreCompleto")
            userCore.setValue(listado.usuario, forKey: "usuario")
            userCore.setValue(listado.contraseña, forKey: "password")
        

            do {
                try context.save()
                objeto = listado
                print(listado.nomCompleto + "Se guardo correctamente su sesión")
            } catch let error as NSError {
                print(listado.nomCompleto + "No se registro correctamente: \(error.userInfo)")
            }
        
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    ovecio
    */

}
