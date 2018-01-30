//
//  Station.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import MapKit

class Station : NSObject, MKAnnotation {
    
    var title : String?
    var subtitle : String?
    var latitude : Double
    var longitude : Double
    
    init(latitude lat: Double, longitude lon: Double) {
        self.latitude = lat
        self.longitude = lon
    }
    
    convenience init(latitude lat: Double, longitude lon: Double, title: String, subtitle: String) {
        self.init(latitude: lat, longitude: lon)
        self.title = title
        self.subtitle = subtitle
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
