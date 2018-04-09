//
//  StopRouteInformationTableViewCell.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-04-07.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import AudioToolbox

class StopRouteInformationTableViewCell : UITableViewCell {
    
    private var trackStyle : TrackStyle = .Normal
    
    private let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    private var route : BusRoute? {
        didSet {
            SetupBusRoute()
        }
    }
    
    // Init main stack
    let mainStack : UIStackView = {
        return UIStackView()
    }()
    
    // 1st column stack : Route number
    let busRouteNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "SNOW"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    // 2nd column stack : Red line between cols
    var redLineView : RedLineView!
    
    // 3rd column stack : Bus info
    let busRouteNameLabel : UILabel = {
        let label = UILabel()
        label.text = "South Keys"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.textColor = .black
        return label
    }()
    
    // 4th column stack : BusTime
    let busTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "55min"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.textColor = .black
        return label
    }()
    
    // Convenience init
    convenience init(route : BusRoute, style : TrackStyle) {
        self.init(style: .default, reuseIdentifier: "stopInfoCell", trackStyle: style)
        self.trackStyle = style
        defer { self.route = route }
    }
    
    // Init
    init(style: UITableViewCellStyle, reuseIdentifier: String?, trackStyle: TrackStyle) {
        super.init(style: style, reuseIdentifier : reuseIdentifier)
        selectionStyle = .none
        
        redLineView = RedLineView(style: trackStyle)
        
        //Add elems to content view
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(busRouteNumberLabel)
        mainStack.addArrangedSubview(redLineView)
        mainStack.addArrangedSubview(busRouteNameLabel)
        mainStack.addArrangedSubview(busTimeLabel)
        
        ApplyConstraints()
    }
    
    // Set up the bus route
    private func SetupBusRoute() {
        guard let routeInfo = route else { return }
        busRouteNameLabel.text = routeInfo.routeName
        busRouteNumberLabel.text = String(routeInfo.routeNumber)
        busTimeLabel.text = "\(NetworkManager.GetNextBusTime(routeInfo))min"
    }
    
    // Required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Constraint
    private func ApplyConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
            ])
        
        redLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redLineView.widthAnchor.constraint(equalToConstant: 30)
            ])
        
        busRouteNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busRouteNumberLabel.widthAnchor.constraint(equalToConstant: busRouteNumberLabel.frame.width)
            ])
    }
    
}
