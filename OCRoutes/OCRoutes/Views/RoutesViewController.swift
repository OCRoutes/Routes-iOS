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

    private let refreshControl = UIRefreshControl()
    
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
        
        allRoutes = NetworkManager.GetAllRoutes()
        
        // Setting up tableview
        SetupFavsTableView()
        
        ApplyConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.title = "ALL ROUTE"
        self.navigationController?.navigationBar.topItem?.title = "ALL ROUTES"
    }
    
    private func SetupFavsTableView() {
        routesTableView = UITableView(frame: CGRect.zero)
        
        routesTableView.dataSource = self
        routesTableView.delegate = self
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            routesTableView.refreshControl = refreshControl
        } else {
            routesTableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshRoutesData(_:)), for: .valueChanged)
        
        routesTableView.backgroundColor = Style.lightWhite
        routesTableView.separatorColor = Style.lightWhite
        routesTableView.layoutMargins = .zero
        routesTableView.separatorInset = .zero
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(RoutesViewController.handleLongPress(_:)))
        routesTableView.addGestureRecognizer(longPressGesture)
        
        view.addSubview(routesTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.routesTableView)
            if let indexPath = routesTableView.indexPathForRow(at: touchPoint) {
                let cell = routesTableView.cellForRow(at: indexPath) as! FavouriteRoutesTableViewCell
                cell.toggleFavourite()
            }
        }
    }
    
    @objc private func refreshRoutesData(_ sender: Any) {
        NetworkManager.GetAllRoutes() { _ in
            DispatchQueue.main.async {
                self.allRoutes = NetworkManager.GetAllRoutes()
                self.refreshControl.endRefreshing()
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StopViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let route = allRoutes?[indexPath.row] {
            var trackStyle = TrackStyle.Normal
            
            if (indexPath.row == 0) {
                trackStyle = .Leading
            }
            
            if ((indexPath.row + 1) == allRoutes!.count) {
                trackStyle = .Ending
            }
            return FavouriteRoutesTableViewCell(route: route, style: trackStyle)
        }
        return UITableViewCell(style: .default, reuseIdentifier: "brokencell")
    }
}
