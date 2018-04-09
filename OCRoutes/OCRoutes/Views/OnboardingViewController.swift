//
//  OnboardingViewController.swift
//  OCRoutes
//
//  Created by sana on 2018-04-06.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import Foundation
import UIKit
import PaperOnboarding

class OnboardingViewController : UIViewController, PaperOnboardingDataSource {
    
    fileprivate var onboardingView = PaperOnboarding()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        view.addSubview(onboardingView)
        
        ApplyConstraint()
    }
    
    
    // How many screens do we want
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = Style.mainColor
        let backgroundColorTwo = UIColor(red: 0.16, green: 0.10, blue: 0.93, alpha: 1)
        let backgroundColorThree = UIColor(red: 0.12, green: 0.93, blue: 0.10, alpha: 1)
        let backgroundColorFour = UIColor(red: 0.12, green: 0.93, blue: 0.10, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 25)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        
        return [
                OnboardingItemInfo(
                        informationImage: #imageLiteral(resourceName: "wave"),
                        title: "Hey there!",
                        description: "Thank you for downloading Routes! We hope we don't dissapoint you like we do our parents!",
                        pageIcon: UIImage(),
                        color: backgroundColorOne,
                        titleColor: .white,
                        descriptionColor: .white,
                        titleFont: titleFont,
                        descriptionFont: descriptionFont
                ),
                OnboardingItemInfo(
                        informationImage: #imageLiteral(resourceName: "long-press"),
                        title: "Save routes/stops!",
                        description: "If you want to save a route or a stop, just do a long press on them and we'll do the rest for you!",
                        pageIcon: UIImage(),
                        color: backgroundColorTwo,
                        titleColor: UIColor.white,
                        descriptionColor: UIColor.white,
                        titleFont: titleFont,
                        descriptionFont: descriptionFont
                ),
                OnboardingItemInfo(
                        informationImage: #imageLiteral(resourceName: "bus-run"),
                        title: "Track your busses!",
                        description: "Use the map to know the exact location of your busses, so you never end up in a dead sprint behind them!",
                        pageIcon: UIImage(),
                        color: backgroundColorThree,
                        titleColor: UIColor.white,
                        descriptionColor: UIColor.white,
                        titleFont: titleFont,
                        descriptionFont: descriptionFont
                )][index]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func ApplyConstraint() {
        // Favs table view constraints
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}
