//
//  itemsWebService.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 15/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class itemsWebService: NSObject {
    
    
    
    static  func listarTodo(completion: @escaping (_ result: Array<Item>) -> Void) {
        
        var resultado = Array<Item>()
        
        let url = URL(string: "https://www.ourlimm.com/ios/getItems.php")
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.httpBody , headers: nil).responseJSON { (response) in
            let json = JSON(response.result.value!)
            
            for i in 0...(json.count-1) {
                
                let item =  Item()
                item.nombre = json[i]["nombre"].string
                item.descripcion = json[i]["descripcion"].string
                item.precio = Double(json[i]["costo"].string!)
                let urlImage = "https://www.ourlimm.com/ios/" + json[i]["imagen1"].string! + ".jpg"
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                item.imagen = UIImage(data: data!)
            
                resultado.append(item)
                
            }
            completion(resultado)
            
        }

        
    }
    
    
    
    
    
    static  func loginUsuarios(usuario: String, pass: String, completion: @escaping (_ result: Usuario) -> Void) {
        
        
        //coloco la url del webservices y lo pongo en un objeto URL
        let url = URL(string: "https://www.ourlimm.com/ios/login.php")
        //Creo el arreglo con los parametros que se envia al webservices
        let parametro: [String: Any] = ["user" : usuario, "pass" : pass]
        //se usa el mismo metodo que el profe nos mostro, pero a diferencia que se quita el nil y se pone el paraemtor,ah y recodar en que method le mendagamos (get o post)
        Alamofire.request(url!, method: .post, parameters: parametro, encoding: URLEncoding.httpBody , headers: nil).responseJSON { (response) in

            let json = JSON(response.result.value!)
            
            let usuario = Usuario()

            if json.count > 0 {
                
                usuario.idUsuario = Int(json[0]["idusuario"].string!)
                usuario.usuario = json[0]["user"].string!
                usuario.contraseña = json[0]["pass"].string!
                usuario.nomCompleto = json[0]["nombrecompleto"].string!
                
            }
            
            completion(usuario)
            
        }
        
    
        
    }
    
    
    
    
    
    

}
