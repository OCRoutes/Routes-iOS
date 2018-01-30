//
//  MapViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView : MKMapView!
    let initialLocation = CLLocation(latitude: 45.42037, longitude: -75.678609)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        SetupMapView()
        PlaceMapMarkers()
        SetupContraint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetupMapView() {
        mapView = MKMapView(frame: CGRect.zero)
        
        checkLocationAuthorizationStatus()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        if let myLocation = self.locationManager.location {
            centerMapOnLocation(location: myLocation)
        } else {
            centerMapOnLocation(location: initialLocation)
        }
        
        mapView.showsCompass = true
        mapView.showsScale = true
        
        view.addSubview(mapView)
    }
    
    func PlaceMapMarkers() {
        let bus1 = StationAnnotation(latitude: 45.423743, longitude: -75.687995)
        let bus2 = StationAnnotation(latitude: 45.413069, longitude: -75.712180)
        let bus3 = StationAnnotation(latitude: 45.403488, longitude: -75.736366)
        
        mapView.addAnnotations([bus1, bus2, bus3])
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
        let safeLayout = view.safeAreaLayoutGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeLayout.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor)
        ])
    }

}
