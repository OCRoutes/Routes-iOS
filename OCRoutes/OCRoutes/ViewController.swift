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
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mapView = MKMapView(frame: CGRect.zero)
        
        let initialLocation = CLLocation(latitude: 45.42037, longitude: -75.678609)

        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        if let myLocation = self.locationManager.location {
            centerMapOnLocation(location: myLocation)
        } else {
            centerMapOnLocation(location: initialLocation)
        }
        
        
        checkLocationAuthorizationStatus()
        view.addSubview(mapView)
        
        SetupContraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    let regionRadius : CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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

