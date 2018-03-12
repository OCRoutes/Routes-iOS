//
//  RedLineView.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-03-12.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

enum TrackStyle {
    case Normal
    case Leading
    case Ending
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
