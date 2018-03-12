//
//  FavoriteStopTableViewCell.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-02-02.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

enum TrackStyle {
    case Normal
    case Leading
    case Ending
}

class FavoriteStopTableViewCell : UITableViewCell {
    
    private var trackStyle : TrackStyle = .Normal
    
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
    
    let spacerView : UIView = {
        return UIView()
    }()
    
    var redLineView : RedLineView!
    
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
    
    convenience init(stop : BusStop, routes : [BusRoute], style : TrackStyle) {
        self.init(style: .default, reuseIdentifier: "favStopCell", trackStyle: style)
        self.trackStyle = style
        defer { self.stop = stop }
        defer { self.routes = routes }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, trackStyle : TrackStyle) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        redLineView = RedLineView(style: trackStyle)
        
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
            thirdColumn.topAnchor.constraint(equalTo: spacerView.topAnchor, constant: 10),
            thirdColumn.bottomAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: -10),
            thirdColumn.leadingAnchor.constraint(equalTo: spacerView.leadingAnchor),
            thirdColumn.trailingAnchor.constraint(equalTo: spacerView.trailingAnchor)
        ])
        
    }
    
}

class RedLineView : UIView {
    
    private var trackStyle : TrackStyle = .Normal
    
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
    
    convenience init (style : TrackStyle) {
        self.init(frame: CGRect.zero, style: style)
    }
    
    init(frame: CGRect, style: TrackStyle) {
        super.init(frame: frame)
        
        self.trackStyle = style
        
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
            redLine.widthAnchor.constraint(equalToConstant: 5),
            redLine.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        switch trackStyle {
            case .Normal:
                redLine.topAnchor.constraint(equalTo: topAnchor).isActive = true
                redLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                break
            case .Leading:
                redLine.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
                redLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                break
            case .Ending:
                redLine.topAnchor.constraint(equalTo: topAnchor).isActive = true
                redLine.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
                break
        }
        
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
        bigCircle.layer.borderWidth = 3.0
        
    }
    
}
