//
//  ViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var mapView : MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mapView = MKMapView(frame: CGRect.zero)
        
        view.addSubview(mapView)
        
        SetupContraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func SetupContraint() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

