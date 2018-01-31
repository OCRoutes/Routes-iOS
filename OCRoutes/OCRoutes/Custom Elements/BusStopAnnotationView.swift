//
//  BusStopAnnotationView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class BusStopAnnotationView : MKAnnotationView {
    
    private let animationDuration : Double = 0.3
    private let annotationSize : CGRect = CGRect(x: 0, y: 0, width: 140, height: 50)
    
    weak var customCalloutView: BusStopDetailView?
    
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        // Disable showing default annotation view
        self.canShowCallout = false
        self.image = UIImage(named: "bus-stop")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.customCalloutView?.removeFromSuperview() // remove old custom callout (if any)
            
            if let newCustomCalloutView = loadBusStopDetailView() {
                // fix location from top-left to its right place.
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height + 10.0
                
                // set custom callout view
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                
                // animate presentation
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    self.customCalloutView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
                    UIView.animate(withDuration: animationDuration, animations: {
                        self.customCalloutView!.alpha = 1.0
                        self.customCalloutView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    })
                }
            }
        } else {
            if customCalloutView != nil {
                if animated { // fade out animation, then remove it.
                    UIView.animate(withDuration: animationDuration, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else {
                    self.customCalloutView!.removeFromSuperview()
                }
            }
        }
        
    }
    
    func loadBusStopDetailView() -> BusStopDetailView? { // 4
        if let stationAnnotation = annotation as? StationAnnotation {
            let view = BusStopDetailView(frame: annotationSize)
            view.SetupWithBusStop(station: stationAnnotation.station!)
            return view
        }
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
}
