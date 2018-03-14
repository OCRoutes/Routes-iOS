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
        
        // Setting nav controller title
        // self.navigationController?.navigationBar.topItem?.title = "Favorites"
        
        // Setting up tableview
        SetupFavsTableView()
        
        // Setup placeholder label
        /*titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.attributedText = NSAttributedString(string: titleString, attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 40)!,
            NSAttributedStringKey.foregroundColor: Style.mainColor
        ])
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)*/
    
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        favsTableView = UITableView(frame: CGRect.zero)
        
        // Setup delegate
        favsTableView.dataSource = self
        favsTableView.delegate = self
        
        // Setup cell dynamic row height
        favsTableView.rowHeight = UITableViewAutomaticDimension
        favsTableView.rowHeight = 70
        
        favsTableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha:1.00)
        
        view.addSubview(favsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Title label constraints
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let busRoute = BusRoute(routeNumber: 104, routeName: "Mackenzie King Station", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Leading)
        case 1:
            let busRoute = BusRoute(routeNumber: 9, routeName: "Greenboro", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Normal)
        case 2:
            let busRoute = BusRoute(routeNumber: 98, routeName: "Aeroport / Airport", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Ending)
        default:
            let busRoute = BusRoute(routeNumber: 98, routeName: "Blair", firstBusTime: "24m", secondBusTime: "1h31m")
            return FavouriteRoutesTableViewCell(route: busRoute, style: .Normal)
        }
    }
}
