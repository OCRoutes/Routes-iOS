//
//  StopRouteInformationViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-04-07.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class StopRouteInformationViewController: UIViewController {
    
    private var stop: BusStop?
    private var route: BusRoute?
    private var routes: [BusRoute]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var tableView = UITableView(frame: .zero)
    
    init(_ stop: BusStop, _ route: BusRoute) {
        super.init(nibName: nil, bundle: nil)
        self.stop = stop
        self.route = route
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestRouteInformation()
        
        view.backgroundColor = .white
        
//        self.navigationController?.navigationBar.backItem?.title = " "
        self.title = stop?.stop_name
        
        let mapButton = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OpenMap(_:)))
        self.navigationItem.rightBarButtonItem = mapButton
        
        SetupTableView()
        
        ApplyConstraints()
    }
    
    private func RequestRouteInformation() {
        guard stop != nil, route != nil else { return }
        NetworkManager.GetStopRouteInformation(self.stop!, self.route!) { (err, routes) in
            if err != nil { print(err) }
            self.routes = routes
        }
    }
    
    private func SetupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func OpenMap(_ sender: AnyObject) {
        let mapVC = MapViewController()
        mapVC.PlaceBusStop(self.stop!)
        
        var bus1 = BusRoute(routeId: "ABC", routeNumber: "98", routeName: "Hawthorne")
        bus1.firstBusTime = "1"
        let bus1Annotation = BusAnnotation(route: bus1, lat: 45.421788, lon: -75.679885)
        
        var bus2 = BusRoute(routeId: "ABC", routeNumber: "98", routeName: "Hawthorne")
        bus2.firstBusTime = "7"
        let bus2Annotation = BusAnnotation(route: bus2, lat: 45.428646, lon: -75.685616)
        
        var bus3 = BusRoute(routeId: "ABC", routeNumber: "98", routeName: "Hawthorne")
        bus3.firstBusTime = "3"
        let bus3Annotation = BusAnnotation(route: bus3, lat: 45.424494, lon: -75.684850)
        
        mapVC.PlaceBuses([bus1Annotation, bus2Annotation, bus3Annotation])
        
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    private func ApplyConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
}

extension StopRouteInformationViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = routes?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let route = routes?[indexPath.row] {
            var trackStyle = TrackStyle.Normal
            
            if (indexPath.row == 0) {
                trackStyle = .Leading
            }
            
            if ((indexPath.row + 1) == routes!.count) {
                trackStyle = .Ending
            }
            return StopRouteInformationTableViewCell(route: route, style: trackStyle)
        }
        return UITableViewCell(style: .default, reuseIdentifier: "brokencell")
    }
    
}


