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
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "Map"
        
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
        mapView.delegate = self
        
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
        let station = Station(stopId: "1234", stopCode: 7356, stopName: "King Edward", stopLatitude: 45.423743, stopLongitude: -75.687995)
        let bus1 = StationAnnotation(station: station)
        mapView.addAnnotations([bus1])
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

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "StationAnnotation")
        
        if annotationView == nil {
            annotationView = BusStopAnnotationView(annotation: annotation, reuseIdentifier: "StationAnnotation")
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
