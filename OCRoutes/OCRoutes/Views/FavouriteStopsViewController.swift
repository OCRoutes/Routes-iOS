//
//  FavouriteStopsViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-07.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class FavouriteStopsViewController : UIViewController {
    
    fileprivate var favsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        // Apply constraints
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        favsTableView = UITableView(frame: CGRect.zero)
        
        // Setup delegates
        favsTableView.dataSource = self
        favsTableView.delegate = self
        
        // Setup cell dynamic row height
        favsTableView.rowHeight = UITableViewAutomaticDimension
        favsTableView.estimatedRowHeight = 150
        
        view.addSubview(favsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Favs table view constraints
        favsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            favsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            favsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            favsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
}

// UITableViewDataSource delegation
extension FavouriteStopsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let busStop = BusStop(stopId: "AB123", stopCode: "7689", stopName: "King Edward", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 89, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1])
        case 1:
            let busStop = BusStop(stopId: "AB123", stopCode: "1234", stopName: "Place dOrleans", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 83, routeName: "Blair", firstBusTime: "<1m", secondBusTime: "31m")
            let busRoute2 = BusRoute(routeNumber: 83, routeName: "Blair", firstBusTime: "3m", secondBusTime: "7m")
            let busRoute3 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1, busRoute2, busRoute3])
        default:
            let busStop = BusStop(stopId: "AB123", stopCode: "7689", stopName: "King Edward", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 123, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1])
        }
        
    }
}
