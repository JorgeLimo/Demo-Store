//
//  CartTableViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 25/03/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CartTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var tableCart: UITableView!
    
    var locationNow = CLLocationCoordinate2D()

    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]

        let myLocationBitch:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        locationNow = myLocationBitch
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
 
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cart.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCart", for: indexPath) as! ItemCarritoTableViewCell

        let item = cart[indexPath.row]
        cell.imgItem.image = item.imagen
        cell.nomItem.text = item.nombre
        cell.tag = indexPath.row
        
        // Configure the cell...
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc))
        swipe.direction = UISwipeGestureRecognizerDirection.left
        cell.addGestureRecognizer(swipe)
        
        return cell
    }
    
 
    @IBAction func realizarCompra(_ sender: UIButton) {
        
        //obtener coredata ID USUARIO, NOMBRE 
        //OBNTER LOS ID (CREO QUE SERIA UN FOR DEL ARREGLO PUBLIC DEL CARRITO)
        //iimpimir los datos
        
        
        print(locationNow)
        
        
    }
    
    
    // GET LOCATION

    
    // END GET LOCATION
    
    
    

    func swipeFunc(sender : UISwipeGestureRecognizer){
        let cell = sender.view
        let indexPath = cell?.tag
        cart.remove(at: indexPath!)
        tableCart.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableCart.reloadData()

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
