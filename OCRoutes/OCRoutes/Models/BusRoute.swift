//
//  BusRoute.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-02-17.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation

struct BusRoute : Codable {
    
    let routeId : String
    let routeNumber : String
    let routeName : String?
    var directionId : String?
    
    var firstBusTime : String? = "--"
    var secondBusTime : String? = "--"
    
    init(routeId: String, routeNumber: String, routeName: String) {
        self.routeId = routeId
        self.routeName = routeName
        self.routeNumber = routeNumber
    }
    
    public func GetFirstBusTime() -> Int {
        return NetworkManager.GetNextBusTime(self)
    }
    
    enum CodingKeys: String, CodingKey {
        case routeNumber = "route_short_name"
        case routeName = "trip_headsign"
        case routeId = "route_id"
        case directionId = "direction_id"
    }
    
}

