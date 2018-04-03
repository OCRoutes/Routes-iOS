//
//  FavoriteRoutesView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class FavouriteRoutesViewController : UIViewController {
    
    fileprivate var favsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up view attributes
        view.backgroundColor = .white

        // Setting up tableview
        SetupFavsTableView()
    
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        favsTableView = UITableView(frame: CGRect.zero)
        
        // Setup delegate
        favsTableView.dataSource = self
        favsTableView.delegate = self
        
        // Colour scheme of view
        favsTableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        favsTableView.separatorColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        favsTableView.layoutMargins = UIEdgeInsets.zero
        favsTableView.separatorInset = UIEdgeInsets.zero
        
        favsTableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha:1.00)
        
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
extension FavouriteRoutesViewController : UITableViewDelegate, UITableViewDataSource {
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
            let busRoute = BusRoute(routeId: "ABC", routeNumber: "104", routeName: "Mackenzie King Station")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Leading)
        case 1:
            let busRoute = BusRoute(routeId: "ABC", routeNumber: "9", routeName: "Greenboro")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Normal)
        case 9:
            let busRoute = BusRoute(routeId: "ABC", routeNumber: "98", routeName: "Aeroport / Airport")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Ending)
        default:
            let busRoute = BusRoute(routeId: "ABC", routeNumber: "98", routeName: "Blair")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Normal)
        }
    }
}
