//
//  Station.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation

struct BusStop : Codable {
    
    var stop_id : String
    var stop_code : String?
    var stop_name : String
    var stop_lat : Double
    var stop_lon : Double
    var distance : Double?
    var routes : [ String ]?
    
    init(stop_id: String, stop_code: String?, stop_name: String, stop_lat: Double, stop_lon: Double) {
        self.stop_id = stop_id
        self.stop_code = stop_code
        self.stop_name = stop_name
        self.stop_lat = stop_lat
        self.stop_lon = stop_lon
    }
    
    enum CodingKeys: String, CodingKey {
        case stop_id = "stop_id"
        case stop_code = "stop_code"
        case stop_name = "stop_name"
        case stop_lat = "stop_lat"
        case stop_lon = "stop_lon"
        case distance = "distance"
        case routes = "routes"
    }

}



