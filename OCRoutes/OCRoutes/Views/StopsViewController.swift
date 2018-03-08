//
//  StopsViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-02-02.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class StopsViewController : UIViewController {
    
    let titleString: String = "All Stops"
    var titleLabel: UILabel!
    
    fileprivate var stopsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting nav controller title
        self.navigationController?.navigationBar.topItem?.title = "ALL STOPS"
        
        // Setting up view attributes
        view.backgroundColor = .white
        
        // Setting up tableview
        SetupFavsTableView()
        
        // Setup placeholder label
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.attributedText = NSAttributedString(string: titleString, attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 40)!,
            NSAttributedStringKey.foregroundColor: Style.mainColor
            ])
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        ApplyConstraint()
    }
    
    private func SetupFavsTableView() {
        stopsTableView = UITableView(frame: CGRect.zero)
        view.addSubview(stopsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func ApplyConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Title label constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        // Routes table view constraints
        stopsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stopsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stopsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stopsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ])
        
    }
    
}

// UITableViewDataSource delegation
extension StopsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
