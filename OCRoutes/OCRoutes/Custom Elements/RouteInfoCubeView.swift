//
//  RouteInfoCubeView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-12.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class RouteInfoCubeView : UIView {
    
    private var CUBE_COLOR : UIColor = Style.mainColor
    
    private let CUBE_SIZE : CGFloat = 30.0
    
    let routeNumberLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "85", attributes: [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20)!,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ])
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CUBE_COLOR
        addSubview(routeNumberLabel)
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: CUBE_SIZE),
            heightAnchor.constraint(equalToConstant: CUBE_SIZE)
        ])
        
        routeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            routeNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            routeNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            routeNumberLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5)
//            routeNumberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            routeNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
