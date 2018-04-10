//
//  LoadingScreenViewController.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-04-08.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit

class LoadingScreenViewController: UIViewController {
    
    private let appLogoImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let loadingLabel : UILabel = {
        let label = UILabel()
        label.text = "Retrieving latest OCTranspo information..."
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.92, green:0.12, blue:0.20, alpha:1.00)
        
        view.addSubview(appLogoImageView)
        view.addSubview(loadingLabel)
        
        ApplyConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appLogoImageView.startRotating(duration: 2)
        MakeNetworkRequests()
    }
    
    private func MakeNetworkRequests() {
        
        //TODO: fix this. It's really really bad to do this... but short for time
        NetworkManager.GetAllRoutes { (err: String?) in
            if err != nil { print(err!) }
            NetworkManager.GetAllStops { (err: String?) in
                DispatchQueue.main.sync {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore2")
                    if launchedBefore  {
                        print("Not first launch.")
                        appDelegate.switchToMainView()
                    } else {
                        print("First launch, setting UserDefault.")
                        UserDefaults.standard.set(true, forKey: "launchedBefore2")
                        appDelegate.switchToOnboarding()
                    }
                }
            }
        }
    }
    
    private func ApplyConstraint() {
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appLogoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            appLogoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            appLogoImageView.widthAnchor.constraint(equalToConstant: 128),
            appLogoImageView.heightAnchor.constraint(equalToConstant: 128)
        ])
        
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 10),
            loadingLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
}

extension UIView {
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = .pi * 2.0
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}
