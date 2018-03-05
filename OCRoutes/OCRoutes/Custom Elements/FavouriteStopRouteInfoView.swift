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
    
    private var route : BusRoute? {
        didSet {
            SetupRouteInfo()
        }
    }
    
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
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let nextBusTimeStack : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stack
    }()
    
    let firstNextBusLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "24m", attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18)!,
            NSAttributedStringKey.foregroundColor: Style.darkGrey
        ])
        label.textAlignment = .right
        return label
    }()
    
    let secondNextBusLabel : UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "1h25", attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18)!,
            NSAttributedStringKey.foregroundColor: Style.darkGrey
        ])
        label.textAlignment = .right
        return label
    }()
    
    convenience init(frame: CGRect, route: BusRoute) {
        self.init(frame: frame)
        defer { self.route = route }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStack)
        ApplyConstraints()
    }
    
    private func SetupRouteInfo() {
        if let myRoute = route {
            routeNumberLabel.text = String(myRoute.routeNumber)
            routeNameLabel.text = myRoute.routeName
            
            // Adding UI element to stack
            mainStack.addArrangedSubview(routeNumberLabel)
            mainStack.addArrangedSubview(routeNameLabel)
            mainStack.addArrangedSubview(nextBusTimeStack)
            
            if let firstTime = myRoute.firstBusTime {
                firstNextBusLabel.attributedText = NSAttributedString(string: firstTime, attributes: [
                    NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18)!,
                    NSAttributedStringKey.foregroundColor: Style.darkGrey
                ])
                nextBusTimeStack.addArrangedSubview(firstNextBusLabel)
            }
            
            if let secondTime = myRoute.secondBusTime {
                secondNextBusLabel.attributedText = NSAttributedString(string: secondTime, attributes: [
                    NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18)!,
                    NSAttributedStringKey.foregroundColor: Style.darkGrey
                ])
                nextBusTimeStack.addArrangedSubview(secondNextBusLabel)
            }
        }
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
    }
    
}
