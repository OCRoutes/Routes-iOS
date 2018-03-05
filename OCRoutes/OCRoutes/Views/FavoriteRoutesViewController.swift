//
//  FavoriteRoutesView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class FavoriteRoutesViewController : UIViewController {
    
    private let titleString: String = "Favorite Routes"
    private var titleLabel: UILabel!
    
    fileprivate var favsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "Favorites"
        
        // Setting up tableview
        SetupFavsTableView()
        
        // Setup placeholder label
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.attributedText = NSAttributedString(string: titleString, attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 40)!,
            NSAttributedStringKey.foregroundColor: Style.mainColor
        ])
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        favsTableView = UITableView(frame: CGRect.zero)
        favsTableView.delegate = self
        favsTableView.dataSource = self
        favsTableView.rowHeight = UITableViewAutomaticDimension
        favsTableView.estimatedRowHeight = 140
        view.addSubview(favsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Title label constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
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
extension FavoriteRoutesViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busStop = BusStop(stopId: "AB1234", stopCode: "7876", stopName: "King Edward / Tempelton", stopLatitude: 45.423743, stopLongitude: -75.687995)
        let route1 = BusRoute(routeNumber: 89, routeName: "Mackenzie King", firstBusTime: "2m", secondBusTime: "1h21m")
        let route2 = BusRoute(routeNumber: 17, routeName: "Orleans", firstBusTime: "45m", secondBusTime: "1h21m")
        let route3 = BusRoute(routeNumber: 92, routeName: "Rideau", firstBusTime: "<1m", secondBusTime: "31m")
        let route4 = BusRoute(routeNumber: 57, routeName: "Kanata", firstBusTime: "9m", secondBusTime: "51m")
        let cell = FavoriteStopTableViewCell(stop: busStop, routes: [route1, route2, route3, route4])
        return cell
    }
}
