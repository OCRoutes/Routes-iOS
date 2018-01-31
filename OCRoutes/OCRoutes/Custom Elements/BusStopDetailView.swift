//
//  BusStopDetailView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class BusStopDetailView : UIView {
    
    var mainStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5.0
        return view
    }()
    
    var busStopNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "7285"
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = Style.mainColor
        return label
    }()
    
    let busStopNameLabel : UILabel = {
        let label = UILabel()
        label.text = "King Edward"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainStack.addArrangedSubview(busStopNumberLabel)
        mainStack.addArrangedSubview(busStopNameLabel)
        
        addSubview(mainStack)
    }
    
    private func ApplyConstraint() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}
