//
//  RoutesViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class RoutesViewController : UIViewController {
    
    let titleString: String = "All Routes"
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "Routes"
        
        view.backgroundColor = .white
        
        //Insert label
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.attributedText = NSAttributedString(string: titleString, attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 40)!,
            NSAttributedStringKey.foregroundColor: Style.mainColor
        ])
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        ApplyConstraint()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
}
