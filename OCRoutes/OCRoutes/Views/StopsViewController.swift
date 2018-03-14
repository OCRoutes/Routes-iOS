//
//  StopsViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-02-02.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class StopsViewController : UIViewController {
    
    let titleString: String = "All Stops"
    var titleLabel: UILabel!
    
    fileprivate var stopsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "ALL STOPS"
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        stopsTableView = UITableView(frame: CGRect.zero)
        
        stopsTableView.delegate = self
        stopsTableView.dataSource = self
        
        // Setup cell dynamic row height
        stopsTableView.rowHeight = UITableViewAutomaticDimension
        stopsTableView.estimatedRowHeight = 150
        
        stopsTableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        
        view.addSubview(stopsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Routes table view constraints
        stopsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stopsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stopsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stopsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
}

// UITableViewDataSource delegation
extension StopsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let busStop = BusStop(stopId: "AB123", stopCode: "7688", stopName: "King Edward", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 89, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            return StopTableViewCell(stop: busStop, routes: [busRoute1], style: .Leading)
        case 1:
            let busStop = BusStop(stopId: "AB123", stopCode: "1234", stopName: "Place dOrleans", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 83, routeName: "Blair", firstBusTime: "<1m", secondBusTime: "31m")
            let busRoute2 = BusRoute(routeNumber: 83, routeName: "Blair", firstBusTime: "3m", secondBusTime: "7m")
            let busRoute3 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            return StopTableViewCell(stop: busStop, routes: [busRoute1, busRoute2, busRoute3], style: .Normal)
        case 9:
            let busStop = BusStop(stopId: "AB123", stopCode: "7689", stopName: "King Edward", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 89, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            let busRoute2 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            let busRoute3 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            let busRoute4 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            let busRoute5 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            return StopTableViewCell(stop: busStop, routes: [busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1], style: .Ending)
        default:
            let busStop = BusStop(stopId: "AB123", stopCode: "7689", stopName: "King Edward", stopLatitude: 123.123, stopLongitude: 456.456)
            let busRoute1 = BusRoute(routeNumber: 89, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            let busRoute2 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            let busRoute3 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            let busRoute4 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            let busRoute5 = BusRoute(routeNumber: 83, routeName: "Kanata", firstBusTime: "5m", secondBusTime: "59m")
            return StopTableViewCell(stop: busStop, routes: [busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5, busRoute1, busRoute2, busRoute3, busRoute4, busRoute5], style: .Normal)
        }
    }
}
