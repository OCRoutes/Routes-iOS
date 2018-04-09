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

    var mapView : MKMapView = MKMapView(frame: CGRect.zero)
    let initialLocation = CLLocation(latitude: 45.42037, longitude: -75.678609)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "MAP"
        
        SetupMapView()
        SetupContraint()
        mapView.fitAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetupMapView() {
        mapView.delegate = self
        
        checkLocationAuthorizationStatus()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        mapView.showsCompass = true
        mapView.showsScale = true
        
        view.addSubview(mapView)
    }
    
    func PlaceBusStop(_ stop: BusStop) {
        let busAnnotation = BusStopAnnotation(stop)
        mapView.addAnnotation(busAnnotation)
        mapView.fitAll()
    }
    
    func SetupAllBusStops() {
        let stops = NetworkManager.GetAllStops()
        for stop in stops {
            let stopAnnotation = BusStopAnnotation(stop)
            mapView.addAnnotation(stopAnnotation)
        }
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

extension MKMapView {
    func fitAll() {
        var zoomRect            = MKMapRectNull;
        for annotation in annotations {
            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
            let pointRect       = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.01, 0.01);
            zoomRect            = MKMapRectUnion(zoomRect, pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(100, 100, 100, 100), animated: true)
    }
}
