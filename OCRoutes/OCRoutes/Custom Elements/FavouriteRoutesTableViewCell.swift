//
//  FavouriteRoutesTableViewCell.swift
//  OCRoutes
//
//  Created by sana on 2018-03-13.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class FavouriteRoutesTableViewCell : UITableViewCell {

    private var trackStyle : TrackStyle = .Normal
    
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
        label.text = "1234"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    // 2nd column stack : Red line between cols
    var redLineView : RedLineView!
    
    // 3rd columns stack : Bus info
    let busRouteNameLabel : UILabel = {
        let label = UILabel()
        label.text = "South Keys"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.textColor = .black
        return label
    }()
    
    // Convenience init
    convenience init(route : BusRoute, style : TrackStyle) {
        self.init(style: .default, reuseIdentifier: "favRouteCell", trackStyle: style)
        self.trackStyle = style
        defer { self.route = route }
    }
    
    // Init
    init(style: UITableViewCellStyle, reuseIdentifier: String?, trackStyle: TrackStyle) {
        super.init(style: style, reuseIdentifier : reuseIdentifier)
        
        redLineView = RedLineView(style: trackStyle)
        
        //Add elems to content view
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(busRouteNumberLabel)
        mainStack.addArrangedSubview(redLineView)
        mainStack.addArrangedSubview(busRouteNameLabel)
        
        ApplyConstraints()
    }
    
    // Set up the bus route
    private func SetupBusRoute() {
        guard let routeInfo = route else { return }
        busRouteNameLabel.text = routeInfo.routeName
        busRouteNumberLabel.text = String(routeInfo.routeNumber)
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
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
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
