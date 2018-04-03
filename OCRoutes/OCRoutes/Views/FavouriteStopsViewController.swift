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
    private let refreshControl = UIRefreshControl()
    
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
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            favsTableView.refreshControl = refreshControl
        } else {
            favsTableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshStopsData(_:)), for: .valueChanged)
        
        favsTableView.backgroundColor = Style.lightWhite
        favsTableView.separatorColor = Style.lightWhite
        favsTableView.layoutMargins = .zero
        favsTableView.separatorInset = .zero
        
        favsTableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        
        view.addSubview(favsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func refreshStopsData(_ sender: Any) {
        NetworkManager.GetAllStops() { _ in //no reason to request this but w/e
            DispatchQueue.main.async {
                // do something?
                self.refreshControl.endRefreshing()
            }
        }
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
            let busStop = BusStop(stop_id: "AB123", stop_code: "7688", stop_name: "King Edward", stop_lat: 123.123, stop_lon: 456.456)
            let busRoute1 = BusRoute(routeId: "ABC123", routeNumber: "89", routeName: "Blair")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1], style: .Leading)
        case 1:
            let busStop = BusStop(stop_id: "AB123", stop_code: "1234", stop_name: "Place dOrleans", stop_lat: 123.123, stop_lon: 456.456)
            let busRoute1 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Blair")
            let busRoute2 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Blair")
            let busRoute3 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Kanata")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1, busRoute2, busRoute3], style: .Normal)
        case 2:
            let busStop = BusStop(stop_id: "AB123", stop_code: "7689", stop_name: "King Edward", stop_lat: 123.123, stop_lon: 456.456)
            let busRoute1 = BusRoute(routeId: "ABC123", routeNumber: "89", routeName: "Blair")
            let busRoute2 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Kanata")
            let busRoute3 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Kanata")
            let busRoute4 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Kanata")
            let busRoute5 = BusRoute(routeId: "ABC123", routeNumber: "83", routeName: "Kanata")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1, busRoute2, busRoute3, busRoute4, busRoute5], style: .Ending)
        default:
            let busStop = BusStop(stop_id: "AB123", stop_code: "7689", stop_name: "King Edward", stop_lat: 123.123, stop_lon: 456.456)
            let busRoute1 = BusRoute(routeId: "ABC123", routeNumber: "123", routeName: "Blair")
            return FavoriteStopTableViewCell(stop: busStop, routes: [busRoute1], style: .Normal)
        }

    }
}

