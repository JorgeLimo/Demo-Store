//
//  PuntosVenta.swift
//  Demo Store
//
//  Created by Jorge Luis Limo Arispe on 23/04/17.
//  Copyright © 2017 Jorge Luis Limo. All rights reserved.
//

import UIKit
import MapKit

class PuntosVenta: NSObject, MKAnnotation {

    var title:String?
    var coordinate: CLLocationCoordinate2D //aqui podemos agregar los dos valores del ws
    var subtitle: String? //aquu esta ka dureccuib
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle:String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
        super.init()
    }

    
}
