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
    
    static public func GetAllStops(callback: @escaping (_ err: String?, _ busStops: [BusStop]?) -> Void) {
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
                return callback(err.debugDescription, nil)
            }
            
            guard let data = data else {
                debugPrint("Failed to get data")
                return callback("Failed to get data", nil)
            }
            
            do {
                let decoder = JSONDecoder()
                let netRes = try decoder.decode([BusStop].self, from: data)
                return callback(nil, netRes)
            } catch let error {
                print(error)
                return callback("Failed to decode data", nil)
            }
        })
        
        allStopsTask?.resume()
    }
    
    static public func GetAllRoutes(callback: @escaping (_ err: String?, _ busRoutes: [BusRoute]?) -> Void) {
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
                return callback(err.debugDescription, nil)
            }
            
            guard let data = data else {
                debugPrint("Failed to get data")
                return callback("Failed to get data", nil)
            }
            
            do {
                let decoder = JSONDecoder()
                let netRes = try decoder.decode([BusRoute].self, from: data)
                return callback(nil, netRes)
            } catch let error {
                print(error)
                return callback("Failed to decode data", nil)
            }
            
        })
        
        allRoutesTask?.resume()
    }
}


