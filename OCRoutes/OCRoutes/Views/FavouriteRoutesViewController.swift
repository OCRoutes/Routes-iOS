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
    private let refreshControl = UIRefreshControl()
    
    private var favRoutes : [BusRoute]? {
        didSet {
            DispatchQueue.main.async {
                self.favsTableView.reloadData()
            }
        }
    }
    
    private var appLogo: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "grey-logo")
        view.contentMode = .scaleAspectFit
        view.alpha = 0.0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let emptyListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.text = "You have no favourite routes."
        label.textColor = Style.lightGrey
        label.alpha = 0.0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up view attributes
        view.backgroundColor = .white

        // Setting up tableview
        SetupFavsTableView()
    
        view.addSubview(appLogo)
        view.addSubview(emptyListLabel)
        
        self.favRoutes = NetworkManager.GetFavouriteRoutes()
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        favsTableView = UITableView(frame: CGRect.zero)
        
        // Setup delegate
        favsTableView.dataSource = self
        favsTableView.delegate = self
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            favsTableView.refreshControl = refreshControl
        } else {
            favsTableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshStopsData(_:)), for: .valueChanged)
        
        // Colour scheme of view
        favsTableView.backgroundColor = Style.lightWhite
        favsTableView.separatorColor = Style.lightWhite
        favsTableView.layoutMargins = UIEdgeInsets.zero
        favsTableView.separatorInset = UIEdgeInsets.zero
        
        favsTableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha:1.00)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(FavouriteRoutesViewController.handleLongPress(_:)))
        favsTableView.addGestureRecognizer(longPressGesture)
        
        view.addSubview(favsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = favsTableView.indexPathForRow(at: touchPoint) {
                let cell = favsTableView.cellForRow(at: indexPath) as! FavouriteRoutesTableViewCell
                cell.toggleFavourite()
            }
        }
    }
    
    @objc private func refreshStopsData(_ sender: Any) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.favRoutes = NetworkManager.GetFavouriteRoutes()
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
        
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: favsTableView.centerXAnchor),
            appLogo.centerYAnchor.constraint(equalTo: favsTableView.centerYAnchor, constant: -10),
            appLogo.widthAnchor.constraint(equalTo: favsTableView.widthAnchor, multiplier: 0.18),
            appLogo.heightAnchor.constraint(equalTo: favsTableView.widthAnchor, multiplier: 0.18)
        ])
        
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyListLabel.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 5),
            emptyListLabel.leftAnchor.constraint(equalTo: favsTableView.leftAnchor),
            emptyListLabel.rightAnchor.constraint(equalTo: favsTableView.rightAnchor)
        ])
    }
    
}

// UITableViewDataSource delegation
extension FavouriteRoutesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = favRoutes?.count {
            count == 0 ? (appLogo.alpha = 1.0, emptyListLabel.alpha = 1.0) : (appLogo.alpha = 0.0, emptyListLabel.alpha = 0.0)
            return count
        }
        appLogo.alpha = 1.0
        return 0
    }
    
    // Height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let route = favRoutes?[indexPath.row] {
            var trackStyle = TrackStyle.Normal
            
            if (indexPath.row == 0) {
                trackStyle = .Leading
            }
            
            if ((indexPath.row + 1) == favRoutes!.count) {
                trackStyle = .Ending
            }
            return FavouriteRoutesTableViewCell(route: route, style: trackStyle)
        }
        return UITableViewCell(style: .default, reuseIdentifier: "brokencell")
    }
}
