//
//  PerfilViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 24/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import CoreData

class PerfilViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagen: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnCambiarImagenPerfil(_ sender: UIButton) {
        
        let action = UIAlertController(title: "Imagen de Perfil", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let actionCamara = UIAlertAction(title: "Camara", style: UIAlertActionStyle.default, handler: {
            (action) in
            self.usarCamara()
        })
        
        let galeriaFotos = UIAlertAction(title: "Galería de Fotos", style: UIAlertActionStyle.default, handler: {
            (action) in
            self.usarGaleria()
        })
        
        action.addAction(actionCamara)
        action.addAction(galeriaFotos)
        self.present(action, animated: true, completion:{
        })
        
    }
    
    func usarCamara () {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = . photo
            imagePicker.modalPresentationStyle = .fullScreen
            
            self.present(imagePicker, animated: true, completion: {})
        }
    }
    
    func usarGaleria(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.present(imagePicker, animated: true, completion: {})
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imagen.image = img
        self.dismiss(animated: true) {}
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }

    @IBAction func CerrarSesion(_ sender: UIButton) {
        eliminarDeCoreData()
        self.performSegue(withIdentifier: "cerrar", sender: sender)
        
    }
    
    func eliminarDeCoreData (){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UsuarioCore")
        
        
        do {
            let result = try context.fetch(fetchRequest)
            
            for user in result {
                context.delete(user)
            }
            
            try context.save()
            
        } catch let error as NSError {
            print(error.description)
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
