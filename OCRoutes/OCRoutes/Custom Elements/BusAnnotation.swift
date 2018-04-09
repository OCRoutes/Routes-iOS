//
//  BusAnnotation.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-04-09.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import MapKit

class BusAnnotation : NSObject, MKAnnotation {
    
    var route: BusRoute?
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    
    init(latitude lat: Double, longitude lon: Double) {
        self.latitude = lat
        self.longitude = lon
    }
    
    convenience init(latitude lat: Double, longitude lon: Double, title: String, subtitle: String) {
        self.init(latitude: lat, longitude: lon)
        self.title = title
        self.subtitle = subtitle
    }
    
    convenience init(route: BusRoute, lat: Double, lon: Double) {
        self.init(latitude: lat, longitude: lon, title: route.routeNumber, subtitle: route.firstBusTime!)
        self.route = route
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
