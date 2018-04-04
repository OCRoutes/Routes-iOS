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
    
    private var favStops : [BusStop]? {
        didSet {
            DispatchQueue.main.async {
                self.favsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        self.favStops = NetworkManager.GetFavouritedStops()
        
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
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(FavouriteStopsViewController.handleLongPress(_:)))
        favsTableView.addGestureRecognizer(longPressGesture)
        
        view.addSubview(favsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func refreshStopsData(_ sender: Any) {
            DispatchQueue.main.async {
                self.favStops = NetworkManager.GetFavouritedStops()
                self.refreshControl.endRefreshing()
        }
    }
    
    @objc func handleLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.favsTableView)
            if let indexPath = favsTableView.indexPathForRow(at: touchPoint) {
                let cell = favsTableView.cellForRow(at: indexPath) as! FavoriteStopTableViewCell
                cell.toggleFavourite()
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
        if let count = favStops?.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let stop = favStops?[indexPath.row] {
            var trackStyle = TrackStyle.Normal
            
            if (indexPath.row == 0) {
                trackStyle = .Leading
            }
            
            if ((indexPath.row + 1) == favStops!.count) {
                trackStyle = .Ending
            }
            return FavoriteStopTableViewCell(stop: stop, routes: stop.routes!, style: trackStyle)
        }
        return UITableViewCell(style: .default, reuseIdentifier: "brokencell")
    }
}

