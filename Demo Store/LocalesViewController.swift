//
//  LocalesViewController.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 23/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MBProgressHUD

class LocalesViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()

        
        itemsWebService.puntosDeVenta() { (resultado) in
            
            for  i in 0...(resultado.count-1){
               
                let locationTmp = CLLocation(latitude:resultado[i].coordinate.latitude, longitude: resultado[i].coordinate.longitude)
                self.centrar(ubicacion: locationTmp)

                self.mapView.addAnnotation(resultado[i])
                
            }
            
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
        }
    }
    
    func centrar(ubicacion: CLLocation){
        let region = MKCoordinateRegion(center: ubicacion.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
        
        mapView.setRegion(region, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
