//
//  RoutesViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class RoutesViewController : UIViewController {
    
    let titleString: String = "All Routes"
    var titleLabel: UILabel!
    
    fileprivate var routesTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "ALL ROUTES"
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        routesTableView = UITableView(frame: CGRect.zero)
        
        routesTableView.dataSource = self
        routesTableView.delegate = self
        
        // Background colour, don't need to set up dynamic height
        routesTableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        
        view.addSubview(routesTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        let safeArea = view.safeAreaLayoutGuide

        // Routes table view constraints
        routesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routesTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            routesTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            routesTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            routesTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
}

// UITableViewDataSource delegation
extension RoutesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // Height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let busRoute = BusRoute(routeNumber: 104, routeName: "Mackenzie King Station", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Leading)
        case 1:
            let busRoute = BusRoute(routeNumber: 9, routeName: "Greenboro", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Normal)
        case 9:
            let busRoute = BusRoute(routeNumber: 98, routeName: "Aeroport / Airport", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Ending)
        default:
            let busRoute = BusRoute(routeNumber: 98, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Normal)
        }
    }
}
