//
//  FavoriteStopTableViewCell.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-02-02.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class FavoriteStopTableViewCell : UITableViewCell {
    
    private var stop : BusStop? {
        didSet {
            SetupStopInfo()
        }
    }
    
    private var routes : [BusRoute]? {
        didSet {
            SetupBusRoutes()
        }
    }
    
    let mainStack : UIStackView = {
        let stack = UIStackView()
        
        return stack
    }()
    
    //1st column
    let busStopNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "6783"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = .black
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    //2nd column
    let redLineView : RedLineView = {
        let view = RedLineView(frame: CGRect.zero)
        return view
    }()
    
    let spacerView : UIView = {
        return UIView()
    }()
    
    //3rd column stack
    let thirdColumn : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stack
    }()
    
    //3rd column label
    let busStopNameLabel : UILabel = {
        let label = UILabel()
        label.text = "King Edward / Tempelton"
        label.font = UIFont(name: "AvenirNext", size: 15)
        label.textColor = Style.mainColor
        return label
    }()
    
    // 3rd column stack for route info
    let routeInfoStack : UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    convenience init(stop : BusStop, routes : [BusRoute]) {
        self.init(frame: CGRect.zero)
        defer { self.stop = stop }
        defer { self.routes = routes }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Adding elements to contentView
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(busStopNumberLabel)
        mainStack.addArrangedSubview(redLineView)
        mainStack.addArrangedSubview(spacerView)
        
        spacerView.addSubview(thirdColumn)
        
        thirdColumn.addArrangedSubview(busStopNameLabel)

        ApplyConstraints()
    }
    
    private func SetupStopInfo() {
        guard let stopInfo = stop else { return }
        busStopNumberLabel.text = stopInfo.stopCode
        busStopNameLabel.text = stopInfo.stopName
    }
    
    private func SetupBusRoutes() {
        if routes != nil {
            for route in routes! {
                thirdColumn.addArrangedSubview(FavouriteStopRouteInfoView(frame: CGRect.zero, route: route))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        thirdColumn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdColumn.topAnchor.constraint(equalTo: spacerView.topAnchor, constant: 5),
            thirdColumn.bottomAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: -5),
            thirdColumn.leadingAnchor.constraint(equalTo: spacerView.leadingAnchor),
            thirdColumn.trailingAnchor.constraint(equalTo: spacerView.trailingAnchor)
        ])
        
    }
    
}

class RedLineView : UIView {
    
    let redLine : UIView = {
        let view = UIView()
        view.backgroundColor = Style.mainColor
        return view
    }()
    
    let bigCircle : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(redLine)
        addSubview(bigCircle)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        redLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redLine.widthAnchor.constraint(equalToConstant: 6),
            redLine.topAnchor.constraint(equalTo: topAnchor),
            redLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            redLine.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        bigCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bigCircle.widthAnchor.constraint(equalToConstant: 18),
            bigCircle.heightAnchor.constraint(equalToConstant: 18),
            bigCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            bigCircle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        bigCircle.layer.cornerRadius = 18 / 2.0
        bigCircle.clipsToBounds = true
        bigCircle.layer.borderColor = Style.mainColor.cgColor
        bigCircle.layer.borderWidth = 2.0
    }
    
}
