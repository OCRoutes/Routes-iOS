//
//  Station.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation

struct BusStop {
    
    var stopId : String
    var stopCode : Int
    var stopName : String
    var stopLat : Double
    var stopLong : Double
    
    init(stopId: String, stopCode: Int, stopName: String, stopLatitude: Double, stopLongitude: Double) {
        self.stopId = stopId
        self.stopCode = stopCode
        self.stopName = stopName
        self.stopLat = stopLatitude
        self.stopLong = stopLongitude
    }
    
}
