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
        self.navigationController?.navigationBar.topItem?.title = "ALL STOPS"
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        allStops = NetworkManager.GetAllStops()
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        stopsTableView = UITableView(frame: CGRect.zero)
        
        stopsTableView.delegate = self
        stopsTableView.dataSource = self
        
        // Setup cell dynamic row height
        stopsTableView.rowHeight = UITableViewAutomaticDimension
        stopsTableView.estimatedRowHeight = 150
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            stopsTableView.refreshControl = refreshControl
        } else {
            stopsTableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshStopsData(_:)), for: .valueChanged)
        
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
    
    @objc private func refreshStopsData(_ sender: Any) {
        NetworkManager.GetAllStops() { _ in
            DispatchQueue.main.async {
                self.allStops = NetworkManager.GetAllStops()
                self.refreshControl.endRefreshing()
            }
        }
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
            
            return StopTableViewCell(stop: stop, routes: stop.routes, style: trackStyle)
        }
        return UITableViewCell(style: .default, reuseIdentifier: "brokencell")
    }
}

