//
//  StopViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-04-10.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class StopViewController : UIViewController, StopViewControllerDelegate {
    
    private let refreshControl = UIRefreshControl()
    
    private var allStops : [BusStop]? {
        didSet {
            DispatchQueue.main.async {
                self.stopsTableView.reloadData()
            }
        }
    }
    
    fileprivate var stopsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting nav controller title
        self.title = "98 Hawthorne"
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        allStops = NetworkManager.GetFakeStops()
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        stopsTableView = UITableView(frame: CGRect.zero)
        
        stopsTableView.delegate = self
        stopsTableView.dataSource = self
        
        // Setup cell dynamic row height
        stopsTableView.rowHeight = UITableViewAutomaticDimension
        stopsTableView.estimatedRowHeight = 150
        
        stopsTableView.backgroundColor = Style.lightWhite
        stopsTableView.separatorColor = Style.lightWhite
        stopsTableView.layoutMargins = .zero
        stopsTableView.separatorInset = .zero
        
        stopsTableView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(StopsViewController.handleLongPress(_:)))
        stopsTableView.addGestureRecognizer(longPressGesture)
        
        view.addSubview(stopsTableView)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.stopsTableView)
            if let indexPath = stopsTableView.indexPathForRow(at: touchPoint) {
                let cell = stopsTableView.cellForRow(at: indexPath) as! StopTableViewCell
                cell.toggleFavourite()
            }
        }
    }
    
    // When a route cube is clicked within a stop cell
    func HandleRouteSelection(_ stop: BusStop, _ route: BusRoute) {
        let vc = StopRouteInformationViewController(stop, route)
        self.navigationController?.pushViewController(vc, animated: true)
        
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
extension StopViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = allStops?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let stop = allStops?[indexPath.row] {
            var trackStyle = TrackStyle.Normal
            
            if (indexPath.row == 0) {
                trackStyle = .Leading
            }
            
            if ((indexPath.row + 1) == allStops!.count) {
                trackStyle = .Ending
            }
//            let stopCell = FavoriteStopTableViewCell(stop: stop, routes: stop.routes!, style: trackStyle)
            let stopCell = StopTableViewCell(stop: stop, routes: stop.routes, style: trackStyle)
            stopCell.delegate = self
            return stopCell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "brokencell")
    }
}
