//
//  ViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 25/03/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import MBProgressHUD

public var cart = Array<Item>()
public var items = Array<Item>()

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchResultsUpdating  {

    @IBOutlet weak var vwSearch: UIView!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var cvCollectionV: UICollectionView!
    
    
    var itemsFiltrados = Array<Item>()
    var vwCabecera:UIView!
    
    /** Method Search **/
    func updateSearchResults(for searchController: UISearchController) {
        
        let texto = searchController.searchBar.text
        
        itemsFiltrados = items.filter({ (item) -> Bool in
            return String(item.precio).lowercased().contains(texto!.lowercased()) || item.nombre.lowercased().contains(texto!.lowercased())
        })
        cvCollectionV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        vwCabecera = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 60))
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchResultsUpdater = self
        vwCabecera = searchController.searchBar
        
        vwSearch.addSubview(vwCabecera)
        
        if currentReachabilityStatus ==  .notReachable {
            let alert = UIAlertController(title: "Mensaje", message: "No tienes internet", preferredStyle : UIAlertControllerStyle.alert)
            let action = UIAlertAction (title: "OK", style: UIAlertActionStyle.default, handler:{ (action) in
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: {
            })
        }else if currentReachabilityStatus == .reachableViaWiFi || currentReachabilityStatus == .reachableViaWWAN{
            let hud = MBProgressHUD(view: self.view)
            hud.show(animated:true)
            hud.label.text = "Cargando"
            
            self.view.addSubview(hud)
            
            itemsWebService.listarTodo() {(resultado) in
                items = resultado
                self.cvCollectionV.reloadData()
                hud.hide(animated: true)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        self.performSegue(withIdentifier: "siguiente", sender: item)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        
        if  searchController.isActive && searchController.searchBar.text != "" {
            return itemsFiltrados.count
        }
        
        return items.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! ItemCellCollectionViewCell
        
        let indice = indexPath.row
        let item:Item
        
        if  searchController.isActive && searchController.searchBar.text != "" {
            item = itemsFiltrados[indice]
        }else{
            item = items[indice]
        }
        
        cell.lblNombre.text = item.nombre
        cell.lblPrecio.text = "S/. \(item.precio!)"
        cell.imgItem.image = item.imagen
        
        //cell.layer.borderWidth = 1
        
        
        let longPressData = UILongPressGestureRecognizer(target: self, action: #selector(longPressFuncion))
        longPressData.minimumPressDuration = 1
        cell.addGestureRecognizer(longPressData)
        
        return cell
    }
    
    func longPressFuncion(sender: UILongPressGestureRecognizer){
        
        let cell = sender.view as! UICollectionViewCell
        let indexPath = cvCollectionV.indexPath(for: cell)
        
        let item = items[(indexPath?.row)!]
        
        
        if !cart.contains(item){
            let alerta = UIAlertController(title: "Alerta", message: "Se cargo al carrito", preferredStyle: UIAlertControllerStyle.alert)
            let accionOkey = UIAlertAction(title: "Okey", style: UIAlertActionStyle.default, handler: nil)
            
            alerta.addAction(accionOkey)
            self.present(alerta, animated: true,completion: nil)
            
            cart.append(item)
            
        }
        
        
    }
    
    
    @IBAction func btnGoCart(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "carrito", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "siguiente" {
            let controlador:DetailViewController = segue.destination as! DetailViewController
            
            controlador.itemdetalle = sender as! Item
        }
    }
    

}

