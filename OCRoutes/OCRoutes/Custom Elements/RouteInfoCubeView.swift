//
//  RouteInfoCubeView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-12.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class RouteInfoCubeView : UICollectionViewCell {
    
    private var CUBE_COLOR : UIColor = Style.mainColor
    
    private let CUBE_SIZE : CGFloat = 30.0
    
    let routeNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "85"
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)!
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CUBE_COLOR
        contentView.addSubview(routeNumberLabel)
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {

        routeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            routeNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            routeNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            routeNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        layer.cornerRadius = 5.0
    }
    
}
