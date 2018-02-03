//
//  FavouriteStopRouteInfoView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-02-03.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class FavouriteStopRouteInfoView : UIView {
    
    let routeNumberLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "85", attributes: [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 18)!,
            NSAttributedStringKey.foregroundColor: Style.mainColor
        ])
        return label
    }()
    
    let routeNameLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Mackenzie King Station", attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18)!,
            NSAttributedStringKey.foregroundColor: Style.darkGrey
        ])
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    
        addSubview(routeNumberLabel)
        addSubview(routeNameLabel)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        routeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            routeNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            routeNumberLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            routeNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
        
        routeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeNameLabel.centerYAnchor.constraint(equalTo: routeNumberLabel.centerYAnchor),
            routeNameLabel.leftAnchor.constraint(equalTo: routeNumberLabel.rightAnchor, constant: 10)
        ])
        
    }
    
}
