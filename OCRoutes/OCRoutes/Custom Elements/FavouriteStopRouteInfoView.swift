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
    
    let mainStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10.0
        return stack
    }()
    
    let routeNumberLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "85", attributes: [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 18)!,
            NSAttributedStringKey.foregroundColor: Style.mainColor
        ])
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
    
    let nextBusTimeStack : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    
    let firstNextBusLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "24m", attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18)!,
            NSAttributedStringKey.foregroundColor: Style.darkGrey
        ])
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(mainStack)
        
        mainStack.addArrangedSubview(routeNumberLabel)
        mainStack.addArrangedSubview(routeNameLabel)
        mainStack.addArrangedSubview(nextBusTimeStack)
        nextBusTimeStack.addArrangedSubview(firstNextBusLabel)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: rightAnchor),
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
//        routeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            routeNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
//            routeNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            routeNumberLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
//            routeNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
//        ])
//
//        routeNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            routeNameLabel.centerYAnchor.constraint(equalTo: routeNumberLabel.centerYAnchor),
//            routeNameLabel.leftAnchor.constraint(equalTo: routeNumberLabel.rightAnchor, constant: 10)
//        ])
//
//        nextBusTimeStack.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            nextBusTimeStack.leftAnchor.constraint(equalTo: routeNameLabel.rightAnchor),
//            nextBusTimeStack.rightAnchor.constraint(equalTo: rightAnchor),
//            nextBusTimeStack.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
    }
    
}
