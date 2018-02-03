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
    
    let redLineView : UIView = {
        let view = UIView()
        view.backgroundColor = Style.mainColor
        return view
    }()
    
    let busStopNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "6783"
        label.font = UIFont(name: "AvenirNext-Bold", size: 26)
        label.textColor = Style.mainColor
        return label
    }()
    
    let busStopNameLabel : UILabel = {
        let label = UILabel()
        label.text = "King Edward / Tempelton"
        label.font = UIFont(name: "AvenirNext", size: 18)
        label.textColor = Style.darkGrey
        return label
    }()
    
    let routeInfoStack : UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Adding elements to contentView
        contentView.addSubview(redLineView)
        contentView.addSubview(busStopNumberLabel)
        contentView.addSubview(busStopNameLabel)
        contentView.addSubview(routeInfoStack)
        
        routeInfoStack.addArrangedSubview(FavouriteStopRouteInfoView(frame: CGRect.zero))
        routeInfoStack.addArrangedSubview(FavouriteStopRouteInfoView(frame: CGRect.zero))
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        
        redLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redLineView.topAnchor.constraint(equalTo: contentView.topAnchor),
            redLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            redLineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            redLineView.widthAnchor.constraint(equalToConstant: 2)
        ])
        
        busStopNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busStopNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            busStopNumberLabel.leftAnchor.constraint(equalTo: redLineView.rightAnchor, constant: 15)
        ])
        
        busStopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busStopNameLabel.leftAnchor.constraint(equalTo: busStopNumberLabel.rightAnchor, constant: 10),
            busStopNameLabel.bottomAnchor.constraint(equalTo: busStopNumberLabel.bottomAnchor),
            busStopNameLabel.heightAnchor.constraint(equalTo: busStopNumberLabel.heightAnchor)
        ])
        
        routeInfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            routeInfoStack.topAnchor.constraint(equalTo: busStopNumberLabel.bottomAnchor, constant: 10),
            routeInfoStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            routeInfoStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            routeInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
}
