//
//  NetworkManager.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-16.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static private let API_URL : String = "https://a1cb58bc.ngrok.io"
    
    static private let defaultSession = URLSession(configuration: .default)
    
    static private var defaultTask : URLSessionDataTask?
    static private var allStopsTask : URLSessionDataTask?
    static private var allRoutesTask : URLSessionDataTask?
    
    static private var allRoutesDict : Dictionary<String, BusRoute> = [:]
    static private var allRoutesList : Array<BusRoute> = []
    static private var favouriteRoutes : Array<BusRoute> = []
    
    static private var allStopDict : Dictionary<String, BusStop> = [:]
    static private var allStopsList : Array<BusStop> = []
    static private var favouriteStops : Array<BusStop> = []
    
    static public func GetAllRoutes() -> [BusRoute] {
        return allRoutesList
    }
    
    static public func GetAllStops() -> [BusStop] {
        return allStopsList
    }
    
    static public func IsStopFavourited(_ stop: BusStop) -> Bool {
        return favouriteStops.contains(where: { (favStop) -> Bool in
            favStop.stop_id == stop.stop_id && favStop.stop_name == stop.stop_name
        })
    }
    
    static public func IsRouteFavourited(_ route: BusRoute) -> Bool {
        return favouriteRoutes.contains(where: { (favRoute) -> Bool in
            (favRoute.routeId == route.routeId && favRoute.routeName! == route.routeName!)
        })
    }
    
    static public func RemoveRouteFromFavs(_ route: BusRoute) {
        favouriteRoutes = favouriteRoutes.filter {
            !($0.routeId == route.routeId && $0.routeName! == route.routeName!)
        }
    }
    
    static public func AddRouteToFavs(_ route: BusRoute) {
        favouriteRoutes.append(route)
    }
    
    static public func RemoveStopFromFavs(_ stop: BusStop) {
        favouriteStops = favouriteStops.filter { $0.stop_id != stop.stop_id && $0.stop_name != stop.stop_name }
    }
    
    static public func AddStopToFavs(_ stop: BusStop) {
        favouriteStops.append(stop)
    }
    
    static public func GetFavouriteRoutes() -> [BusRoute] {
        return favouriteRoutes
    }
    
    static public func GetFavouritedStops() -> [BusStop] {
        return favouriteStops
    }
    
    static public func GetFakeStops() -> [BusStop] {
        let route = BusRoute(routeId: "abc", routeNumber: "98", routeName: "Hawthorne")
        
        var stop1 = BusStop(stop_id: "abc", stop_code: "0000", stop_name: "Stop1", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop1.routes = [route]
        
        var stop2 = BusStop(stop_id: "abc", stop_code: "1111", stop_name: "Stop2", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop2.routes = [route]
        
        var stop3 = BusStop(stop_id: "abc", stop_code: "2222", stop_name: "Stop3", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop3.routes = [route]
        
        var stop4 = BusStop(stop_id: "abc", stop_code: "3333", stop_name: "Stop4", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop4.routes = [route]
        
        var stop5 = BusStop(stop_id: "abc", stop_code: "4444", stop_name: "Stop5", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop5.routes = [route]
        
        var stop6 = BusStop(stop_id: "abc", stop_code: "5555", stop_name: "Stop6", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop6.routes = [route]
        
        var stop7 = BusStop(stop_id: "abc", stop_code: "6666", stop_name: "Stop7", stop_lat: 45.4196944, stop_lon: -75.6792876)
        stop7.routes = [route]
        
        return [stop1, stop2, stop3, stop4, stop5, stop6, stop7]
    }
    
    static public func CheckServerHealth() {
        defaultTask?.cancel()
        
        guard let urlComponents = URLComponents(string: "\(API_URL)/ping") else {
            print("Failed to create urlComponents")
            return //TODO: handle a failure in a better way
        }
        
        guard let url = urlComponents.url else {
            print("Failed to get urlComponents.url")
            return
        }
        
        defaultTask = defaultSession.dataTask(with: url, completionHandler: { (data, res, err) in
            if let err = err {
                print("ERROR: \(err.localizedDescription)")
                return
            } else if let data = data, let res = res as? HTTPURLResponse {
                print("Server Status: \(res.statusCode)")
            }
        })
        
        defaultTask?.resume()
    }
    
    static public func GetAllStops(callback: @escaping (_ err: String?) -> Void) {
        allStopsTask?.cancel()
        
        guard let urlComponents = URLComponents(string: "\(API_URL)/stops?lat=45.419534&lon=-75.678803") else {
            print("Failed to create urlComponents")
            return //TODO: handle a failure in a better way
        }
        
        guard let url = urlComponents.url else {
            print("Failed to get urlComponents.url")
            return
        }
        
        allStopsTask = defaultSession.dataTask(with: url, completionHandler: { (data, res, err) in
            if err != nil {
                debugPrint("Error when getting all stops")
                return callback(err.debugDescription)
            }
            
            guard let data = data else {
                debugPrint("Failed to get data")
                return callback("Failed to get data")
            }
            
            do {
                let decoder = JSONDecoder()
                let stops = try decoder.decode([BusStop].self, from: data)
                
                self.allStopsList = stops
                for stop in stops {
                    allStopDict[stop.stop_id] = stop
                }
                
                return callback(nil)
            } catch let error {
                print(error)
                return callback("Failed to decode data")
            }
        })
        
        allStopsTask?.resume()
    }
    
    static public func GetAllRoutes(callback: @escaping (_ err: String?) -> Void) {
        allRoutesTask?.cancel()
        
        guard let urlComponents = URLComponents(string: "\(API_URL)/routes") else {
            print("Failed to create urlComponents")
            return //TODO: handle a failure in a better way
        }
        
        guard let url = urlComponents.url else {
            print("Failed to get urlComponents.url")
            return
        }
        
        allRoutesTask = defaultSession.dataTask(with: url, completionHandler: { (data, res, err) in
            
            if err != nil {
                debugPrint("Error when getting all stops")
                return callback(err.debugDescription)
            }
            
            guard let data = data else {
                debugPrint("Failed to get data")
                return callback("Failed to get data")
            }
            
            do {
                let decoder = JSONDecoder()
                let routes = try decoder.decode([BusRoute].self, from: data)
                
                self.allRoutesList = routes
                for route in routes {
                    allRoutesDict[route.routeId] = route
                }
                
                return callback(nil)
            } catch let error {
                print(error)
                return callback("Failed to decode data")
            }
            
        })
        
        allRoutesTask?.resume()
    }
    
    static public func GetStopRouteInformation(_ stop: BusStop, _ route: BusRoute, callback: @escaping (_ err: String?, _ routes: [BusRoute]) -> Void){
        
        callback(nil, [
            BusRoute(routeId: "ABC", routeNumber: route.routeNumber, routeName: route.routeName!),
            BusRoute(routeId: "ABC", routeNumber: route.routeNumber, routeName: route.routeName!),
            BusRoute(routeId: "ABC", routeNumber: route.routeNumber, routeName: route.routeName!),
            BusRoute(routeId: "ABC", routeNumber: route.routeNumber, routeName: route.routeName!)
        ])
        
    }
    
    static public func GetNextBusTime(_ route: BusRoute) -> Int {
        return Int(arc4random_uniform(42))
    }
}


