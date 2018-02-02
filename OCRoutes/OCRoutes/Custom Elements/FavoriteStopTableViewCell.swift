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
    
    let busStopNumberLabel : UILabel = {
        let label = UILabel()
        label.text = "6783"
        label.font = UIFont(name: "AvenirNext-Bold", size: 26)
        label.textColor = Style.mainColor
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Adding elements to contentView
        contentView.addSubview(busStopNumberLabel)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        
        busStopNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busStopNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            busStopNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15)
        ])
        
        
        
    }
    
}
