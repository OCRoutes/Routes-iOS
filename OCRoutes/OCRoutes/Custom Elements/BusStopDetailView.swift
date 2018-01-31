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
    
    var mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5.0
        return view
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainStack.addArrangedSubview(busStopNumberLabel)
        mainStack.addArrangedSubview(busStopNameLabel)
        
        mainView.addSubview(mainStack)
        addSubview(mainView)
        
        ApplyConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupWithBusStop(station: Station) {
        busStopNumberLabel.text = String(station.stopCode)
        busStopNameLabel.text = station.stopName
    }
    
    private func ApplyConstraint() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.90),
            mainView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 10)
        ])
    }
    
}
