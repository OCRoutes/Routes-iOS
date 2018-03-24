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
    
    private var allRoutes : [BusRoute]? {
        didSet {
            DispatchQueue.main.async {
                self.routesTableView.reloadData()
            }
        }
    }
    
    fileprivate var routesTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "ALL ROUTES"
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        allRoutes = NetworkManager.GetAllRoutes()
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        routesTableView = UITableView(frame: CGRect.zero)
        
        routesTableView.delegate = self
        routesTableView.dataSource = self
        
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
extension RoutesViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = allRoutes?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let route = allRoutes?[indexPath.row] {
            var trackStyle = TrackStyle.Normal
            
            if(indexPath.row == 0) {
                trackStyle = .Leading
            }
            
            if ((indexPath.row + 1) == allRoutes?.count) {
                trackStyle = .Ending
            }
            
            return FavouriteRoutesTableViewCell(route: route, style: trackStyle)
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "brokenCell")
        
    }
}
