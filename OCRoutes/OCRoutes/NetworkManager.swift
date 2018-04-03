//
//  NetworkManager.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-16.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static private let API_URL : String = "http://localhost:8080"
    
    static private let defaultSession = URLSession(configuration: .default)
    
    static private var defaultTask : URLSessionDataTask?
    static private var allStopsTask : URLSessionDataTask?
    static private var allRoutesTask : URLSessionDataTask?
    
    static private var allRoutesDict : Dictionary<String, BusRoute> = [:]
    static private var allRoutesList : Array<BusRoute> = []
    static private var allStopDict : Dictionary<String, BusStop> = [:]
    static private var allStopsList : Array<BusStop> = []
    
    static public func GetAllRoutes() -> [BusRoute] {
        return allRoutesList
    }
    
    static public func GetAllStops() -> [BusStop] {
        return allStopsList
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
                print("HTTP Status: \(res.statusCode)")
                print(data)
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
}


